
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

