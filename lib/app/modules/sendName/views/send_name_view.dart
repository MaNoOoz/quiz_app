import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/modules/Verification/views/verification_view.dart';
import 'package:quiz_app/app/modules/Widgets/Common/SharedWidgets.dart';
import 'package:quiz_app/app/modules/utili/Constants.dart';

import '../../../routes/app_pages.dart';
import '../controllers/send_name_controller.dart';

class SendNameView extends GetView<SendNameController> {
  const SendNameView({Key? key}) : super(key: key);

  static const String routeName = Routes.SEND_NAME;

  @override
  Widget build(BuildContext context) {
    var c = Get.put(SendNameController());

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInDownBig(child: SharedWidgets().buildLogo()),
                  SPACEV10,
                  SPACEV10,
                  SPACEV10,
                  FadeInLeft(
                    child: const Text(
                      'أدخل الأسم',
                      style: mainTitleBlack,
                    ),
                  ),
                  SPACEV10,
                  SPACEV10,
                  SPACEV10,
                  Center(child: _buildNameInput(c)),
                  SPACEV10,
                  _buildRequestBtn(c)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildRequestBtn(SendNameController c) {
  return FadeInDown(
    delay: const Duration(milliseconds: 600),
    child: MaterialButton(
      minWidth: double.infinity,
      onPressed: () async {
        // c.isLoading = false;

        var ok1 = c.formKey.currentState!.validate();
        // var ok2 = c.formKey2.currentState!.validate();
        if (ok1) {
          var res = await c.updateUserName(userName: c.userName);
          if (res != null) {
            await Get.toNamed(VerificationView.routeName, arguments: res);
          }
          showSnackBarRed();
        }
      },
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: c.isLoading
          ? Container(
              width: 20,
              height: 20,
              child: const CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: Colors.black,
                strokeWidth: 2,
              ),
            )
          : const Text(
              "إرسال",
              style: mainStyleLW,
            ),
    ),
  );
}

Widget _buildNameInput(SendNameController c) {
  return GetBuilder<SendNameController>(builder: (logic) {
    return Form(
      key: c.formKey,
      child: FadeInDown(
        delay: const Duration(milliseconds: 600),
        child: TextFormField(
          controller: c.nameController,
          onChanged: (val) {
            c.userName = val;
            Logger().d(c.userName);
          },
          onSaved: (val) {
            c.userName = val!;
            // Logger().d(number);
          },
          validator: (val) {
            return val!.isEmpty ? 'تحقق من الإسم ' : null;
          },
          cursorColor: Colors.black,
          autofocus: false,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0.0),
            labelText: 'الإسم',
            hintText: 'Username',
            labelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
            ),
            prefixIcon: const Icon(
              Icons.manage_accounts_outlined,
              color: Colors.black,
              size: 18,
            ),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            floatingLabelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  });
}
