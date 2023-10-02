import 'package:flutter/material.dart';

class ApplicationToolbar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;
  const ApplicationToolbar(
      {Key? key, required this.title, required this.automaticallyImplyLeading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading, // hides leading widget
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
