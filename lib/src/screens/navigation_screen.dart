import 'package:flutter/material.dart';
import 'package:flutter_yaber/src/screens/home/home_feed_screen.dart';
import 'package:flutter_yaber/src/screens/home/home_mypage_screen.dart';
import 'package:flutter_yaber/src/screens/home/home_upload_screen.dart';
import 'package:get/get.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _page = 4;

  _changePage(int index) {
    if (index == 2) {
      Get.to(const HomeUploadScreen());
    } else {
      setState(() {
        _page = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _homeAppbar(_page),
      body: IndexedStack(
        index: _page,
        children: [
          HomeFeedScreen(),
          Center(child: Text('Search')),
          Center(child: Text('Uplade')),
          Center(child: Text('Bookmark')),
          const HomeMypageScreen(),
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

PreferredSizeWidget _homeAppbar(int index) {
  // Widget build(BuildContext context) {
  String title = '';
  String getTitle(int page) {
    switch (page) {
      case 0:
        title = 'YABER';
        break;
      case 1:
        title = 'SEARCH';
        break;
      case 2:
        title = 'UPLOAD POST';
        break;
      case 3:
        title = 'BOOKMARK';
        break;
      case 4:
        title = 'MY PAGE';
        break;
      default:
        title = '';
        break;
    }
    return title;
  }

  List<Widget> getActionIcon(int page) {
    IconButton iconButton1 = IconButton(
        onPressed: () {
          // Get.to(const AlarmPage());
        },
        icon: const Icon(
          Icons.notifications_none,
          color: Colors.black,
        ));
    IconButton iconButton2 = IconButton(
        onPressed: () {
          // Get.to(const SettingPage());
        },
        icon: const Icon(
          Icons.settings,
          color: Colors.black,
        ));
    List<Widget> list = [];
    if (page == 4) {
      list.add(iconButton2);
      list.add(iconButton1);
    } else {
      list.add(iconButton1);
    }
    return list;
  }

  return AppBar(
    title: Text(
      getTitle(index),
      style: index == 0
          ? const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Colors.redAccent)
          : const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black),
    ),
    elevation: 0,
    centerTitle: index == 4 ? false : true,
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    actions: getActionIcon(index),
  );
}
