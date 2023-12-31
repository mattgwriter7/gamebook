import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    //  Force portrait only
    //  see: https://stackoverflow.com/questions/51806662/how-to-set-landscape-orientation-mode-for-flutter-app
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Gamebook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Config.main_background_color,
        textTheme: TextTheme(
          bodyText2: TextStyle( color: Config.main_font_color, fontSize: Config.main_font_size ),
        ), 
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
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
        //  First page of the App is:
        'Start_Page': (context) => const Start_Page(),
        //  other pages
        'Title_Page': (context) => Title_Page(),
        'Passage_Page': (context) => const Passage_Page(),
        'Fetch_Page': (context) => const Fetch_Page(),
        'Key_Page': (context) => const Load_Page(),
        'Settings_Page': (context) => const Settings_Page(),
        'About_Page': (context) => const About_Page(),
        'More_Page': (context) => const More_Page(),
        'Credits_Page': (context) => const Credits_Page(),
        //  dummy pages (remove from production)
        'Dummies_Page': (context) => const Dummies_Page(),
        'Dummy1_Page': (context) => const Dummy1_Page(),
        'Dummy2_Page': (context) => const Dummy2_Page(),
        //  other pages (none yet)        
      },
    );
  }
}