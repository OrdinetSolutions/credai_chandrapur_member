import 'dart:convert';
import 'package:credai_chandrapur_member/Events/detailsEvent.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../urls.dart';

class EventPage extends StatefulWidget{
  @override
  _EventPageState createState() => _EventPageState();

}

class _EventPageState extends State<EventPage>{

  var data;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async{
    var res = await http.get(Uri.parse(Urls.getEvents));
    print(res.body);
    var convertDataTojson = jsonDecode(res.body.toString());
    data = convertDataTojson['events'];
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
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => detailsEvent(
                    id: data[index]['id'],
                    title: data[index]['title'],
                    description: data[index]['description'],
                    type: data[index]['type'],
                    date: data[index]['date'],
                    time: data[index]['time'],
                    venue: data[index]['venue']
                )));
              },
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.all(5), child: Image(image: NetworkImage(Urls.imagesDocumentsLink + "events/" + data[index]['id'] + "/1.jpeg"), width: MediaQuery.of(context).size.width * 0.40,)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data[index]['title'], style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),),
                          Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(data[index]['description'], maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black, fontSize: 15),)),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: data[index]['type'] == "1"
                                  ?Text("Open to all", style: TextStyle(color: Colors.amber, fontSize: 12),)
                                  :Text("Only for CREDAI Members", style: TextStyle(color: Colors.amber, fontSize: 12),)
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text("Event on " + data[index]['date'] + ", " + data[index]['time'], style: TextStyle(color: Colors.blue, fontSize: 12),)),
                          Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text("Venue - " + data[index]['venue'], style: TextStyle(color: Colors.redAccent, fontSize: 12),)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
            :Center(
          child: data != "0"?CircularProgressIndicator():Text("No Events"),
        ),
      ),
    );
  }

}
