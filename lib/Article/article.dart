import 'dart:convert';
import 'package:credai_chandrapur_member/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'addArticle.dart';
import 'detailsArticle.dart';

class ArticlePage extends StatefulWidget{
  @override
  _ArticlePageState createState() => _ArticlePageState();

}

class _ArticlePageState extends State<ArticlePage>{

  var data;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async{
    var res = await http.get(Uri.parse(Urls.getArticles));
    print(res.body);
    var convertDataTojson = jsonDecode(res.body.toString());
    data = convertDataTojson['articles'];
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => detailsArticle(
                    image: data[index]['image'],
                    title: data[index]['title'],
                    description: data[index]['description'],
                    member_name: data[index]['member_name'],
                    date: data[index]['date'],
                    time: data[index]['time']
                )));
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: data[index]['image'] != ""
                          ?Center(child: Image(image: NetworkImage(data[index]['image']), height: 200,)):Text(""),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data[index]['title'], style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),),
                          Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(data[index]['description'], maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black, fontSize: 15),)),
                          Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(data[index]['member_name'] + " On " + data[index]['date'] + ", " + data[index]['time'], style: TextStyle(color: Colors.grey, fontSize: 12),)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
            :Center(
          child: data != "0"?CircularProgressIndicator():Text("No Articles"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => addArticle()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

}