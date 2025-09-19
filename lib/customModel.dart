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
      final response = await http.get(
          Uri.parse("https://jsonplaceholder.typicode.com/photos"),
      );
      if (response.statusCode == 200) {
        try {
          List<dynamic> data = jsonDecode(response.body);
          print("Response body: ${response.body}");
          return data.map((e) => Photos.fromJson(e)).toList();
        } catch (e) {
          throw Exception("Failed to parse JSON: $e");
        }
      } else {
        throw Exception("Failed to load photos. Status: ${response.statusCode}");
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Model"),
        centerTitle: true,
        backgroundColor: Colors.pink.shade100,
      ),
      body: FutureBuilder<List<Photos>>(
        future: getPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          final photos = snapshot.data!;
          return ListView.builder(
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(photos[index].url),
                ),
                subtitle: Text(photos[index].title),
              );
            },
          );
        },
      ),
    );
  }

// Widget build(BuildContext context) {
  //
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: Text("Custom Model"),
  //         centerTitle: true,
  //         backgroundColor: Colors.pink.shade100,
  //       ),
  //     body:
  //        FutureBuilder(
  //         future: getPhotos(),
  //         builder: (context, AsyncSnapshot<List<Photos>> snapshot ){
  //           return ListView.builder(
  //             itemCount: photosList.length,
  //
  //             itemBuilder: (context, index) {
  //               return ListTile(
  //                 leading: CircleAvatar(
  //                   backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
  //                 ),
  //                 subtitle : Text(snapshot.data![index].title.toString()),
  //
  //               );
  //             }
  //           );
  //         },
  //       ),
  //
  //   );
  // }
}

class Photos {
  String title, url;

  Photos({required this.title, required this.url});

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      title: json['title'] as String,
      url: json['url'] as String,
    );
  }
}