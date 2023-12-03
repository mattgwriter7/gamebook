// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../../classes/Config.dart';
import '../../classes/Utils.dart';

//  ----------------------------------------------------
//  At the bottom of the choices for each passage is a
//  "More Options" button.  Hat button takes you to
//  this page for "special" actions, like: "Quit story,
//  "View story credits," etc.
//  ----------------------------------------------------

class More_Page extends StatelessWidget {
  const More_Page({super.key});

  //  (this page) variables
  static const String filename = 'More_Page.dart';  

  // (this page) methods
  void _buildTriggered() {
    Utils.log( filename, '_buildTriggered()');
  }  

  @override
  Widget build(BuildContext context) {

    _buildTriggered();

    return WillPopScope(
      onWillPop: () async {
        //  is back button allowed? (true means yes!)       
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,  
          appBar: AppBar(
              title: const Text( 'More Options' ),
              centerTitle: true,
              backgroundColor: Colors.pink,
              elevation: 0,
              foregroundColor: Colors.black,
            ),
          //  drawer: Drawer_Widget(),
          body: Container(
            width: double.infinity,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container( 
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25,0,50,45),
                    child: Text( 'Choose "Back to story" to cancel and go back',
                    style: TextStyle( fontSize: 20 ), 
                    textAlign: TextAlign.center,),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(25,12,25,0),
                  child: ElevatedButton(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Back to story',
                        style: TextStyle(fontSize: 16),
                        ),
                    ),  
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(16,12,12, 12 ),
                    ),                        
                    onPressed: () {
                      Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
                        Navigator.of(context).pop();
                      }); 
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(25,12,25,0),
                  child: ElevatedButton(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Quit and go to title page',
                        style: TextStyle(fontSize: 16),
                        ),
                    ),  
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(16,12,12, 12 ),
                    ),                        
                    onPressed: () {
                      Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
                        Navigator.of(context).popUntil(ModalRoute.withName('Title_Page'));
                      });
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(25,12,25,0),
                  child: ElevatedButton(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Quit and try another story',
                        style: TextStyle(fontSize: 16),
                        ),
                    ),  
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(16,12,12, 12 ),
                    ),                        
                    onPressed: () {
                      Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
                        //Navigator.of(context).pushNamedAndRemoveUntil('Key_Page', (Route route) => false);
                        Navigator.of(context).popAndPushNamed('Key_Page');
                      }); 
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(25,12,25,20),
                  child: ElevatedButton(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Story credits',
                        style: TextStyle(fontSize: 16),
                        ),
                    ),  
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(16,12,12, 12 ),
                    ),                        
                    onPressed: () {
                      Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
                        //Navigator.of(context).pushNamedAndRemoveUntil('Key_Page', (Route route) => false);
                        Navigator.of(context).pushNamed('Credits_Page');
                      }); 
                    },
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}