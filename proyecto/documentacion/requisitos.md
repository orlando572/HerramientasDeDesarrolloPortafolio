## Requisitos Funcionales y no funcionales - "RutaFácil AQP"

### Requisitos Funcionales
- El usuario podrá ingresar su ubicación actual mediante GPS o seleccionar un punto manualmente en el mapa.
- El usuario podrá buscar un destino por nombre, dirección, punto de interés (POI) o seleccionando en el mapa.
- La app mostrará las paradas/paraderos más cercanas al origen y al destino (con distancia a pie).
- La app calculará y mostrará las mejores rutas ordenadas por criterios configurables: menor tiempo total, menor distancia caminando, o combinación.
- La app indicará claramente: qué combi/línea tomar.
- Mostrará tiempo estimado desglosado: caminata + tiempo en vehículo.
- Permitirá ver el recorrido completo de una línea específica en el mapa (con todos sus paraderos).
- Mostrará información detallada de paraderos cercanos (nombre, líneas que pasan, ubicación exacta).
- El usuario podrá guardar rutas favoritas, direcciones frecuentes y paraderos favoritos.
- Soporte completo para modo offline: cálculo de rutas básicas, visualización de mapas y datos descargados (al menos las  rutas principales de Arequipa).
- El usuario podrá actualizar datos de rutas cuando tenga internet (sincronización con la nube).
- Opción de reportar problemas (ruta cerrada, paradero movido, accidente) para mejorar los datos - colectivamente.

### Requisitos No Funcionales
- La app funcionará solo en Android (versión mínima: Android 8.0 o superior, para cubrir la mayoría de dispositivos).
- Tiempo de respuesta para calcular una ruta: máximo 4 segundos (incluso en modo offline).
- Precisión de ubicación: combinar GPS, red móvil y Wi-Fi; solicitar permiso solo mientras se usa la app (no en segundo plano).
- Interfaz simple, intuitiva y accesible (pensada para usuarios de todas las edades, incluyendo adultos mayores). 
- Usar Jetpack Compose con buen contraste, tamaños de texto grandes y soporte para TalkBack.
- Idioma principal: español (preparar la app para futura internacionalización).

## Privacidad y seguridad:
- Solo usar ubicación con permiso explícito.
- Cumplir con Google Play Data Safety (declarar qué datos se recolectan).
- Encriptación de datos sensibles si guardas algo en la nube.

## Rendimiento y eficiencia:
- Funcionar fluidamente en celulares de gama baja (mínimo 2 GB RAM).
- Bajo consumo de batería (evitar polling constante del GPS).
- Tamaño de APK razonable (< 50 MB).

## Modo offline-first 
- La base de datos embebida (Room) será la fuente principal de verdad. La sincronización con la nube se hará en segundo plano con WorkManager.

## Escalabilidad y mantenibilidad
- Poder agregar, editar o desactivar rutas/paraderos fácilmente (a través de la nube o importando GTFS).
- Usar arquitectura limpia (MVVM o MVI con Jetpack Compose) para facilitar el mantenimiento.

## Fiabilidad 
- La app debe seguir funcionando aunque falle la sincronización temporalmente.

## Accesibilidad
- Cumplir con estándares básicos de Android Accessibility (contraste, etiquetas para screen readers, navegación por touch).