import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_app/controllers/character_services.dart';
import 'package:rick_and_morty_app/models/character_list.dart';
import 'package:rick_and_morty_app/views/character_detail.dart';
import 'package:rick_and_morty_app/views/theme/app_colors.dart';
import 'package:rick_and_morty_app/views/theme/app_images.dart';
import 'package:rick_and_morty_app/views/theme/app_text_style.dart';

import 'components/app_bar_component.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  CharacterListPageState createState() => CharacterListPageState();
}

class CharacterListPageState extends State<CharacterListPage> {
  late Future<CharacterList> _characterList;
  late CharacterList _originalList;
  late final CharacterServices _characterServices = CharacterServices();
  final loading =
      ValueNotifier(true); // Mostra um indicador de loading para o usuário
  bool isFiltered = false;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _characterList = _characterServices.getAllCharacters();
    loadCharacter();
  }

  loadCharacter() async {
    loading.value = true;

    loading.value = false;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void Function(String)? onFilter(text) {
    if (text.toString().length >= 1) {
      setState(() {
        _characterList = _characterServices.getFilteredCharacters(name: text);
      });
    } else {
      if (isFiltered) {
        setState(() {
          _characterList = _characterServices.getAllCharacters();
          isFiltered = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      var nextPageTrigger = 0.8 *
          _scrollController
              .position.maxScrollExtent; // 80% do ListView mostrado
      var currentPosition = _scrollController.position.pixels;

      if (_scrollController.position.pixels > nextPageTrigger) {
        setState(() {
          _characterList = _characterServices.getNextCharacters(_originalList);
          _scrollController.jumpTo(currentPosition);
        });
      }
    });

    return Scaffold(
      appBar: appBarComponent(context, displaySearch: true, onFilter: onFilter),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AppImages.background,
                ),
                fit: BoxFit.cover)),
        child: Center(
            child: FutureBuilder<CharacterList?>(
                future: _characterList,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Text('none');
                    case ConnectionState.waiting:
                      return const CircularProgressIndicator();

                    default:
                      _originalList = snapshot.data!;
                      return ListView.builder(
                          key: const PageStorageKey('listviwerChar'),
                          itemCount: snapshot.data?.results?.length,
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            return Card(
                              color: AppColors.cardColorDark,
                              elevation: 3,
                              shadowColor: AppColors.shadowColor,
                              clipBehavior: Clip.antiAlias,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CharacterDetailPage(
                                        characterSelected:
                                            snapshot.data?.results?[index],
                                      ),
                                    ),
                                  ); //navegação para outra rota
                                },
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 160,
                                            height: 160,
                                            child: Image.network(
                                              snapshot
                                                  .data!.results![index].image,
                                              fit: BoxFit.fitWidth,
                                            )),
                                        SizedBox(
                                          height: 160,
                                          width: 160,
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 10),
                                              Text(
                                                snapshot
                                                    .data!.results![index].name
                                                    .toUpperCase(),
                                                style: GoogleFonts.alatsi(
                                                    textStyle: AppTextStyle
                                                        .styleBodyBig),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '${snapshot.data!.results![index].species} - ${snapshot.data!.results![index].status}',
                                                style: GoogleFonts.teko(
                                                    textStyle: AppTextStyle
                                                        .styleBodyBig),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text('Last known location:',
                                                  style: AppTextStyle
                                                      .styleSubTitle),
                                              Text(
                                                snapshot.data!.results![index]
                                                    .location.name,
                                                style: GoogleFonts.teko(
                                                    textStyle: AppTextStyle
                                                        .styleBodySmall),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                  }
                })),
      ),
    );
  }
}
