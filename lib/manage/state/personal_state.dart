import 'package:app_book/models/user_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class PersonalState {
  Rx<UserModel> userInfo = UserModel().obs;
}
