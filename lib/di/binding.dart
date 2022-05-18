import 'package:get/get.dart';
import 'package:qube_health_assignment/controller/feeling_history_controller.dart';
import 'package:qube_health_assignment/data/repo/implementor/feeling_history_repository_impl.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put(FeelingHistoryRepositoryImpl())
      ..put(FeelingHistoryController());
  }
}
