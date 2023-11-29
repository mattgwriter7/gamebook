// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import '../../classes/Config.dart';
import '../../classes/Utils.dart';
import '../classes/Conn.dart';
import '../classes/Passage.dart';
import '../classes/Story.dart';
import '../models/Passage_Model.dart';

class Fetch_Page extends StatefulWidget {
  const Fetch_Page({ super.key });

  @override
  State createState() => _Fetch_PageState();
}

class _Fetch_PageState extends State<Fetch_Page> {

  // (this page) variables
  static const String filename = 'Fetch_Page.dart';
  
  // (this page) init and dispose
  @override
  void initState() {
    super.initState();
    Utils.log( filename, 'initState()' );
    WidgetsBinding.instance.addPostFrameCallback((_) => _addPostFrameCallbackTriggered(context));  

    //  fetch selected passage
    fetchPassage();    
  }

  @override
  void dispose() {
    Utils.log( filename, 'dispose()');
    super.dispose();
  }

  // (this page) methods
  void _buildTriggered() {
    Utils.log( filename, '_buildTriggered()');
  }

  void fetchPassage2() {
    //  WILLFIX: this fake fetch needs to be replaced by a real one
    Future.delayed( Duration(milliseconds: Config.long_delay ), () async {
      Navigator.of(context).pushReplacementNamed('Passage_Page');
    }); 
    return;
  }

  //  WILLFIX: REFACTORING NEEDED!
  //  This method same as fetchPassage() in Start_Page.dart
  void fetchPassage() async {
    bool flag = await Conn.fetch( Story.key + '/${ Config.last_fetced_file }.json' );
    if ( !flag ) {
      Utils.log( filename, '<<< BAD CONN! ${ Conn.status.toString() } >>>');
      //  WILLFIX: do something with this CONN error
    } 
    else {
      Utils.log( filename, '<<< GOOD CONN! >>>' );
      // fetch worked, so decode the JSON payload
      Passage_Model json = Passage_Model.fromJson(jsonDecode( Conn.payload ));      

      if ( json.key!.isEmpty) {
        //  WILLFIX: do something with error (no author node returned)
      }
      else {    
        Passage.title = json.title!;
        Passage.description = json.description!;
         
         // empty choices
         Passage.clearChoices();
         
         // loop choices
        int choice_max = json.choices!.length;
        for ( int i = 0; i < choice_max; i++ ) {
          Passage.addChoice( json.choices![i].text!, json.choices![i].key!);
          Utils.log ( filename, i.toString() + '. ' + json.choices![i].text! );
        }

        //  Fetches successfull, so redirect!
        Future.delayed( Duration(milliseconds: Config.long_delay ), () async {
          Navigator.of(context).pushReplacementNamed('Passage_Page');
        });   
      }
    }  
    return;
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
        return false;  
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,  
            //  backgroundColor: Config.main_background_color,
            body: Container(
              width: double.infinity,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,0,10,40),
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFFcccccc),
                        )
                      ),
                    ),
                  ),
                  Text('Fetching passage...'),
                ],
              ),
            ),
          ),
        ),
    );
  }
}