import 'package:get/get.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_screen.dart';
import '../modules/sign_in/sign_in_binding.dart';
import '../modules/sign_in/sign_in_screen.dart';
import '../modules/sign_up/sign_up_binding.dart';
import '../modules/sign_up/sign_up_screen.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
        name: AppRoutes.splash,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: AppRoutes.signIn,
        page: () => const SignInScreen(),
        binding: SignInBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRoutes.signUp,
        page: () => const SignUpScreen(),
        binding: SignUpBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: AppRoutes.home,
        page: () => const HomeScreen(),
        binding: HomeBinding(),
        transition: Transition.fadeIn),
  ];
}
