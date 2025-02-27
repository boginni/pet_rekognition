import 'package:flutter/material.dart';
import 'package:pet_recognition/app/ui/features/cadastro/cadastro_page.dart';
import 'package:pet_recognition/app/ui/features/main/home_page.dart';

import '../setup.dart';
import 'app_routes.dart';
import 'features/consulta/consulta_page.dart';
import 'features/recognition/recognition_page.dart';
import 'features/splash/splash_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashPage(),
        AppRoutes.recognition: (context) => const RecognitionPage(),
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.cadastro: (context) => const CadastroPage(),
        AppRoutes.consulta: (context) => const ConsultaPage(),
      },
    );
  }
}
