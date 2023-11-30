// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';
import '../classes/Story.dart';
import '../classes/Passage.dart';
import '../widgets/Drawer_Widget.dart';

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
    if ( index == Passage.choice_text.length-1 ) _padme = 100;
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
            Config.passage_key = Passage.choice_key[index];
            Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
              //  RESTART ?
              if ( Config.passage_key == 'RESTART') { 
                //  WILLFIX: Should this RESET go into Provider?
                Config.story_started = false;
                Navigator.of(context).popUntil(ModalRoute.withName('Title_Page')); 
              }              
              else {
                Navigator.of(context).pushReplacementNamed('Fetch_Page');
              }
            });             
          },
        ),
      ),
    );
  }

  Widget passageRow( BuildContext context, int index) {

    double _image_bottom = 25;    //  this is how much padding is needed for images, which
                                  //  is different when there is a caption!

    //  is there a caption (for image)?  
    SizedBox caption_box = SizedBox(height:0);
    if( Passage.caption != '') {
      _image_bottom = 5;
      caption_box = SizedBox( width: double.infinity, child: Padding(
        padding: EdgeInsets.fromLTRB(25,0,25,25),
        child: Text( Passage.caption, style: TextStyle( fontStyle: FontStyle.italic, fontSize: 14 ), textAlign: TextAlign.center, ),
      ));
    }

    //  is there an image?  
    SizedBox img_box = SizedBox(height:0);
    if( Passage.image != '') {
      img_box = SizedBox( height: 250, child: Padding(
        padding: EdgeInsets.fromLTRB(25,0,25,_image_bottom),
        child: Image.network( '${ Config.server_address }${ Story.key }/assets/${ Passage.image }.png', 
          fit: BoxFit.fitHeight,
        ),
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
      case 2: // CAPTION
        return  caption_box;        
      case 3: // DESCRIPTION
        return  Container( 
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25,0,25,0),
            child: Text( Passage.description ),
          ),
        );
      case 4: // WHAT DO YOU DO?
        return  Container( 
          child: Padding(
            padding: EdgeInsets.fromLTRB(25,30,25,30),
              child: GestureDetector(
                //  for debugging, a long press will reload this passage
                onLongPress: () { 
                  Navigator.of(context).pushReplacementNamed('Fetch_Page');  
                },
                child: Text('What Do You Do?', style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold ), textAlign: TextAlign.center,)),
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
    int index_max = 5+Passage.choice_text.length;
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