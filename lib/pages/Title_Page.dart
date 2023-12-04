// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../../classes/Config.dart';
import '../../classes/Utils.dart';
import '../widgets/Drawer_Widget.dart';
import '../classes/Story.dart';

//  ----------------------------------------------------
//  This stateless page displays the "cover" of a story.
//  (Title, author, cover image)
//  ----------------------------------------------------

class Title_Page extends StatelessWidget {
  Title_Page({super.key});

  //  (this page) variables
  static const String _filename = 'Title_Page.dart';  
  var image = Image.network( '${ Config.server_address }${ Story.key }/assets/book_cover.png');
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
                    padding: const EdgeInsets.fromLTRB(30,0,30,10),
                    child: Text( 
                      Story.title, 
                      textAlign: TextAlign.center,
                      style: TextStyle( fontFamily: 'Headline1', fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black )),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB((MediaQuery.of(context).size.width/8),0,(MediaQuery.of(context).size.width/8),0),
                    child: Container(
                      //  book_cover.png should be 600x600 (or at least a square)
                      width: double.infinity,
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/title_placeholder_white.png",
                        image: '${ Config.server_address }${ Story.key }/assets/book_cover.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        
                      ), 
                    ),
                  ),
                  //  WILLFIX: below is for image credit (in the future)
                  Padding(
                      padding: EdgeInsets.fromLTRB((MediaQuery.of(context).size.width/8),0,(MediaQuery.of(context).size.width/8),0),
                      child: Container(
                        width: double.infinity,
                        child: Text('',
                        textAlign: TextAlign.right,
                        style: TextStyle( fontSize: 12)),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30,5,30,20),
                    child: Text(  
                      Story.author, 
                      textAlign: TextAlign.center, 
                      style: TextStyle( fontWeight: FontWeight.bold ),  
                    ),
                  ),
                  ElevatedButton(
                    child: Text('begin'),
                    onPressed: () {
                      //  start the story!!!
                      Config.PASSAGE_KEY = 'START';
                      Config.story_started = true;
                      Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
                        Navigator.of(context).pushNamed('Fetch_Page');
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