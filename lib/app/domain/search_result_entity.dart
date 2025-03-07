import 'package:pet_recognition/app/domain/result_match_entity.dart';

class SearchResultEntity {
  final List<ResultMatchesEntity>? matches;

  const SearchResultEntity({this.matches});

  factory SearchResultEntity.fromJson(Map<String, dynamic> json) {
    return SearchResultEntity(
      matches:
          json['matches'] != null
              ? (json['matches'] as List)
                  .map((i) => ResultMatchesEntity.fromJson(i))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'matches': matches?.map((e) => e.toJson()).toList()};
  }
}
