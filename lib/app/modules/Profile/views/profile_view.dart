import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/Common/SharedWidgets.dart';
import '../../utili/Constants.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var c = Get.put(ProfileController());

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await c.getUsersScores();
          },
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                SharedWidgets().buildTextLeft("Profile", mainStyleTB),
                SPACEV10,
                SPACEV10,
                SPACEV10,
                Obx(() {
                  return Column(
                    children: [
                      SharedWidgets().buildTextLeft("${c.name.value}", mainStyleLB),
                      SharedWidgets().buildTextLeft("${c.mobile.value}", mainStyleLB),
                    ],
                  );
                }),
                SharedWidgets().buildTextLeft("النتائج السابقة", mainStyleTB),
                Obx(() {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: c.listOfScores.length,
                      itemBuilder: (BuildContext context, int index) {
                        // var score = c.listOfScores[index]['score'];
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            onTap: () async {},
                            trailing: CircleAvatar(child: Container(child: Text(index.toString()))),
                            title: Center(
                              child: Text("score!", style: mainStyleLB),
                            ),
                            subtitle: Center(
                              child: Text("score".toString(), style: mainStyleLB),
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
