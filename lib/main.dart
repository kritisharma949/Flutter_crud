import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:crud/view_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> insertrecord() async {
    if (name.text != "" && email.text != "" && password.text != "") {
      try {
        String uri = "http://localhost/crud_api/insert_record.php";

        var res = await http.post(Uri.parse(uri), body: {
          "name": name.text,
          "email": email.text,
          "password": password.text
        });

        if (res.statusCode == 200) {
          var response = jsonDecode(res.body);
          if (response["success"] == true) {
            print("Record inserted successfully");
            name.text = "";
            email.text = "";
            password.text = "";
          } else {
            print("Error occurred while inserting record");
          }
        } else {
          print(
              "Error occurred while communicating with server. Status code: ${res.statusCode}");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("please fill all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Insert Record"),
          backgroundColor: Colors.blueGrey,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Enter the name')),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enter the Email'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: password,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Enter the Password')),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  insertrecord();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                ),
                child: Text('Insert'),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => view_data()));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueGrey,
                      ),
                      child: Text('View Data'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
