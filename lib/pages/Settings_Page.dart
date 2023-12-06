// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../../classes/Config.dart';
import '../../classes/Utils.dart';

//  ----------------------------------------------------
//  This is a placeholder page (awaiting content)
//  ----------------------------------------------------

class Settings_Page extends StatelessWidget {
  const Settings_Page({super.key});

  //  (this page) variables
  static const String filename = 'Settings_Page.dart';  

  // (this page) methods
  void _buildTriggered() {
    Utils.log( filename, '_buildTriggered()');
  }  

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
          appBar: AppBar(
              title: const Text( 'Settings' ),
              centerTitle: true,
              elevation: 0,
            ), 
          //  drawer: Drawer_Widget(),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text( Config.license,
                    style: TextStyle( fontSize: 12, fontStyle: FontStyle.italic ),
                    textAlign: TextAlign.center,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}