import 'package:flutter/material.dart';
import './pages/_AllPages.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //  (this page) variables
  static const String filename = 'main.dart';   

  @override
  Widget build(BuildContext context) {
    //  Show main page loaded in log
    Utils.log( filename, '== init "${ Config.app_name }" version ${ Config.app_version } ==' );

    return MaterialApp(
      title: 'Gamebook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText2: TextStyle( color: Config.main_font_color, fontSize: Config.main_font_size ),
        ), 
        appBarTheme: AppBarTheme(
          backgroundColor: Config.appbar_background,
          foregroundColor: Config.appbar_foreground,
          iconTheme: const IconThemeData(color: Color(0xFFffffff)),
          titleTextStyle: const TextStyle(
            height: 1,
            fontSize: 18,
          ),
        ),
        cardTheme: const CardTheme(
          color: Color(0xFF222222),
        ), 
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
                MaterialStateProperty.all<Color>( Config.button_background_color ),
              padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(10,10,10,10)),
            ),
          ),
      ),
      initialRoute: 'Start_Page',
      //  initialRoute: 'Dummies_Page',
      routes: {
        //  start and end pages
        'Start_Page': (context) => const Start_Page(),
        'End_Page': (context) => const End_Page(),
        //  other pages
        'Title_Page': (context) => const Title_Page(),
        'Passage_Page': (context) => const Passage_Page(),
        'Fetch_Page': (context) => const Fetch_Page(),
        //  dummy pages (remove from production)
        'Dummies_Page': (context) => const Dummies_Page(),
        'Dummy1_Page': (context) => const Dummy1_Page(),
        'Dummy2_Page': (context) => const Dummy2_Page(),
        //  other pages (none yet)        
      },
    );
  }
}