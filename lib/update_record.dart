import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class update_record extends StatefulWidget {
  String name;
  String email;
  String password;
  update_record(this.name, this.email, this.password);

  @override
  State<update_record> createState() => _update_recordState();
}

class _update_recordState extends State<update_record> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> update_record() async {
    String uri = "http://localhost/crud_api/update_data.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {
        "name": name.text,
        "email": email.text,
        "password": password.text,
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("updated");
      } else {
        print("some issues");
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    name.text = widget.name;
    email.text = widget.email;
    password.text = widget.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Record"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('Enter the name')),
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
                update_record();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
              ),
              child: Text('Update'),
            ),
          ),
        ],
      ),
    );
  }
}
