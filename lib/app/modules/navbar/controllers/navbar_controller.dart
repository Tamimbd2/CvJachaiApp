import 'package:get/get.dart';
import '../../findjob/controllers/findjob_controller.dart';

class NavbarController extends GetxController {
  final currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
    
    // Auto-refresh Find Job page when selected
    if (index == 1) {
      if (Get.isRegistered<FindjobController>()) {
        Get.find<FindjobController>().fetchJobs();
      }
    }
  }
}
