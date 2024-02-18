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
              color: Colors.red,
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
