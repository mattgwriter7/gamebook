// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../../classes/Config.dart';
import '../../classes/Utils.dart';
import '../widgets/Drawer_Widget.dart';

class Title_Page extends StatelessWidget {
  const Title_Page({super.key});

  //  (this page) variables
  static const String _filename = 'Title_Page.dart';  
  static const String _story_title = 'The Long and Winding Road';  

  // (this page) methods
  void _buildTriggered() {
    Utils.log( _filename, '_buildTriggered()');
  }  

  @override
  Widget build(BuildContext context) {

    _buildTriggered();

    return WillPopScope(
      onWillPop: () async {
        //  is back button allowed? (true means yes!)       
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,  
            appBar: AppBar(
              title: const Text( '' ),
              centerTitle: true,
              backgroundColor: Colors.pink,
              elevation: 0,
              foregroundColor: Colors.black,
            ), //AppBar
            drawer: Drawer_Widget(),
          body: Container(
            width: double.infinity,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50,0,40,0),
                    child: Text( 
                      _story_title, 
                      textAlign: TextAlign.center,
                      style: TextStyle( fontFamily: 'Headline1', fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50,30,40,50),
                    child: Text( 'by Matt Garvin'),
                  ),
                  ElevatedButton(
                    child: Text('begin'),
                    onPressed: () {
                      Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
                        Navigator.of(context).pushNamed('Passage_Page');
                      }); 
                    },
                  )
                ],
              )
            ),
        ),
      ),
    );
  }
}