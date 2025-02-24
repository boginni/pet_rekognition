import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/down_side_step_component.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/frontal_side_step_component.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/left_side_step_component.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/right_side_step_component.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/up_side_step_component.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/finalize_component.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/initial_step_component.dart';
import 'package:pet_recognition/app/ui/widgets/pet_face_component.dart';

import 'cadastro_controller.dart';
import 'cadastro_state.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final state = ValueNotifier<CadastroState>(CadastroStartState());
  final controller = CadastroController();

  CameraController? cameraController;
  int pageIndex = 0;
  final pictures = <XFile>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  Future<void> init() async {
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

    pictures.add(image);
  }

  void finalize() {
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
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: ValueListenableBuilder(
        valueListenable: state,
        builder: (context, value, child) {
          return switch (value) {
            CadastroStartState() => InitialStepComponent(
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
              onNext: () async {
                await takePicture();
                state.value = LeftSideState();
              },
            ),
            LeftSideState() => LeftSideStepComponent(
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
              onNext: () async {
                await takePicture();
                state.value = FrontalSideState(2);
              },
            ),
            RightSideState() => RightSideStepComponent(
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
              onNext: () async {
                await takePicture();
                state.value = FrontalSideState(3);
              },
            ),
            UpSideState() => UpSideStepComponent(
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
              onNext: () {
                takePicture();
                state.value = FrontalSideState(4);
              },
            ),
            DownSideState() => DownSideStepComponent(
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
              onNext: () async {
                await takePicture();
                state.value = FrontalSideState(5);
              },
            ),
            CadastroFinalizeState() => FinalizeComponent(
              finalize: () {
                finalize();
              },
            ),
            FrontalSideState(index: final index) => FrontalSideStepComponent(
              index: index,
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
              onNext: () async {
                await takePicture();

                switch (index) {
                  case 1:
                    state.value = LeftSideState();
                    break;
                  case 2:
                    state.value = RightSideState();
                    break;
                  case 3:
                    state.value = UpSideState();
                    break;
                  case 4:
                    state.value = DownSideState();
                    break;
                  case 5:
                    state.value = CadastroFinalizeState();
                    break;
                  default:
                    state.value = CadastroStartState();
                }
              },
            ),
          };
        },
      ),
    );
  }
}
