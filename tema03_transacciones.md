# Manejo de Transacciones en el Sistema de Gestión de Reservas

En una base de datos, una **transacción** es una unidad lógica de trabajo que agrupa una o varias operaciones (INSERT, UPDATE o DELETE) que deben ejecutarse de forma completa o deshacerse por completo.  
En otras palabras: *o se guarda todo, o no se guarda nada*.

Su objetivo principal es mantener la **integridad, consistencia y confiabilidad** de los datos, incluso frente a errores, fallas del sistema o múltiples usuarios operando al mismo tiempo.

---

### ¿Por qué son importantes en nuestro proyecto?

En nuestro sistema de gestión de reservas (cancha, jugador, estado, pagos), hay operaciones donde **no puede quedar nada a medias**.  
Por ejemplo:

- Registrar una nueva reserva implica:
  - validar que la cancha esté libre,
  - verificar que el jugador exista,
  - registrar el estado correspondiente,
  - guardar la reserva.

Si alguna de esas operaciones falla, la reserva no debe quedar “a medias”. Una transacción asegura justamente eso.

---

## Beneficios aplicados al proyecto

### ✔ Integridad de datos  
Evita que se confirme una reserva si la cancha ya estaba ocupada, o si falló el registro del estado o del jugador.

### ✔ Consistencia  
Permite que la base pase siempre de un estado válido a otro estado válido.

### ✔ Control de errores  
Si ocurre una falla en mitad de la operación, un **ROLLBACK** revierte todo.

### ✔ Concurrencia  
Cuando varios usuarios reservan al mismo tiempo, una transacción evita que se genere un doble turno en la misma fecha, hora y cancha.

---

## Ejemplos reales en nuestro sistema donde usaríamos transacciones

- Crear una nueva reserva.  
- Cambiar el estado de una reserva y registrar el pago.  
- Dar de alta un nuevo jugador junto a su usuario correspondiente.  
- Eliminar un usuario y, por ON DELETE CASCADE, eliminar su registro de jugador.

En todos estos casos, una transacción nos permite garantizar que las operaciones se ejecuten de manera segura y completa.

---

## Conclusión

Las transacciones son una herramienta fundamental para asegurar la calidad de los datos de nuestro sistema.  
Aplicarlas correctamente permite que la información del sistema de reservas —jugadores, canchas, estados y turnos— sea confiable, consistente y resistente a errores.


