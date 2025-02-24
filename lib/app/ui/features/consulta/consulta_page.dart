import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pet_recognition/app/ui/features/consulta/steps/loading_component.dart';
import 'package:pet_recognition/app/ui/features/consulta/steps/pet_capture_component.dart';
import 'package:pet_recognition/app/ui/features/consulta/steps/result_aguia_component.dart';
import 'package:pet_recognition/app/ui/features/consulta/steps/result_crocodilo_component.dart';
import 'package:pet_recognition/app/ui/features/consulta/steps/result_lobo_component.dart';

import '../../widgets/pet_face_component.dart';
import 'consulta_controller.dart';
import 'consulta_state.dart';

class ConsultaPage extends StatefulWidget {
  const ConsultaPage({super.key});

  @override
  State<ConsultaPage> createState() => _ConsultaPageState();
}

class _ConsultaPageState extends State<ConsultaPage> {
  final state = ValueNotifier<ConsultaState>(ConsultaCapturaState());
  final controller = ConsultaController();
  CameraController? cameraController;
  XFile? capturedImage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  void init() async {
    cameraController = await controller.getCameraController();
    setState(() {});
  }

  Future<XFile?> _takePicture() async {
    final CameraController? cameraController = this.cameraController;
    if (cameraController == null || !cameraController.value.isInitialized) {
      print('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      print('Camera is already taking a picture');
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print('Error: ${e.code}\nError Message: ${e.description}');
      return null;
    }
  }

  Future<void> takePicture() async {
    final image = await _takePicture();

    if (image == null) {
      return;
    }

    capturedImage = image;
  }

  void finish() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    cameraBuilder(BuildContext context) {
      if (cameraController != null) {
        return CameraPreview(cameraController!);
      }

      return const CircularProgressIndicator();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Consulta')),
      body: ValueListenableBuilder<ConsultaState>(
        valueListenable: state,
        builder: (context, value, child) {
          return switch (value) {
            ConsultaCapturaState() => PetCaptureComponent(
              onNext: () async {
                await takePicture();
                state.value = ConsultaLoadingState();
                Future.delayed(const Duration(seconds: 2), () {
                  state.value = ConsultaResultCrocodiloState(
                    capturedImage!,
                    capturedImage!,
                  );
                });
              },
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
            ),
            ConsultaLoadingState() => const LoadingComponent(),
            ConsultaResultCrocodiloState(
              capturedImage: final capturedImage,
              bestMatch: final bestMatch,
            ) =>
              ResultCrocodiloComponent(
                onFinish: finish,
                leftImage: FileImage(File(capturedImage.path)),
                rightImage: FileImage(File(capturedImage.path)),
              ),
            ConsultaResultLoboState(
              accuracy: final accuracy,
              capturedImage: final capturedImage,
              bestMatch: final bestMatch,
            ) =>
              ResultLoboComponent(
                onFinish: finish,
                accuracy: accuracy,
                leftImage: FileImage(File(capturedImage.path)),
                rightImage: FileImage(File(capturedImage.path)),
              ),
            ConsultaResultAguiaState(
              accuracy: final accuracy,
              capturedImage: final capturedImage,
              bestMatch: final bestMatch,
            ) =>
              ResultAguiaComponent(
                onFinish: finish,
                accuracy: accuracy,
                leftImage: FileImage(File(capturedImage.path)),
                rightImage: FileImage(File(capturedImage.path)),
              ),
          };
        },
      ),
    );
  }
}
