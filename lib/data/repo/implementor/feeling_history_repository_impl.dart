import 'dart:convert';

import 'package:qube_health_assignment/common/utils.dart';
import 'package:qube_health_assignment/data/model/request/user_feeling_request.dart';
import 'package:qube_health_assignment/data/model/response/user_feeling_response.dart';
import 'package:qube_health_assignment/data/repo/interactor/feeling_history_repository.dart';
import 'package:http/http.dart' as http;

class FeelingHistoryRepositoryImpl implements FeelingHistoryRepository {
  FeelingHistoryRepositoryImpl();

  ///this method will look up for teh user feeling history from the API
  @override
  Future<UserFeelingResponse> getUserFeelingHistory(
      UserFeelingRequest userFeelingRequest) async {
    try {
      final response = await http.post(Uri.parse(url),
          headers: {xApiKey: xApiKeyValue},
          body: jsonEncode(userFeelingRequest));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        final results = UserFeelingResponse.fromJson(data);
        return results;
      } else {
        throw Exception();
      }
    } on Exception {
      rethrow;
    }
  }
}
