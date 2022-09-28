import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/app/data/models/ScoreModel.dart';

import '../../Widgets/Common/SharedWidgets.dart';
import '../../utili/Constants.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var c = Get.put(ProfileController());
    // Logger().d("buildProfileView : ${c.userScoresList.length}");

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTop(c),
                _buildBody(c),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(ProfileController c) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 24, 24),
      child: Column(
        children: [
          SPACEV10,
          Obx(() {
            return _buildUserInfo(c);
          }),
          SPACEV10,
          SPACEV50,
          SharedWidgets().buildTextLeft("النتائج السابقة", mainStyleTMBL),
          SPACEV10,
          Obx(() {
            // return _buildScores(c);

            return c.userScoresList.isEmpty
                ? Center(
                    child: const Text(
                      "No Games Yet 😫",
                      style: mainStyleTMBU,
                    ),
                  )
                : _buildScores(c);
          })
        ],
      ),
    );
  }

  Widget _buildScores(ProfileController c) {
    var list = Card(
      color: Colors.green.shade50,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        height: 300,
        child: Obx(() {
          var scoreList = ListView.builder(
            itemCount: c.userScoresList.length,
            shrinkWrap: true,
            reverse: true,
            itemBuilder: (BuildContext context, int index) {
              var model = c.userScoresList[index];

              return _buildItem(c.name.value, index, model);
            },
          ).obs;
          return scoreList.value;
        }),
      ),
    ).obs;
    return list.value;
  }

  Widget _buildUserInfo(ProfileController c) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.green.shade50,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: Image.network(
                "https://picsum.photos/150/150",
                height: 90,
                width: 90,
                fit: BoxFit.fill,
              ),
            ),
            Spacer(),
            Container(
              // margin: EdgeInsets.only(left: 16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SharedWidgets()
                      .buildTextLeft("${c.name.value.toUpperCase()}", mainStyleTMBL, align: TextAlign.center),
                  SharedWidgets().buildTextLeft("${c.mobile.value}", mainStyleTMBU, align: TextAlign.center),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(name, int index, ScoreModel model) {
    return FadeOutUp(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: Colors.white54,
            border: Border.all(color: Colors.black.withOpacity(0.13)),
            // gradient: LinearGradient(
            //     begin: Alignment.bottomCenter,
            //     end: Alignment.topRight,
            //     colors: GradientColors.green,
            //     tileMode: TileMode.clamp
            //     // stops: [0.6, 0.7],
            //     ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(8),
                      dense: true,
                      // title: Text(
                      //   "${name}",
                      //   style: mainStyleTMBL,
                      // ),
                      title: Row(
                        children: [
                          Text(
                            "Score : ${model.score}",
                            style: mainStyleLableSmall,
                          ),
                          const Spacer(),
                          Text("Date : ${model.dateOfGame.substring(0, 10)}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTop(ProfileController c) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        SharedWidgets().buildIconWithText(
            icon: const Icon(
              Icons.logout,
              color: Colors.black45,
            ),
            text: "",
            onPressed: () async {
              await c.logOUt();
            }),
      ],
    );
  }
}
