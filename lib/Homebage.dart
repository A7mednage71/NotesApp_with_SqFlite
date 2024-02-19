import 'package:flutter/material.dart';
import 'package:sqflite_proj/AddNoteScreen.dart';
import 'package:sqflite_proj/Sqflite.dart';
import 'package:sqflite_proj/wedgets/NoteItem.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final SqFlite sqFlite = SqFlite();
  List notes = [];
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    notes = await sqFlite.readData(sql: "SELECT * FROM 'Notes'");
    print("++++++++++read notes+++++++++");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          MaterialButton(
            onPressed: () {
              sqFlite.DeleteDatabase();
            },
            child: const Text('Delete all Notes'),
          ),
          SizedBox(
            height: 720,
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return NoteItem(
                  note: notes[index],
                  notes: notes,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext) {
            return const AddNote();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
