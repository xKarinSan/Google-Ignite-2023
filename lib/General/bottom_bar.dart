import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final LocalStorage storage = LocalStorage('bottom_bar_state');
  int _selectedIndex = 0;

  // @override
  // bool get wantKeepAlive => true;

  void _onItemTapped(int index) {
    setState(() {
      storage.setItem('index', index);
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    print('before: ${storage.getItem("index")}');
    if (storage.getItem("index") == null) {
      storage.setItem('index', 0);
    }
    _selectedIndex = storage.getItem("index");
  }

  @override
  Widget build(BuildContext context) {
    if (storage.getItem("index") != null) {
      _selectedIndex = storage.getItem("index");
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
        if (index == 0 && index != _selectedIndex)
          {Navigator.pushNamed(context, "/home")}
        else if (index == 1 && index != _selectedIndex)
          {Navigator.pushNamed(context, "/recycling")}
        else if (index == 2 && index != _selectedIndex)
          {Navigator.pushNamed(context, "/contests")}
        else if (index == 3 && index != _selectedIndex)
          {Navigator.pushNamed(context, "/rewards")}
        else if (index == 4 && index != _selectedIndex)
          {Navigator.pushNamed(context, "/profile")},
        _onItemTapped(index),
      },
      //some widget )
    );
  }
}
