class SearchResultEntity {
  List<Matches>? matches;

  SearchResultEntity({this.matches});

  SearchResultEntity.fromJson(Map<String, dynamic> json) {
    if (json['matches'] != null) {
      matches = <Matches>[];
      json['matches'].forEach((v) {
        matches!.add(Matches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (matches != null) {
      data['matches'] = matches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Matches {
  String? id;
  String? rawImage;
  String? facialImage;
  double? score;
  int? registerTimestamp;

  Matches({
    this.id,
    this.rawImage,
    this.facialImage,
    this.score,
    this.registerTimestamp,
  });

  Matches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rawImage = json['raw_image'];
    facialImage = json['facial_image'];
    score = json['score'];
    registerTimestamp = json['register_timestamp'];
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
