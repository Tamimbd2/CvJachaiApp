import 'package:get/get.dart';

import '../controllers/findjob_controller.dart';

class FindjobBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindjobController>(() => FindjobController());
  }
}
