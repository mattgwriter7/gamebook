// ignore_for_file: prefer_const_constructors, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import '../classes/Conn.dart';
import '../models/Passage_Model.dart';
import '../models/Story_Model.dart';
import '../widgets/Drawer_Widget.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';
import '../classes/Passage.dart';
import '../classes/Story.dart';

class Start_Page extends StatefulWidget {
  const Start_Page({ super.key });

  @override
  State createState() => _Start_PageState();
}

class _Start_PageState extends State<Start_Page> {

  _Start_PageState() {
    Utils.log( 'Start_Page.dart', 'init' );
  }

  // (this page) variables
  static const String filename = 'Start_Page.dart';
  static bool loading_flag = true;
  static String story_title = 'Default Story';

  // (this page) init and dispose
  @override
  void initState() {
    super.initState();
    Utils.log( filename, 'initState()' );
    WidgetsBinding.instance.addPostFrameCallback((_) => _addPostFrameCallbackTriggered(context));

    //  fetch selected story
    fetchStory();
  }

  @override
  void dispose() {
    Utils.log( filename, ' dispose()');
    super.dispose();
  }

  // (this page) methods
  void _buildTriggered() {
    Utils.log( filename, ' _buildTriggered()');
  }

  void fetchStory() async {

    //  <<< START OF TRY FETCH >>>
    bool flag = await Conn.fetch( 'story.json' );
    if ( !flag ) {
      Utils.log( filename, '<<< BAD CONN! ${ Conn.status.toString() } >>>');
      //  WILLFIX: do something with this CONN error
    } 
    else {
      Utils.log( filename, '<<< GOOD CONN! >>>' );
      // fetch worked, so decode the JSON payload
      Story_Model json = Story_Model.fromJson(jsonDecode( Conn.payload ));      

      if ( json.author!.isEmpty) {
        //  WILLFIX: do something with error (no author node returned)
      }
      else {
        Story.title = json.title!;
        Story.author = json.author!;
        Story.url = json.url!;
        Story.key = json.key!;
        //  Story fetches successfull, now do Passage
        fetchPassage();   
      }
    }   
    return;
  }

  void fetchPassage() async {
    bool flag = await Conn.fetch( Story.key + '/START.json' );
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
          Navigator.of(context).pushNamed('Title_Page');
        });    
      }
    }  
    return;
  }


  void _addPostFrameCallbackTriggered( context ) {
    Utils.log( filename, ' _addPostFrameCallbackTriggered()');
  }

  // (this page) build
  @override
  Widget build(BuildContext context) {

    _buildTriggered();

    return WillPopScope(
      onWillPop: () async {
        return true;  //  this allows the back button to work
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    color: Config.debug_flag ? Colors.yellow : Colors.transparent,
                    child: Center(child: Text('U-CHOOSE', style: TextStyle( fontSize: 32, fontWeight: FontWeight.bold, color: Colors.pink )))),
                  Container(
                    height: 50,
                    color: Config.debug_flag ? Colors.blue : Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,0,10,0),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFFcccccc),
                              )
                            ),
                          ),
                        ),
                        SizedBox( width: 2 ),
                        Text('Loading "$story_title"'),
                      ],
                    )), 
                  Container(
                    height: 100,
                    color: Config.debug_flag ? Colors.green : Colors.transparent,
                    child: Center(
                      child: Visibility(
                        visible: !loading_flag,
                        child: Text('Oops! The story could\nnot be loaded', textAlign: TextAlign.center,)))),                        
                  Container(
                    height: 50,
                    color: Config.debug_flag ? Colors.blue : Colors.transparent,
                    child: Visibility(
                      visible: !loading_flag,
                      child: SizedBox(
                        width: 120,
                        height: 40,
                        child: ElevatedButton(
                          child: Text('try again'),
                          onPressed: ()  {
                      
                          },
                          ),
                      ),
                    )),                                     
                ],
              )
            ),
          ),
        ),
    );
  }
}