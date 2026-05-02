import 'package:get/get.dart';

import '../controllers/createjob_controller.dart';

class CreatejobBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatejobController>(
      () => CreatejobController(),
    );
  }
}
