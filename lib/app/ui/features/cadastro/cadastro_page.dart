import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/down_side_step_component.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/finalize_component.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/frontal_side_step_component.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/initial_step_component.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/left_side_step_component.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/right_side_step_component.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/up_side_step_component.dart';
import 'package:pet_recognition/app/ui/widgets/pet_face_component.dart';

import '../../widgets/camera_view_component.dart';
import 'cadastro_controller.dart';
import 'cadastro_state.dart';
import 'steps/error_step_component.dart';
import 'steps/loading_step_component.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage>
    with TickerProviderStateMixin {
  List<XFile> images = [];

  final state = ValueNotifier<CadastroState>(CadastroStartState());
  final controller = CadastroController();
  late final animationController = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  );

  bool isTakingPicture = false;

  CameraController? cameraController;
  int pageIndex = 0;

  final progress = ValueNotifier<double>(0);

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
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      return null;
    }

    try {
      final file = await cameraController.takePicture();
      return file;
    } on CameraException catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Erro ao tirar foto')));
      }

      return null;
    }
  }

  Future<XFile?> takePicture() async {
    if (isTakingPicture) {
      throw Exception('Already taking picture');
    }

    try {
      isTakingPicture = true;

      final image = await _takePicture();

      if (image != null) {
        return image;
      }
    } finally {
      isTakingPicture = false;
    }

    return null;
  }

  void finalize() {
    Navigator.of(context).pop();
  }

  Future<void> photoEvent() async {
    final image = await takePicture();

    if (image == null) {
      state.value = CadastroStartState();

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Erro ao tirar foto')));
      }

      return;
    }

    images.add(image);
  }

  void nextStep() async {
    final action = switch (state.value) {
      CadastroStartState() => () {
        state.value = LeftSideState();
      },
      LeftSideState() => () {
        state.value = FrontalSideState(2);
      },
      RightSideState() => () {
        state.value = FrontalSideState(3);
      },
      UpSideState() => () {
        state.value = FrontalSideState(4);
      },
      DownSideState() => () {
        state.value = FrontalSideState(5);
      },
      CadastroFinalizeState() => () {
        state.value = CadastroStartState();
      },
      CadastroLoadingState() => () {
        controller
            .register(
              images,
              callback: (p0) {
                progress.value = p0;
              },
            )
            .then((value) {
              if (value > 3) {
                state.value = CadastroFinalizeState();
                return;
              }

              state.value = CadastroErrorState();
            });
      },
      CadastroErrorState() => throw UnimplementedError(),
      FrontalSideState(index: final index) => () {
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
            state.value = CadastroLoadingState();
            break;
          default:
            state.value = CadastroStartState();
        }
      },
    };

    if ([
      CadastroFinalizeState,
      CadastroErrorState,
      CadastroLoadingState,
    ].any((element) => state.value.runtimeType == element)) {
      action();
      return;
    }

    await photoEvent();

    action();

    animationController.reset();
    animationController.forward().then((value) {
      nextStep();
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
      appBar: AppBar(title: const Text('Cadastro')),
      body: ValueListenableBuilder(
        valueListenable: state,
        builder: (context, currentState, child) {
          return switch (currentState) {
            CadastroStartState() => InitialStepComponent(
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
              onNext: () async {
                images.clear();
                animationController.reset();
                animationController.forward().then((value) {
                  nextStep();
                });
              },
            ),
            LeftSideState() => LeftSideStepComponent(
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
            ),
            RightSideState() => RightSideStepComponent(
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
            ),
            UpSideState() => UpSideStepComponent(
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
            ),
            DownSideState() => DownSideStepComponent(
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
            ),
            CadastroFinalizeState() => FinalizeComponent(
              finalize: () {
                finalize();
              },
            ),
            CadastroLoadingState() => ValueListenableBuilder(
              valueListenable: progress,
              builder: (context, value, child) {
                return LoadingStepComponent(progress: value);
              },
            ),
            CadastroErrorState() => ErrorStepComponent(
              onPressed: () {
                state.value = CadastroStartState();
              },
            ),
            FrontalSideState(index: final index) => FrontalSideStepComponent(
              index: index,
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
            ),
          };
        },
      ),
    );
  }
}
