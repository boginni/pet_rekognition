import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:pet_recognition/app/domain/constants.dart';

import '../domain/failures.dart';
import '../domain/pet_repository.dart';
import '../domain/search_result_entity.dart';

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
  Future<SearchResultEntity> search(XFile photo) async {
    try {
      final response = await dio.post(
        '/search',
        data: FormData.fromMap({
          "image": await MultipartFile.fromFile(photo.path),
        }),
      );

      return SearchResultEntity.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw const PetNotFoundFailure();
      }

      rethrow;
    }
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
