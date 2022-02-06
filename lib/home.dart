import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:json_place_holder/photos.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Photos> photos = [];

  Future<List<Photos>> getPhotos() async {
    try {
      var response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        print(data);
        for (var element in data) {
          photos.add(Photos.fromJson(element));
        }
        return photos;
      }
    } catch (e) {
      print('ERROR $e');
    }

    return photos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Load Photos'),
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<List<Photos>>(
          future: getPhotos(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return ListView.builder(
                itemCount: snapShot.data!.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(snapShot.data![index].title!),
                    subtitle: Text(snapShot.data![index].id.toString()),
                        leading:
                            Image.network(snapShot.data![index].thumnailUrl!),
                      ));
            } else if (snapShot.hasError) {
              return Text('Error occured');
            }

            return CircularProgressIndicator();
          }),
    );
  }
}
