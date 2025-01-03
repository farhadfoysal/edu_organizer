import 'package:class_organizer/ui/screens/auth/SignInScreen.dart';
import 'package:class_organizer/ui/screens/students_screen/campus_routine.dart';
import 'package:class_organizer/ui/screens/students_screen/class_manager_screen.dart';
import 'package:class_organizer/ui/screens/students_screen/class_set_up_menu.dart';
import 'package:class_organizer/ui/screens/students_screen/edit_profile_screen.dart';
import 'package:class_organizer/ui/screens/students_screen/academic_calender_screen.dart';
import 'package:class_organizer/ui/screens/students_screen/settings_screen.dart';
import 'package:class_organizer/ui/screens/students_screen/student_companion_screen.dart';
import 'package:class_organizer/ui/widgets/drawer_widget.dart';
import 'package:class_organizer/utility/profile_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: index == 0
          ? ProfileAppBar(
        title:  'Student Companions',
        actionIcon: Icons.more_vert,
        onActionPressed: (){},
        appBarbgColor: const Color(0xFF01579B),
      )
          : null,
      drawer: const DrawerWidget(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            index = value;
          });
        },
        children: [
          StudentCompanionScreen(),
          ClassManagerScreen(),
          CampusRoutine(),
          AcademicCalender(),
          EditProfileScreen(),
          ClassSetUpMenu(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          _pageController.jumpToPage(value);
          setState(() {
            index = value;
          });
        },
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.indigoAccent,
        unselectedItemColor: Colors.grey,
        elevation: 3,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_outlined),
            label: 'Schedules',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_outlined),
            label: 'Routines',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Academic Calender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Menu',
          ),
        ],
      ),

    );
  }
}
