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
      Uri.parse('https://gorest.co.in/public/v2/users'),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complex", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
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
                  child: Column(
                    children: [
                      ReusableTile(
                          id: index,
                          title: users[index].name!,
                          email: users[index].email!,
                          status: users[index].status!
                      ),
                    ]
                  )
                );
              },
            );
          }
        },
      ),
    );
  }
}


class ReusableTile extends StatelessWidget {
  final int id;
  final String title, email,status;
   const ReusableTile({super.key, required this.id,required this.title, required this.email, required this.status});


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade700,
        child: Text("${id + 1}",style: TextStyle(color: Colors.white),),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("✉️: $email"),
      trailing: Text(status, style: TextStyle( color: status == "active" ? Colors.green : Colors.red),),


    );
  }
}
