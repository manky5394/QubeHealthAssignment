import 'package:qube_health_assignment/data/model/request/user_feeling_request.dart';
import 'package:qube_health_assignment/data/model/response/user_feeling_response.dart';

abstract class FeelingHistoryRepository {
  Future<UserFeelingResponse> getUserFeelingHistory(
      UserFeelingRequest userFeelingRequest);
}
