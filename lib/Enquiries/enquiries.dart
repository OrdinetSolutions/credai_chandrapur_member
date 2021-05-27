import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../urls.dart';

class EnquiryPage extends StatefulWidget{
  @override
  _EnquiryPageState createState() => _EnquiryPageState();

}

class _EnquiryPageState extends State<EnquiryPage>{

  SharedPreferences prefLoginData;
  String memberId;
  var data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{

    prefLoginData= await SharedPreferences.getInstance();
    memberId = prefLoginData.getString('id');
    print(memberId);

    var res = await http.post(Uri.parse(Urls.getEnquiries),
        body: {"id": memberId},
        headers: {"Accept": "application/json"});

    print(res.body);
    var convertDataTojson = jsonDecode(res.body.toString());
    data = convertDataTojson['enquiries'];

    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Enquiries"),
      ),
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
                    Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text("Enquiry On - " + data[index]['e_project_name'], style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),)),
                    Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(data[index]['u_name'], style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 18),),),
                    Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(data[index]['u_mobile'] + " | " + data[index]['u_email'], style: TextStyle(color: Colors.black, fontSize: 14),)),
                    Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(data[index]['e_message'], style: TextStyle(color: Colors.black, fontSize: 16),)),
                    Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text("On " + data[index]['e_date'] + ", " + data[index]['e_time'], style: TextStyle(color: Colors.grey, fontSize: 12),)),
                  ],
                ),
              ),
            );
          },
        )
            :Center(
          child: data != "0"?CircularProgressIndicator():Text("No Enquiries"),
        ),
      ),
    );
  }

}