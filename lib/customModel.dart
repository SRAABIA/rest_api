import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Customs extends StatefulWidget {
  const Customs({super.key});

  @override
  State<Customs> createState() => _CustomsState();
}

class _CustomsState extends State<Customs> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos() async {
      final respone = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
      var data = jsonDecode(respone.body.toString());
      if(respone.statusCode == 200){
        photosList.clear();
        for(Map i in data){
         Photos photo = Photos(title: i['title'], url: i['url']);
         photosList.add(photo);
        }
      }
      return photosList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Custom Model"),
          centerTitle: true,
          backgroundColor: Colors.pink.shade100,
        ),
      body: Expanded(
        child: FutureBuilder(
          future: getPhotos(),
          builder: (context, AsyncSnapshot<List<Photos>> snapshot ){
            return ListView.builder(
              itemCount: photosList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                  ),
                  subtitle : Text(snapshot.data![index].title.toString()),

                );
              }
            );
          },
        ),
      )
    );
  }
}

class Photos {
  String title, url;

  Photos({required this.title, required this.url});
}