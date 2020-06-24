import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'PostData.dart';

Future<Data> fetchData() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/albums/1');

  if (response.statusCode == 200) {
    return Data.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error while loading data');
  }
}

class Data {
  final int userId;
  final int id;
  final String title;

  Data({this.userId, this.id, this.title});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class FetchData extends StatefulWidget {
  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  Future<Data> fetchedData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchedData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Request'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.all(40.0),
              child: FutureBuilder<Data>(
                future: fetchedData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'Title - ${snapshot.data.title}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ),
          Text(
            'Click Here to Post new title.',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.red),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PostData()));
            },
            child: Icon(Icons.navigate_next),
          )
        ],
      ),
    );
  }
}
