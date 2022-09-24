import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../Widgets/Common/SharedWidgets.dart';
import '../../utili/Constants.dart';
import '../controllers/leaderboard_controller.dart';

class LeaderboardView extends GetView<LeaderboardController> {
  const LeaderboardView({Key? key}) : super(key: key);
  static const String routeName = Routes.LEADERBOARD;

  @override
  Widget build(BuildContext context) {
    var c = Get.put(LeaderboardController());

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              children: [
                SharedWidgets().buildTextLeft("المتصدرين", mainStyleTB),
                SPACEV10,
                SPACEV10,
                SPACEV10,
                Obx(() {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: c.listOfUsers.length,
                      itemBuilder: (BuildContext context, int index) {
                        var name = c.listOfUsers[index]['name'];
                        var score = c.listOfUsers[index]['score'];
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            onTap: () async {
                              // if (GamesName.isNotEmpty) {
                              //   await Get.to(() => const NewGameView(), arguments: [GamesPath, GamesName]);
                              //
                              //   // Navigator.pushNamed(context, GamesPath);
                              // } else {
                              //   // log("Cart items : ${cartitems.length}");
                              // }
                            },
                            trailing: CircleAvatar(child: Container(child: Text(index.toString()))),
                            title: Center(
                              child: Text(name, style: mainStyleLB),
                            ),
                            subtitle: Center(
                              child: Text(score.toString(), style: mainStyleLB),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
