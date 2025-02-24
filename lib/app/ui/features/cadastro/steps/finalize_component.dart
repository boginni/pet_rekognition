import 'package:flutter/material.dart';

class FinalizeComponent extends StatelessWidget {
  const FinalizeComponent({super.key, required this.finalize});

  final VoidCallback finalize;

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
            Text('', textAlign: TextAlign.center),
            Expanded(
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.check_circle,
                    size: 128,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                Text(''),
                FilledButton(onPressed: finalize, child: Text('FINALIZAR')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
