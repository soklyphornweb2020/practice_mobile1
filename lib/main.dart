import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(Pixabay());

class Pixabay extends StatefulWidget {
  @override
  _PixabayState createState() => _PixabayState();
}

class _PixabayState extends State<Pixabay> {
  Map image;
  List imgList;
  Future getPixabay() async {
    http.Response response = await http.get("https://pixabay.com/api/?key=14001068-da63091f2a2cb98e1d7cc1d82&q=yellow+flowers&image_type=photo&pretty=true");
    image = json.decode(response.body);
    setState(() {
     imgList = image['hits'];
    });
  }
   @override
   void initState(){
     super.initState();
     getPixabay();
   }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Text('Pixabay',
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.red,
          ),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: imgList == null ? 0 : imgList.length,
          itemBuilder:(context, i) {
            return Card(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(imgList[i]['largeImageURL']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(imgList[i]['largeImageURL']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${imgList[i]['tags']}",
                          style: TextStyle(color: Colors.red, fontSize: 17.0,),
                          ),
                        ),
                        IconButton(icon: Icon(Icons.share, color: Colors.red,),),
                        IconButton(icon: Icon(Icons.favorite, color: Colors.red,),),
                        IconButton(icon: Icon(Icons.link, color: Colors.red,),),
                      ],
                    )
                  )
                ],
              )
            );
          }
        ),
      ),
    );
  }
}