import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 43, 50, 71),
          title: Text('Add Todo'),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(hintText: 'Description'),
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 10,
            ),
            SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 85, 41, 218),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: submitData,
                child: Text('submit')),
          ],
        ));
  }

  Future<void> submitData() async {
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_complete": false,
    };
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      titleController.text = '';
      descriptionController.text = '';
      print('Success');
      showSuccessMessage('Success');
    } else {
      print('failure');
      print(response.body);
      showFailureMessage('Failure');
    }
    ;
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      //duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showFailureMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
      //duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
