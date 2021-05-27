import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../urls.dart';

class NoticePage extends StatefulWidget{
  @override
  _NoticePageState createState() => _NoticePageState();

}

class _NoticePageState extends State<NoticePage>{

  SharedPreferences prefLoginData;
  String memberId;

  var data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {

    prefLoginData= await SharedPreferences.getInstance();
    memberId = prefLoginData.getString('id');
    print(memberId);

    var res = await http.post(Uri.parse(Urls.getNotices),
        body: {"id": memberId},
        headers: {"Accept": "application/json"});

    print(res.body);
    var convertDataTojson = jsonDecode(res.body.toString());
    data = convertDataTojson['notices'];

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
                    Text(data[index]['title'], style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),),
                    Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(data[index]['description'], style: TextStyle(color: Colors.black, fontSize: 15),)),
                  ],
                ),
              ),
            );
          },
        )
            :Center(
          child: data != "0"?CircularProgressIndicator():Text("No Notices"),
        ),
      ),
    );
  }

}