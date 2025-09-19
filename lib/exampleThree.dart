import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rest_api/Models/UserModel.dart';

class Complex extends StatefulWidget {
  const Complex({super.key});

  @override
  State<Complex> createState() => _ComplexState();
}

class _ComplexState extends State<Complex> {
  Future<List<UserModel>> getUserApi() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      print("Status code: ${response.statusCode}");
      print("Response: ${response.body}");
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complex"),
        centerTitle: true,
        backgroundColor: Colors.pink.shade200,
      ),
      body: FutureBuilder<List<UserModel>>(
        future: getUserApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.pink.shade200,
                strokeWidth: 5,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data found"));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text("Name: ${users[index].name}"),
                    subtitle: Text("Email: ${users[index].email}"),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
