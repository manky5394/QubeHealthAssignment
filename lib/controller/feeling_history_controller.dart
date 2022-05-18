import 'package:get/get.dart';
import 'package:qube_health_assignment/common/utils.dart';
import 'package:qube_health_assignment/data/model/request/user_feeling_request.dart';
import 'package:qube_health_assignment/data/model/response/user_feeling_response.dart';
import 'package:qube_health_assignment/data/repo/implementor/feeling_history_repository_impl.dart';
import 'package:qube_health_assignment/data/repo/interactor/feeling_history_repository.dart';

class FeelingHistoryController extends GetxController {
  late FeelingHistoryRepository _feelingHistoryRepository;

  FeelingHistoryController() {
    _feelingHistoryRepository = Get.find<FeelingHistoryRepositoryImpl>();
  }

  Rx<UserFeelingResponse> rxUserFeelingResponse = Rx(UserFeelingResponse());

  RxBool isLoading = false.obs;

  Future<void> getUserFeelingsHistoryList(String enteredDate) async {
    showLoading();

    final result = await _feelingHistoryRepository
        .getUserFeelingHistory(createUserFeelingRequest(enteredDate));

    rxUserFeelingResponse.value = result;
    rxUserFeelingResponse.refresh();
    hideLoading();
  }

  UserFeelingRequest createUserFeelingRequest(String enteredDate) {
    return UserFeelingRequest(userId: userId, feelingDate: enteredDate);
  }

  showLoading() {
    isLoading.toggle();
  }

  hideLoading() {
    isLoading.toggle();
  }
}
