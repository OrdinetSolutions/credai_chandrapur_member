import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../urls.dart';

class addArticle extends StatefulWidget {
  @override
  _addArticleState createState() => _addArticleState();
}

class _addArticleState extends State<addArticle> {

  SharedPreferences prefLoginData;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  File _image;
  final picker = ImagePicker();
  String base64Image = '';

  showCheckLogin(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.asset(
            ("assets/loader.gif"),
            width: 50,
            height: 50,
          ),
        );
      },
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        base64Image = base64Encode(_image.readAsBytesSync());
        print(base64Image);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Article"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left:0, right: 0, top:5, bottom: 5),
                  child: InkWell(
                    onTap: getImage,
                    child: Container(
                        padding: EdgeInsets.all(5),
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(2)),
                        child: _image == null
                            ? Padding(padding: EdgeInsets.all(15),child: Center(child: Image.asset("assets/article.png")))
                            : Center(child: Image.file(_image)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0, right: 15.0, top:5, bottom: 5),
              child: TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                    hintText: 'Enter valid Title'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0, right: 15.0, top:5, bottom: 5),
              child: TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                    hintText: 'Enter valid Username'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () async {
                  var currDate = new DateTime.now();
                  var formatterDate = new DateFormat('dd MMM yyyy');
                  String currentDate = formatterDate.format(currDate);

                  var currTime = new DateTime.now();
                  var formatterTime = new DateFormat('hh:mm a');
                  String currentTime = formatterTime.format(currTime);

                  String title = titleController.text;
                  String description = descriptionController.text;

                  prefLoginData = await SharedPreferences.getInstance();
                  String member_id = prefLoginData.getString("id");

                  if(title == ""){
                    Toast.show("Please enter Title", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                  }else if(base64Image == ""){
                    Toast.show("Please add Image", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                  } else{
                    showCheckLogin(context);

                    var response = await http.post(Uri.parse(Urls.addArticle),
                        body: {
                          "image": base64Image,
                          "member_id": member_id,
                          "title": title,
                          "description": description,
                          "date": currentDate,
                          "time": currentTime
                        },
                        headers: {"Accept": "application/json"});

                    setState(() {
                      var convertDataTojson = jsonDecode(response.body.toString());
                      if(convertDataTojson == 0)
                      {
                        Toast.show("Error", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                      }else{
                        Toast.show("Added Successfully", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                        Navigator.pop(context, true);
                      }
                      print(convertDataTojson);
                    });
                  }
                },
                child: Text(
                  'Add Article',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
