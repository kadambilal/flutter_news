import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sonproje/description_page.dart';
import 'package:sonproje/settings_page.dart';

import 'package:sonproje/news.dart';
import 'package:http/http.dart' as http;

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  // Eskiden Firestore'du.

  /*_dataTransfer() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('item', "123");
  }*/

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<News> getData() async {
    final response = await http.get(
        'http://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=9b7435faa59b4bff9d7c411bb23b1d18');
    return newsFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: Text(
          "Haberler Akışı",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => settingsPage(),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<News>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Haberler yükleniyor lütfen bekleyiniz..'),
                      SizedBox(
                        height: 50,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
                );
                break;
              default:
                if (snapshot.hasError)
                  return Center(
                    child: Text('Hata: ${snapshot.error}'),
                  );
                else
                  return ListView.builder(
                    itemCount: snapshot.data.articles.length,
                    itemBuilder: (context, index) {
                      List<Article> response = snapshot.data.articles;
                      Article item = response[index];
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                        child: InkWell(
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => descriptionPage(
                                    title: item.title,
                                    description: item.description,
                                    urlToImage: item.urlToImage,
                                    author: item.author,
                                    content: item.content,
                                  ),
                                ),
                              );
                            },
                            leading: item.urlToImage != null
                                ? Image.network(
                                    item.urlToImage,
                                    height: 80,
                                    width: 80,
                                  )
                                : SizedBox.shrink(),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
            }
          },
        ),
      ),
    );
  }
}
