// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';
import '../widgets/Drawer_Widget.dart';

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

  void fetchStory() {
    //  WILLFIX: this fake fetch needs to be replaced by a real one
    Future.delayed( Duration(milliseconds: Config.long_delay ), () async {
      Navigator.of(context).pushNamed('Title_Page');
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