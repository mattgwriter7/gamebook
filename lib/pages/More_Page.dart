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


class More_Page extends StatefulWidget {
  const More_Page({ super.key });

  @override
  State createState() => _More_PageState();
}

class _More_PageState extends State<More_Page> {

  // (this page) variables
  static const String filename = 'More_Page.dart';
  static bool result = false;
  
  // (this page) init and dispose
  @override
  void initState() {
    super.initState();
    Utils.log( filename, 'initState()' );
    WidgetsBinding.instance.addPostFrameCallback((_) => _addPostFrameCallbackTriggered(context));  
  }

  @override
  void dispose() {
    Utils.log( filename, 'dispose()');
    super.dispose();
  }

  //  from:
  //  https://stackoverflow.com/questions/63494817/flutter-returning-content-from-alertdialog
  Future<bool> confirmContinue( String prompt ) async {
    return await showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity( 0.75 ),
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text( prompt,
              style: TextStyle( fontWeight: FontWeight.bold, fontSize: 20 ),
              textAlign: TextAlign.center, 
            ),
            SizedBox( height: 20 ),
            Text( 'Doing so means you lose all progress and will need to start over.'),
          ],
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context, false);
            }, 
            icon: const Icon(
            Icons.close,
            // color: Colors.pink,
            size: 16.0,
          ),
            label: Text('no '),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,5,0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context, true);
              }, 
              icon: const Icon(
              Icons.check,
              size: 16.0,
            ),
              label: Text('yes '),
            ),
          ),
        ],
      ),
    );
  }

  // (this page) methods
  void _buildTriggered() {
    Utils.log( filename, '_buildTriggered()');
  }

  void _addPostFrameCallbackTriggered( context ) {
    Utils.log( filename, '_addPostFrameCallbackTriggered()');
  }

  // (this page) build
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
              title: const Text( 'More Options', style: TextStyle(color: Colors.white)),
              centerTitle: true,
              elevation: 0,
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
                    onPressed: () async {
                      result = await confirmContinue( 'Are you sure you\nwant to quit?');
                      if( result ) {                      
                        Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
                          Navigator.of(context).popUntil(ModalRoute.withName('Title_Page'));
                        });
                      }
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
                    onPressed: () async {
                      result = await confirmContinue( 'Are you sure you\want to quit?');
                      if( result ) {
                        Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
                          //Navigator.of(context).pushNamedAndRemoveUntil('Key_Page', (Route route) => false);
                          Navigator.of(context).popAndPushNamed('Key_Page');
                        }); 
                      }
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