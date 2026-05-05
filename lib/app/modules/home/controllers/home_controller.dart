import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final userName = 'User'.obs;
  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  void _loadUserData() {
    final userData = _box.read('user_data');
    if (userData != null) {
      // Adjust based on your API response structure
      userName.value = userData['user']?['full_name'] ?? 
                       userData['user']?['name'] ?? 
                       userData['name'] ?? 
                       'User';
    }
  }

  final count = 0.obs;




  void increment() => count.value++;
}
