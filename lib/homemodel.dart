// To parse this JSON data, do
//
//     final homemodel = homemodelFromJson(jsonString);

import 'dart:convert';

Homemodel homemodelFromJson(String str) => Homemodel.fromJson(json.decode(str));

String homemodelToJson(Homemodel data) => json.encode(data.toJson());
class Homemodel {
  Homemodel({
    this.data,
    this.total,
    this.page,
    this.limit,
  });

  List<Datum>? data;
  int? total;
  int? page;
  int? limit;

  factory Homemodel.fromJson(Map<String, dynamic> json) => Homemodel(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    total: json["total"] == null ? null : json["total"],
    page: json["page"] == null ? null : json["page"],
    limit: json["limit"] == null ? null : json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "total": total == null ? null : total,
    "page": page == null ? null : page,
    "limit": limit == null ? null : limit,
  };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
  });

  String? id;
  Title? title;
  String? firstName;
  String? lastName;
  String? picture;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : titleValues.map![json["title"]],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    picture: json["picture"] == null ? null : json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : titleValues.reverse?[title],
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "picture": picture == null ? null : picture,
  };
}

enum Title { MR, MRS, MS, MISS }

final titleValues = EnumValues({
  "miss": Title.MISS,
  "mr": Title.MR,
  "mrs": Title.MRS,
  "ms": Title.MS
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}