Pruebas unitarias

Nos han solicitado desarrollar el motor de validación para el alta y edición de canchas, respetando los diagramas de secuencia de la Funcionalidad 1. Hemos realizado el método validarDatos.
Firma: validarDatos(nombre, tipo, apertura, cierre, precio)
Teniendo en cuenta el análisis de los tipos de entrada para este contrato, indique las pruebas unitarias completando la tabla:

| nombre | tipo | apertura | cierre | precio | Descripción | Resultado esperado |
|---|---|---|---|---|---|---|
| "Cancha 1" | 1 | "10:00" | "22:00" | 5000 | Inserción normal de una cancha con datos correctos | { valid: true } |
| "" | 1 | "10:00" | "22:00" | 5000 | Intento de validación con el campo nombre vacío | { valid: false, error: "El nombre es obligatorio." } |
| "Tenis" | 3 | "22:00" | "10:00" | 6000 | Inserción donde la hora de cierre cruza de día | { valid: false, error: "Revisar horarios: Si cruza la medianoche, el cierre debe ser de madrugada..." } |
| "Futbol 5" | 1 | "14:00" | "18:00" | -1500 | Inserción con un valor de precio negativo | { valid: false, error: "El precio debe ser un número válido." } |

Nos han solicitado desarrollar el contrato principal de confirmación de turnos estipulado en la Sección 4.3 de la Funcionalidad 2.
Firma: confirmarReserva(id_jugador, id_cancha, fecha, hora, monto_total, id_estado)
Teniendo en cuenta el análisis de los tipos de entrada para este contrato, indique las pruebas unitarias completando la tabla:

| id_jugador | id_cancha | fecha | hora | monto_total | id_estado | Descripción | Resultado esperado |
|---|---|---|---|---|---|---|---|
| 5 | 1 | "2026-06-10" | "15:00" | 5000 | 1 | Confirmación exitosa de un turno libre | Instancia de Reserva y Detalle creados con éxito en BD |
| 5 | 1 | "2026-06-10" | "18:00" | 5000 | 1 | Confirmación sobre un horario que ya está ocupado | Aborta transacción por solapamiento y retorna error |
| null | 1 | "2026-06-10" | "15:00" | 5000 | 1 | Intento de confirmación sin identificar al jugador (null) | Falla validación / Excepción de BD por campo nulo |

Nos han solicitado desarrollar el motor de validación atómica que previene el Double-Booking, según la Conversación 5 del Contexto.
Firma: validarSolapamiento(id_cancha, fecha, hora)
Teniendo en cuenta el análisis de los tipos de entrada para este método, indique las pruebas unitarias completando la tabla:

| id_cancha | fecha | hora | Descripción | Resultado esperado |
|---|---|---|---|---|
| 1 | "2026-06-10" | "15:00" | Validación de un bloque horario libre en la base de datos | false |
| 1 | "2026-06-10" | "18:00" | Validación de un bloque horario que ya fue ocupado | true |

Nos han solicitado desarrollar el contrato principal para dar de baja un turno, estipulado en la Sección 4.3 de la Funcionalidad 2.
Firma: cancelarReserva(id_reserva)
Teniendo en cuenta el análisis de los tipos de entrada para este contrato, indique las pruebas unitarias completando la tabla:

| id_reserva | Descripción | Resultado esperado |
|---|---|---|
| 15 | Cancelación de una reserva que está actualmente activa (Pendiente) | Ejecuta liberarBloque(), pasa estado a Cancelado |
| 22 | Intento de cancelar una reserva cuyo estado ya era "Cancelado" | Excepción: "La reserva ya se encuentra cancelada." |

Nos han solicitado desarrollar la función que consulta a la base de datos qué turnos están ocupados para generar el calendario (Conversación 4).
Firma: buscarOcupacion(id_cancha, fecha)
Teniendo en cuenta el análisis de los tipos de entrada para este método, indique las pruebas unitarias completando la tabla:

| id_cancha | fecha | Descripción | Resultado esperado |
|---|---|---|---|
| 1 | "2026-06-10" | Búsqueda de ocupación en un día con 3 turnos reservados | Arreglo con 3 bloques horarios ocupados |
| 1 | "2026-06-11" | Búsqueda de ocupación en un día vacío (sin reservas) | Arreglo vacío [] |
