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
      final response = await http.get(Uri.parse('https://gorest.co.in/public/v2/users'));
      print(response.body.toString());

      if (response.statusCode == 200) {
        try {
          List<dynamic> data = jsonDecode(response.body.toString());
          print("Response body: ${data.toString()}");
          for(Map i in data){
            Photos photos = Photos(name: i['name'], email: i['email']);
            photosList.add(photos);

          }
          return photosList;
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
                 // backgroundImage: NetworkImage(photos[index].url),
                ),
                subtitle: Text(photos[index].name),
                title: Text(photos[index].email),
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
  String name, email;

  Photos({required this.name, required this.email});

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
}