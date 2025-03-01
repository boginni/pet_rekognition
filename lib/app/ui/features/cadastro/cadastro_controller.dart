import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_recognition/app/domain/pet_repository.dart';

class CadastroController {
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

  Future<int> register(List<XFile> images, {Function(double)? callback}) async {
    int count = 0;
    final total = images.length.toDouble();

    final results = await Future.wait(
      images.map((image) async {
        try {
          await petRepository.register(image);
          return true;
        } catch (e) {
          return false;
        } finally {
          count++;
          callback?.call(count / total);
        }
      }),
    );

    return results.where((element) => element).length;
  }
}
