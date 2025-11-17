
USE TurnosYaDB;
GO

-- 1. Roles
INSERT INTO roles (nombre_rol) VALUES 
('Administrador'), ('Canchero'), ('Jugador');
GO

-- 2. Usuarios (Contraseña '1234' hasheada - SOLO PARA PRUEBAS)
INSERT INTO usuario (nombre, apellido, email, contraseña, activo, telefono, dni, id_rol) VALUES
('Juan', 'Perez', 'juan.perez@email.com', HASHBYTES('SHA2_256', '1234'), 1, '3794112233', '40111222', 3), -- Rol 3 = Jugador
('Ana', 'Gomez', 'ana.gomez@email.com', HASHBYTES('SHA2_256', '1234'), 1, '3794445566', '35999888', 1); -- Rol 1 = Admin
GO

-- 3. Jugador (Especialización del usuario Juan Perez)
INSERT INTO jugador (id_usuario_jugador) VALUES 
(1); -- ID de Juan Perez (asumiendo que es ID 1)
GO

-- 4. Métodos de Pago
INSERT INTO metodo_pago (descripcion) VALUES 
('Efectivo'), ('Transferencia MP'), ('Tarjeta de Crédito');
GO

-- 5. Tipos de Cancha
INSERT INTO tipo_cancha (descripcion) VALUES 
('Fútbol 5'), ('Pádel'), ('Básquet');
GO

-- 6. Canchas
INSERT INTO cancha (nro_cancha, ubicacion, precio_hora, id_tipo) VALUES 
(1, 'Nave Principal (Izquierda)', 5000.00, 1), -- Fútbol 5
(2, 'Nave Principal (Derecha)', 5000.00, 1), -- Fútbol 5
(3, 'Fondo (Vidrio)', 4500.00, 2); -- Pádel
GO

-- 7. Estados (Importante: Asumimos IDs 1=Pend, 5=Canc)
INSERT INTO estado (estado, id_pago) VALUES
('Pendiente', NULL),         -- ID 1
('Confirmada (Efectivo)', 1), -- ID 2
('Confirmada (MP)', 2),       -- ID 3
('Confirmada (TC)', 3),       -- ID 4
('Cancelada', NULL);         -- ID 5
GO

-- 8. Reserva (Una reserva existente para pruebas)
INSERT INTO reserva (fecha, hora, duracion, id_jugador, id_estado, id_cancha) VALUES
(GETDATE() + 1, '18:00:00', '60 min', 1, 1, 3); -- Cancha 3, Mañana 18:00, Pendiente (ID 1)
GO

PRINT '--- Lote de datos insertado con éxito ---';
GO

-- -------------------------------------------------
-- EJEMPLO 1: Función Escalar (Validación)
-- -------------------------------------------------
CREATE FUNCTION fn_VerificarDisponibilidad (
    @id_cancha INT,
    @fecha DATE,
    @hora TIME
)
RETURNS BIT
AS
BEGIN
    DECLARE @disponible BIT = 1;
    DECLARE @id_estado_cancelado INT = 5; -- Asumimos ID 5 = Cancelada

    IF EXISTS (
        SELECT 1
        FROM reserva
        WHERE id_cancha = @id_cancha
          AND fecha = @fecha
          AND hora = @hora
          AND id_estado != @id_estado_cancelado
    )
    BEGIN
        SET @disponible = 0; -- No está disponible
    END

    RETURN @disponible;
END;
GO
PRINT 'FUNCIÓN: fn_VerificarDisponibilidad creada.';

-- -------------------------------------------------
-- EJEMPLO 2: Función Escalar (Cálculo)
-- -------------------------------------------------
CREATE FUNCTION fn_CalcularPrecioTurno (
    @id_cancha INT,
    @fecha DATE
)
RETURNS DECIMAL(12, 2)
AS
BEGIN
    DECLARE @precio_base DECIMAL(12, 2);
    DECLARE @precio_final DECIMAL(12, 2);
    
    -- Obtenemos el precio base de la cancha
    SELECT @precio_base = precio_hora FROM cancha WHERE id_cancha = @id_cancha;
    
    SET @precio_final = @precio_base;

    -- Lógica de negocio: Sábados (7) o Domingos (1) tienen 20% de recargo
    -- (OJO: Esto depende de la configuración de SET DATEFIRST)
    IF DATEPART(dw, @fecha) IN (1, 7)
    BEGIN
        SET @precio_final = @precio_base * 1.20;
    END

    RETURN @precio_final;
