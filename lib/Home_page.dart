import 'package:flutter/material.dart';
import 'package:sqflite_proj/Sqflite.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final SqFlite sqFlite = SqFlite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () async {
                int response = await sqFlite.insertData(
                  sql: "INSERT INTO 'Notes' ('Note') VALUES ('note one')",
                );
                print(response);
              },
              color: const Color.fromARGB(255, 139, 244, 54),
              child: const Text('SAVE DATA'),
            ),
            MaterialButton(
              onPressed: () async {
                List<Map> response =
                    await sqFlite.readData(sql: "SELECT * FROM 'Notes'");
                print(response);
              },
              color: Colors.red,
              child: const Text('READ DATA'),
            ),
          ],
        ),
      ),
    );
  }
}
