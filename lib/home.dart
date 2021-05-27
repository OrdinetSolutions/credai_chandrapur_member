import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:credai_chandrapur_member/Article/article.dart';
import 'package:credai_chandrapur_member/CompanyProfile/companyProfile.dart';
import 'package:credai_chandrapur_member/Documents/document.dart';
import 'package:credai_chandrapur_member/Enquiries/enquiries.dart';
import 'package:credai_chandrapur_member/Events/event.dart';
import 'package:credai_chandrapur_member/Help/help.dart';
import 'package:credai_chandrapur_member/Login/login.dart';
import 'package:credai_chandrapur_member/Meetings/meeting.dart';
import 'package:credai_chandrapur_member/Notices/notice.dart';
import 'package:credai_chandrapur_member/Payments/payments.dart';
import 'package:credai_chandrapur_member/Projects/projects.dart';
import 'package:credai_chandrapur_member/urls.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

  var appBarTitle = "Articles";
  int _selectedIndex = 0;

  SharedPreferences prefLoginData;
  String memberId;

  var data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'CREDAI Members',
        text: 'Play Store Link',
        linkUrl: 'https://ordinet.in/',
        chooserTitle: 'Download App');
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

    setState(() {});
  }

  final List<Widget> _navigationBody = <Widget>[
    ArticlePage(),
    EventPage(),
    MeetingPage(),
    NoticePage(),
    DocumentPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(index == 0)
      {
        appBarTitle = "Articles";
      }else if(index == 1)
      {
        appBarTitle = "Events";
      }else if(index == 2)
      {
        appBarTitle = "Meetings";
      }else if(index == 3)
      {
        appBarTitle = "Notices";
      }else if(index == 4)
      {
        appBarTitle = "Imp. Documents";
      }
    });
  }

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text("Are You Sure?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Yes"),
              onPressed: () async {
                prefLoginData = await SharedPreferences.getInstance();
                prefLoginData.clear();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => login()), (_) => false);
              },
            ),

            FlatButton(
              child: Text("No"),
              onPressed: () {
                //Put your code here which you want to execute on No button click.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            data != null? UserAccountsDrawerHeader(
                accountName: Text(data[0]['owner_name']),
                accountEmail: Text(data[0]['company_name']),
                currentAccountPicture: Image.network(Urls.imagesDocumentsLink + "companyImages/" + memberId + ".jpeg"),
            ):UserAccountsDrawerHeader(
              accountName: Text("Hello User"),
              accountEmail: Text(""),
              currentAccountPicture: Image.network("assets/article.png"),
            ),
            ListTile(
              leading: Icon(
                Icons.article,
                color: Colors.green
              ),
              title: Text(
                'Articles',
                  style: TextStyle(
                    color: Colors.green
                  ),
              ),
              onTap: () {
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.location_city),
              title: Text('Projects'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('Payments'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance),
              title: Text('Company Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyProfilePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share'),
              onTap: () {
                share();
              },
            ),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Logout'),
              onTap: () {
                showAlert(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.message,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EnquiryPage()));
            },
          )
        ],
      ),
      body: Center(
        child: _navigationBody[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.article,
            ),
            label: 'Articles',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event,
            ),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.meeting_room,
            ),
            label: 'Meetings',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.book,
            ),
            label: 'Notices',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment,
            ),
            label: 'Imp. Documents',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
