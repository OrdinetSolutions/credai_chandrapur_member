import 'package:flutter/material.dart';

class AddProjectPage1 extends StatefulWidget{
  @override
  _AddProjectPage1State createState() => _AddProjectPage1State();

}

class _AddProjectPage1State extends State<AddProjectPage1>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Project"),
      ),
      body: SingleChildScrollView(

      ),
    );
  }

}