import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pet_recognition/app/ui/features/consulta/steps/consulta_error_step_component.dart';
import 'package:pet_recognition/app/ui/features/consulta/steps/loading_component.dart';
import 'package:pet_recognition/app/ui/features/consulta/steps/pet_capture_component.dart';
import 'package:pet_recognition/app/ui/features/consulta/steps/result_component.dart';
import 'package:pet_recognition/app/ui/features/consulta/steps/result_crocodilo_component.dart';

import '../../../domain/failures.dart';
import '../../widgets/camera_view_component.dart';
import '../../widgets/pet_face_component.dart';
import 'consulta_controller.dart';
import 'consulta_state.dart';

class ConsultaPage extends StatefulWidget {
  const ConsultaPage({super.key});

  @override
  State<ConsultaPage> createState() => _ConsultaPageState();
}

class _ConsultaPageState extends State<ConsultaPage>
    with SingleTickerProviderStateMixin {
  final state = ValueNotifier<ConsultaState>(ConsultaCapturaState());
  final controller = ConsultaController();
  CameraController? cameraController;
  XFile? capturedImage;
  late final animationController = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  );

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
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } catch (_) {
      return null;
    }
  }

  void finish() {
    Navigator.of(context).pop();
  }

  void search() async {
    final image = await _takePicture();

    if (image == null) {
      state.value = ConsultaErrorState();

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Erro ao tirar foto')));
      }

      return;
    }

    final imageProvider = FileImage(File(image.path));

    state.value = ConsultaLoadingState();

    try {
      capturedImage = image;
      final result = await controller.consultar(image);

      final matches = result.matches;

      if (matches?.isEmpty ?? true) {
        state.value = ConsultaNotFoundState(imageProvider);
        return;
      }

      final bestMatch = matches!.first;

      final score = bestMatch.score ?? 0;

      final url = bestMatch.rawImage ?? bestMatch.facialImage;

      state.value = ConsultaResultState(
        matches:
            matches..sort((a, b) => (b.score ?? 0).compareTo(a.score ?? 0)),
        petImage: imageProvider,
      );
    } on PetNotFoundFailure catch (_) {
      state.value = ConsultaNotFoundState(imageProvider);
    } catch (e) {
      state.value = ConsultaErrorState();
    }
  }

  void initCaptura() async {
    animationController.reset();
    animationController.forward().then((value) {
      search();
    });
  }

  @override
  Widget build(BuildContext context) {
    cameraBuilder(BuildContext context) {
      if (cameraController != null) {
        return ValueListenableBuilder(
          valueListenable: animationController,
          builder: (context, value, _) {
            final counter = (3 - (value * 3)).ceil();

            return Center(
              child: CameraViewComponent(
                progressValue: value,
                cameraController: cameraController!,
                showCounter: animationController.isAnimating,
                counter: counter,
              ),
            );
          },
        );
      }

      return Center(child: const CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Consulta')),
      body: ValueListenableBuilder<ConsultaState>(
        valueListenable: state,
        builder: (context, value, child) {
          return switch (value) {
            ConsultaCapturaState() => PetCaptureComponent(
              onNext: initCaptura,
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
            ),
            ConsultaLoadingState() => const LoadingComponent(),
            ConsultaErrorState() => ConsultaErrorStepComponent(
              onPressed: () {
                state.value = ConsultaCapturaState();
              },
            ),
            ConsultaNotFoundState() => ResultCrocodiloComponent(
              leftImage: value.petImage,
              onFinish: () {
                state.value = ConsultaCapturaState();
              },
            ),
            ConsultaResultState() => ResultComponent(
              matches: value.matches,
              petImage: value.petImage,
              onFinish: () {
                state.value = ConsultaCapturaState();
              },
            ),
          };
        },
      ),
    );
  }
}
