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

  Container _makeButton ( String str ) {
    return Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              str,
                              style: TextStyle(fontSize: 16),
                              ),
                          ),  
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(16,12,12,12),
                          ),                        
                          onPressed: () {},
                        ),
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container( 
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25,40,25,40),
                      child: Text('Title', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold )),
                    ),
                  ),
                  Container( 
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25,0,25,0),
                      child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                    ),
                  ),                
                  Container( 
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25,30,25,20),
                      child: Text('What Do You Do?', style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold )),),
                  ),   
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25,10,25,5),
                    child: _makeButton('Morbi malesuada velit vel volutpat egestas'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25,5,25,5),
                    child: _makeButton('In hac habitasse platea'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25,5,25,5),
                    child: _makeButton('Duis suscipit lorem lorem, sed venenatis metus fringilla vel'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25,5,25,5),
                    child: _makeButton('Quisque rhoncus imperdiet orci'),
                  ),
                  SizedBox(
                    height: 150,
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}