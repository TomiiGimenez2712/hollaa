# Pruebas Unitarias

Nos han solicitado desarrollar el motor de validación de canchas para el sistema "Turnos YA". Hemos realizado la clase `Cancha` y el método estático `validarDatos`, que acepta cinco parámetros (nombre, tipo, apertura, cierre, precio) y retorna un objeto literal indicando si los datos son válidos o si existe un error.

`static validarDatos(nombre, tipo, apertura, cierre, precio) { ... }`

Teniendo en cuenta el análisis de los tipos de entrada para el método "validarDatos", indique las pruebas unitarias que realizaría completando la siguiente tabla:

| nombre | tipo | apertura | cierre | precio | Descripción | Resultado esperado |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| "Cancha 1" | 1 | "10:00" | "22:00" | 5000 | Inserción normal de una cancha con datos correctos | `{ valid: true }` |
| "" | 1 | "10:00" | "22:00" | 5000 | Intento de validación con el campo "nombre" vacío | `{ valid: false, error: "El nombre es obligatorio." }` |
| "Padel Pro" | `null` | "08:00" | "20:00" | 4000 | Inserción omitiendo el identificador del tipo de deporte | `{ valid: false, error: "El tipo de deporte es obligatorio." }` |
| "Tenis" | 3 | "22:00" | "10:00" | 6000 | Inserción donde la hora de cierre es menor a la de apertura | `{ valid: false, error: "La hora de cierre debe ser posterior a la de apertura." }` |
| "Futbol 5" | 1 | "14:00" | "18:00" | -1500 | Inserción con un valor de precio negativo | `{ valid: false, error: "El precio debe ser un valor positivo." }` |
| 12345 | "A" | "10:00" | "22:00" | "Gratis" | Inserción con tipos de datos incorrectos (letras en números) | `{ valid: false, error: ... }` (Error de tipado/validación) |
