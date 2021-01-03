import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class descriptionPage extends StatefulWidget {
  // Constructor tanımladık, home_page'den gelecek verileri this ile bu sayfada çekeceğimizi belirttik.

  String title, description, urlToImage, author, content;
  descriptionPage(
      {this.title,
      this.description,
      this.urlToImage,
      this.author,
      this.content});

  _DescriptionPageState createState() => _DescriptionPageState();
}

/*_dataRead() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String data = pref.getString('item');
  print(data);
}*/

final FirebaseAuth _auth = FirebaseAuth.instance;

class _DescriptionPageState extends State<descriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Center(
        child: InkWell(
          child: ListTile(
            title: Column(
              children: [
                Image.network(widget.urlToImage),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                /*Text(
                  widget.author,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ), */
                /*Text(
                  widget.content,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
