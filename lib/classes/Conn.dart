//  ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names

import 'Config.dart';
import 'Utils.dart';
import 'package:http/http.dart' as http;

//  Presenting the dead simple "Conn" class version 1.25, used
//  to make server connections and fetch JSON...
//  For a *REALLY* thourough explanation see END NOTES below...

class Conn {

  static const String _fileName = "Conn.dart";
  //  status and payload store server data
  static String base_url      = Config.server_address;
  static int    status        = 0;         //  200 means server status is good!
  static String payload       = '';       //  the JSON string returned
  static int    timeout_max   = 10;   //  max seconds

  //  fetch() is the meat of this class, used to grab the JSON
  static Future<bool> fetch ( String url ) async {
    bool flag = false;  // true means the connection was good!
    
    //  build the URL
    String full_url = base_url + url + '?t=1';
    
    // attempt a fetch
    Utils.log( _fileName, 'Conn.fetch() using "$full_url"');
    await http.get( Uri.parse( full_url ) ).timeout(
      Duration(seconds: timeout_max ),
      onTimeout: () { return http.Response('Error', 402); },
    ).then((response) async {               
      if(response.statusCode != 200 ) {
          status = response.statusCode;
          payload = '';
          flag = false;
        }
      else  {
          status = 200;
          payload = response.body;
          flag = true;
      }
    });      
    return flag;
  }
}

//  END NOTES
//  The goal of this class is to make all (or most!) server
//  interactions in one place.
//
//  There are two variables:
//    1. Conn.status    - this int shows the server status from the last attempt
//    2. Conn.payload   - this String is the JSON returned from the last attempt
//
//  Furthermore, there is one method: fetch()
//  This method tries to make the server connection.
//  Either way the Conn.status gets set (where 200 means "good").
//
//  If the connection is good, the JSON fetched is stored in
//  Conn.payload, ready to be parsed from whence it was called.
//
//  If the connection didn't work, and no JSON was returned,
//  Conn.payload is an enpty String.
//
//  Finally, if fetch() is passed testServer=true the fetch
//  will try to force a fetch from the debug server
//  (which is https://panelsplus.net)