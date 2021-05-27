import 'package:credai_chandrapur_member/Projects/addProjectPage1.dart';
import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget{
  @override
  _ProjectPageState createState() => _ProjectPageState();

}

class _ProjectPageState extends State<ProjectPage>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Projects"),
        ),
        body: SingleChildScrollView(

        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddProjectPage1()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

}