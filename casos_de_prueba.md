Id-nombre del sistema: Sistema Turnos YA
Version del caso de prueba: 1
Caso de uso: Agregar Nueva Cancha (Gestión Administrativa)
Autor del caso de prueba: Grupo 15
Nombre del probador: 
Fecha de creacion: 04/06/2026
Fecha de ejecucion: 

| CP | Objetivo | Datos de entrada | Resultado esperado | obtenido |
|---|---|---|---|---|
| 1 | Administrador olvida asignar un precio a la nueva cancha | Nombre: Cancha 5, Deporte: Fútbol, Apertura: 10:00, Cierre: 22:00, Precio: (campo en blanco). Click en Guardar | El sistema rechaza la operación validando el campo y mostrando el mensaje: El precio debe ser un número válido. | |
| 2 | Administrador configura mal el horario (cierre ilógico) | Nombre: Padel 2, Deporte: Padel, Apertura: 18:00, Cierre: 12:00, Precio: 3000. Click en Guardar | El sistema detecta el error temporal (cierre anterior a apertura sin ser de madrugada). Muestra: Revisar horarios: Si cruza la medianoche, el cierre debe ser de madrugada (antes de las 07:00 AM). | |


Id-nombre del sistema: Sistema Turnos YA
Version del caso de prueba: 1
Caso de uso: Reservar Turno (Interacción del Cliente)
Autor del caso de prueba: Grupo 15
Nombre del probador: 
Fecha de creacion: 04/06/2026
Fecha de ejecucion: 

| CP | Objetivo | Datos de entrada | Resultado esperado | obtenido |
|---|---|---|---|---|
| 1 | Cliente recurrente reserva rápidamente solo con su email | Selección: Jueves 20:00. Email: juan_frecuente@mail.com. Nombre: (vacío). Teléfono: (vacío). Click en Confirmar | El sistema busca en BD, reconoce que Juan ya existe, omite la validación de nombre/teléfono y aprueba la reserva vinculándola a su ID histórico. | |
| 2 | Cliente nuevo intenta reservar pero omite su celular | Selección: Jueves 19:00. Email: nuevo_cliente@mail.com. Nombre: Carlos. Teléfono: (vacío). Click en Confirmar | El sistema verifica que el email no existe en BD. Al ser nuevo, detiene el proceso y alerta: Como es tu primera vez, necesitamos tu Nombre y Teléfono. | |
| 3 | Alta concurrencia: Dos clientes clickean el mismo turno a la vez | Selección: Viernes 21:00 (Hora pico). El Cliente A confirma la reserva medio segundo antes que el Cliente B. | El sistema inserta el Detalle del Cliente A. Cuando el Cliente B llega a la BD, la validación atómica falla y le muestra: Este horario acaba de ser ocupado por otra persona. Recarga la agenda e intenta con otro. | |


Id-nombre del sistema: Sistema Turnos YA
Version del caso de prueba: 1
Caso de uso: Cancelar Reserva (Gestión de Reservas)
Autor del caso de prueba: Grupo 15
Nombre del probador: 
Fecha de creacion: 04/06/2026
Fecha de ejecucion: 

| CP | Objetivo | Datos de entrada | Resultado esperado | obtenido |
|---|---|---|---|---|
| 1 | Cliente suspende el partido y cancela el turno | El cliente ingresa su email, ve su reserva activa del domingo y hace clic en Cancelar. | El sistema elimina el detalle_reserva (liberando inmediatamente el horario en la agenda para que otro lo alquile) y actualiza el estado a Cancelado. | |
