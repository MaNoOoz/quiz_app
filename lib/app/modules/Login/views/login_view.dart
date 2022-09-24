import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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
                    style: mainStyleTB,
                  ),
                ),
                SharedWidgets().buildDesc("Enter your phone number to continue, we will send you OTP to verify."),
                SPACEV10,
                SPACEV10,
                SPACEV10,
                _buildPhoneInput(c),
                SPACEV10,
                SPACEV10,
                SPACEV10,
                // _buildNameInput(c),
                SPACEV10,
                SPACEV10,
                _buildRequestBtn(c),
                SPACEV10,
                _buildDontHaveAcount(c)
              ],
            ),
          ),
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

  Widget _buildDontHaveAcount(LoginController c) {
    return FadeInDown(
      delay: const Duration(milliseconds: 800),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            style: TextStyle(color: Colors.grey.shade700),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              Get.toNamed(LoginView.routeName);
            },
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRequestBtn(LoginController c) {
    return FadeInDown(
      delay: const Duration(milliseconds: 600),
      child: MaterialButton(
        minWidth: double.infinity,
        onPressed: () async {
          c.isLoading = false;

          var ok1 = c.formKey.currentState!.validate();
          // var ok2 = c.formKey2.currentState!.validate();
          if (ok1) {
            c.loginUser(mobileNumber: c.number);
            // Get.toNamed(VerificationView.routeName, arguments: c.number);
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
                "Request OTP",
                style: TextStyle(color: Colors.white),
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
                initialValue: c.number,
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

                inputDecoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 15, left: 0),
                  border: InputBorder.none,
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                ),
                onInputChanged: (PhoneNumber number) {
                  c.number = number;
                  // Logger().d(c.number);
                },
                onInputValidated: (bool value) {
                  // Logger().d("$value");
                },
                onSaved: (PhoneNumber number) {
                  c.number = number;
                  // Logger().d(number);
                },
              ),
            ),

            // Positioned(
            //   left: 10,
            //   top: 8,
            //   bottom: 8,
            //   child: Container(
            //     height: 40,
            //     width: 1,
            //     color: Colors.black.withOpacity(0.13),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
