import 'package:chatapp_flutter/helper/helper_function.dart';
import 'package:chatapp_flutter/pages/login_page.dart';
import 'package:chatapp_flutter/pages/profile_page.dart';
import 'package:chatapp_flutter/pages/search_page.dart';
import 'package:chatapp_flutter/service/auth_service.dart';
import 'package:chatapp_flutter/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();

  @override
  void initState() {
    gettingUserData();
    super.initState();
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailfromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNamefromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(context, SearchPage());
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                nextScreen(context, LoginPage());
                print("LOGOUT!!");
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          "Groups",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            Icon(
              Icons.account_circle,
              size: 100,
              color: Colors.grey,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              userName,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Divider(
              height: 2,
              thickness: 1,
            ),
            ListTile(
              onTap: () async {
                authService.signOut().whenComplete(() {
                  nextScreenReplace(context, LoginPage());
                });
              },
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.group),
              title: Text(
                "Groups",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                nextScreenReplace(
                    context,
                    ProfilePage(
                      userName: userName,
                      email: email,
                    ));
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.person_2),
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () async {
                await authService.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.exit_to_app),
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
