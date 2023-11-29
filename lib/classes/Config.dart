// ignore_for_file: file_names, constant_identifier_names, non_constant_identifier_names

//  Presenting the "Config" class (version 1.0)
//  This class is for "global variables" used by
//  the app.

import 'package:flutter/material.dart';

class Config {
  
  static const  String    app_name                  = "gamebook";
  static const  String    app_version               = "1.0.alpha.5";
  static bool             debug_flag                = false;
  
  //  timeouts and delays
  static int              server_timeout            = 10;     // seconds
  static int              short_delay               = 500;    // milliseconds
  static int              long_delay                = 1500;   // milliseconds

  // global "CSS" styles
  static Color            main_background_color     = const Color(0xFF1A1A1A);
  static Color            main_font_color           = Colors.black;
  static const double     main_font_size            = 16;
  static Color            button_background_color   = Colors.cyan.shade400;
  static Color            accent1_color             = Colors.grey;
  static Color            accent2_color             = const Color(0xFF333333);
  static Color            hilite1_color             = Colors.cyan.shade400;

  static Color            appbar_background         = Colors.transparent; // const Color.fromARGB(255, 174, 48, 48);
  static Color            appbar_foreground         = Colors.black;

  //  global "status" colors (for errors, warning, etc.)
  static List<Color> status_color = [
    Colors.grey,
    Colors.white,
    Colors.green,
    Colors.orange,
    Colors.red,
  ];

  //  CUSTOM STUFF! (from here on this is stuff unique to this App)

  static const String server_address = 'https://panelsplus.net/other/gamebook/';      //  WILLFIX: THIS MUST CHANGE TO CORRECT SERVER!!
  static String last_fetced_file = 'START';
}