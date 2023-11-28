// ignore_for_file: file_names

class Passage {

  static String title = '';                         //  0
  static String image = '';                         //  1
  static String image_caption = '';                 //  2
  static String description = '';                   //  3
  static String choice_heading = '';                //  4
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

  static void fakeFill() {
    title = 'Fake Title';
    description = 'Mammas ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
    addChoice('Morbi malesuada velit vel volutpat egestas','KEY1');
    addChoice('In hac habitasse platea?','KEY2');
    addChoice('Duis suscipit lorem lorem, sed venenatis metus fringilla vel','KEY3');
    addChoice('Quisque rhoncus imperdiet orci','KEY4');
    addChoice('5th choice!','KEY5');
  }
}