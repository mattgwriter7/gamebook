// ignore_for_file: file_names

class Passage {

  static String title = '';                         //  0 is always title
  static String image = '';                         //  1 is always image...
  static String caption = '';                       //  2... 
  static String credit = '';                    
  static String description = '';               
  static String choice_heading = '';            
  static List<String> choice_text = [];             //  6 on are choices (of varying length)
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