import 'package:flutter/material.dart';

class developersPage extends StatefulWidget {
  _DevelopersPageState createState() => _DevelopersPageState();
}

class _DevelopersPageState extends State<developersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: Text(
          "GELİŞTİRİCİLER",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Text("Bilal KADAM"),
            padding: const EdgeInsets.all(100.0),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
