part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const home = _Paths.home;
  static const login = _Paths.login;
  static const signup = _Paths.signup;
  static const sendotp = _Paths.sendotp;
  static const verifyotp = _Paths.verifyotp;
  static const resetpassword = _Paths.resetpassword;
  static const findjob = _Paths.findjob;
  static const cvshortlisting = _Paths.cvshortlisting;
  static const personalizatiion = _Paths.personalizatiion;
  static const createjob = _Paths.createjob;
}

abstract class _Paths {
  _Paths._();
  static const home = '/home';
  static const login = '/login';
  static const signup = '/signup';
  static const sendotp = '/sendotp';
  static const verifyotp = '/verifyotp';
  static const resetpassword = '/resetpassword';
  static const findjob = '/findjob';
  static const cvshortlisting = '/cvshortlisting';
  static const personalizatiion = '/personalizatiion';
  static const createjob = '/createjob';
}
