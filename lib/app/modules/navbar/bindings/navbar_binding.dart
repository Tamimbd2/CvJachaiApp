import 'package:get/get.dart';
import '../controllers/navbar_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../findjob/controllers/findjob_controller.dart';
import '../../cvshortlisting/controllers/cvshortlisting_controller.dart';
import '../../personalizatiion/controllers/personalizatiion_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarController>(() => NavbarController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<FindjobController>(() => FindjobController());
    Get.lazyPut<CvshortlistingController>(() => CvshortlistingController());
    Get.lazyPut<PersonalizatiionController>(() => PersonalizatiionController());
  }
}
