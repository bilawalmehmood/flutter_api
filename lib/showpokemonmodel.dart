import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/pokemon_model.dart';

class ShowProduct extends StatefulWidget {
  ShowProduct({Key? key}) : super(key: key);

  @override
  State<ShowProduct> createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  Future<Model> getPokemonApi() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/cd45c5af-c1fa-4e1a-aa79-15b4ac43ed3c'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return Model.fromJson(data);
    } else {
      return Model.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pokemon API"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<Model>(
            future: getPokemonApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.pokemon?.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .2,
                            width: MediaQuery.of(context).size.height * 1,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(snapshot
                                        .data!.pokemon![index]!.img
                                        .toString()))),
                          )
                        ],
                      );
                    });
              } else {
                return Text("Loading");
              }
            },
          ))
        ],
      ),
    );
  }
}
