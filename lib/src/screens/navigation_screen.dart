import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _page = 0;

  _changePage(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _page,
        children: [
          Center(child: Text('Home')),
          Center(child: Text('Search')),
          Center(child: Text('Uplade')),
          Center(child: Text('Bookmark')),
          Center(child: Text('Profile')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.black54,
          type: BottomNavigationBarType.fixed,
          currentIndex: _page,
          onTap: _changePage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.where_to_vote_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline), label: 'Upload'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_outline), label: 'BookMark'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined), label: 'Mypage'),
          ]),
    );
  }
}
