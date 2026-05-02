part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const SIGNUP = _Paths.SIGNUP;
  static const SENDOTP = _Paths.SENDOTP;
  static const VERIFYOTP = _Paths.VERIFYOTP;
  static const RESETPASSWORD = _Paths.RESETPASSWORD;
  static const FINDJOB = _Paths.FINDJOB;
  static const CVSHORTLISTING = _Paths.CVSHORTLISTING;
  static const PERSONALIZATIION = _Paths.PERSONALIZATIION;
  static const CREATEJOB = _Paths.CREATEJOB;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const SENDOTP = '/sendotp';
  static const VERIFYOTP = '/verifyotp';
  static const RESETPASSWORD = '/resetpassword';
  static const FINDJOB = '/findjob';
  static const CVSHORTLISTING = '/cvshortlisting';
  static const PERSONALIZATIION = '/personalizatiion';
  static const CREATEJOB = '/createjob';
}
