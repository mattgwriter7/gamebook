// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../../classes/Config.dart';
import '../../classes/Utils.dart';

//  This helper page serves as a template
//  for future Statefull pages
//  (and should be removed from Production)

class Dummy2_Page extends StatefulWidget {
  const Dummy2_Page({ super.key });

  @override
  State createState() => _Dummy2_PageState();
}

class _Dummy2_PageState extends State<Dummy2_Page> {

  // (this page) variables
  static const String filename = 'Dummy2_Page.dart';
  
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
    super.dispose();
  }

  // (this page) methods
  void _buildTriggered() {
    Utils.log( filename, '_buildTriggered()');
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
            resizeToAvoidBottomInset: false,  
            //  backgroundColor: Config.main_background_color,
            appBar: AppBar(
              title: const Text( filename ),
              centerTitle: true,
            ), //AppBar
            // drawer: DrawerWidget(),
            body: Container(
              width: double.infinity,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text( filename,
                    style: TextStyle( fontWeight: FontWeight.bold ) ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text( '(not completed)' ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}