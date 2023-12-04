// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';
import '../classes/Story.dart';
import '../classes/Passage.dart';
import '../widgets/Drawer_Widget.dart';

//  ------------------------------------------------------------
//  This page is the UI part of the main loop of the "game."  It
//  is where the magic happens.
//  For a *REALLY* thourough explanation see END NOTES below...
//  ------------------------------------------------------------

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

    //  button_count is used by makeButton() to
    //  keep track of which button is being made
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

//  ----------------------------------------------------
//  makeButton() returns the buttons/choices at the 
//  of each passage
//  When a button is clicked, the PASSAGE KEY is used
//  to fetch the next passage, and the loop continues...
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
            padding: EdgeInsets.fromLTRB( 16,12,12, 12 ),
          ),                        
          onPressed: () {
            Utils.log( filename, 'clicked choice #' + index.toString() + ' ("${ Passage.choice_key[index] }")');
            //  <<< THIS IS WHERE NEXT "PASSAGE KEY"/"JSON FILE" IS SET >>>
            Config.PASSAGE_KEY = Passage.choice_key[index];
            
              //  SPECIAL CASE #1: RESTART KEY
              if ( Config.PASSAGE_KEY == 'RESTART') { 
                //  WILLFIX: Should this RESET go into Provider?
                Config.story_started = false;
                Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
                  Navigator.of(context).popUntil(ModalRoute.withName('Title_Page'));
                });
                return;
              }              
              //  SPECIAL CASE #2: MORE OPTIONS KEY
              if ( Config.PASSAGE_KEY == 'MORE') { 
              Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
                Navigator.of(context).pushNamed('More_Page');
              }); 
                return;
              }              
              //  No special case, so do a normal fetch:
              Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
                Navigator.of(context).pushReplacementNamed('Fetch_Page');
              }); 
              return;
                       
          },
        ),
      ),
    );
  }

  //  ----------------------------------------------------
  //  passageRow() returns one "Row" of the Passage,
  //  which gets displayed in the UI.
  //  A "Row" can be the Title, Image, Description, etc
  //  of that specific passage.
  //  NOTE: Each "Choice" also gets its own row.
  //        The generated passageRows are used by 
  //        fullyBuiltPassage() in the Build below
  //  WILLFIX: atm passageRow() is inefficient because
  //           it generates img_box (and more stuff)
  //           for every row.  So these items
  //           need to be refactored into helpers
  //           used by the Switch below
  Widget passageRow( BuildContext context, int index) {
    Container bottom_box_padding = Container(height:25);
    if ( Passage.image + Passage.caption + Passage.credit == '') bottom_box_padding = Container(height:0);

    //  is there an image?  
    //  ( it is recommended they be 700x400 pixels so the placeholder works )
    Container img_box = Container(height:0);
    if( Passage.image != '') {
      img_box = Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25,0,25,0),
          child: Container(
            color: Color(0xFFf5f5f5),
            //  book_cover.png should be 600x600 (or at least a square)
            width: double.infinity,
            child: FadeInImage.assetNetwork(
              placeholder: "assets/images/passage_placeholder_grey.png",
              image: '${ Config.server_address }${ Story.key }/assets/${ Passage.image }.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ), 
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
            child: GestureDetector(
              child: Text( Passage.title, style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold ), textAlign: TextAlign.center,),
                //  for debugging, a long press will reload this passage
                onLongPress: () { 
                  Navigator.of(context).pushReplacementNamed('Fetch_Page');  
                },              
              ),
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

  //  fullyBuiltPassage() generates the Passage UI,
  //  row-by-row, using multiple passageRow()
  //  calls
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
              //  the fullyBuiltPassage()gets wrapped in a 
              //  SingleChildScrollView() so it can scroll.
              //  (because a Passage is usually longer than
              //  the screen...)
              child: SingleChildScrollView(child: fullyBuiltPassage() ),
            ),
          ),
        ),
    );
  }
}

//  END NOTES
//  This page is the main page of the main game loop:
//    1. Fetch_Page.dart grabs JSON and puts in Passage() class
//    2. Passage_Page.dart uses the Passage() class to build
//       the UI, and also accepts user input (when a choice is
//       made) to take the PASSAGE_KEY and redirect to 
//       the Fetch_Page again.
//
//  This page builds the Passage UI like this:
//    1. in build() the method fullyBuiltPassage() is called
//    2. in fullyBuiltPassage(), the UI is built, "row-by-row"
//       with passageRow() calls, where each passageRow() 
//       generates one "row" of UI. (Like "Title, image, etc")
