import 'package:flutter/material.dart';

class ConsultaErrorStepComponent extends StatelessWidget {
  const ConsultaErrorStepComponent({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16 * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 32,
          children: [
            Text('Algum Erro aconteceu', textAlign: TextAlign.center),
            Expanded(
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.error,
                    size: 128,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                Text(''),
                FilledButton(
                  onPressed: onPressed,
                  child: Text('TENTAR NOVAMENTE'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
