// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';
import '../classes/Story.dart';
import '../classes/Passage.dart';
import '../widgets/Drawer_Widget.dart';

//  ----------------------------------------------------
//  This page is the UI part of the main loop of the 
//  "game."  It is where the magic happens.  It takes
//  the json fetched by "Fetch_Page.dart" and 
//  displays it in the UI.
//
//  Furthermore, this page accepts choices made by the user
//  to fetch the next passage.
//  ----------------------------------------------------

class Passage_Page extends StatefulWidget {
  const Passage_Page({ super.key });

  @override
  State createState() => _Passage_PageState();
}

class _Passage_PageState extends State<Passage_Page> {

  _Passage_PageState() {
    Utils.log( 'Passage_Page.dart', 'init' );
  }

  // (this page) variables
  static const String filename = 'Passage_Page.dart';
  static int button_count = -1;
  
  // (this page) init and dispose
  @override
  void initState() {
    super.initState();
    Utils.log( filename, 'initState()' );
    WidgetsBinding.instance.addPostFrameCallback((_) => _addPostFrameCallbackTriggered(context));

    //  WILLFIX: initialize the ui
    //    atm it is faked... choice_text and other stuff needs to
    //    come from Passage() class (already filled out)
    //    and this page is just for filling the ui
    button_count = -1;
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

  Container makeButton () {
    button_count++;
    int index = button_count;
    double _padme = 0; 
    if ( index == Passage.choice_text.length-1 ) { 
      _padme = 100;
      button_count = 0; //  WILLFIX: Hot Reload fix (remove from Production)
    }
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0,0,0,_padme),
        child: ElevatedButton(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              Passage.choice_text[index],
              style: TextStyle(fontSize: 16),
              ),
          ),  
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.fromLTRB(16,12,12, 12 ),
          ),                        
          onPressed: () {
            Utils.log( filename, 'clicked choice #' + index.toString() + ' ("${ Passage.choice_key[index] }")');
            //  <<< THIS IS WHERE NEXT JSON FILE IS SET >>>
            Config.PASSAGE_KEY = Passage.choice_key[index];
            
              //  SPECIAL CASE #1: RESTART 
              if ( Config.PASSAGE_KEY == 'RESTART') { 
                //  WILLFIX: Should this RESET go into Provider?
                Config.story_started = false;
                Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
                  Navigator.of(context).popUntil(ModalRoute.withName('Title_Page'));
                });
                return;
              }              
              //  SPECIAL CASE #2: MORE OPTIONS
              if ( Config.PASSAGE_KEY == 'MORE') { 
              Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
                Navigator.of(context).pushNamed('More_Page');
              }); 
                return;
              }              
              //  if no spcial case do a normal fetch:
              Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
                Navigator.of(context).pushReplacementNamed('Fetch_Page');
              }); 
              return;
                       
          },
        ),
      ),
    );
  }

  Widget passageRow( BuildContext context, int index) {

    Container bottom_box_padding = Container(height:25);
    if ( Passage.image + Passage.caption + Passage.credit == '') bottom_box_padding = Container(height:0);

    //  is there an image?  
    Container img_box = Container(height:0);
    if( Passage.image != '') {
      img_box = Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25,0,25,0),
          child: Container(
            //  book_cover.png should be 600x600 (or at least a square)
            width: double.infinity,
            child: Image.network( '${ Config.server_address }${ Story.key }/assets/${ Passage.image }.png',
            fit: BoxFit.cover,) 
          ),
        ), 
      );
    }

    //  is there an image credit?  
    Container credit_box = Container(height:0);
    if( Passage.credit != '') {
      credit_box = Container( width: double.infinity, color: Colors.transparent, child: Padding(
        padding: EdgeInsets.fromLTRB(25,0,25,0),
        child: Text( Passage.credit, style: TextStyle( fontStyle: FontStyle.italic, fontSize: 12 ), textAlign: TextAlign.right, ),
      ));
    }

    //  is there an image caption?  
    Container caption_box = Container(height:0);
    if( Passage.caption != '') {
      caption_box = Container( width: double.infinity, color: Colors.transparent, child: Padding(
        padding: EdgeInsets.fromLTRB(25,5,25,0),
        child: Text( Passage.caption, style: TextStyle( fontStyle: FontStyle.italic, fontSize: 14 ), textAlign: TextAlign.center, ),
      ));
    }

    switch ( index ) {
      case 0: // TITLE
        return  Container( 
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25,45,25,40),
            child: Text( Passage.title, style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold ), textAlign: TextAlign.center,),
          ),
        );
      case 1: // IMAGE
        return  img_box;
      case 2: // CREDIT
        return  credit_box;        
      case 3: // CAPTION
        return  caption_box;        
      case 4: // bottom_box_padding
        return  bottom_box_padding;        
      case 5: // DESCRIPTION
        return  Container( 
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25,0,25,0),
            child: Text( Passage.description,
            textAlign: TextAlign.left, ),
          ),
        );
      case 6: // WHAT DO YOU DO?
        return  Container( 
          child: Padding(
            padding: EdgeInsets.fromLTRB(25,30,25,30),
              child: GestureDetector(
                //  for debugging, a long press will reload this passage
                onLongPress: () { 
                  Navigator.of(context).pushReplacementNamed('Fetch_Page');  
                },
                child: Text(Passage.choice_heading, style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold ), textAlign: TextAlign.center,)),
          ),
        );    
      default:
        return Padding(
          padding: const EdgeInsets.fromLTRB(25,5,25,5),
          child: makeButton(),
        );
    }
  }

  Widget fullyBuiltPassage() {
    int index_max = 7+Passage.choice_text.length;
    return Column(
      children: List<Widget>.generate( index_max, (index) {
        return passageRow( context, index );
      })
    );
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
        return false;  //  this allows the back button to work
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
              child: SingleChildScrollView(child: fullyBuiltPassage()),
            ),
          ),
        ),
    );
  }
}