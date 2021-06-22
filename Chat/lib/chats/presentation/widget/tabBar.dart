
import 'package:flutter/material.dart';

class Tabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
 
  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  floatingActionButton: FloatingActionButton(
    onPressed: () { },
    tooltip: 'Increment',
    child: Icon(Icons.add),
    elevation: 2.0,
  ),
  bottomNavigationBar: BottomAppBar(
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[],
    ),
    //notchedShape: CircularNotchedRectangle(),
    color: Colors.blueGrey,
  ),
);
  }
}