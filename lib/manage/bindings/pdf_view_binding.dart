import 'package:app_book/manage/controllers/pdf_view_controller.dart';
import 'package:get/get.dart';

class PdfViewBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(PdfViewController());
  }
}
