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

  Widget _section( BuildContext contec, int index) {
    if( index == 0 ) {
      return Text('title');
    }
    else 
    return Padding(
                          padding: const EdgeInsets.fromLTRB(25,5,25,5),
                          child: _makeButton('Quisque rhoncus imperdiet orci'),
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
            body: Container(
              width: double.infinity,
              child: ListView.builder(
                      itemCount: 25,
                      itemBuilder: ( context, index) {
                        return _section(context, index);                      
                      },
                    ),
            ),
          ),
        ),
    );
  }
}