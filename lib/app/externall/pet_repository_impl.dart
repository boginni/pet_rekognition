import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:pet_recognition/app/domain/constants.dart';

import '../domain/pet_repository.dart';

class PetRepositoryImpl implements PetRepository {
  final Dio dio;

  const PetRepositoryImpl(this.dio);

  @override
  Future<void> register(XFile image) async {
    await dio.post(
      '/register',
      data: FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path),
      }),
    );
  }

  @override
  Future<void> search(XFile photo) async {
    await dio.post('/search');
  }

  @override
  Future<String> authenticate() async {
    final response = await dio.post(
      '/authentication',
      data: {
        "clientId": Constants.clientId,
        "clientSecret": Constants.clientSecret,
      },
    );


    return response.data['token'];

  }
}
