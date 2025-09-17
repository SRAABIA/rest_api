import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/PostsModel.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PostsModel> posts = [];
  Future<List<PostsModel>> getPostApi() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      posts.clear();
      for( Map i in data){
        posts.add(PostsModel.fromJson(i));
      }
    }

    return posts;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body:
      Column(
        children: [
          Expanded( // size of list is greater than screen, so we are telling the screen to occupy the length of list
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return Text('L O A D I N G . . .');
                }
                else{
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4, // shadow effect
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // align left
                            children: [
                              Text(
                                posts[index].title.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                posts[index].body.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  height: 1.4, // line spacing
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );

                }
              },

            ),
          ),

        ],
      ),
    );
  }
}

