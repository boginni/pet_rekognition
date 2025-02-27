import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/pet_repository.dart';
import '../../app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool hasError = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  Future<void> init() async {
    try {
      final petRepository = GetIt.instance<PetRepository>();
      final dio = GetIt.instance<Dio>();

      final token = await petRepository.authenticate();
      dio.options.headers['Authorization'] = token;


      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    } catch (e) {
      setState(() {
        hasError = true;
      });
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            hasError
                ? Text('Autenticação Falhou, fale com o suporte')
                : CircularProgressIndicator(),
      ),
    );
  }
}
