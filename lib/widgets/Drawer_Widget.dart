//  ignore_for_file: file_names, must_be_immutable, camel_case_types

//  Drawer_Widget version 1.01 (updated June 23, 2023)
//  To style this widget, see "START OF DEFAULT STYLING"
//  a few lines down...

import 'package:flutter/material.dart';

import '../classes/Config.dart';

class Drawer_Widget extends StatelessWidget {
  Drawer_Widget ({Key? key}) : super(key: key);

  final Divider divider = const Divider( color: Color(0xFF666666), thickness: 1 );

  ListTile customListTile ( String label ) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(10,0,0,0),
        child: Icon(
          Icons.person,
          size: 20.0,
          color: Colors.black,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,0),
        child: Text( label ),
      ),
      onTap: () { },
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
                  padding: const EdgeInsets.fromLTRB(20,0,15,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,30,0,0),
                        child: Text('“The Dark Castle of Murwyche”',
                          style: TextStyle( fontFamily: 'Headline1', fontSize: 24, color: Colors.black ),
                          textAlign: TextAlign.center,
                          ),
                      ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,10,0,20),
                          child: Text('by M.R.Garvin',
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
                height: (MediaQuery.of(context).size.height)/2-20,
              ),
              divider,
              customListTile('Load New Story'),
              divider,
              customListTile('Settings'),
              divider,
              customListTile('About “U-CHOOSE”'),
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