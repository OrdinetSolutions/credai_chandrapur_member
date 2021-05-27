import 'package:flutter/material.dart';

class detailsEvent extends StatefulWidget {

  final String id, title, description, type, date, time, venue;

  const detailsEvent({Key key, this.id, this.title, this.description, this.type, this.date, this.time, this.venue}) : super(key: key);

  @override
  _detailsEventState createState() => _detailsEventState();
}

class _detailsEventState extends State<detailsEvent> {

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
              child: "${widget.id}" != ""
                  ?Center(child: Image(image: NetworkImage("${widget.id}"), height: 200,)):Text(""),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${widget.title}", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),),
                        "${widget.type}" == "1"
                            ?Text("Open to all", style: TextStyle(color: Colors.amber, fontSize: 12),)
                            :Text("Only For CREDAI Members", style: TextStyle(color: Colors.amber, fontSize: 12),),
                      ],
                    ),
                  )),
                  Padding(padding: EdgeInsets.fromLTRB(10, 5, 0, 0), child: Text("About Event - ", style: TextStyle(color: Colors.grey, fontSize: 12),)),
                  Padding(padding: EdgeInsets.fromLTRB(10, 5, 0, 10), child: Text("${widget.description}", style: TextStyle(color: Colors.black, fontSize: 16),)),
                  Padding(padding: EdgeInsets.fromLTRB(10, 5, 0, 0), child: Text("Date: " + "${widget.date}", style: TextStyle(color: Colors.black, fontSize: 14),)),
                  Padding(padding: EdgeInsets.fromLTRB(10, 5, 0, 0), child: Text("Time: " + "${widget.time}", style: TextStyle(color: Colors.black, fontSize: 14),)),
                  Padding(padding: EdgeInsets.fromLTRB(10, 5, 0, 0), child: Text("Venue: " + "${widget.venue}", style: TextStyle(color: Colors.black, fontSize: 14),)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
