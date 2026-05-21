import 'package:get/get.dart';
import '../controllers/my_jobs_controller.dart';

class MyJobsBinding extends Bindings {
  @override
  void dependencies() {
    // fenix: true ensures the controller is re-created if it was disposed,
    // preventing "controller not found" errors on repeated navigation.
    Get.lazyPut<MyJobsController>(
      () => MyJobsController(),
      fenix: true,
    );
  }
}
