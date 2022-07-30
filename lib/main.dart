import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_app/views/character_list.dart';
import 'package:rick_and_morty_app/views/components/app_bar_component.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty_app/views/theme/app_colors.dart';
import 'package:rick_and_morty_app/views/theme/app_images.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, //Controle de orientação da tela
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ricky and Morty App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Rick and Morty'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBarComponent(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              color: Colors.transparent,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    child: Image.asset(
                      AppImages.portal,
                      fit: BoxFit.fill,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CharacterListPage(
                                    title: 'Ricky and Morty',
                                  )));
                    },
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CharacterListPage(
                                    title: 'Ricky and Morty',
                                  )));
                    },
                    title: Text('List all chars of Ricky and Morty',
                        style: GoogleFonts.shadowsIntoLight(
                          textStyle: const TextStyle(
                              color: AppColors.portalColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
