// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../../classes/Config.dart';
import '../../classes/Utils.dart';

class Dummy2_Page extends StatefulWidget {
  const Dummy2_Page({ super.key });

  @override
  State createState() => _Dummy2_PageState();
}

class _Dummy2_PageState extends State<Dummy2_Page> {

  // (this page) variables
  static const String _filename = 'Dummy2_Page.dart';
  
  // (this page) init and dispose
  @override
  void initState() {
    super.initState();
    Utils.log( _filename, 'initState()' );
    WidgetsBinding.instance.addPostFrameCallback((_) => _addPostFrameCallbackTriggered(context));  
  }

  @override
  void dispose() {
    Utils.log( _filename, 'dispose()');
    super.dispose();
  }

  // (this page) methods
  void _buildTriggered() {
    Utils.log( _filename, '_buildTriggered()');
  }

  void _addPostFrameCallbackTriggered( context ) {
    Utils.log( _filename, '_addPostFrameCallbackTriggered()');
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
              title: const Text( _filename ),
              centerTitle: true,
            ), //AppBar
            // drawer: DrawerWidget(),
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