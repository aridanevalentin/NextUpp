import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextupp/core/service_locator.dart';
import 'package:nextupp/l10n/app_localizations.dart';
import 'package:nextupp/presentation/screens/home_screen.dart';
import 'package:nextupp/core/theme/app_theme.dart';

Future<void> main() async {
  // Asegura que los 'bindings' de Flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();
  // Carga el archivo .env
  await dotenv.load(fileName: ".env");
  // Configura todas las dependencias antes de que la app arranque.
  await setupLocator();

  runApp(const ProviderScope(child: NextUppApp()));
}

// Este es el Widget raíz de la aplicación
class NextUppApp extends StatelessWidget {
  // 'const' significa que este Widget no cambia (es bueno para el rendimiento)
  const NextUppApp({super.key});

  // El método 'build' es como la función @Composable.
  // Describe cómo debe ser la UI.
  @override
  Widget build(BuildContext context) {
    // MaterialApp es como tu 'MyWatchlistTheme' + 'Surface'.
    // Configura toda la app para que use Material Design.
    return MaterialApp(
      // Quita la molesta cinta de "DEBUG" de la esquina
      debugShowCheckedModeBanner: false,

      // 'title' es para el sistema operativo
      title: 'NextUpp',

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      // 'theme' es donde pondremos el tema de colores
      theme: AppTheme.darkTheme,

      // 'home' es la primera pantalla que se muestra
      home: const HomeScreen(),
    );
  }
}
