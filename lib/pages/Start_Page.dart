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
  static int button_count = -1;
  List<String> choice_text = [
    'Morbi malesuada velit vel volutpat egestas',
    'In hac habitasse platea',
    'Duis suscipit lorem lorem, sed venenatis metus fringilla vel',
    'Quisque rhoncus imperdiet orci',
  ];
  
  // (this page) init and dispose
  @override
  void initState() {
    super.initState();
    Utils.log( filename, 'initState()' );
    WidgetsBinding.instance.addPostFrameCallback((_) => _addPostFrameCallbackTriggered(context));
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
    double _padding = 0;
    button_count++;
    int index = button_count;
    if ( button_count == choice_text.length-1 ) {
      _padding = 200; 
    } 

    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0,0,0,_padding),
        child: ElevatedButton(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              choice_text[button_count],
              style: TextStyle(fontSize: 16),
              ),
          ),  
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.fromLTRB(16,12,12,12),
          ),                        
          onPressed: () {
            Utils.log( filename, 'clicked choice #' + index.toString());
          },
        ),
      ),
    );
  }

  Widget passageRow( BuildContext contec, int index) {

    switch ( index ) {
      case 0: // TITLE
        return  Container( 
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25,45,25,40),
            child: Text('Title', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold ), textAlign: TextAlign.center,),
          ),
        );
      case 1: // IMAGE
        return  SizedBox(height:0);
      case 2: // DESCRIPTION
        return  Container( 
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25,0,25,0),
            child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
          ),
        );
      case 3: // WHAT DO YOU DO?
        return  Container( 
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25,30,25,30),
                      child: Text('What Do You Do?', style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold ), textAlign: TextAlign.center,),
          ),
        );    
      default:
        return Padding(
          padding: const EdgeInsets.fromLTRB(25,5,25,5),
          child: makeButton(),
        );
    }
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
              child: ListView.builder(
                      itemCount: 8,
                      itemBuilder: ( context, index) {
                        return passageRow(context, index);                      
                      },
                    ),
            ),
          ),
        ),
    );
  }
}