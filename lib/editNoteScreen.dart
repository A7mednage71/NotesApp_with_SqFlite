import 'package:flutter/material.dart';
import 'package:sqflite_proj/Homebage.dart';
import 'package:sqflite_proj/Sqflite.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key, this.note});
  final note;
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  GlobalKey<FormState> _formKey = GlobalKey();

  SqFlite sqFlite = SqFlite();

  String Note = "NNNN";
  String Title = "NNNN";
  String Color = "NNNN";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
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
                  int res = await sqFlite.updateData(
                    sql: '''
                        UPDATE Notes SET 
                        note  =  '$Note',
                        color =  '$Color',
                        Title =  '$Title'
                        WHERE id = ${widget.note['id']} 
                        ''',
                  );

                  print(res);

                  if (res > 0) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext) => Homepage(),
                        ),
                        (route) => false);
                  }
                },
                color: Colors.amber,
                child: Text('Edit Note'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
