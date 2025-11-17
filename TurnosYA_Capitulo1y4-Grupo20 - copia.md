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
    * [4.1 Diagrama de Entidad-Relación (DER)](#41-diagrama-de-entidad-relaci%C3%B3n-der)
    * [4.2 Diagrama Relacional](#42-diagrama-relacional)
    * [4.3 Diccionario de Datos](#43-diccionario-de-datos)
* [CAPÍTULO V: CONCLUSIONES](#cap%C3%ADtulo-v-conclusiones)
* [CAPÍTULO VI: BIBLIOGRAFÍA](#cap%C3%ADtulo-vi-bibliograf%C3%ADa)

---

## 1. CAPÍTULO I: INTRODUCCIÓN

El presente proyecto tiene como objetivo el desarrollo de una base de datos para la gestión de turnos en canchas deportivas. El sistema está diseñado para facilitar la reserva de turnos por parte de la administración para un manejo eficiente de las mismas. La base de datos tendra funcionalidades específicas para los distintos tipos de usuarios, y utilizará una base de datos actualizada para garantizar disponibilidad en tiempo real y seguridad en las reservas y pagos.

### 1.2 Caso de estudio

[cite_start]Hoy en día, hay una gran variedad de sistemas y aplicaciones dedicados a la gestión de reservas de canchas de pádel, fútbol y otros espacios deportivos[cite: 35]. [cite_start]Sin embargo, muchas de estas soluciones no se adaptan a las necesidades específicas de los usuarios locales o resultan demasiado complicadas para que pequeños centros deportivos las utilicen de forma práctica en su día a día[cite: 36]. [cite_start]Las soluciones más utilizadas dependen aún de interacciones manuales vía redes sociales o llamadas telefónicas, generando demoras, errores y dificultades para los administradores[cite: 37]. [cite_start]Nuestro proyecto busca mejorar esa experiencia con una solución simple, eficiente y accesible[cite: 38].

### 1.3 Objetivos y Fundamentación
#### 1.3.1 Objetivo General

[cite_start]Desarrollar una base de datos que permita automatizar el proceso de reserva de canchas deportivas y la gestión de pagos, optimizando el trabajo y mejorando la experiencia[cite: 41].

#### 1.3.2 Objetivos específicos
* [cite_start]Permitir a los jugadores reservar turnos según disponibilidad[cite: 43].
* [cite_start]Facilitar al administrador la visualización, modificación y cancelación de turnos[cite: 44].
* [cite_start]Integrar métodos de pago para una gestión financiera más eficaz[cite: 45].
* [cite_start]Asegurar que toda la información esté centralizada y actualizada en tiempo real[cite: 46].

#### 1.3.3 Fundamentación
[cite_start]La necesidad de automatizar el proceso de gestión de canchas se basa en las dificultades reportadas por usuarios, quienes manifestaron problemas en la coordinación manual de turnos, errores en la disponibilidad y falta de control sobre pagos[cite: 48]. [cite_start]El desarrollo de esta herramienta responde a esas demandas reales, mejorando la eficiencia operativa y la satisfacción de los usuarios[cite: 49].

---

## CAPÍTULO II: MARCO CONCEPTUAL REFERENCIAL

[cite_start]Este capítulo sitúa el problema dentro de un conjunto de conocimientos que permiten orientar la búsqueda y ofrecen una conceptualización adecuada de los términos utilizados[cite: 760, 761].

### 2.1 Estado del Arte (Situación del Problema)

[cite_start]Como se mencionó en el caso de estudio, existe una amplia gama de aplicaciones para la gestión de espacios deportivos[cite: 35]. Sin embargo, se detecta una brecha en soluciones que sean simultáneamente simples, accesibles para pequeños centros y que resuelvan los problemas centrales de la gestión manual. [cite_start]Los sistemas actuales a menudo fallan por depender de comunicación manual (redes sociales, teléfono), lo que introduce errores de disponibilidad, demoras en la confirmación y una gestión de pagos deficiente[cite: 37]. Este proyecto se enfoca en resolver estos puntos débiles mediante una base de datos centralizada.

### 2.2 Conceptos Teóricos de Bases de Datos

[cite_start]El desarrollo de este proyecto, como requisito de la asignatura, debe involucrar los conceptos teóricos de los motores de bases de datos aplicados a un caso práctico[cite: 720]. Los pilares conceptuales de este trabajo son:

* [cite_start]**Modelo Entidad-Relación (MER):** Es una herramienta para el modelado de datos que permite representar las entidades relevantes de un sistema de información (como `Jugador` [cite: 382][cite_start], `Cancha` [cite: 384][cite_start], `Reserva` [cite: 383]) y las relaciones entre ellas.
* **Modelo Relacional:** Es el modelo de base de datos en el que se basa el diseño. Consiste en representar los datos en tablas (relaciones) compuestas por filas (tuplas) y columnas (atributos). Este modelo garantiza la integridad y consistencia de los datos mediante el uso de claves primarias (PK) y claves foráneas (FK).
* **Sistema Gestor de Base de Datos (SGBD):** Es el software que permite definir, construir y manipular la base de datos, proporcionando mecanismos de control de acceso, concurrencia y recuperación de fallos.
* **SQL (Structured Query Language):** Es el lenguaje estándar utilizado para gestionar y consultar bases de datos relacionales.

---

## CAPÍTULO III: METODOLOGÍA SEGUIDA

[cite_start]En este capítulo se presenta el plan seguido y las acciones llevadas a cabo para realizar el trabajo, describiendo los pasos, actividades e instrumentos utilizados[cite: 767, 769, 772].

### 3.1 Fases del Proyecto

El desarrollo del proyecto de base de datos se estructuró en las siguientes fases:

1.  [cite_start]**Educción de Requisitos:** Se investigaron las necesidades y problemas de los usuarios clave[cite: 56].
2.  [cite_start]**Especificación de Requisitos:** Se documentaron los requisitos funcionales y no funcionales que la base de datos debe soportar[cite: 71].
3.  [cite_start]**Diseño Conceptual y Lógico:** Se creó el Diagrama Entidad-Relación [cite: 381] y el Diagrama Relacional.
4.  [cite_start]**Implementación:** Se generó el Diccionario de Datos [cite: 421] como paso previo a la creación de los *scripts* SQL para la implementación física.

### 3.2 Método de Educción de Requisitos

[cite_start]Para obtener los datos sobre las necesidades del sistema, se empleó la técnica de **entrevistas estructuradas**, dirigidas a los dos perfiles clave[cite: 56]:

* **Jugadores** (usuarios finales de las reservas).
* **Cancheros** (administradores del sistema).

[cite_start]Esta técnica permitió obtener información precisa sobre los problemas de la gestión manual[cite: 57]. [cite_start]Se incluyeron preguntas abiertas, cerradas y bipolares[cite: 58].

#### [cite_start]3.2.1 Preguntas a jugadores [cite: 59]
* [cite_start]¿Con qué frecuencia reservas una cancha? [cite: 60]
* [cite_start]¿Qué dificultades enfrentan al reservar? [cite: 61]
* [cite_start]¿Te gustaría recibir confirmaciones automáticas? [cite: 63]

#### [cite_start]3.2.2 Preguntas a cancheros [cite: 64]
* [cite_start]¿Cómo gestionan actualmente los turnos? [cite: 65]
* [cite_start]¿Qué problemas surgen en la administración diaria? [cite: 66]
* [cite_start]¿Necesitás ver reportes o estadísticas? [cite: 67]
* [cite_start]¿Te interesaría agregar reservas manuales? [cite: 68]

### 3.3 Requisitos Funcionales (RF) Relevantes para la BD

[cite_start]A partir de la educción, se definieron los requisitos funcionales [cite: 110] que la base de datos debe ser capaz de soportar. Los más relevantes para el diseño de datos son:

| $N^{\circ}$ | Descripción |
| :--- | :--- |
| **RF#1** | [cite_start]El sistema deberá permitir a los jugadores visualizar un calendario de turnos[cite: 111]. |
| **RF#2** | [cite_start]El sistema deberá permitir seleccionar cancha, fecha y horario entre los disponibles[cite: 111]. |
| **RF#3** | [cite_start]El sistema deberá registrar reservas con confirmación automática[cite: 111]. |
| **RF#4** | [cite_start]El sistema deberá permitir al canchero modificar, cancelar o agregar reservas manualmente[cite: 113]. |
| **RF#5** | [cite_start]El sistema deberá mostrar el estado de pago de cada reserva[cite: 115]. |
| **RF#6** | [cite_start]El sistema deberá permitir al jugador elegir el método de pago[cite: 117]. |
| **RF#8** | [cite_start]El sistema deberá validar conflictos de horarios antes de confirmar reservas[cite: 121]. |
| **RF#9** | [cite_start]El sistema deberá mostrar un resumen diario de reservas al canchero[cite: 123]. |

### 3.4 Herramientas Utilizadas

Para la gestión y diseño del proyecto se utilizaron las siguientes herramientas:

* [cite_start]**Herramientas de modelado de datos:** Se utilizaron herramientas gráficas para la creación del Diagrama Entidad-Relación [cite: 381] y el Diagrama Relacional.
* [cite_start]**Trello:** Para la organización de tareas y seguimiento del proyecto[cite: 286].
* [cite_start]**Procesadores de texto y hojas de cálculo:** Para la elaboración del Diccionario de Datos [cite: 421] y la documentación del informe.

---

## CAPÍTULO IV: DESARROLLO DEL TEMA / PRESENTACIÓN DE RESULTADOS

[cite_start]Este capítulo presenta los hallazgos y el diseño propuesto para responder a los objetivos planteados[cite: 775, 778].

### 4.1 Diagrama de Entidad-Relación (DER)

[cite_start]El primer resultado del modelado es el DER[cite: 381], que identifica las entidades principales y sus relaciones.

![Diagrama de Entidad - Relación del proyecto TurnosYA](https://i.imgur.com/URL-DEL-DIAGRAMA-ER.png) 
[cite_start]*(Nota: Reemplaza la URL de arriba con la imagen de tu DER, ya que no estaba en el .md original. Usé el DER del PDF como referencia [cite: 381])*

### 4.2 Diagrama Relacional

A partir del DER, se obtiene el modelo relacional, que representa la estructura de las tablas de la base de datos.

![diagrama_relacional](https://github.com/lautarogimenezx/TurnosYA/blob/main/docs/TurnosYA_relacional.png)

### 4.3 Diccionario de Datos

[cite_start]Define en detalle la estructura, tipo de datos, restricciones y significado de cada campo en las tablas del modelo relacional[cite: 421].

Acceso al documento [PDF](https://github.com/lautarogimenezx/TurnosYA/blob/main/docs/Diccionario_de_Datos-TurnosYA.pdf) del diccionario de datos.

[cite_start]*A continuación, se incluye un extracto del diccionario de datos a modo de ejemplo (extraído del trabajo de campo de Ingeniería de Software I [cite: 421]):*

[cite_start]**Tabla: Jugador** [cite: 427]
* [cite_start]**Descripción:** Almacena los datos personales de los jugadores del sistema[cite: 429].
* **Campos:**
    * [cite_start]`ID_jugador` (PK) [cite: 430, 444]
    * [cite_start]`nombre` [cite: 430]
    * [cite_start]`apellido` [cite: 430]
    * [cite_start]`email` [cite: 430]
    * [cite_start]`contraseña` [cite: 433]
    * [cite_start]`telefono` [cite: 436]

[cite_start]**Tabla: Reserva** [cite: 510]
* [cite_start]**Descripción:** Almacena la información de cada turno reservado[cite: 512].
* **Campos:**
    * [cite_start]`ID_reserva` (PK) [cite: 517, 546]
    * [cite_start]`fecha` [cite: 521]
    * [cite_start]`hora` [cite: 524]
    * [cite_start]`ID_estado` (FK) [cite: 527, 552]
    * [cite_start]`ID_jugador` (FK) [cite: 531, 549]
    * [cite_start]`ID_cancha` (FK) [cite: 534, 550]
    * [cite_start]`ID_canchero` (FK) [cite: 538, 551]

[cite_start]**Tabla: Estado_Reserva** [cite: 502]
* [cite_start]**Descripción:** Guarda la información sobre el estado de la reserva y el pago[cite: 505].
* **Campos:**
    * [cite_start]`ID_estado` (PK) [cite: 507]
    * [cite_start]`estado` (ej: pendiente, cancelado, aprobado) [cite: 507]
    * [cite_start]`metodo_pago` [cite: 507]
    * [cite_start]`estado_pago` (ej: en espera, aprobado, rechazado) [cite: 507]

---

## CAPÍTULO V: CONCLUSIONES

[cite_start]En este capítulo se interpreta el sentido de los resultados encontrados en el capítulo anterior [cite: 786] [cite_start]y se evalúa el cumplimiento de los objetivos del Trabajo Práctico[cite: 787].

[cite_start]El desarrollo del proyecto ha permitido **alcanzar el objetivo general** de diseñar una base de datos robusta para automatizar el proceso de reserva de canchas[cite: 41]. [cite_start]La información recogida durante la investigación, plasmada en los requisitos (Capítulo III) [cite: 110-127], se ha traducido exitosamente en un modelo de datos (Capítulo IV) que responde a las necesidades detectadas.

Analizando los **objetivos específicos** (Sección 1.3.2):

1.  [cite_start]**Reservar turnos:** El diseño lo permite mediante la relación entre las tablas `Jugador`, `Reserva` y `Cancha`[cite: 43, 381].
2.  [cite_start]**Gestión del administrador:** Se cumple al incluir la entidad `Canchero` [cite: 414] [cite_start]y relacionarla con la `Reserva` [cite: 381][cite_start], permitiendo la modificación, cancelación (actualizando el campo `estado` en `Estado_Reserva` [cite: 507][cite_start]) y visualización de turnos[cite: 44].
3.  [cite_start]**Integrar métodos de pago:** La tabla `Estado_Reserva` satisface este requisito al incluir los campos `metodo_pago` y `estado_pago`[cite: 45, 507].
4.  [cite_start]**Información centralizada:** El modelo relacional propuesto logra centralizar toda la información operativa en una única base de datos, garantizando la disponibilidad en tiempo real [cite: 46, 130] [cite_start]y respondiendo a la fundamentación inicial[cite: 48].

[cite_start]En conclusión, el diseño de la base de datos "TurnosYA" soluciona los problemas de coordinación manual, errores de disponibilidad y falta de control de pagos identificados en el caso de estudio[cite: 48].

---

## CAPÍTULO VI: BIBLIOGRAFÍA

[cite_start]Se citan los documentos consultados y efectivamente utilizados para la realización del trabajo [cite: 790][cite_start], basándose en las referencias del proyecto de Ingeniería de Software I[cite: 84].

| Referencias | Título |
| :--- | :--- |
| IEEE | [cite_start]Standard IEEE 830-1998 [cite: 84] |
| Licenciatura en Sistemas de Información | [cite_start]PFC (Proyecto Final de Carrera) [cite: 84] |
| Ingeniería en Software I | [cite_start]Plantilla de clase [cite: 84] |