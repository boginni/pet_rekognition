import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class RecognitionPage extends StatefulWidget {
  const RecognitionPage({super.key});

  @override
  State<RecognitionPage> createState() => _RecognitionPageState();
}

class _RecognitionPageState extends State<RecognitionPage> {
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initCamera();
    });
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();


    if (cameras.isEmpty) {
      return;
    }

    final cameraController = CameraController(cameras[0], ResolutionPreset.max);

    await cameraController.initialize();


    setState(() {
      controller = cameraController;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child:
                controller == null
                    ? const CircularProgressIndicator()
                    : CameraPreview(controller!),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: FilledButton(
              onPressed: () async {
                await initCamera();
              },
              child: Text('Testar'),
            ),
          ),
        ],
      ),
    );
  }
}
