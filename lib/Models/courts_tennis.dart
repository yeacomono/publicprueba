enum Horario {
  Manana,
  Tarde,
  Noche,
}

class AgendCourtTennis {
  CourtTennis? courtTennis;
  String? username;
  DateTime? dateTime;
  String? drop;
  String? type;

  AgendCourtTennis(
      {this.courtTennis, this.username, this.dateTime, this.drop, this.type});
  factory AgendCourtTennis.fromJson(Map<String, dynamic> json) =>
      AgendCourtTennis(
        courtTennis: json["courtTennis"] == null
            ? null
            : CourtTennis.fromJson(json["courtTennis"]),
        username: json["username"],
        dateTime: json["day"] == null ? null : DateTime.parse(json["day"]),
        drop: json["drop"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        'courtTennis': courtTennis?.toJson(),
        'username': username,
        'day': dateTime?.toIso8601String(),
        'drop': drop,
        'type': type,
      };
}

class CourtTennis {
  String? name;
  String? direction;
  String? city;
  String? state;

  CourtTennis({
    this.name,
    this.direction,
    this.city,
    this.state,
  });

  factory CourtTennis.fromJson(Map<String, dynamic> json) {
    return CourtTennis(
      name: json['name'],
      direction: json['direction'],
      city: json['city'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'direction': direction,
      'city': city,
      'state': state,
    };
  }
}
