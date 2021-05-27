import 'package:flutter/material.dart';

class detailsArticle extends StatefulWidget {

  final String image, title, description, member_name, date, time;

  const detailsArticle({Key key, this.image, this.title, this.description, this.member_name, this.date, this.time}) : super(key: key);

  @override
  _detailsArticleState createState() => _detailsArticleState();
}

class _detailsArticleState extends State<detailsArticle> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: "${widget.image}" != ""
                  ?Center(child: Image(image: NetworkImage("${widget.image}"), height: 200,)):Text(""),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${widget.title}", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),),
                  )),
                  Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text("${widget.description}", maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black, fontSize: 15),)),
                  Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0), child: Text("${widget.member_name}" + " On " + "${widget.date}" + ", " + "${widget.time}", style: TextStyle(color: Colors.grey, fontSize: 12),)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
