import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebasetrain2/screens/add_note_screen.dart';
import 'package:firebasetrain2/screens/main_screen.dart';
import 'package:firebasetrain2/screens/note_screen.dart';
import 'package:firebasetrain2/screens/profile_screen.dart';
import 'package:firebasetrain2/screens/to_do_list.dart';
import 'package:flutter/material.dart';


class MainNavigator extends StatefulWidget {
  const MainNavigator({Key? key}) : super(key: key);

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  final PageController _pageController = PageController();


  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const MainScreen(),
    const ToDoList(),
    const NoteScreen(),
    //const AddNoteScreen(),
     ProfileScreen(),
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
    return  Scaffold(
        body: SizedBox(

          child: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _screens,
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10 ),
          child: CustomNavigationBar(
            isFloating: true,
            elevation: 2,
            iconSize: 35,
            borderRadius: const Radius.circular(20),
            selectedColor: Colors.white,
            unSelectedColor: const Color.fromARGB(147, 157, 168, 129),
            //backgroundColor: const Color.fromARGB(255, 248, 248, 248),
            backgroundColor: const Color.fromRGBO(65, 77, 87, 1.0),

            strokeColor: Colors.white,
            items: [
              CustomNavigationBarItem(
                icon: Image.asset('assets/img/home_bottom.png',
                  color: Colors.white70,
                ),
              ),
              CustomNavigationBarItem(
                icon: Center(
                  child:Image.asset('assets/img/toDo_list.png',
                    color: Colors.white70, ),
                ),
                ),
              CustomNavigationBarItem(
                icon: Image.asset('assets/img/note_bottom.png',
                  color: Colors.white70, ),
              ),
           /*   CustomNavigationBarItem(
                icon: Image.asset('assets/img/create_note_bottom.png',
                ),
              ),*/
              CustomNavigationBarItem(
                icon: Image.asset('assets/img/profile_bottom.png',
                  color: Colors.white70, ),
              ),
            ],
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
          ),
        ),
    );
  }
}
