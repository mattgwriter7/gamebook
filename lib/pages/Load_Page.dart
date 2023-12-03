// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../classes/Config.dart';
import '../../classes/Utils.dart';

//  ----------------------------------------------------
//  This page accepts user input as "Story Keys".  These
//  simple keys -- only 4-8 characters, ALLCAPS -- are
//  then used by the Start_Page.dart to fetch their
//  corresponding stories.
//  WILLFIX: There is an issue where some devices
//  that are vertically short cause part of the text
//  field to be obscured (when the keyboard is shown.)
//  ----------------------------------------------------

class Load_Page extends StatefulWidget {
  const Load_Page({ super.key });

  @override
  State createState() => _Load_PageState();
}

class _Load_PageState extends State<Load_Page> {

  // (this page) variables
  static const String filename = 'Load_Page.dart';
  final _key_controller = TextEditingController(); //stores the user-entered username

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
    _key_controller.dispose();
    super.dispose();
  }

  // (this page) methods
  void _buildTriggered() {
    Utils.log( filename, '_buildTriggered()');
  }

  String massagedText( String str ) {
    String allowed_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_',
           new_str = '',
           char;
    int max_chars = str.length;   

    for (int i=0; i<max_chars; i++) {
      char = str[i];
      if( allowed_chars.contains(char)) new_str+= char;
    }           
    return new_str;
  }

  void keySubmitted() {
    Utils.log( filename, 'keySubmitted() with "${ _key_controller.text }"');  
    //  WILLFIX: needs some error checking
    String key = _key_controller.text;

    //  massage string
    key = massagedText( _key_controller.text ); 
    _key_controller.text = key;

    //  allow submission, even if blank
    Config.STORY_KEY = _key_controller.text;
    Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
      Navigator.of(context).pushReplacementNamed('Start_Page');
    });    

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
        return true;  
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,  
            //  backgroundColor: Config.main_background_color,
            appBar: AppBar(
              title: const Text( 'Load Story' ),
              centerTitle: true,
              backgroundColor: Colors.pink,
              elevation: 0,
              foregroundColor: Colors.black,
            ), //AppBar
            // drawer: DrawerWidget(),
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
                    height: 75,
                    color: Config.debug_flag ? Colors.blue : Colors.transparent,
                    child: Row(
                      children: [  
                        Expanded( flex: 1, child: SizedBox()),
                            
                            
                            
                                //  << START: TEXT FIELD >>
                                Expanded( flex: 2, child: 
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,10,0,0),
                                  child: TextField(
                                    onSubmitted: (value)  => keySubmitted(),
                                    controller: _key_controller,
                                    autocorrect: false,
                                    enableSuggestions: false,
                                    keyboardType: TextInputType.text,
                                    inputFormatters: [
                                      UpperCaseTextFormatter(),
                                    ],
                                    style: const TextStyle(
                                      color: Color(0xFF000000),
                                      decoration:TextDecoration.none,
                                      fontSize: 18,
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFFBBBBBB), width: 3.0)
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                        color: Color(0xFFBBBBBB), width: 3.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                        color: Colors.blue, width: 3.0),
                                      ),                                      
                                      isDense: true,
                                      hintText: "STORY_KEY",
                                      hintStyle: TextStyle(
                                        color: Color(0xFFcccccc),
                                        fontSize: 18,
                                      ),
                                      counterText: "", 

                                      fillColor: Color(0xFFeeeeee),
                                      filled: true,
                                      contentPadding: EdgeInsets.only(
                                        left: 20,
                                        bottom: 20,
                                        top: 20,
                                        right: 20),
                                    ),
                                    maxLength: 8,
                                  ),
                                ),
              
                                //  << END: TEXT FIELD >>     
                                
                                
              
                                
                                ),
                        Expanded( flex: 1, child: SizedBox()),    
                    ],)
                  ),
                  Container(
                    height: 100,
                    color: Config.debug_flag ? Colors.green : Colors.transparent,
                    child: Center(
                      child: Text( 'Keys are usually 4-8 letters\nand ALLCAPS', textAlign: TextAlign.center,))),                        
                    Container(
                      height: 56,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: Text('submit'),
                          onPressed: ()  {
                            keySubmitted();
                          }
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

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}