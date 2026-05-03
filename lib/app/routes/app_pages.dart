import 'package:get/get.dart';

import '../modules/createjob/bindings/createjob_binding.dart';
import '../modules/createjob/views/createjob_view.dart';
import '../modules/cvshortlisting/bindings/cvshortlisting_binding.dart';
import '../modules/cvshortlisting/views/cvshortlisting_view.dart';
import '../modules/findjob/bindings/findjob_binding.dart';
import '../modules/findjob/views/findjob_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/navbar/bindings/navbar_binding.dart';
import '../modules/navbar/views/navbar_view.dart';
import '../modules/personalizatiion/bindings/personalizatiion_binding.dart';
import '../modules/personalizatiion/views/personalizatiion_view.dart';
import '../modules/resetpassword/bindings/resetpassword_binding.dart';
import '../modules/resetpassword/views/resetpassword_view.dart';
import '../modules/sendotp/bindings/sendotp_binding.dart';
import '../modules/sendotp/views/sendotp_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/verifyotp/bindings/verifyotp_binding.dart';
import '../modules/verifyotp/views/verifyotp_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.signup,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.sendotp,
      page: () => const SendotpView(),
      binding: SendotpBinding(),
    ),
    GetPage(
      name: _Paths.verifyotp,
      page: () => const VerifyotpView(),
      binding: VerifyotpBinding(),
    ),
    GetPage(
      name: _Paths.resetpassword,
      page: () => const ResetpasswordView(),
      binding: ResetpasswordBinding(),
    ),
    GetPage(
      name: _Paths.findjob,
      page: () => const FindjobView(),
      binding: FindjobBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.cvshortlisting,
      page: () => const CvshortlistingView(),
      binding: CvshortlistingBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.personalizatiion,
      page: () => const PersonalizatiionView(),
      binding: PersonalizatiionBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.createjob,
      page: () => const CreatejobView(),
      binding: CreatejobBinding(),
    ),
    GetPage(
      name: _Paths.navbar,
      page: () => const NavbarView(),
      binding: NavbarBinding(),
    ),
  ];
}
