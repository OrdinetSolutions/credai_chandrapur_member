import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import '../urls.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentPage extends StatefulWidget{
  @override
  _DocumentPageState createState() => _DocumentPageState();

}

class _DocumentPageState extends State<DocumentPage>{

  var data;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async{
    var res = await http.get(Uri.parse(Urls.getDocuments));
    print(res.body);
    var convertDataTojson = jsonDecode(res.body.toString());
    data = convertDataTojson['documents'];
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
                    GestureDetector(
                        child: Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text("View Document", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue, fontSize: 14))),
                        onTap: () {
                          launch(data[index]['filepath']);
                        }
                    ),
                  ],
                ),
              ),
            );
          },
        )
            :Center(
          child: data != "0"?CircularProgressIndicator():Text("No Documents"),
        ),
      ),
    );
  }

}