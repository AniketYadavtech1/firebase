import 'package:get/get.dart';

import '../controller/crud_controller.dart';

class CrudBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CrudController>(() => CrudController());
  }
}
