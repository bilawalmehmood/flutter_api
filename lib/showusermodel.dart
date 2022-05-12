import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/models/users_model.dart';
import 'package:http/http.dart' as http;

class ShowUserModel extends StatefulWidget {
  ShowUserModel({Key? key}) : super(key: key);

  @override
  State<ShowUserModel> createState() => _ShowUserModelState();
}

class _ShowUserModelState extends State<ShowUserModel> {
  List<UsersModel> userlist = [];
  Future<List<UsersModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      userlist.clear();
      for (Map<String, dynamic> i in data) {
        userlist.add(UsersModel.fromJson(i));
      }
      return userlist;
    } else {
      return userlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Learning"),
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<UsersModel>> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                      itemCount: userlist.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(children: [
                            ReusableRow(
                                title: "Name :",
                                value: snapshot.data![index].name.toString()),
                            ReusableRow(
                                title: "Email :",
                                value: snapshot.data![index].email.toString()),
                            ReusableRow(
                                title: "City :",
                                value: snapshot.data![index].address?.street
                                    .toString()),
                          ]),
                        );
                      });
                }
              }),
        ),
      ]),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String? title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title!), Text(value!)],
      ),
    );
  }
}
