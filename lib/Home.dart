import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:documentation_get_request_with_indicator/posts_class.dart';

Future<Posts> fetchPost() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');
  if (response.statusCode == 200) {
    return Posts.fromJson(json.decode(response.body));
  } else {
    throw Exception('Faild to Load Posts');
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Posts> post;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    post = fetchPost();
    //print(post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("featching data from Api"),
      ),
      body: Center(
        child: FutureBuilder<Posts>(
          future: post,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.title);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
