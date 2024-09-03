import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/firestore.dart';
import 'package:todo_app/widget/todo_card.dart';

class Stream_note extends StatelessWidget {
  final bool done;

  const Stream_note(this.done, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore_Datasource().stream(done),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final noteslist = Firestore_Datasource().getTodos(snapshot);
        return ListView.builder(
          shrinkWrap: true,  // Ensures ListView takes up only the necessary space
          physics: NeverScrollableScrollPhysics(),  // Disables ListView's independent scrolling
          itemCount: noteslist.length,
          itemBuilder: (context, index) {
            final note = noteslist[index];
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                Firestore_Datasource().delet_Todo(note.id);
              },
              child: Task_Widget(
                note,
                index: index,
              ),
            );
          },
        );
      },
    );
  }
}
