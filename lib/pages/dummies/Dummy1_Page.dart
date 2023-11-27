// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../../classes/Config.dart';
import '../../classes/Utils.dart';

class Dummy1_Page extends StatelessWidget {
  const Dummy1_Page({super.key});

  //  (this page) variables
  static const String _filename = 'Dummy1_Page.dart';  

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
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,  
          appBar: AppBar(
            title: const Text( _filename ),
            centerTitle: true,
          ), 
          //  drawer: Drawer_Widget(),
          body: Container(
              color: Colors.transparent,
              child: const Center(
                child: Text( _filename ),
              ),
            ),
        ),
      ),
    );
  }
}