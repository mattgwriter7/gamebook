// ignore_for_file: file_names

class Passage {

  static String title = '';                         //  0 is always title
  static String image = '';                         //  1 is always image...
  static String caption = '';                       //  2... 
  static String description = '';                   //  3...
  static String choice_heading = '';                //  4...
  static List<String> choice_text = [];             //  5 on are choices (of varying length)
  static List<String> choice_key = [];

  static void clearChoices () {
    choice_text = [];
    choice_key = [];
    return;
  }

  static void addChoice ( String text, String key ) {
    choice_text.add( text );
    choice_key.add( key );
    return;
  }

}