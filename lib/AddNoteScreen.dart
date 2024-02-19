import 'package:flutter/material.dart';
import 'package:sqflite_proj/Homebage.dart';
import 'package:sqflite_proj/Sqflite.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> _formKey = GlobalKey();

  SqFlite sqFlite = SqFlite();

  String Note = "NNNN";
  String Title = "NNNN";
  String Color = "NNNN";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              TextFormField(
                onSaved: (newValue) {
                  Note = newValue!;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    labelText: 'Note'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onSaved: (newValue) {
                  Title = newValue!;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    labelText: 'Title'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onSaved: (newValue) {
                  Color = newValue!;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    labelText: 'Color'),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () async {
                  _formKey.currentState!.save();
                  int res = await sqFlite.insertData(
                    sql: '''INSERT INTO Notes (Note, Title, color)
                              VALUES ('$Note', '$Title', '$Color')''',
                  );

                  print(res);

                  if (res > 0) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext) => Homepage(),
                        ),
                        (route) => false);
                  }
                },
                color: Colors.amber,
                child: Text('Add Note'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
