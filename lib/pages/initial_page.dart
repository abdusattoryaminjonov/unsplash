import 'package:flutter/material.dart';
import 'package:unsplash/pages/collections_page.dart';
import 'package:unsplash/pages/details_page.dart';
import 'package:unsplash/pages/home_page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  PageController? _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index){
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          HomePage(),

          CollectionsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.collections,), label: ""),
        ],
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        selectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        iconSize: 35,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
            _pageController!.animateToPage(
                index,
                duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          });
        },
      ),
    );
  }
}