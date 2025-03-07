class ResultMatchesEntity {
  final String? id;
  final String? rawImage;
  final String? facialImage;
  final double? score;
  final int? registerTimestamp;

  const ResultMatchesEntity({
    this.id,
    this.rawImage,
    this.facialImage,
    this.score,
    this.registerTimestamp,
  });

  factory ResultMatchesEntity.fromJson(Map<String, dynamic> json) {
    return ResultMatchesEntity(
      id: json['id'] as String?,
      rawImage: json['raw_image'] as String?,
      facialImage: json['facial_image'] as String?,
      score: (json['score'] as num?)?.toDouble(),
      registerTimestamp: json['register_timestamp'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['raw_image'] = rawImage;
    data['facial_image'] = facialImage;
    data['score'] = score;
    data['register_timestamp'] = registerTimestamp;
    return data;
  }
}
