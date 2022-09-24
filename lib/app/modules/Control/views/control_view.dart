import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/app/modules/Leaderboard/views/leaderboard_view.dart';
import 'package:quiz_app/app/modules/Profile/views/profile_view.dart';

import '../../Widgets/Common/custom_bottom_nav.dart';
import '../../home/views/home_view.dart';
import '../controllers/control_controller.dart';

class ControlView extends GetView<ControlController> {
  const ControlView({Key? key}) : super(key: key);
  static const String routeName = '/control';

  Widget _buildBottomBar(ControlController c) {
    return Obx(() {
      return CustomAnimatedBottomBar(
        containerHeight: 70,
        backgroundColor: Colors.white,
        selectedIndex: c.currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: c.changePage,
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.deepOrangeAccent,
            inactiveColor: c.inactiveColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Leaderboard'),
            activeColor: Colors.blue,
            inactiveColor: c.inactiveColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person_pin_rounded),
            title: Text('Profile'),
            activeColor: Colors.green,
            inactiveColor: c.inactiveColor,
            textAlign: TextAlign.center,
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.put(ControlController());

    return Scaffold(
      bottomNavigationBar: _buildBottomBar(c),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text("إضغط مرة ثانية للخروج"),
        ),
        child: getBody(c),
      ),
    );
  }

  getBody(ControlController c) {
    List<Widget> pages = [
      const HomeView(),
      const LeaderboardView(),
      const ProfileView(),
    ];
    return Obx(() {
      return IndexedStack(
        index: c.currentIndex,
        children: pages,
      );
    });
  }
}
