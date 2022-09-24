import 'package:get/get.dart';

import '../modules/Control/bindings/control_binding.dart';
import '../modules/Control/views/control_view.dart';
import '../modules/IntroScreen/bindings/intro_screen_binding.dart';
import '../modules/IntroScreen/views/intro_screen_view.dart';
import '../modules/Leaderboard/bindings/leaderboard_binding.dart';
import '../modules/Leaderboard/views/leaderboard_view.dart';
import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/Profile/bindings/profile_binding.dart';
import '../modules/Profile/views/profile_view.dart';
import '../modules/Quiz/bindings/quiz_binding.dart';
import '../modules/Quiz/views/quiz_view.dart';
import '../modules/Result/bindings/result_binding.dart';
import '../modules/Result/views/result_view.dart';
import '../modules/Verification/bindings/verification_binding.dart';
import '../modules/Verification/views/verification_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/onBorading/bindings/on_borading_binding.dart';
import '../modules/onBorading/views/on_borading_view.dart';
import '../modules/sendName/bindings/send_name_binding.dart';
import '../modules/sendName/views/send_name_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CONTROLL;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRO_SCREEN,
      page: () => const IntroScreenView(),
      binding: IntroScreenBinding(),
    ),
    GetPage(
      name: _Paths.CONTROL,
      page: () => const ControlView(),
      binding: ControlBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LEADERBOARD,
      page: () => const LeaderboardView(),
      binding: LeaderboardBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ON_BORADING,
      page: () => const OnBoradingView(),
      binding: OnBoradingBinding(),
    ),
    GetPage(
      name: _Paths.VERIFICATION,
      page: () => const VerificationView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: _Paths.SEND_NAME,
      page: () => SendNameView(),
      binding: SendNameBinding(),
    ),
    GetPage(
      name: _Paths.QUIZ,
      page: () => const QuizView(),
      binding: QuizBinding(),
    ),
    GetPage(
      name: _Paths.RESULT,
      page: () => const ResultView(),
      binding: ResultBinding(),
    ),
  ];
}
