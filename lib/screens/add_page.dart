
import 'package:flutter/material.dart';
import 'package:todo_app/services/todo_service.dart';

import '../utils/snackbar_helper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({
    super.key,
    this.todo,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (widget.todo != null) {
      isEdit = true;
      final title = todo?['title'];
      final description = todo?['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 43, 50, 71),
          title: Text(
            isEdit ? 'Edit Todo' : 'Add Todo',
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(hintText: 'Description'),
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 10,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(55, 85, 41, 218),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: isEdit ? updateData : submitData,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    isEdit ? 'Update' : 'submit',
                  ),
                )),
          ],
        ));
  }

  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      print('you can not call update without todo data');
      return;
    }
    final id = todo['_id'];
    
    final isSuccess = await TodoService.updateTodo(id, body);

    if (isSuccess != null) {
      showSuccessMessage(context, message: 'Success');
      Navigator.pop(context);
    } else {
      showFailureMessage(context, message: 'Failure');
    }
  }

  Future<void> submitData() async {
  
    final isSuccess = await TodoService.addTodo(body);
    if (isSuccess != null) {
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage(context, message: 'Success');
       Navigator.pop(context);
    } else {
      showFailureMessage(context, message: 'Failure');
    }
  }

  Map get body {
    final title = titleController.text;
    final description = descriptionController.text;
    return {
      "title": title,
      "description": description,
      "is_complete": false,
    };
  }
}
