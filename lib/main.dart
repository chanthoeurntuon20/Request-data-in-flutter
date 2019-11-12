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
  Map img;
  List imgList;
 Future getData() async{
   var url = "https://pixabay.com/api/?key=14001068-da63091f2a2cb98e1d7cc1d82&q=red+person&image_type=photo&pretty=true";
   http.Response response = await http.get(url);
  // debugPrint(response.body);
  img = json.decode(response.body);
  setState(() {
   imgList = img['hits']; 
  });
  debugPrint(imgList.toString());
 }
 @override
 ///ini enter
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold( 
        appBar: AppBar( 
          title: Text("Pixabay"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: imgList == null ? 0 : imgList.length,
          itemBuilder: (context,i){
            final myList = imgList[i];
            return Card( 
              child: Column( 
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row( 
                      children: <Widget>[
                        CircleAvatar( 
                          backgroundImage: NetworkImage(myList['userImageURL']),
                        ),
                        SizedBox(width: 20.0,),
                        Text("${myList['user']}"),
                      ],
                    ),
                  ),
                  Container( 
                    child: Image.network(myList['largeImageURL']),
                  ),
                  Container( 
                    margin: EdgeInsets.all(20.0),
                    child: Row( 
                      children: <Widget>[
                        Expanded(
                          child: Column( 
                            children: <Widget>[
                              Icon(Icons.thumb_up),
                              Text("${myList['likes']}"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column( 
                            children: <Widget>[
                              Icon(Icons.favorite),
                              Text("${myList['favorites']}"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column( 
                            children: <Widget>[
                              Icon(Icons.comment),
                              Text("${myList['comments']}"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column( 
                            children: <Widget>[
                              Icon(Icons.group),
                              Text("${myList['views']}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}