import 'package:flutter/material.dart';

void main() {
  runApp(const NextUppApp());
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

      // 'theme' es donde pondremos el tema de colores
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      // 'home' es la primera pantalla que se muestra
      home: const HomeScreen(),
    );
  }
}


// Primera pantala
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold es el esqueleto (como el Scaffold de Compose)
    return Scaffold(
      // TopAppBar
      appBar: AppBar(
        title: const Text('NextUpp'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // Contenido
      body: const Center(
        child: Text(
          '¡Mi app NextUpp funciona!',
        ),
      ),
    );
  }
}
