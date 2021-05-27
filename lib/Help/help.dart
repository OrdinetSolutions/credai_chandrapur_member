import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget{
  @override
  _HelpPageState createState() => _HelpPageState();

}

class _HelpPageState extends State<HelpPage>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Help"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset("assets/ordinet_logo.png", width: MediaQuery.of(context).size.width * 0.70,),
              ),
              Row(
                children: [
                  Container(margin: EdgeInsets.only(top: 20, left: 20), child: Text("Address:", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),), width: MediaQuery.of(context).size.width * 0.30,),
                  Container(margin: EdgeInsets.only(top: 20, right: 20), child: Text("Hinjewadi Phase 2, \nOpp. to DMart, Pune", style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 20),)),
                ],
              ),
              Row(
                children: [
                  Container(margin: EdgeInsets.only(top: 20, left: 20), child: Text("Mobile No.:", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),), width: MediaQuery.of(context).size.width * 0.30,),
                  Container(margin: EdgeInsets.only(top: 20, right: 20), child: Text("9175546443", style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 20),)),
                ],
              ),
              Row(
                children: [
                  Container(margin: EdgeInsets.only(top: 20, left: 20), child: Text("Email Id:", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),), width: MediaQuery.of(context).size.width * 0.30,),
                  Container(margin: EdgeInsets.only(top: 20, right: 20), child: Text("support@ordinet.in", style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 20),)),
                ],
              ),
              Row(
                children: [
                  Container(margin: EdgeInsets.only(top: 20, left: 20), child: Text("Website:", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),), width: MediaQuery.of(context).size.width * 0.30,),
                  Container(margin: EdgeInsets.only(top: 20, right: 20), child: Text("www.ordinet.in", style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 20),)),
                ],
              ),
            ],
          ),
        )
    );
  }

}