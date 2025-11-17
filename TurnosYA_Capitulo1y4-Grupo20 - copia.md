# Gestion de Canchas "TurnosYA"

**Asignatura**: Bases de Datos I (FaCENA-UNNE)

**Integrantes**:
 - Galarza, Juan Cruz
 - Gauna, Lucia Carolina
 - Gimenez, Lautaro Nicolas
 - Gimenez, Tomas

**Año**: 2025

## ÍNDICE O SUMARIO

* [CAPÍTULO I: INTRODUCCIÓN](#1-cap%C3%ADtulo-i-introducci%C3%B3n)
    * [1.2 Caso de estudio](#12-caso-de-estudio)
    * [1.3 Objetivos y Fundamentación](#13-objetivos-y-fundamentaci%C3%B3n)
* [CAPÍTULO II: MARCO CONCEPTUAL REFERENCIAL](#cap%C3%ADtulo-ii-marco-conceptual-referencial)
    * [2.1 Estado del Arte (Situación del Problema)](#21-estado-del-arte-situaci%C3%B3n-del-problema)
    * [2.2 Conceptos Teóricos de Bases de Datos](#22-conceptos-te%C3%B3ricos-de-bases-de-datos)
* [CAPÍTULO III: METODOLOGÍA SEGUIDA](#cap%C3%ADtulo-iii-metodolog%C3%ADa-seguida)
    * [3.1 Fases del Proyecto](#31-fases-del-proyecto)
    * [3.2 Método de Educción de Requisitos](#32-m%C3%A9todo-de-educci%C3%B3n-de-requisitos)
    * [3.3 Requisitos Funcionales (RF) Relevantes para la BD](#33-requisitos-funcionales-rf-relevantes-para-la-bd)
    * [3.4 Herramientas Utilizadas](#34-herramientas-utilizadas)
* [CAPÍTULO IV: DESARROLLO DEL TEMA / PRESENTACIÓN DE RESULTADOS](#cap%C3%ADtulo-iv-desarrollo-del-tema--presentaci%C3%B3n-de-resultados)
    * [4.1 Diagrama Relacional](#41-diagrama-relacional)
    * [4.2 Diccionario de Datos](#42-diccionario-de-datos)
* [CAPÍTULO V: CONCLUSIONES](#cap%C3%ADtulo-v-conclusiones)
* [CAPÍTULO VI: BIBLIOGRAFÍA](#cap%C3%ADtulo-vi-bibliograf%C3%ADa)

---

## 1. CAPÍTULO I: INTRODUCCIÓN

El presente proyecto tiene como objetivo el desarrollo de una base de datos para la gestión de turnos en canchas deportivas. El sistema está diseñado para facilitar la reserva de turnos por parte de la administración para un manejo eficiente de las mismas. La base de datos tendra funcionalidades específicas para los distintos tipos de usuarios, y utilizará una base de datos actualizada para garantizar disponibilidad en tiempo real y seguridad en las reservas y pagos.

### 1.2 Caso de estudio

Hoy en día, hay una gran variedad de sistemas y aplicaciones dedicados a la gestión de reservas de canchas de pádel, fútbol y otros espacios deportivos. Sin embargo, muchas de estas soluciones no se adaptan a las necesidades específicas de los usuarios locales o resultan demasiado complicadas para que pequeños centros deportivos las utilicen de forma práctica en su día a día. Las soluciones más utilizadas dependen aún de interacciones manuales vía redes sociales o llamadas telefónicas, generando demoras, errores y dificultades para los administradores. Nuestro proyecto busca mejorar esa experiencia con una solución simple, eficiente y accesible.

### 1.3 Objetivos y Fundamentación
#### 1.3.1 Objetivo General

Desarrollar una base de datos que permita automatizar el proceso de reserva de canchas deportivas y la gestión de pagos, optimizando el trabajo y mejorando la experiencia.

#### 1.3.2 Objetivos específicos
* Permitir a los jugadores reservar turnos según disponibilidad.
* Facilitar al administrador la visualización, modificación y cancelación de turnos.
* Integrar métodos de pago para una gestión financiera más eficaz.
* Asegurar que toda la información esté centralizada y actualizada en tiempo real.

#### 1.3.3 Fundamentación
La necesidad de automatizar el proceso de gestión de canchas se basa en las dificultades reportadas por usuarios, quienes manifestaron problemas en la coordinación manual de turnos, errores en la disponibilidad y falta de control sobre pagos. El desarrollo de esta herramienta responde a esas demandas reales, mejorando la eficiencia operativa y la satisfacción de los usuarios.

---

## CAPÍTULO II: MARCO CONCEPTUAL REFERENCIAL

Este capítulo sitúa el problema dentro de un conjunto de conocimientos que permiten orientar la búsqueda y ofrecen una conceptualización adecuada de los términos utilizados.

### 2.1 Estado del Arte (Situación del Problema)

Como se mencionó en el caso de estudio, existe una amplia gama de aplicaciones para la gestión de espacios deportivos. Sin embargo, se detecta una brecha en soluciones que sean simultáneamente simples, accesibles para pequeños centros y que resuelvan los problemas centrales de la gestión manual. Los sistemas actuales a menudo fallan por depender de comunicación manual (redes sociales, teléfono), lo que introduce errores de disponibilidad, demoras en la confirmación y una gestión de pagos deficiente. Este proyecto se enfoca en resolver estos puntos débiles mediante una base de datos centralizada.

### 2.2 Conceptos Teóricos de Bases de Datos

El desarrollo de este proyecto se basa en los conceptos teóricos de los motores de bases de datos relacionales. Los pilares conceptuales de este trabajo son:

* **Modelo Relacional:** Es el modelo de base de datos en el que se basa el diseño. Consiste en representar los datos en tablas (relaciones) compuestas por filas (tuplas) y columnas (atributos).
* **Integridad Referencial:** Se garantiza mediante el uso de Claves Primarias (PK) y Claves Foráneas (FK), asegurando que las relaciones entre tablas sean consistentes. Por ejemplo, una `reserva` no puede existir sin un `usuario` y una `cancha` válidos.
* **Normalización:** El diseño separa entidades en distintas tablas (como `usuario`, `roles`, `cancha`, `tipo_cancha`) para evitar la redundancia de datos y mejorar la consistencia.
* **Control de Acceso Basado en Roles (RBAC):** Aunque la lógica de permisos reside en la aplicación, la base de datos soporta este modelo al centralizar a todos los agentes en una tabla `usuario` y asignarles permisos a través de una tabla `roles`. Esto permite que un "Administrador" tenga permisos sobre reservas que no le pertenecen.

---

## CAPÍTULO III: METODOLOGÍA SEGUIDA

En este capítulo se presenta el plan seguido y las acciones llevadas a cabo para realizar el trabajo, describiendo los pasos, actividades e instrumentos utilizados.

### 3.1 Fases del Proyecto

El desarrollo del proyecto de base de datos se estructuró en las siguientes fases:

1.  **Educción de Requisitos:** Se investigaron las necesidades y problemas de los usuarios clave (jugadores y cancheros).
2.  **Especificación de Requisitos:** Se documentaron los requisitos funcionales que la base de datos debe soportar.
3.  **Diseño Conceptual y Lógico:** Se creó el Diagrama Relacional para modelar la estructura de los datos y sus relaciones.
4.  **Implementación (Diseño Físico):** Se generó el Diccionario de Datos como paso previo a la creación de los *scripts* SQL para la implementación física.

### 3.2 Método de Educción de Requisitos

Para obtener los datos sobre las necesidades del sistema, se empleó la técnica de **entrevistas estructuradas**, dirigidas a los dos perfiles clave:

* **Jugadores** (usuarios finales de las reservas).
* **Cancheros** (administradores del sistema).

Esta técnica permitió obtener información precisa sobre los problemas de la gestión manual.

#### 3.2.1 Preguntas a jugadores
* ¿Con qué frecuencia reservas una cancha?
* ¿Qué dificultades enfrentan al reservar?
* ¿Te gustaría recibir confirmaciones automáticas?

#### 3.2.2 Preguntas a cancheros
* ¿Cómo gestionan actualmente los turnos?
* ¿Qué problemas surgen en la administración diaria?
* ¿Te interesaría agregar reservas manuales?

### 3.3 Requisitos Funcionales (RF) Relevantes para la BD

A partir de la educción, se definieron los requisitos funcionales que la base de datos debe ser capaz de soportar. Los más relevantes para el diseño de datos son:

| $N^{\circ}$ | Descripción |
| :--- | :--- |
| **RF#1** | El sistema deberá permitir a los usuarios (con rol "Jugador") visualizar un calendario de turnos. |
| **RF#2** | El sistema deberá permitir seleccionar cancha, fecha y horario entre los disponibles. |
| **RF#3** | El sistema deberá registrar reservas asociadas a un usuario. |
| **RF#4** | El sistema deberá permitir a un usuario (con rol "Canchero" o "Administrador") modificar, cancelar o agregar reservas manualmente. |
| **RF#5** | El sistema deberá mostrar el estado de pago de cada reserva. |
| **RF#6** | El sistema deberá permitir al jugador elegir el método de pago. |
| **RF#8** | El sistema deberá validar conflictos de horarios antes de confirmar reservas. |

### 3.4 Herramientas Utilizadas

* **Herramientas de modelado de datos:** Para la creación del Diagrama Relacional.
* **Procesadores de texto:** Para la elaboración de este informe y el Diccionario de Datos.

---

## CAPÍTULO IV: DESARROLLO DEL TEMA / PRESENTACIÓN DE RESULTADOS

Este capítulo presenta el diseño propuesto para la base de datos, respondiendo a los objetivos planteados.

### 4.1 Diagrama Relacional

El siguiente diagrama representa la estructura lógica de la base de datos "TurnosYA", incluyendo todas las entidades, sus atributos y las relaciones entre ellas.

*(Aquí debes insertar la imagen que me pasaste: `WhatsApp Image 2025-11-16 at 21.41.33.jpeg`)*

![Diagrama Relacional Actualizado](https://i.imgur.com/8Qn7mR7.png) 
*(Nota: Puse una imagen de marcador de posición. ¡Reemplaza el enlace de arriba con la ruta a tu imagen!)*

### 4.2 Diccionario de Datos

Define en detalle la estructura, tipo de datos y restricciones de cada tabla en el modelo relacional.

---
**Tabla: `roles`**

* **Descripción:** Almacena los tipos de perfiles de usuario (Ej: Administrador, Canchero, Jugador).

| Campo | Tipo | Restricciones | Significado |
| :--- | :--- | :--- | :--- |
| **id_rol** | INT | **PK** | Identificador único del rol. |
| nombre_rol | VARCHAR | NOT NULL | Nombre descriptivo del rol. |

---
**Tabla: `usuario`**

* **Descripción:** Almacena los datos de todas las personas que interactúan con el sistema.

| Campo | Tipo | Restricciones | Significado |
| :--- | :--- | :--- | :--- |
| **id_usuario** | INT | **PK** | Identificador único del usuario. |
| nombre | VARCHAR | NOT NULL | Nombre del usuario. |
| apellido | VARCHAR | NOT NULL | Apellido del usuario. |
| email | VARCHAR | UNIQUE, NOT NULL | Correo electrónico (para login). |
| contraseña | VARCHAR | NOT NULL | Contraseña encriptada. |
| activo | BOOLEAN | NOT NULL | Indica si el usuario está activo. |
| telefono | VARCHAR | NULL | Teléfono de contacto. |
| **id_rol** | INT | **FK** (roles) | Referencia al rol del usuario. |

---
**Tabla: `tipo_cancha`**

* **Descripción:** Almacena los tipos de canchas disponibles (Ej: Fútbol 5, Pádel, Tenis).

| Campo | Tipo | Restricciones | Significado |
| :--- | :--- | :--- | :--- |
| **id_tipo** | INT | **PK** | Identificador único del tipo. |
| descripcion | VARCHAR | NOT NULL | Nombre del tipo de cancha. |

---
**Tabla: `cancha`**

* **Descripción:** Almacena la información de cada cancha física disponible.

| Campo | Tipo | Restricciones | Significado |
| :--- | :--- | :--- | :--- |
| **id_cancha** | INT | **PK** | Identificador único de la cancha. |
| nro_cancha | VARCHAR | NOT NULL | Nombre o número de la cancha. |
| ubicacion | VARCHAR | NULL | Descripción de la ubicación. |
| precio_hora | DECIMAL | NOT NULL | Costo del alquiler por hora. |
| **id_tipo** | INT | **FK** (tipo_cancha) | Referencia al tipo de cancha. |

---
**Tabla: `metodo_pago`**

* **Descripción:** Almacena los métodos de pago aceptados (Ej: Efectivo, Tarjeta, Transferencia).

| Campo | Tipo | Restricciones | Significado |
| :--- | :--- | :--- | :--- |
| **id_pago** | INT | **PK** | Identificador único del método. |
| descripcion | VARCHAR | NOT NULL | Nombre del método de pago. |

---
**Tabla: `estado`**

* **Descripción:** Almacena los posibles estados de una reserva (Ej: Pendiente, Confirmada, Cancelada, Pagada).

| Campo | Tipo | Restricciones | Significado |
| :--- | :--- | :--- | :--- |
| **id_estado** | INT | **PK** | Identificador único del estado. |
| estado | VARCHAR | NOT NULL | Nombre del estado de la reserva. |
| **id_pago** | INT | **FK** (metodo_pago), **NULL** | Método de pago elegido (Opcional). |

---
**Tabla: `reserva`**

* **Descripción:** Tabla principal que almacena todas las reservas de turnos.

| Campo | Tipo | Restricciones | Significado |
| :--- | :--- | :--- | :--- |
| **id_reserva** | INT | **PK** | Identificador único de la reserva. |
| fecha | DATE | NOT NULL | Fecha del turno. |
| hora | TIME | NOT NULL | Hora de inicio del turno. |
| duracion | INT | NOT NULL | Duración en minutos. |
| **id_usuario** | INT | **FK** (usuario) | Usuario que realiza la reserva. |
| **id_estado** | INT | **FK** (estado) | Estado actual de la reserva. |
| **id_cancha** | INT | **FK** (cancha) | Cancha que ha sido reservada. |

---

## CAPÍTULO V: CONCLUSIONES

En este capítulo se interpreta el sentido de los resultados encontrados y se evalúa el cumplimiento de los objetivos planteados.

El desarrollo del proyecto ha permitido **alcanzar el objetivo general** de diseñar una base de datos centralizada y robusta para la gestión de turnos. El diseño final, presentado en el Capítulo IV, responde exitosamente a los requisitos relevados.

Analizando los **objetivos específicos** (Sección 1.3.2):

1.  **Reservar turnos:** Se cumple mediante la tabla `reserva`, que se vincula con un `id_usuario` (el jugador) y un `id_cancha`.
2.  **Gestión del administrador:** Este es el punto clave del nuevo diseño. Al centralizar a todos en la tabla `usuario` y asignarles un `id_rol`, el sistema (la aplicación) puede implementar la lógica de permisos. Un "Canchero" (rol) puede modificar o cancelar reservas (`UPDATE` en `reserva`) que pertenecen a otro `id_usuario` (el jugador), cumpliendo el requisito (RF#4).
3.  **Integrar métodos de pago:** Se logra mediante las tablas `metodo_pago` y `estado`. Una reserva puede tener un estado "Pagada" y una referencia al método con el que se abonó.
4.  **Información centralizada:** El modelo relacional propuesto logra centralizar toda la información operativa, evitando redundancia y asegurando la integridad referencial.

En conclusión, el diseño de la base de datos "TurnosYA" basado en una tabla `usuario` unificada con `roles` es una solución escalable y correcta que soluciona los problemas de gestión manual, permite el control administrativo y asegura la consistencia de los datos.

---

## CAPÍTULO VI: BIBLIOGRAFÍA

Se citan los documentos consultados y utilizados para la realización del trabajo.

| Referencias | Título |
| :--- | :--- |
| IEEE | Standard IEEE 830-1998 |
| Licenciatura en Sistemas de Información | PFC (Proyecto Final de Carrera) |
| Ingeniería en Software I | Plantilla de clase |
