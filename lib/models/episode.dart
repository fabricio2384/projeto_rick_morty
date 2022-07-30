class Episode {
  late int id;
  late String name;
  late String airDate;
  late String episode;
  late List<String> characters;
  late String url;
  late String created;

  Episode({id, name, airDate, episode, characters, url, created});

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        id: json['id'],
        name: json['name'],
        airDate: json['air_date'],
        episode: json['episode'],
        characters: json['characters'].cast<String>(),
        url: json['url'],
        created: json['created'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['air_date'] = airDate;
    data['episode'] = episode;
    data['characters'] = characters;
    data['url'] = url;
    data['created'] = created;
    return data;
  }
}
