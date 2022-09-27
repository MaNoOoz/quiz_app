import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/modules/Widgets/Common/SharedWidgets.dart';

import '../../utili/Constants.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    var c = Get.put(LoginController());

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                SharedWidgets().buildLogo(),
                SPACEV10,
                FadeInDown(
                  child: const Text(
                    'مستخدم جديد',
                    style: mainTitleBlack,
                  ),
                ),
                SharedWidgets().buildTextDown(
                    // "Enter your phone number to continue, we will send you OTP to verify.", mainStyleLBB),
                    "من فضلك أدخل رقم الجوال سنرسل لك كود التحقق.",
                    mainStyleLBB),
                SPACEV10,
                SPACEV10,
                SPACEV10,
                Obx(() {
                  return _buildPhoneInput(c);
                }),
                SPACEV10,
                SPACEV10,
                SPACEV10,
                // _buildNameInput(c),
                SPACEV10,
                SPACEV10,
                Obx(() {
                  return _buildRequestBtn();
                }),
                SPACEV10,
                _buildDontHaveAcount(c)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDontHaveAcount(LoginController c) {
    return FadeInDown(
      delay: const Duration(milliseconds: 800),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'لديك حساب بالفعل',
            style: mainStyleLBB,
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              Get.toNamed(LoginView.routeName);
            },
            child: const Text(
              textDirection: TextDirection.rtl,
              'دخول',
              style: mainStyleTMBU,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRequestBtn() {
    var c = Get.put(LoginController());

    return FadeInDown(
      delay: const Duration(milliseconds: 600),
      child: MaterialButton(
        minWidth: double.infinity,
        onPressed: () async {
          var ok1 = c.formKey.currentState!.validate();
          // var ok2 = c.formKey2.currentState!.validate();
          if (ok1) {
            var isSent = await c.loginUser(mobileNumber: c.number.value);
            Logger().d("isSent --- ${isSent}");

            if (isSent) {
              // Get.toNamed(VerificationView.routeName);
            } else {
              showSnackBarRed();
            }
          }
        },
        color: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: c.loadingStatus.value == LoadingStatus.loading
            ? Container(
                width: 20,
                height: 20,
                child: const CircularProgressIndicator(
                  backgroundColor: Colors.green,
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                "طلب رمز OTP",
                textDirection: TextDirection.rtl,
                style: mainStyleLBW,
              ),
      ),
    );
  }

  Widget _buildPhoneInput(LoginController c) {
    return FadeInDown(
      delay: const Duration(milliseconds: 400),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black.withOpacity(0.13)),
          boxShadow: const [
            BoxShadow(
              color: Color(0xffeeeeee),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            const SizedBox(
              height: 10,
            ),
            Form(
              key: c.formKey,
              child: InternationalPhoneNumberInput(
                errorMessage: "تأكد من الرقم/ الدولة",

                textStyle: TextStyle(color: Colors.blue),
                initialValue: c.number.value,
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.DIALOG,
                  // useEmoji: true,
                ),
                countrySelectorScrollControlled: true,
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                selectorTextStyle: const TextStyle(color: Colors.black),
                textFieldController: c.mobileController,
                formatInput: true,
                // maxLength: 9,
                keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                cursorColor: Colors.black,

                inputDecoration: const InputDecoration(
                  // contentPadding: const EdgeInsets.only(bottom: 15, left: 0),
                  border: InputBorder.none,
                  hintText: 'رقم الجوال',
                  hintStyle: mainStyleLableSmall,
                ),
                onInputChanged: (PhoneNumber number) {
                  c.number.value = number;
                  // Logger().d(c.number.value);
                },
                onInputValidated: (bool value) {
                  // Logger().d("$value");
                },
                onSaved: (PhoneNumber number) {
                  c.number.value = number;
                  // Logger().d(number);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

// Widget _buildNameInput(LoginController c) {
//   return Form(
//     key: c.formKey2,
//     child: TextFormField(
//       controller: c.nameController,
//       onChanged: (val) {
//         c.userName = val;
//       },
//       onSaved: (val) {
//         c.userName = val!;
//         // Logger().d(number);
//       },
//       validator: (val) {
//         return val!.isEmpty ? 'تحقق من الإسم ' : null;
//       },
//       cursorColor: Colors.black,
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.all(0.0),
//         labelText: 'الإسم',
//         hintText: 'Username',
//         labelStyle: TextStyle(
//           color: Colors.black,
//           fontSize: 14.0,
//           fontWeight: FontWeight.w400,
//         ),
//         hintStyle: TextStyle(
//           color: Colors.grey,
//           fontSize: 14.0,
//         ),
//         prefixIcon: Icon(
//           Icons.manage_accounts_outlined,
//           color: Colors.black,
//           size: 18,
//         ),
//         fillColor: Colors.white,
//         filled: true,
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         floatingLabelStyle: TextStyle(
//           color: Colors.black,
//           fontSize: 18.0,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.black, width: 1.5),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//       ),
//     ),
//   );
// }

}
