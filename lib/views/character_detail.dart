import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_app/models/character.dart';
import 'package:rick_and_morty_app/views/theme/app_colors.dart';
import 'package:rick_and_morty_app/views/theme/app_images.dart';
import 'package:rick_and_morty_app/views/theme/app_text_style.dart';
import 'components/app_bar_component.dart';

class CharacterDetailPage extends StatefulWidget {
  late Character character;

  final String title = "Detalhes do Personagem";

  CharacterDetailPage({Key? key, required characterSelected})
      : super(key: key) {
    character = characterSelected;
  }

  @override
  CharacterDetailPageState createState() {
    return CharacterDetailPageState(character);
  }
}

class CharacterDetailPageState extends State<CharacterDetailPage> {
  late Character character;

  CharacterDetailPageState(Character? characterState) {
    character = characterState!;
  }

  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AppImages.background,
                ), //Imagem gratuita retirada de um banco de imagens.
                fit: BoxFit.cover)),
        child: LayoutBuilder(
          builder: ((context, constraints) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: AppColors.cardColorDark,
                        shadowColor: AppColors.shadowColor,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5, //leve sombreamento
                        margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    character.image,
                                    height: 250,
                                    width: 250,
                                    fit: BoxFit.fill,
                                  ),
                                )),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.assignment_ind,
                                  color: AppColors.detailsAmber,
                                  size: 25,
                                ),
                                Text(
                                  character.name.toUpperCase(),
                                  style: GoogleFonts.alatsi(
                                      textStyle: AppTextStyle.styleBodyBig),
                                ),
                              ],
                            ),
                            Text(
                              '${character.species} - ${character.status} - ${character.gender}',
                              style: GoogleFonts.teko(
                                  textStyle: AppTextStyle.styleBodyBig),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('First appearance: ',
                                style: AppTextStyle.styleSubTitle),
                            Text(
                              character.firstAppearance,
                              style: GoogleFonts.teko(
                                textStyle: AppTextStyle.styleBodyBig,
                              ),
                            ),
                            Text('Origin:', style: AppTextStyle.styleSubTitle),
                            Text(
                              character.origin.name,
                              style: GoogleFonts.teko(
                                  textStyle: AppTextStyle.styleBodyBig),
                            ),
                            Text('Last known location:',
                                style: AppTextStyle.styleSubTitle),
                            Text(
                              character.location.name,
                              style: GoogleFonts.teko(
                                  textStyle: AppTextStyle.styleBodyBig),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]);
          }),
        ),
      ),
    );
  }
}
