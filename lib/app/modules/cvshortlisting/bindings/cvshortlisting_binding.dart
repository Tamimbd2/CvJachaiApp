import 'package:get/get.dart';

import '../controllers/cvshortlisting_controller.dart';

class CvshortlistingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CvshortlistingController>(() => CvshortlistingController());
  }
}
