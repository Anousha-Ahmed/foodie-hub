import 'package:get/get.dart';

import '../modules/add_card/add_card_screen.dart';
import '../modules/cart/cart_screen.dart';
import '../modules/categories/categories_binding.dart';
import '../modules/categories/categories_screen.dart';
import '../modules/category_items/category_items_binding.dart';
import '../modules/category_items/category_items_screen.dart';
import '../modules/checkout/checkout_binding.dart';
import '../modules/delivery_address/delivery_address_screen.dart';
import '../modules/edit_profile/edit_profile_binding.dart';
import '../modules/edit_profile/edit_profile_screen.dart';
import '../modules/profile/profile_binding.dart';
import '../modules/profile/profile_screen.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_screen.dart';
import '../modules/order_summary/order_summary_screen.dart';
import '../modules/payment_methods/payment_methods_screen.dart';
import '../modules/payment_success/payment_success_screen.dart';
import '../modules/sign_in/sign_in_binding.dart';
import '../modules/sign_in/sign_in_screen.dart';
import '../modules/sign_up/sign_up_binding.dart';
import '../modules/sign_up/sign_up_screen.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_screen.dart';
import '../modules/change_password/change_password_binding.dart';
import '../modules/change_password/change_password_screen.dart';
import '../modules/settings/settings_binding.dart';
import '../modules/settings/settings_screen.dart';
import '../modules/add_address/add_address_binding.dart';
import '../modules/add_address/add_address_screen.dart';
import '../modules/address/address_binding.dart';
import '../modules/address/address_screen.dart';
import '../modules/track_order/track_order_binding.dart';
import '../modules/track_order/track_order_screen.dart';
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
    GetPage(
        name: AppRoutes.categories,
        page: () => const CategoriesScreen(),
        binding: CategoriesBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: AppRoutes.categoryItems,
        page: () => const CategoryItemsScreen(),
        binding: CategoryItemsBinding(),
        transition: Transition.rightToLeft),
    // CartController main.dart me permanent register hai, is liye binding nahi chahiye
    GetPage(
        name: AppRoutes.cart,
        page: () => const CartScreen(),
        transition: Transition.rightToLeft),
    // CheckoutController yahan se bana, aage ki teeno screens isi ko use karti hain
    GetPage(
        name: AppRoutes.orderSummary,
        page: () => const OrderSummaryScreen(),
        binding: CheckoutBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: AppRoutes.deliveryAddress,
        page: () => const DeliveryAddressScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: AppRoutes.paymentMethods,
        page: () => const PaymentMethodsScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: AppRoutes.addCard,
        page: () => const AddCardScreen(),
        transition: Transition.downToUp),
    GetPage(
        name: AppRoutes.paymentSuccess,
        page: () => const PaymentSuccessScreen(),
        transition: Transition.fadeIn),
    GetPage(
    name: AppRoutes.profile,
    page: () => const ProfileScreen(),
    binding: ProfileBinding(),
    transition: Transition.fadeIn),
    GetPage(
        name: AppRoutes.editProfile,
        page: () => const EditProfileScreen(),
        binding: EditProfileBinding(),
        transition: Transition.rightToLeft),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsScreen(),
      binding: SettingsBinding(),
      transition: Transition.rightToLeft),
    GetPage(
        name: AppRoutes.settingsPayment,
        page: () => const PaymentMethodsScreen(settingsMode: true),
        binding: CheckoutBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: AppRoutes.changePassword,
        page: () => const ChangePasswordScreen(),
        binding: ChangePasswordBinding(),
        transition: Transition.rightToLeft),
    GetPage(
      name: AppRoutes.addresses,
      page: () => const AddressScreen(),
      binding: AddressBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: AppRoutes.addAddress,
      page: () => const AddAddressScreen(),
      binding: AddAddressBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: AppRoutes.trackOrder,
      page: () => const TrackOrderScreen(),
      binding: TrackOrderBinding(),
      transition: Transition.rightToLeft),
    ];
}