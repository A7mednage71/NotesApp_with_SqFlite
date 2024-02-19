import 'package:flutter/material.dart';
import 'package:sqflite_proj/Homebage.dart';
import 'package:sqflite_proj/Sqflite.dart';
import 'package:sqflite_proj/editNoteScreen.dart';

class NoteItem extends StatefulWidget {
  NoteItem({super.key, this.note, required this.notes});
  final note;
  final List notes;
  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 11),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${widget.note['Note']}'),
                    Text('${widget.note['Title']}'),
                    Text('${widget.note['color']}'),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (BuildContext) {
                      return EditNote(
                        note: widget.note,
                      );
                    }));
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  )),
              IconButton(
                onPressed: () async {
                  SqFlite sqFlite = SqFlite();
                  // int res = await sqFlite.deleteData(
                  //     sql:
                  //         "DELETE FROM 'Notes' WHERE id = ${widget.note['id']} ");
                  int res = await sqFlite.delete(
                      table: "Notes", where: "id = ${widget.note['id']}");
                  print(res);

                  if (res > 0) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Homepage(),
                    ));
                    // widget.notes.removeWhere(
                    //     (element) => element['id'] == widget.note['id']);
                  }
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
