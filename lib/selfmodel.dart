import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyModel extends StatefulWidget {
  MyModel({Key? key}) : super(key: key);

  @override
  State<MyModel> createState() => _MyModelState();
}

class _MyModelState extends State<MyModel> {
  List<Photo> photoList = [];

  Future<List<Photo>> getPhoto() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        Photo photo = Photo(title: i['title'], url: i['url'], id: i['id']);
        photoList.add(photo);
      }
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My API Model"),
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
              future: getPhoto(),
              builder: (context, AsyncSnapshot<List<Photo>?> snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading");
                } else {
                  return ListView.builder(
                      itemCount: photoList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                snapshot.data![index].url.toString()),
                          ),
                          title: Text(snapshot.data![index].title.toString()),
                          subtitle: Text(snapshot.data![index].id.toString()),
                        );
                      });
                }
              }),
        ),
      ]),
    );
  }
}

class Photo {
  String? title, url;
  int? id;

  Photo({required this.title, required this.url, required id});
}
