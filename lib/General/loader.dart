import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final String title;

  const Loader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
            ),
            const CircularProgressIndicator(
                color: Color.fromRGBO(18, 126, 0, 1)),
          ],
        ),
      ),
    );
  }
}
