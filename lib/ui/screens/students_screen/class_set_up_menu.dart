import 'package:class_organizer/ui/screens/bus/bus_schedule.dart';
import 'package:class_organizer/admin/panel/admin_comopanion.dart';
import 'package:class_organizer/admin/school/exam/exam_routine.dart';
import 'package:class_organizer/admin/school/pages/courses.dart';
import 'package:class_organizer/admin/school/pages/departments.dart';
import 'package:class_organizer/admin/school/pages/programs.dart';
import 'package:class_organizer/admin/school/pages/rooms.dart';
import 'package:class_organizer/admin/school/pages/routines.dart';
import 'package:class_organizer/admin/school/pages/sessions.dart';
import 'package:class_organizer/admin/school/pages/students.dart';
import 'package:class_organizer/admin/school/pages/teachers.dart';
import 'package:class_organizer/ui/screens/students_screen/class_manager_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utility/profile_app_bar_admin.dart';
import '../../../utility/scanner_code.dart';
import '../../widgets/drawer_widget.dart';
import 'campus_routine.dart';


class ClassSetUpMenu extends StatefulWidget {
  const ClassSetUpMenu({super.key});

  @override
  State<ClassSetUpMenu> createState() => _ClassSetUpMenuState();
}

class _ClassSetUpMenuState extends State<ClassSetUpMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:ProfileAppBarAdmin(
        title: 'Menu',
        actionIcon: Icons.more_vert,
        onActionPressed: (){},
        appBarbgColor: const Color(0xFF01579B),
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menu Grid Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  childAspectRatio: 0.75,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    _buildMenuItem(Icons.bus_alert_outlined, 'Bus',
                            () => _navigateToPage(context, 'bus')),
                    _buildMenuItem(Icons.event_busy, 'Absences',
                            () => _navigateToPage(context, 'absence')),
                    _buildMenuItem(Icons.calculate, 'Calculation',
                            () => _navigateToPage(context, 'calculation')),
                    _buildMenuItem(Icons.qr_code_scanner, 'Scanner',
                            () => _navigateToPage(context, 'scanner')),
                    _buildMenuItem(Icons.schedule, 'Timetable',
                            () => _navigateToPage(context, 'time')),
                    _buildMenuItem(Icons.event_note, 'Schedule',
                            () => _navigateToPage(context, 'schedules'),
                        hasNotification: true, notificationCount: 3),
                    _buildMenuItem(Icons.note, 'Notes',
                            () => _navigateToPage(context, 'notes')),
                    _buildMenuItem(Icons.school_outlined, 'Exams',
                            () => _navigateToPage(context, 'exams')),
                    _buildMenuItem(Icons.punch_clock_outlined, 'Routines',
                            () => _navigateToPage(context, 'routines')),
                  ],
                ),
              ),

              // Today's Summary Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Setup and Customize Your Routine",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  _buildSummaryCard(
                      Icons.schedule,
                      'Timetable',
                      'There is no classes',
                      'You don\'t have classes timetable to attend today.',
                          () => _navigateToPage(context, 'TimetableSummaryPage')),
                  _buildSummaryCard(
                      Icons.book,
                      'Homework',
                      'No homework',
                      'Today you have no scheduled tasks to present.',
                          () => _navigateToPage(context, 'HomeworkPage')),
                  _buildSummaryCard(
                      Icons.school,
                      'Exams',
                      'No exams',
                      'You don\'t have scheduled exams today.',
                          () => _navigateToPage(context, 'ExamsPage')),
                  _buildSummaryCard(Icons.event, 'Events', 'Cse', 'FgF',
                          () => _navigateToPage(context, 'EventsPage')),
                  _buildSummaryCard(
                      Icons.book,
                      'Books',
                      'There are no books',
                      'Today you have no borrowed books to return.',
                          () => _navigateToPage(context, 'BooksPage')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build menu item with navigation
  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap,
      {bool hasNotification = false, int notificationCount = 0}) {
    return InkWell(
      onTap: onTap, // This will handle navigation when tapped
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blue[50],
                child: Icon(icon, color: Colors.blue, size: 30),
              ),
              SizedBox(height: 8),
              Text(title, style: TextStyle(fontSize: 12)),
            ],
          ),
          if (hasNotification)
            Positioned(
              right: 0,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.red,
                child: Text(
                  notificationCount.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Helper method to build summary card with navigation
  Widget _buildSummaryCard(IconData icon, String title, String subtitle,
      String description, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        child: ListTile(
          onTap: onTap,
          // This will handle navigation when tapped
          leading: CircleAvatar(
            backgroundColor: Colors.blue[50],
            child: Icon(icon, color: Colors.blue),
          ),
          title: Text(title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Text(subtitle),
              SizedBox(height: 4),
              Text(description,
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          trailing: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, String pageName) {
    if(pageName=='bus'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => BusSchedule()));
    }else if(pageName=='schedules'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => CampusRoutine()));
      //Get.off(CampusRoutine());
    }else if(pageName=='scanner'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ScannerCode()));
    }else if(pageName=='rooms'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => RoomListPage()));
    }else if(pageName=='courses'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => CoursesListPage()));
    }else if(pageName=='routines'){
      //Get.off(ClassManagerScreen());
      Navigator.push(context, MaterialPageRoute(builder: (context) => ClassManagerScreen()));
    }else if(pageName=='faculty'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => TeachersListPage()));
    }else if(pageName=='exams'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ExamRoutine()));
    }else{

    }
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) {
    //     // Placeholder for different pages, replace with actual page widgets
    //     return Scaffold(
    //       appBar: AppBar(title: Text(pageName)),
    //       body: Center(child: Text('This is the $pageName page')),
    //     );
    //   }),
    // );
  }
}

