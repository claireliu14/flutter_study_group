import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'UvLight.dart';

import 'dart:async';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter networking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter networking'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: FutureBuilder<List<UvLight>>(
            future: fetchData(),
            builder:
                (BuildContext context, AsyncSnapshot<List<UvLight>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();

                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return createListView(snapshot.data);

                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
              }
            }),
      ),
    );
  }

  Widget createListView(List<UvLight> list) {
    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (BuildContext context, int index) =>
          Divider(),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Row (
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(list[index].County),
              Text(list[index].SiteName),
              Text(list[index].UVI)
            ],
          ),
        );
      },
    );
  }

  Future<List<UvLight>> fetchData() async {
    final response = await http
        .get('http://opendata.epa.gov.tw/webapi/Data/UV/?format=json');

    if (response.statusCode == 200) {
      print(response.body);
      return UvLight.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data.');
    }
  }
}
