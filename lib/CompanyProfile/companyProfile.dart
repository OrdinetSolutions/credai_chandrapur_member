import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:credai_chandrapur_member/urls.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class CompanyProfilePage extends StatefulWidget{
  @override
  _CompanyProfilePageState createState() => _CompanyProfilePageState();

}

class _CompanyProfilePageState extends State<CompanyProfilePage>{

  final TextEditingController cnController = TextEditingController();
  final TextEditingController onController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  SharedPreferences prefLoginData;
  String memberId = '';

  var data;

  File _image;
  final picker = ImagePicker();
  String base64Image = '';

  updateProfile(BuildContext context) {
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
    this.getJsonData();
  }

  Future<String> getJsonData() async {

    prefLoginData= await SharedPreferences.getInstance();
    memberId = prefLoginData.getString('id');
    print(memberId);

    var res = await http.post(Uri.parse(Urls.getCompanyProfile),
        body: {"id": memberId},
        headers: {"Accept": "application/json"});

    print(res.body);
    var convertDataTojson = jsonDecode(res.body.toString());
    data = convertDataTojson['member'];

    setState(() {
      cnController.text = data[0]['company_name'];
      onController.text = data[0]['owner_name'];
      mobileController.text = data[0]['mobile_no'];
      dobController.text = data[0]['dob'];
      emailController.text = data[0]['email'];
      websiteController.text = data[0]['website'];
      addressController.text = data[0]['address'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Company Profile"),
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
                          ? memberId == ''? Center(child: Image.asset("assets/article.png")):Center(child: Image.network(Urls.imagesDocumentsLink + "companyImages/" + memberId + ".jpeg"))
                          : Center(child: Image.file(_image)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0, right: 15.0, top:5, bottom: 5),
              child: TextFormField(
                controller: cnController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Company Name',
                    hintText: 'Enter Company Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0, right: 15.0, top:5, bottom: 5),
              child: TextFormField(
                controller: onController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Owner Name',
                    hintText: 'Enter Owner Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0, right: 15.0, top:5, bottom: 5),
              child: TextFormField(
                controller: mobileController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mobile No.',
                    hintText: 'Enter Mobile No.'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0, right: 15.0, top:5, bottom: 5),
              child: TextFormField(
                controller: dobController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'DOB',
                    hintText: 'Enter DOB'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0, right: 15.0, top:5, bottom: 5),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0, right: 15.0, top:5, bottom: 5),
              child: TextFormField(
                controller: websiteController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Website',
                    hintText: 'Enter Website'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0, right: 15.0, top:5, bottom: 5),
              child: TextFormField(
                controller: addressController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                    hintText: 'Enter Address'),
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

                  String company_name = cnController.text;
                  String owner_name = onController.text;
                  String mobile = mobileController.text;
                  String dob = dobController.text;
                  String email = emailController.text;
                  String website = websiteController.text;
                  String address = addressController.text;

                  prefLoginData = await SharedPreferences.getInstance();
                  String member_id = prefLoginData.getString("id");

                  print(member_id + ", " + company_name + ", " + owner_name + ", " + mobile + ", " + dob + ", " + email + ", " + website + ", " + address);

                  if(company_name == ""){
                    Toast.show("Please enter Title", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                  }else if(owner_name == ""){
                    Toast.show("Please enter Owner Name", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                  }else if(mobile == ""){
                    Toast.show("Please enter Mobile No.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                  } else{
                    updateProfile(context);

                    var response = await http.post(Uri.parse(Urls.updateCompanyProfile),
                        body: {
                          "id": member_id,
                          "company_name": company_name,
                          "owner_name": owner_name,
                          "dob": dob,
                          "mobile_no": mobile,
                          "email": email,
                          "website": website,
                          "address": address,
                          "image": base64Image
                        },
                        headers: {"Accept": "application/json"});

                    setState(() {
                      var convertDataTojson = jsonDecode(response.body.toString());
                      if(convertDataTojson == 0)
                      {
                        Toast.show("Error", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                        Navigator.pop(context, true);
                      }else{
                        Toast.show("Updated Successfully", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                        Navigator.pop(context, true);
                      }
                      print(convertDataTojson);
                    });
                  }
                },
                child: Text(
                  'Update Profile',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

}