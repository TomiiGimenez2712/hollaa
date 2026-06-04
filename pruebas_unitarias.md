Pruebas unitarias

Nos han solicitado desarrollar el motor de validación de canchas para el sistema Turnos YA. Hemos realizado la clase Cancha y el método validarDatos, que acepta cinco parámetros y retorna un objeto literal indicando si es válido o el error.
static validarDatos(nombre, tipo, apertura, cierre, precio) { ... }
Teniendo en cuenta el análisis de los tipos de entrada para el método validarDatos indique las pruebas unitarias que realizaría completando la siguiente tabla:

| nombre | tipo | apertura | cierre | precio | Descripción | Resultado esperado |
|---|---|---|---|---|---|---|
| "Cancha 1" | 1 | "10:00" | "22:00" | 5000 | Inserción normal de una cancha con datos correctos | { valid: true } |
| "" | 1 | "10:00" | "22:00" | 5000 | Intento de validación con el campo nombre vacío | { valid: false, error: "El nombre es obligatorio." } |
| "Padel Pro" | null | "08:00" | "20:00" | 4000 | Inserción omitiendo el identificador del tipo de deporte | { valid: false, error: "El tipo de deporte es obligatorio." } |
| "Tenis" | 3 | "22:00" | "10:00" | 6000 | Inserción donde la hora de cierre cruza de día | { valid: false, error: "Revisar horarios: Si cruza la medianoche, el cierre debe ser de madrugada (antes de las 07:00 AM)." } |
| "Futbol 5" | 1 | "14:00" | "18:00" | -1500 | Inserción con un valor de precio negativo | { valid: false, error: "El precio debe ser un número válido." } |

Nos han solicitado desarrollar un validador de concurrencia para evitar que dos personas reserven a la misma hora. Hemos realizado la clase Detalle_Reserva y el método validarSolapamiento, que acepta tres parámetros y retorna un booleano.
static validarSolapamiento(id_cancha, fecha, hora) { ... }
Teniendo en cuenta el análisis de los tipos de entrada para el método validarSolapamiento indique las pruebas unitarias que realizaría completando la siguiente tabla:

| id_cancha | fecha | hora | Descripción | Resultado esperado |
|---|---|---|---|---|
| 1 | "2026-06-10" | "15:00" | Validación de un bloque horario que no tiene reservas previas | false |
| 1 | "2026-06-10" | "18:00" | Validación de un bloque horario que ya fue ocupado en BD | true |
| 99 | "2026-06-10" | "10:00" | Validación en una cancha inexistente (debería dar libre) | false |

Nos han solicitado desarrollar el alta de clientes en la base de datos. Hemos realizado la clase Jugador y el método crearJugador, que acepta tres parámetros y retorna un objeto Jugador.
static crearJugador(email, nombre, telefono) { ... }
Teniendo en cuenta el análisis de los tipos de entrada para el método crearJugador indique las pruebas unitarias que realizaría completando la siguiente tabla:

| email | nombre | telefono | Descripción | Resultado esperado |
|---|---|---|---|---|
| "juan@mail.com" | "Juan Perez" | "123456" | Creación exitosa de un jugador nuevo | Objeto Jugador con id asignado |
| null | "Juan Perez" | "123456" | Intento de creación sin enviar un email | Excepción de BD por null |
| "juan@mail.com" | "Otro Nombre" | "987654" | Intento de creación con un email ya existente en BD | Excepción por clave única |