// import 'package:flutter/material.dart';
//
// class SchoolSetup extends StatefulWidget {
//   const SchoolSetup({super.key});
//
//   @override
//   State<SchoolSetup> createState() => _SchoolSetupState();
// }
//
// class _SchoolSetupState extends State<SchoolSetup> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Menu'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Menu Grid Section
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: GridView.count(
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 crossAxisCount: 4,
//                 childAspectRatio: 1,
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing: 10,
//                 children: [
//                   _buildMenuItem(Icons.book, 'Subjects'),
//                   _buildMenuItem(Icons.event_busy, 'Absences'),
//                   _buildMenuItem(Icons.calculate, 'Calculation'),
//                   _buildMenuItem(Icons.schedule, 'Timetable'),
//                   _buildMenuItem(Icons.event_note, 'Schedule',
//                   hasNotification: true, notificationCount: 3),
//                   _buildMenuItem(Icons.note, 'Notes'),
//                   _buildMenuItem(Icons.people, 'Teachers'),
//                   _buildMenuItem(Icons.qr_code_scanner, 'Scanner'),
//                   _buildMenuItem(Icons.bar_chart, 'Statistics'),
//                 ],
//               ),
//             ),
//
//             // Today's Summary Section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 "Today's Summary",
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//             ),
//             ListView(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               children: [
//                 _buildSummaryCard(Icons.schedule, 'Timetable',
//                 'There is no classes',
//                 'You don\'t have classes timetable to attend today.'),
//                 _buildSummaryCard(Icons.book, 'Homework', 'No homework',
//                 'Today you have no scheduled tasks to present.'),
//                 _buildSummaryCard(Icons.school, 'Exams', 'No exams',
//                 'You don\'t have scheduled exams today.'),
//                 _buildSummaryCard(Icons.event, 'Events', 'Cse', 'FgF'),
//                 _buildSummaryCard(Icons.book, 'Books', 'There are no books',
//                 'Today you have no borrowed books to return.'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMenuItem(IconData icon, String title,
//   {bool hasNotification = false, int notificationCount = 0}) {
//     return Stack(
//       children: [
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: 30,
//               backgroundColor: Colors.green[50],
//               child: Icon(icon, color: Colors.green, size: 30),
//             ),
//             SizedBox(height: 8),
//             Text(title, style: TextStyle(fontSize: 12)),
//           ],
//         ),
//         if (hasNotification)
//           Positioned(
//             right: 0,
//             child: CircleAvatar(
//               radius: 10,
//               backgroundColor: Colors.red,
//               child: Text(
//                 notificationCount.toString(),
//                 style: TextStyle(fontSize: 12, color: Colors.white),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
//
//Widget _buildSummaryCard(IconData icon,String title,String subtitle,String description) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: Card(
//         child: ListTile(
//           leading: CircleAvatar(
//             backgroundColor: Colors.green[50],
//             child: Icon(icon, color: Colors.green),
//           ),
//           title: Text(title),
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 4),
//               Text(subtitle),
//               SizedBox(height: 4),
//               Text(description,
//               style: TextStyle(fontSize: 12, color: Colors.grey)),
//             ],
//           ),
//           trailing: Icon(Icons.arrow_forward),
//         ),
//       ),
//     );
//   }
// }
