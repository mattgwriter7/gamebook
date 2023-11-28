// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../../classes/Config.dart';
import '../../classes/Utils.dart';

class Fetch_Page extends StatefulWidget {
  const Fetch_Page({ super.key });

  @override
  State createState() => _Fetch_PageState();
}

class _Fetch_PageState extends State<Fetch_Page> {

  // (this page) variables
  static const String _filename = 'Fetch_Page.dart';
  
  // (this page) init and dispose
  @override
  void initState() {
    super.initState();
    Utils.log( _filename, 'initState()' );
    WidgetsBinding.instance.addPostFrameCallback((_) => _addPostFrameCallbackTriggered(context));  

    //  fetch selected passage
    fetchPassage();    
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

  void fetchPassage() {
    //  WILLFIX: this fake fetch needs to be replaced by a real one
    Future.delayed( Duration(milliseconds: Config.long_delay ), () async {
      Navigator.of(context).pushReplacementNamed('Passage_Page');
    }); 
    return;
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
        return false;  
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,  
            //  backgroundColor: Config.main_background_color,
            body: Container(
              width: double.infinity,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,0,10,40),
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFFcccccc),
                        )
                      ),
                    ),
                  ),
                  Text('Fetching passage...'),
                ],
              ),
            ),
          ),
        ),
    );
  }
}