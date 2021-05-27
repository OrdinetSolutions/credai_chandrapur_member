import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../urls.dart';

class PaymentPage extends StatefulWidget{
  @override
  _PaymentPageState createState() => _PaymentPageState();

}

class _PaymentPageState extends State<PaymentPage>{

  SharedPreferences prefLoginData;
  String memberId;
  var data;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async{
    prefLoginData= await SharedPreferences.getInstance();
    memberId = prefLoginData.getString('id');
    print(memberId);

    var res = await http.post(Uri.parse(Urls.getPayments),
        body: {"id": memberId},
        headers: {"Accept": "application/json"});

    print(res.body);
    var convertDataTojson = jsonDecode(res.body.toString());
    data = convertDataTojson['payments'];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Payments"),
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
                      Text(data[index]['subject'], style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),),
                      Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text("Rs. " + data[index]['amount'] + "/-", style: TextStyle(color: Colors.black, fontSize: 15),)),
                      data[index]['filepath'] == ""
                          ?Text("")
                          :GestureDetector(
                          child: Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text("View Document", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue, fontSize: 14))),
                          onTap: () {
                            launch(data[index]['filepath']);
                          }
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text("On " + data[index]['date'] + ", " + data[index]['time'], style: TextStyle(color: Colors.grey, fontSize: 12),)),
                    ],
                  ),
                ),
              );
            },
          )
              :Center(
            child: data != "0"?CircularProgressIndicator():Text("No Payments"),
          ),
        ),
    );
  }

}