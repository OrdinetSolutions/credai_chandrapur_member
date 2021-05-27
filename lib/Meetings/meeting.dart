import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../urls.dart';

class MeetingPage extends StatefulWidget{
  @override
  _MeetingPageState createState() => _MeetingPageState();

}

class _MeetingPageState extends State<MeetingPage>{

  var data;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async{
    var res = await http.get(Uri.parse(Urls.getMeetings));
    print(res.body);
    var convertDataTojson = jsonDecode(res.body.toString());
    data = convertDataTojson['meetings'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: data != null
            ?ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index){
            return Card(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(data[index]['topic'], style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),),
                      data[index]['type'] == "1"
                          ?Text(" (Offline)", style: TextStyle(color: Colors.amber, fontSize: 12),)
                          :Text(" (Online)", style: TextStyle(color: Colors.amber, fontSize: 12),)
                    ],),
                    Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(data[index]['description'], style: TextStyle(color: Colors.black, fontSize: 16),)),
                    Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text("On " + data[index]['date'] + ", " + data[index]['time'], style: TextStyle(color: Colors.grey, fontSize: 12),)),
                  ],
                ),
              ),
            );
          },
        )
            :Center(
          child: data != "0"?CircularProgressIndicator():Text("No Meetings"),
        ),
      ),
    );
  }

}