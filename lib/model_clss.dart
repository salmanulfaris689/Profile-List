/*// To parse this JSON data, do
//
//     final profilemodel = profilemodelFromJson(jsonString);

import 'dart:convert';

Profilemodel profilemodelFromJson(String str) => Profilemodel.fromJson(json.decode(str));

String profilemodelToJson(Profilemodel data) => json.encode(data.toJson());

class Profilemodel {
  Profilemodel({
    this.data,
    this.total,
    this.page,
    this.limit,
  });

  List<Datum>? data;
  int? total;
  int? page;
  int? limit;

  factory Profilemodel.fromJson(Map<String, dynamic> json) => Profilemodel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    total: json["total"],
    page: json["page"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "total": total,
    "page": page,
    "limit": limit,
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
  Title ?title;
  String ?firstName;
  String ?lastName;
  String? picture;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: titleValues.map![json["title"]],
    firstName: json["firstName"],
    lastName: json["lastName"],
    picture: json["picture"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": titleValues.reverse![title],
    "firstName": firstName,
    "lastName": lastName,
    "picture": picture,
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
  Map<T, String> ?reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}*/


// To parse this JSON data, do
//
//     final profilemodel = profilemodelFromJson(jsonString);

import 'dart:convert';

Profilemodel profilemodelFromJson(String str) => Profilemodel.fromJson(json.decode(str));

String profilemodelToJson(Profilemodel data) => json.encode(data.toJson());

class Profilemodel {
    Profilemodel({
        this.id,
        this.title,
        this.firstName,
        this.lastName,
        this.picture,
        this.gender,
        this.email,
        this.dateOfBirth,
        this.phone,
        this.location,
        this.registerDate,
        this.updatedDate,
    });

    String? id;
    String? title;
    String? firstName;
    String? lastName;
    String? picture;
    String? gender;
    String? email;
    DateTime? dateOfBirth;
    String? phone;
    Location? location;
    DateTime? registerDate;
    DateTime? updatedDate;

    factory Profilemodel.fromJson(Map<String, dynamic> json) => Profilemodel(
        id: json["id"],
        title: json["title"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        picture: json["picture"],
        gender: json["gender"],
        email: json["email"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        phone: json["phone"],
        location: Location.fromJson(json["location"]),
        registerDate: DateTime.parse(json["registerDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "firstName": firstName,
        "lastName": lastName,
        "picture": picture,
        "gender": gender,
        "email": email,
        "dateOfBirth": dateOfBirth!.toIso8601String(),
        "phone": phone,
        "location": location!.toJson(),
        "registerDate": registerDate!.toIso8601String(),
        "updatedDate": updatedDate!.toIso8601String(),
    };
}

class Location {
    Location({
        this.street,
        this.city,
        this.state,
        this.country,
        this.timezone,
    });

    String? street;
    String? city;
    String? state;
    String? country;
    String? timezone;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        street: json["street"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        timezone: json["timezone"],
    );

    Map<String, dynamic> toJson() => {
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "timezone": timezone,
    };
}