END;
GO
PRINT 'FUNCIÓN: fn_CalcularPrecioTurno creada.';

-- -------------------------------------------------
-- EJEMPLO 3: Función de Tabla (Reporte)
-- -------------------------------------------------
CREATE FUNCTION fn_ObtenerAgendaPorCancha (
    @id_cancha INT,
    @fecha DATE
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        r.id_reserva,
        r.hora,
        r.duracion,
        e.estado,
        u.nombre AS jugador_nombre,
        u.apellido AS jugador_apellido,
        u.telefono AS jugador_telefono
    FROM reserva r
    JOIN estado e ON r.id_estado = e.id_estado
    JOIN jugador j ON r.id_jugador = j.id_usuario_jugador
    JOIN usuario u ON j.id_usuario_jugador = u.id_usuario
    WHERE r.id_cancha = @id_cancha
      AND r.fecha = @fecha
      AND e.estado != 'Cancelada' -- Ocultar canceladas
);
GO
PRINT 'FUNCIÓN: fn_ObtenerAgendaPorCancha creada.';

-- -------------------------------------------------
-- EJEMPLO 4: Procedimiento (Gestión de Usuarios - Transaccional)
-- -------------------------------------------------
CREATE PROCEDURE sp_CrearUsuarioJugador
(
    @nombre VARCHAR(60),
    @apellido VARCHAR(60),
    @email VARCHAR(120),
    @dni VARCHAR(20),
    @telefono VARCHAR(25),
    @contraseña VARCHAR(100) 
)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @id_rol_jugador INT;
    DECLARE @id_nuevo_usuario INT;

    -- 1. Buscamos el ID del rol 'Jugador'
    SELECT @id_rol_jugador = id_rol FROM roles WHERE nombre_rol = 'Jugador';
    IF @id_rol_jugador IS NULL
    BEGIN
        RAISERROR('Error crítico: El rol "Jugador" no existe en la tabla de roles.', 16, 1);
        RETURN -1;
    END

    -- 2. Iniciamos la transacción
    BEGIN TRANSACTION;
    
    BEGIN TRY
        -- 3. Insertamos en la tabla 'usuario' (hasheando la contraseña)
        INSERT INTO usuario (nombre, apellido, email, contraseña, activo, telefono, dni, id_rol)
        VALUES (@nombre, @apellido, @email, HASHBYTES('SHA2_256', @contraseña), 1, @telefono, @dni, @id_rol_jugador);
        
        -- 4. Obtenemos el ID del usuario recién creado
        SET @id_nuevo_usuario = SCOPE_IDENTITY();

        -- 5. Insertamos en la tabla 'jugador' para especializarlo
        INSERT INTO jugador (id_usuario_jugador)
        VALUES (@id_nuevo_usuario);

        -- 6. Si todo salió bien, confirmamos la transacción
        COMMIT TRANSACTION;
        PRINT 'Jugador creado con éxito. ID = ' + CAST(@id_nuevo_usuario AS VARCHAR);
        RETURN @id_nuevo_usuario;

    END TRY
    BEGIN CATCH
        -- 7. Si algo falla, revertimos todo
        ROLLBACK TRANSACTION;
        
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        
        -- Manejo de errores comunes (Duplicados)
        IF ERROR_NUMBER() = 2627 OR ERROR_NUMBER() = 2601 -- Violación de UNIQUE KEY
        BEGIN
            IF @ErrorMessage LIKE '%UQ_usuario_email%'
                RAISERROR('El email "%s" ya se encuentra registrado.', 16, 1, @email);
            ELSE IF @ErrorMessage LIKE '%UQ_usuario_dni%'
                RAISERROR('El DNI "%s" ya se encuentra registrado.', 16, 1, @dni);
            ELSE
                RAISERROR(@ErrorMessage, 16, 1);
        END
        ELSE
        BEGIN
            RAISERROR(@ErrorMessage, 16, 1);
        END
        
        RETURN -1;
    END CATCH
