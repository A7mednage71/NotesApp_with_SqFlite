import 'package:flutter/material.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    notes = await sqFlite.readData(sql: "SELECT * FROM 'Notes'");
    print("++++++++++read notes+++++++++");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return NoteItem(
            note: notes[index],
          );
        },
      ),
    );
  }
}
