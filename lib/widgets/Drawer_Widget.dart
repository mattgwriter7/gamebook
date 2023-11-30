//  ignore_for_file: file_names, must_be_immutable, camel_case_types

//  Drawer_Widget version 1.01 (updated June 23, 2023)
//  To style this widget, see "START OF DEFAULT STYLING"
//  a few lines down...

import 'package:flutter/material.dart';

import '../classes/Config.dart';
import '../classes/Story.dart';
import '../classes/Utils.dart';

class Drawer_Widget extends StatelessWidget {
  Drawer_Widget ({Key? key}) : super(key: key);

  final filename = 'Drawer_Widget';
  final Divider divider = const Divider( color: Color(0xFFcccccc), thickness: 1 );

  void tappedDrawer( BuildContext context, String label ) {
    Utils.log( filename, 'tappedDrawer() labeled "$label"');

    if ( label == 'Back to Story' ) {
      Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
        Navigator.of(context).popAndPushNamed('Fetch_Page');
      }); 
    }
    else {
      Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
        switch ( label ) {
          case 'Load Story':
            Navigator.of(context).popAndPushNamed('Key_Page');
            break;
          case 'Settings': 
            Navigator.of(context).popAndPushNamed('Settings_Page');
            break;
          default: 
            Navigator.of(context).popAndPushNamed('About_Page');
          break;  
        }
        return;
        
      });  
    }
    return;
  }

  ListTile customListTile ( BuildContext context, String label, IconData icn ) {
    return ListTile(
      dense: true,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(10,0,0,0),
        child: Icon(
          icn,
          size: 27.0,
          color: Colors.black,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,0),
        child: Text( label ),
      ),
      onTap: () {
        tappedDrawer( context, label );
       },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Stack(
        children: [ 
          ListView(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,20,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,20,0,0),
                        child: Text('“${ Story.title }”',
                          style: TextStyle( fontFamily: 'Headline1', fontSize: 24, color: Colors.black ),
                          textAlign: TextAlign.center,
                          ),
                      ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,10,0,20),
                          child: Text('by ${ Story.author }',
                            style: TextStyle( fontSize: 14 ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,10,0,0),
                          child: Text('presented by',
                            style: TextStyle( fontSize: 11, color: Config.accent2_color,  ),
                          ),
                        ),                    
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/logo_square.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                height: (MediaQuery.of(context).size.height)/2-40,
              ),
              divider,
              customListTile( context, 'Load Story', Icons.menu_book ),
              Visibility(visible: Config.story_started, child: divider),
              Visibility(visible: Config.story_started, child: customListTile( context, 'Back to Story', Icons.arrow_back )),              
              divider,
              customListTile( context, 'Settings', Icons.settings ),
              divider,
              customListTile( context, 'About “U·CHOOSE”', Icons.help_outline_sharp ),
              divider,
              
              
            ],
          ),
               Positioned(
                right: 4,
                bottom: 3,
                child: Text('${ Config.app_version }', style: TextStyle( fontSize: 11 ))
              ),
        ],
      ),
    );
  }
}