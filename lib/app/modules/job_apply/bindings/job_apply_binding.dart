import 'package:get/get.dart';
import '../controllers/job_apply_controller.dart';

class JobApplyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobApplyController>(
      () => JobApplyController(),
    );
  }
}