END;
GO
PRINT 'PROCEDIMIENTO: sp_CrearUsuarioJugador creado.';

-- -------------------------------------------------
-- EJEMPLO 5: Procedimiento (Lógica de Negocio - Reservar)
-- -------------------------------------------------
CREATE PROCEDURE sp_RegistrarReserva
    (
    @id_jugador INT,
    @id_cancha INT,
    @fecha DATE,
    @hora TIME,
    @duracion VARCHAR(50) = '60 min'
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_estado_pendiente INT = 1; -- Asumimos ID 1 = Pendiente
    DECLARE @mensaje_error NVARCHAR(4000);

    BEGIN TRY
        
        -- 1. Validación de Jugador
        IF NOT EXISTS (SELECT 1 FROM jugador WHERE id_usuario_jugador = @id_jugador)
        BEGIN
            RAISERROR('El ID de jugador proporcionado no es válido.', 16, 1);
            RETURN;
        END

        -- 2. Validación de Disponibilidad (usando nuestra función)
        IF dbo.fn_VerificarDisponibilidad(@id_cancha, @fecha, @hora) = 0
        BEGIN
            RAISERROR('El turno para esa cancha, fecha y hora ya no está disponible.', 16, 1);
            RETURN;
        END

        -- 3. Inserción
        INSERT INTO reserva (fecha, hora, duracion, id_jugador, id_estado, id_cancha)
        VALUES (@fecha, @hora, @duracion, @id_jugador, @id_estado_pendiente, @id_cancha);
        
        -- 4. Devolvemos la reserva creada
        SELECT * FROM reserva WHERE id_reserva = SCOPE_IDENTITY(); 

    END TRY
    BEGIN CATCH
        SET @mensaje_error = ERROR_MESSAGE();
        RAISERROR(@mensaje_error, 16, 1);
    END CATCH
END;
GO
PRINT 'PROCEDIMIENTO: sp_RegistrarReserva creado.';

-- -------------------------------------------------
-- EJEMPLO 6: Procedimiento (Administrativo - Confirmar Pago)
-- -------------------------------------------------
CREATE PROCEDURE sp_ConfirmarPagoReserva
(
    @id_reserva INT,
    @id_metodo_pago INT
)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @id_estado_nuevo INT;
    
    IF NOT EXISTS (SELECT 1 FROM reserva WHERE id_reserva = @id_reserva)
    BEGIN
        RAISERROR('La reserva con ID %d no existe.', 16, 1, @id_reserva);
        RETURN;
    END

    -- Buscamos el estado "Confirmada" que coincida con el método de pago
    SELECT @id_estado_nuevo = id_estado
    FROM estado
    WHERE id_pago = @id_metodo_pago AND estado LIKE 'Confirmada%';

    IF @id_estado_nuevo IS NULL
    BEGIN
        RAISERROR('No se encontró un estado "Confirmada" para el método de pago ID %d.', 16, 1, @id_metodo_pago);
        RETURN;
    END

    UPDATE reserva
    SET id_estado = @id_estado_nuevo
    WHERE id_reserva = @id_reserva;

    PRINT 'Reserva ID %d actualizada a estado Confirmado (Método Pago ID %d).';
END;
GO
PRINT 'PROCEDIMIENTO: sp_ConfirmarPagoReserva creado.';

-- -------------------------------------------------
-- EJEMPLO 7: Procedimiento (Administrativo - Cancelar)
-- -------------------------------------------------
CREATE PROCEDURE sp_CancelarReserva
(
    @id_reserva INT
)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @id_estado_cancelado INT = 5; -- Asumimos ID 5 = Cancelada
    DECLARE @id_reserva_actual INT;

    -- Validar que la reserva exista y no esté ya cancelada
    SELECT @id_reserva_actual = id_reserva 
    FROM reserva 
    WHERE id_reserva = @id_reserva AND id_estado != @id_estado_cancelado;

    IF @id_reserva_actual IS NULL
    BEGIN
        RAISERROR('La reserva ID %d no existe o ya se encuentra cancelada.', 16, 1, @id_reserva);
        RETURN;
    END
    
    UPDATE reserva
    SET id_estado = @id_estado_cancelado
    WHERE id_reserva = @id_reserva;

    PRINT 'Reserva ID %d cancelada con éxito.';
END;
GO
PRINT '--- Todas las Funciones y SPs han sido creados ---';


PRINT '--- INICIANDO LOTE DE PRUEBAS ---';

-- (Variables para la fecha de "Mañana", que es donde insertamos la reserva)
DECLARE @FechaPrueba DATE = GETDATE() + 1;
DECLARE @FechaPruebaFinDeSemana DATE;

-- (Buscar el próximo sábado para probar el recargo de precio)
SET @FechaPruebaFinDeSemana = GETDATE();
WHILE DATEPART(dw, @FechaPruebaFinDeSemana) != 7
BEGIN
    SET @FechaPruebaFinDeSemana = @FechaPruebaFinDeSemana + 1;
END


-- -------------------------------------------------
-- PRUEBAS: Funciones de Validación y Cálculo
-- -------------------------------------------------


-- Prueba 1 (Función): Verificar turno OCUPADO (Debe devolver 0)
SELECT dbo.fn_VerificarDisponibilidad(3, @FechaPrueba, '18:00:00') AS TurnoOcupado;

-- Prueba 2 (Función): Verificar turno LIBRE (Misma cancha, otra hora) (Debe devolver 1)
SELECT dbo.fn_VerificarDisponibilidad(3, @FechaPrueba, '19:00:00') AS TurnoLibre_OtraHora;

-- Prueba 3 (Función): Verificar turno LIBRE (Otra cancha, misma hora) (Debe devolver 1)
SELECT dbo.fn_VerificarDisponibilidad(1, @FechaPrueba, '18:00:00') AS TurnoLibre_OtraCancha;

-- Prueba 4 (Función): Calcular precio en día de semana (Cancha 1: 5000)
SELECT dbo.fn_CalcularPrecioTurno(1, GETDATE() + 1) AS PrecioDiaSemana; -- Asumiendo que mañana no es Sab/Dom

-- Prueba 5 (Función): Calcular precio en Fin de Semana (Cancha 1: 5000 * 1.20 = 6000)
SELECT dbo.fn_CalcularPrecioTurno(1, @FechaPruebaFinDeSemana) AS PrecioFinDeSemana;
GO

-- -------------------------------------------------
-- PRUEBAS: sp_CrearUsuarioJugador (Transaccional)
-- -------------------------------------------------

-- Prueba 6 (Éxito): Crear un nuevo jugador
EXEC sp_CrearUsuarioJugador
    @nombre = 'Carlos',
    @apellido = 'Santana',
    @email = 'carlos.santana@email.com',
    @dni = '30111222',
    @telefono = '3794887766',
    @contraseña = 'Password123';
-- (Debería imprimir 'Jugador creado con éxito...' y devolver el nuevo ID)

-- Prueba 7 (Error): Intentar crear con DNI duplicado
EXEC sp_CrearUsuarioJugador
    @nombre = 'Carlos',
    @apellido = 'Santana',
    @email = 'carlos.OTROEMAIL@email.com',
    @dni = '30111222', -- DNI Repetido
    @telefono = '3794887766',
    @contraseña = 'Password123';
-- (Debería fallar y mostrar el error de RAISERROR: 'El DNI... ya se encuentra registrado.')

-- Prueba 8 (Error): Intentar crear con Email duplicado
EXEC sp_CrearUsuarioJugador
    @nombre = 'Juan',
    @apellido = 'Perez',
    @email = 'juan.perez@email.com', -- Email Repetido
    @dni = '50111222',
    @telefono = '3794112233',
    @contraseña = 'Password123';
-- (Debería fallar y mostrar el error de RAISERROR: 'El email... ya se encuentra registrado.')
GO

-- -------------------------------------------------
-- PRUEBAS: sp_RegistrarReserva
-- -------------------------------------------------

-- Prueba 9 (Éxito): Reservar un turno libre
-- (Juan Perez (ID 1) reserva la Cancha 1 mañana a las 19:00)
EXEC sp_RegistrarReserva
    @id_jugador = 1,
    @id_cancha = 1,
    @fecha = @FechaPrueba,
    @hora = '19:00:00';
-- (Debería devolver la fila de la reserva creada, ID 2)
DECLARE @id_reserva_nueva INT = (SELECT MAX(id_reserva) FROM reserva);

-- Prueba 10 (Error): Intentar reservar el turno ocupado del Lote de Datos
EXEC sp_RegistrarReserva
    @id_jugador = 1,
    @id_cancha = 3,
    @fecha = @FechaPrueba,
    @hora = '18:00:00';
-- (Debería fallar: 'El turno... ya no está disponible.')

-- Prueba 11 (Error): Intentar reservar el turno que acabamos de crear (Prueba 9)
EXEC sp_RegistrarReserva
    @id_jugador = 1,
    @id_cancha = 1,
    @fecha = @FechaPrueba,
    @hora = '19:00:00';
-- (Debería fallar: 'El turno... ya no está disponible.')

-- Prueba 12 (Error): Intentar reservar con un Jugador ID inválido
EXEC sp_RegistrarReserva
    @id_jugador = 999, -- No existe
    @id_cancha = 2,
    @fecha = @FechaPrueba,
    @hora = '20:00:00';
-- (Debería fallar: 'El ID de jugador... no es válido.')
GO

-- -------------------------------------------------
-- PRUEBAS: SPs Administrativos y Funciones de Reporte
-- -------------------------------------------------

-- (Situación inicial: Tenemos la Reserva ID 1 (Pendiente) y la ID 2 (Pendiente))
DECLARE @id_reserva_original INT = (SELECT MIN(id_reserva) FROM reserva);
DECLARE @id_reserva_nueva INT = (SELECT MAX(id_reserva) FROM reserva);

-- Prueba 13 (Reporte): Ver la agenda de la Cancha 3 (Debe mostrar la reserva ID 1)
PRINT 'Agenda Cancha 3 (Antes de confirmar):';
SELECT * FROM dbo.fn_ObtenerAgendaPorCancha(3, @FechaPrueba);

-- Prueba 14 (SP Admin): Confirmar el pago de la reserva ID 1 con 'Transferencia MP' (ID Pago 2)
EXEC sp_ConfirmarPagoReserva @id_reserva = @id_reserva_original, @id_metodo_pago = 2;
-- (Debería imprimir 'Reserva ID 1 actualizada...')

-- Prueba 15 (Reporte): Ver la agenda de la Cancha 3 (Ahora debe decir 'Confirmada (MP)')
PRINT 'Agenda Cancha 3 (Después de confirmar):';
SELECT * FROM dbo.fn_ObtenerAgendaPorCancha(3, @FechaPrueba);

-- Prueba 16 (Reporte): Ver la agenda de la Cancha 1 (Debe mostrar la reserva ID 2 'Pendiente')
PRINT 'Agenda Cancha 1 (Reserva nueva):';
SELECT * FROM dbo.fn_ObtenerAgendaPorCancha(1, @FechaPrueba);

-- Prueba 17 (SP Admin): Cancelar la reserva ID 2
EXEC sp_CancelarReserva @id_reserva = @id_reserva_nueva;
-- (Debería imprimir 'Reserva ID 2 cancelada...')

-- Prueba 18 (Reporte): Ver la agenda de la Cancha 1 (Ahora debe estar vacía)
PRINT 'Agenda Cancha 1 (Después de cancelar):';
SELECT * FROM dbo.fn_ObtenerAgendaPorCancha(1, @FechaPrueba);

-- Prueba 19 (Error SP Admin): Intentar cancelar la reserva ID 2 de nuevo
EXEC sp_CancelarReserva @id_reserva = @id_reserva_nueva;
-- (Debería fallar: 'La reserva ID 2... ya se encuentra cancelada.')
GO