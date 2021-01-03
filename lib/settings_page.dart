import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:sonproje/developers_page.dart';
import 'package:sonproje/signin_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class settingsPage extends StatefulWidget {
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<settingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: Text(
          "AYARLAR",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          //! Builder eklemezsek Scaffold.of() hata verecektir!
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.login),
              onPressed: () async {
                final User user = _auth.currentUser;
                if (user == null) {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    content: Text("Henüz giriş yapılmamış"),
                  ));
                  return;
                }

                await _auth.signOut();

                final String uid = user.uid;
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("$uid başarıyla çıkış yapıldı"),
                ));

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: RaisedButton(
              color: Colors.green,
              highlightColor: Colors.red,
              elevation: 10,
              child: Text(
                "Geliştiriciler",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => developersPage(),
                ),
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
          ),
          Container(
            margin: new EdgeInsets.symmetric(horizontal: 140.0),
            child: Text(
              "Version 1.0.0",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
