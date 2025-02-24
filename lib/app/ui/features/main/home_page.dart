import 'package:flutter/material.dart';
import 'package:pet_recognition/app/ui/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  void navigateToCadastro() {
    Navigator.of(context).pushNamed(AppRoutes.cadastro);
  }

  void navigateToConsulta() {
    Navigator.of(context).pushNamed(AppRoutes.consulta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'PTLV-V5.0',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: () {
                        navigateToCadastro();
                      },
                      child: Text('Cadastrar Pet'),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        navigateToConsulta();
                      },
                      child: Text('Consultar Pet'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            left: 16,
            bottom: 16,
            child: Text("PET FACE ID", textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
