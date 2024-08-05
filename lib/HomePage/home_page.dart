// ignore_for_file: library_private_types_in_public_api, avoid_print, deprecated_member_use

// import 'package:doodhwala/Add_Data/Add_User_Name_data/add_user_name_data.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Add_Data/Add_User_Name_data/add_user_name_data.dart';
import 'user_name_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final GlobalKey _bottomNavigationKey = GlobalKey();
   // GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  static final List<Widget> _pages = <Widget>[
          Dudhwale(),
    const AddDataForm(),
    // const ProfilePage(),
    // const Setting(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Build Home Page");
    return Scaffold(

      body: _pages[_selectedIndex],

      backgroundColor: Colors.deepPurpleAccent,

        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
            color: Colors.white,
            // buttonBackgroundColor: Colors.red,
            backgroundColor: Colors.deepPurpleAccent,
            animationCurve: Curves.easeInOut,
            animationDuration:const Duration(milliseconds: 900),
            index: 0,
            height: 70.0,

            items:  [
              SvgPicture.asset('assets/icons/homesv.svg', height: 25, width:25,
                 color: Colors.deepPurpleAccent,),
              const Icon(Icons.add_box_rounded, size: 30, color: Colors.deepPurpleAccent,),

              // Add PNG Image
              /*
              Image.asset("home.png"),
               Icon(Icons.home, size: 30, color: Colors.deepPurpleAccent,),
               Icon(Icons.search),

               const ImageIcon(
                AssetImage('assets/icons/profile.png'),
              ),
              */
            ],
          onTap: _onItemTapped,
          letIndexChange: (index) => true,
       ),

      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     // BottomNavigationBarItem(
      //     //   icon: Icon(Icons.add),
      //     //   label: 'Add',
      //     // ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.amber[800],
      //   onTap: _onItemTapped,
      // ),
    );
  }
}


// Setting Class
class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Center(
          child: Text("Setting Page")),
    );
  }
}
