## Explicación Conceptual del Modelo Adaptativo (Lógica de Diablo 2)

Para este modelo, implementamos una estructura dinámica adaptativa. En lugar de usar columnas fijas y rígidas para los atributos de los objetos o personajes, usamos un sistema de catálogos intermedios que permite expandir el juego sin tocar la estructura de la base de datos.

La lógica de las relaciones y el flujo de los IDs funciona de la siguiente manera:

### 1. El sujeto del juego (`entidades`)
En esta tabla es donde nacen los objetos o personajes físicos del juego (por ejemplo, un "Hacha de Verdugo" o un personaje "Bárbaro"). Esta tabla solo genera un `id` único para el objeto, pero no sabe qué propiedades tiene. El objeto no viaja hacia la izquierda del diagrama; se queda esperando a que las tablas de asignación le den sus poderes.

### 2. El corazón del diagrama (`opciones_validas`)
Como se puede ver en el flujo de las flechas, **`opciones_validas` es la entidad que conecta todo y sabe qué ID debe conectar con qué**. Esta tabla es el cerebro del sistema:
* **Hacia la izquierda**: Conecta con `grupos_opciones` (las categorías como "Resistencias" o "Clase Permitida") y con `opciones` (los nombres puros de los efectos como "Fuego" o "Bárbaro"). Al cruzar estos IDs, genera una regla de juego válida (Ej: el ID 500 ahora significa "Resistencia al Fuego").
* **Hacia la derecha**: Le sirve de puente a las tablas de asignación. Los objetos del juego no van a buscar los nombres de los efectos directamente a las tablas maestras; vienen a buscar el ID del "combo" ya armado acá en `opciones_validas`.

### 3. El filtro excluyente (`entidad_tiene_opcion_unica`)
Si nuestra entidad (el Hacha) tiene una propiedad que es excluyente y no se puede repetir (por ejemplo, que la "Clase Permitida" sea únicamente el Bárbaro), el dato se registra acá. 
* Se conecta con `entidades` por el `id_entidad` y con `opciones_validas` por el `id_opcion_valida`.
* **La clave es el atributo `id_grupo`**: Este atributo actúa como un candado (restricción Unique). Si el hacha ya está asignada al grupo "Clase Permitida" con la opción "Bárbaro", el sistema impide que se le meta otra fila con el mismo grupo para el Paladín.

### 4. Los modificadores acumulativos (`entidad_tiene_opciones_multiples`)
Si nuestra hacha tiene propiedades que sí se pueden acumular o tener varias de la misma categoría (como tener "Resistencia al Fuego" y "Resistencia al Rayo", o el espacio para los huecos de las gemas/runas), el flujo de datos viaja por acá.
* Conecta el ID del hacha con el ID de la opción válida en el catálogo central.
* Como acá no está el atributo `id_grupo` molestando, la base de datos nos libera el camino para meterle todas las resistencias o sockets en paralelo que el hacha necesite. El porcentaje final del stat (por ejemplo, un 30%) se le pega directamente a esta asignación.
