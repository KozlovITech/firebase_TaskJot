import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebasetrain2/screens/add_note_screen.dart';
import 'package:firebasetrain2/screens/hello_screen.dart';
import 'package:firebasetrain2/screens/note_screen.dart';
import 'package:firebasetrain2/screens/profile_screen.dart';
import 'package:flutter/material.dart';


class MainNavigator extends StatefulWidget {
  const MainNavigator({Key? key}) : super(key: key);

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  PageController _pageController = PageController();


  int _selectedIndex = 0;

  List<Widget> _screens = [
    const HelloScreen(),
    const NoteScreen(),
    const AddNoteScreen(),
    const ProfileScreen(),
  ];

  void _onPageChanged(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  void _onItemTapped(int i){
    _pageController.jumpToPage(i);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(

          child: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _screens,
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            child: CustomNavigationBar(
              isFloating: true,
              elevation: 2,
              iconSize: 30,
              borderRadius: const Radius.circular(20),
              selectedColor: Colors.white,
              unSelectedColor: const Color.fromARGB(255, 129, 129, 129),
              backgroundColor: const Color.fromARGB(255, 248, 248, 248),
              strokeColor: Colors.white,
              items: [
                CustomNavigationBarItem(
                  icon: Image.asset('assets/img/home_bottom.png',
                  ),
                ),
                CustomNavigationBarItem(
                  icon: Image.asset('assets/img/note_bottom.png',
                  ),
                ),
                CustomNavigationBarItem(
                  icon: Image.asset('assets/img/create_note_bottom.png',
                  ),
                ),
                CustomNavigationBarItem(
                  icon: Image.asset('assets/img/profile_bottom.png',
                  ),
                ),
              ],
              onTap: _onItemTapped,
              currentIndex: _selectedIndex,
            ),
          ),
        ),
      ),
    );
  }
}
