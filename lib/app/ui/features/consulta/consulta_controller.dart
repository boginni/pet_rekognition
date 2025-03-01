import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/pet_repository.dart';

class ConsultaController {
  late final PetRepository petRepository = GetIt.instance.get();

  Future<CameraController> getCameraController() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      throw Exception('No cameras available');
    }

    final cameraController = CameraController(cameras[0], ResolutionPreset.max);

    await cameraController.initialize();

    return cameraController;
  }

  Future<void> consultar(XFile image) async {
    return await petRepository.search(image);
  }
}
