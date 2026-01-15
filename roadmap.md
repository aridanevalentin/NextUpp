---Hoja de Ruta V2: NextUpp (TFC)
---FASE 1: Despliegue Técnico
Objetivo: Que el código compile. Sin esto no hay app.

[X] Configurar Entorno: Instalar Flutter SDK en casa.

[X] Fichero de Claves: Crear el archivo .env en la raíz con tus API Keys (TMDB y RAWG) para que no falle el flutter_dotenv.

[X] Generar Código Base de Datos: Ejecutar el comando mágico para que Drift funcione:

dart run build_runner build --delete-conflicting-outputs

(Esto solucionará los errores de app_database.g.dart que menciona el informe).

[X] Smoke Test: Ejecutar la app y ver que no explota al abrirse.

---FASE 2: Reforma Visual y UX
Objetivo: Que la app sea bonita, usable y tenga las pantallas de usuario listas (con datos falsos).

[X] Formato de Tiempo: Crear función formatDuration(int minutes) para que "125 min" se vea como "2h 5m".

[ ] Feedback al Usuario (Snackbars):

Implementar mensajes flotantes: "Película guardada correctamente" o "Eliminada de pendientes".

Manejar errores: Si falla la API, mostrar "Error de conexión" y no un pantallazo rojo.

[ ] Lógica de Estados:

Hacer que funcione el botón "Mover a Pendientes" desde Completados.

[ ] Maquetación de Usuario (Mockup):

Crear la pantalla UserProfileScreen (solo diseño, datos falsos).

Diseñar la zona de estadísticas (gráficos de horas o contadores simples).

Diseñar la tarjeta de "Review" para cuando sea social.

[ ] Mejora Estética General:

Unificar colores y tipografías.

Mejorar las tarjetas (MediaCard) para que las carátulas se vean bien.

---FASE 3: Backend & Usuarios (Firebase)
Objetivo: Conectar la app bonita a la nube.

[ ] Setup Firebase: Crear proyecto (Plan Spark - Gratis) y activar Auth/Firestore.

[ ] Login Real: Conectar la pantalla de login con Firebase Auth.

[ ] Sincronización: Subir los datos locales a la nube cuando haya internet.
:flag_ea:
Haz clic para reaccionar
:underage:
Haz clic para reaccionar
:white_check_mark:
Haz clic para reaccionar
Añadir reacción
Editar
Reenviar
Más
[12:37]jueves, 15 de enero de 2026 12:37
---FASE 4: Funcionalidad Social (El "9")
Objetivo: Ver perfiles reales.

[ ] Ver Perfil Ajeno: Llenar la pantalla de usuario (que hiciste en Fase 2) con datos reales de Firebase.

[ ] Feed de Actividad: Ver qué han visto tus amigos recientemente.

---FASE 5: Inteligencia Artificial (El "10")
Objetivo: Estimación y Recomendaciones.

[ ] Feature Estimación: Prompt para calcular cuándo terminas tu lista.

[ ] Feature Recomendador: Prompt para sugerencias basadas en gustos.

---FASE 6: Entrega
[ ] Icono y Splash: Branding final.

[ ] Limpieza de código: Eliminar TODOs y logs.

[ ] APK: Generar archivo instalable.