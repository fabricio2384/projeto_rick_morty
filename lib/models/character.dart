import 'package:flutter/cupertino.dart';

class Character {
  late int id;
  late String name;
  late String status;
  late String species;
  late String type;
  late String gender;
  late Origin origin;
  late Origin location;
  late String image;
  late List<String> episode;
  late String url;
  late String created;

  Character(
      {@required id,
      @required name,
      @required status,
      @required species,
      @required type,
      @required gender,
      @required origin,
      @required location,
      @required image,
      @required episode,
      @required url,
      @required created});

  factory Character.fromJson(Map<String, dynamic> json) {
    Character c = Character(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        type: json['type'],
        gender: json['gender'],
        origin:
            (json['origin'] != null ? Origin.fromJson(json['origin']) : null)!,
        location: (json['location'] != null
            ? Origin.fromJson(json['location'])
            : null)!,
        image: json['image'],
        episode: json['episode'].cast<String>(),
        url: json['url'],
        created: json['created']);

    c.id = json['id'];
    c.name = json['name'];
    c.status = json['status'];
    c.species = json['species'];
    c.type = json['type'];
    c.gender = json['gender'];
    c.origin =
        (json['origin'] != null ? Origin.fromJson(json['origin']) : null)!;
    c.location =
        (json['location'] != null ? Origin.fromJson(json['location']) : null)!;
    c.image = json['image'];
    c.episode = json['episode'].cast<String>();
    c.url = json['url'];
    c.created = json['created'];
    return c;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['species'] = species;
    data['type'] = type;
    data['gender'] = gender;
    data['origin'] = origin.toJson();
    data['location'] = location.toJson();
    data['image'] = image;
    data['episode'] = episode;
    data['url'] = url;
    data['created'] = created;
    return data;
  }

  String get firstAppearance {
    var episodeArray = episode[0].split('/');
    return '${episodeArray[4]}: ${episodeArray[5]}';
  }
}

class Origin {
  late String name;
  late String url;

  Origin({String? nameGiven, String? urlGiven}) {
    name = nameGiven!;
    url = urlGiven!;
  }

  factory Origin.fromJson(Map<String, dynamic> json) =>
      Origin(nameGiven: json['name'], urlGiven: json['url']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
