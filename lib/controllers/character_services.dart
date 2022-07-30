import 'dart:convert';

import 'package:rick_and_morty_app/infra/consts.dart';
import 'package:rick_and_morty_app/models/character.dart';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/models/character_list.dart';

class CharacterServices {
  Future<Character> getSingleCharacter(String id) async {
    var uri = Uri.parse('$urlBase$characterPath$id');

    final response = await http.get(uri);

    return Character.fromJson(json.decode(response.body));
  }

  Future<CharacterList> getAllCharacters() async {
    var uri = Uri.parse('$urlBase$characterPath');

    final response = await http.get(uri);

    dynamic list = json.decode(response.body);
    CharacterList charlist = CharacterList.fromJson(list);

    return charlist;
  }

  Future<CharacterList> getNextCharacters(
      CharacterList originalCharlist) async {
    if (originalCharlist.info?.next == null) {
      return originalCharlist;
    } else {
      String? url = originalCharlist.info?.next!;
      var uri = Uri.parse(url!);

      final response = await http.get(uri);

      dynamic list = json.decode(response.body);
      CharacterList charlist = CharacterList.fromJson(list);

      List<Character> l = charlist.results!;

      charlist.results = [];

      for (var originalChar in originalCharlist.results!) {
        charlist.results!.add(originalChar);
      }

      for (var newChar in l) {
        charlist.results!.add(newChar);
      }

      return charlist;
    }
  }

  Future<CharacterList> getFilteredCharacters({required name}) async {
    String filter = '';
    late CharacterList charlist;
    filter += (name != null) ? 'name=$name' : '';

    var uri = Uri.parse('$urlBase$characterPath?$filter');

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      charlist = await getAllCharacters();
    } else {
      dynamic list = json.decode(response.body);
      charlist = CharacterList.fromJson(list);
    }

    return charlist;
  }
}
