import 'package:get/get.dart';

import '../controllers/personalizatiion_controller.dart';

class PersonalizatiionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalizatiionController>(() => PersonalizatiionController());
  }
}
