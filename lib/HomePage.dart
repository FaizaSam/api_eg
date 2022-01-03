// ignore: file_names
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

String stringResponse;
Map dataResponse;
List listResponse;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map mapResponse;
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        stringResponse = response.body;
        mapResponse = jsonDecode(response.body);
        //  dataResponse = mapResponse['data'];
        listResponse = mapResponse['data'];
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Demo'),
      ),
      body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Column(
                children: [
                  Image.network(listResponse[index]['avatar']),
                  Text(listResponse[index]['id'].toString()),
                  Text(listResponse[index]['email'].toString()),
                  Text(listResponse[index]['first_name'].toString()),
                  Text(listResponse[index]['last_name'].toString()),
                  //   Text(listResponse[index]['id'].toString()),
                ],
              ),
            );
          },
          itemCount: listResponse == null ? 0 : listResponse.length),
    );
  }
}
