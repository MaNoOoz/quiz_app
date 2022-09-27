import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';

import '../../Widgets/Common/SharedWidgets.dart';
import '../../utili/Constants.dart';
import '../controllers/verification_controller.dart';

class VerificationView extends GetView<VerificationController> {
  static const String routeName = '/verification';

  const VerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var c = Get.put(VerificationController());
    // PhoneNumber phoneNumber = Get.arguments[0];
    // LoginResponseModel user = Get.arguments[1];
    // Logger().d("${phoneNumber.phoneNumber}");
    // Logger().d("success ${user.success}");

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SharedWidgets().buildLogo(),
                  SPACEV10,
                  FadeInDown(
                      duration: const Duration(milliseconds: 500),
                      child: const Text(
                        "التحقق",
                        style: mainTitleBlack,
                      )),
                  SPACEV10,
                  // SharedWidgets().buildDesc("Your code was sent to \n ${phoneNumber.phoneNumber}"),
                  SPACEV10,
                  _buildInputCode(c),
                  SPACEV10,
                  _buildFooter(c),

                  Obx(() {
                    return _buildVerifyBtn(c);
                  }),
                  SPACEV10,

                  SPACEV10,

                  // _buildVerifyBtn(c),
                ],
              )),
        ));
  }

  bool mValidator(String input) {
    return input.length < 4 ? true : false;
  }

  Widget _buildVerifyBtn(VerificationController c) {
    var btn = FadeInDown(
      delay: const Duration(milliseconds: 800),
      duration: const Duration(milliseconds: 500),
      child: MaterialButton(
        elevation: 0,
        onPressed: () async {
          mValidator(c.code.value) ? showSnackBarError() : await c.checkToken(c);
        },
        color: Colors.black,
        minWidth: Get.width * 0.8,
        height: 50,
        child: Text(
          "تحقق",
          style: mainStyleLBW,
        ),
      ),
    ).obs;
    return btn.value;
  }

  Widget _buildFooter(VerificationController c) {
    return FadeInDown(
      delay: const Duration(milliseconds: 700),
      duration: const Duration(milliseconds: 500),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "لم يصلك الكود ؟ ",
            style: mainStyleLBB,
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                "إعادة إرسال",
                style: mainStyleLBb,
              ))
        ],
      ),
    );
  }

  Widget _buildInputCode(VerificationController c) {
    return FadeInDown(
      delay: const Duration(milliseconds: 600),
      duration: const Duration(milliseconds: 500),
      child: VerificationCode(
        length: 4,
        autofocus: false,
        textStyle: const TextStyle(fontSize: 20, color: Colors.black),
        underlineColor: Colors.black,
        keyboardType: TextInputType.number,
        underlineUnfocusedColor: Colors.black,
        onCompleted: (value) {
          c.code.value = value;
        },
        onEditing: (value) {},
      ),
    );
  }

  Widget _buildInputTest(VerificationController c) {
    var tf = TextFormField(
      style: mainStyleLBB,
      decoration: InputDecoration(
        label: const Text("إدخل إسمك من فضلك "),
        hintStyle: mainStyleLBB,
        border: OutlineInputBorder(
          borderSide: Divider.createBorderSide(
            Get.context,
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      autofocus: false,
      validator: (value) {
        return value!.isEmpty ? 'تحقق من الإسم ' : null;
      },
      onChanged: (value) {
        // user.name = value;
        // Logger().d("onChanged ${user.name}");
      },
      textAlign: TextAlign.center,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.unspecified,
      keyboardType: TextInputType.number,
    ).obs;

    return FadeInDown(
      delay: const Duration(milliseconds: 600),
      duration: const Duration(milliseconds: 500),
      child: tf.value,
    );
  }
}
