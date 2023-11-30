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
  static String fail_mssg = 'Oops! The story could\nnot be loaded';
  static int fail_count = 0;

  // (this page) init and dispose
  @override
  void initState() {
    super.initState();
    Utils.log( filename, 'initState()' );
    WidgetsBinding.instance.addPostFrameCallback((_) => _addPostFrameCallbackTriggered(context));

    //  reset story
    Config.story_started = false;
    loading_flag = true;
    fail_mssg = 'Oops! The story could\nnot be loaded';
    fail_count = 0;
    
    //  if there is no story key, set it to DEFAULT
    if ( Config.story_key == '' ) {
      Config.story_key = 'DEFAULT';
    }
    //  now fetch the story
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
    //  bool flag = await Conn.fetch( 'story.json' );
    bool flag = await Conn.fetch( 'lookup.php?key=' + Config.story_key );
    if ( !flag ) {
      Utils.log( filename, '<<< BAD CONN! ${ Conn.status.toString() } >>>');
      //  WILLFIX: do something with this CONN error
      connectionFailedAgain();
    } 
    else {
      var response = json.decode(Conn.payload);
      if ( response['status'] == 'bad' ) {
        Utils.log( filename, '<<< GOOD CONN, BAD JSON! >>>');
        connectionFailedAgain();
      }
      else {
        Utils.log( filename, '<<< GOOD CONN, GOOD JSON! >>>');
        Story_Model json = Story_Model.fromJson(jsonDecode( Conn.payload ));
        Story.title = json.title!;
        Story.author = json.author!;
        Story.url = json.url!;
        Story.key = json.key!;

        //  Fetches successfull, so redirect!
        Future.delayed( Duration(milliseconds: Config.long_delay ), () async {
          Navigator.of(context).pushNamed('Title_Page');
        }); 
      }
    }   
    return;
  }

  void connectionFailedAgain() {
    Future.delayed( Duration(milliseconds: Config.long_delay ), () async {
      fail_count++;
      setState(() {
        loading_flag = false;
        if( fail_count > 4 ) { fail_mssg = 'Should you try a different\nStory Key?'; return; }
        if( fail_count > 2 ) { fail_mssg = 'Is your network\nconnected?'; return; }
      });  
    });     
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,70,0,0), //  WILLFIX: SEE NOTES.md "FORM ISSUE"
                    child: Container(
                      height: 120,
                      color: Config.debug_flag ? Colors.yellow : Colors.transparent,
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/logo_square.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    color: Config.debug_flag ? Colors.blue : Colors.transparent,
                    child: 
                      loading_flag  ?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,0,6,0),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.pink,
                                  )
                                ),
                              ),
                            ),
                            SizedBox( width: 2 ),
                            Text('Loading "${ Config.story_key }"', style: TextStyle( fontSize: 18)),
                          ],
                        )
                      : 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,0,6,0),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(
                                  Icons.error,
                                  size: 20,
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                            SizedBox( width: 2 ),
                            Text('Key "${ Config.story_key }" failed', style: TextStyle( fontSize: 18)),
                          ],
                        )                   
                  ),  
                  Container(
                    height: 100,
                    color: Config.debug_flag ? Colors.green : Colors.transparent,
                    child: Center(
                      child: Visibility(
                        visible: !loading_flag,
                        child: Text( fail_mssg, textAlign: TextAlign.center,)))),                        
                    Container(
                      height: 56,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Visibility(
                          visible: !loading_flag,
                          child: ElevatedButton(
                            child: Text('try again'),
                            onPressed: ()  {
                              setState(() {
                                loading_flag = true;
                              });
                              fetchStory();
                            },
                          ),
                        ),
                      ),
                    )                                    
                ],
              )
            ),
          ),
        ),
    );
  }
}