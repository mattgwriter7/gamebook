//  ignore_for_file: file_names, must_be_immutable, camel_case_types

//  Drawer_Widget version 1.01 (updated June 23, 2023)
//  To style this widget, see "START OF DEFAULT STYLING"
//  a few lines down...

import 'package:flutter/material.dart';
import 'dart:async';
import '../classes/Config.dart';
import '../classes/Utils.dart';

class Drawer_Widget extends StatelessWidget {
  Drawer_Widget ({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Drawer(
      // backgroundColor: _backgroundColor,
      child: Stack(
        children: [

          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[

              //  =======================
              //  Drawer Image
              //  =======================              
              DrawerHeader(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    /*
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage( _image ),
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                      ),
                    ),
                    */
                  ),
                ),
                ),
              
              //  =======================
              //  Drawer Items
              //  =======================
              /*
              _getNavItem( context, 'Dashboard'),
              _divider,          
              _getNavItem( context, 'Devices'),
              _divider,          
              _getNavItem( context, 'Workflow'),
              _divider,
              // if it is debug mode, show the Debug option
              Visibility(
                visible: true,
                child: _getNavItem( context, 'Debug')
              ),
              */ 
            ],
          ),

          
        ],
      ),
    );
  }
}