import 'package:rick_and_morty_app/models/character.dart';

class CharacterList {
  late Info? info;
  late List<Character>? results;

  CharacterList({required this.info, required this.results});

  factory CharacterList.fromJson(Map<String, dynamic> json) {
    CharacterList charList = CharacterList(info: null, results: null);
    charList.info =
        (json['info'] != null ? Info.fromJson(json['info']) : null)!;

    List<Character> results = <Character>[];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        results.add(Character.fromJson(v));
      });
    }
    charList.results = results;
    return charList;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['info'] = info?.toJson();
    data['results'] = results?.map((v) => v.toJson()).toList();
    return data;
  }
}

class Info {
  late int count;
  late int pages;
  late String? next;
  late String? prev;

  Info(
      {required this.count,
      required this.pages,
      required this.next,
      required this.prev});

  Info.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pages = json['pages'];
    next = json['next'];
    prev = json['prev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['pages'] = pages;
    data['next'] = next;
    data['prev'] = prev;
    return data;
  }
}
