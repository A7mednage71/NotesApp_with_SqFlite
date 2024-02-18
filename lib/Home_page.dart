import 'package:flutter/material.dart';

class homepage extends StatelessWidget {
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {},
              color: const Color.fromARGB(255, 139, 244, 54),
              child: const Text('SAVE DATA'),
            ),
            MaterialButton(
              onPressed: () {},
              color: Colors.red,
              child: const Text('READ DATA'),
            ),
          ],
        ),
      ),
    );
  }
}
