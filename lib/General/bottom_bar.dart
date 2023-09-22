import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

// =============== pages ===============
import "../Recycling/Pages/bin_locator.dart";
import "../Home/pages/home.dart";
import "../Contests/pages/all_contest_page.dart";

void main() {
  runApp(const BottomBar());
}

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final LocalStorage storage = LocalStorage('bottom_bar_state');
  int _selectedIndex = 0;

  @override
  bool get wantKeepAlive => true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    storage.setItem('index', index);
  }

  @override
  Widget build(BuildContext context) {
    if (storage.getItem("index") != null) {
      _selectedIndex = storage.getItem("index");
      // print("index: $_selectedIndex");
    } else {
      _selectedIndex = 0;
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      currentIndex: _selectedIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Hunt',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events),
          label: 'Contests',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star_rate),
          label: 'Rewards',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) => {
        _onItemTapped(index),
        if (index == 0)
          {Navigator.pushNamed(context, "/home")}
        else if (index == 1)
          {Navigator.pushNamed(context, "/recycling")}
        else if (index == 2)
          {Navigator.pushNamed(context, "/contests")}
        else if (index == 3)
          {Navigator.pushNamed(context, "/rewards")}
        else if (index == 4)
          {Navigator.pushNamed(context, "/profile")}
      },
      //some widget )
    );
  }
}
