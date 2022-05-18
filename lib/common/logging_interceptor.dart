// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
//
// class LoggingInterceptors extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     if (kDebugMode) {
//       print(
//           "--> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"${options.baseUrl ?? ""}${options.path ?? ""}"}");
//       print("Headers:");
//       options.headers.forEach((k, v) => print('$k: $v'));
//       print("queryParameters:");
//       options.queryParameters.forEach((k, v) => print('$k: $v'));
//       if (options.data != null) {
//         print("Body: ${options.data}");
//       }
//       print(
//           "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");
//     }
//     super.onRequest(options, handler);
//   }
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     if (kDebugMode) {
//       print(
//           "<-- ${response.statusCode} ${(response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL')}");
//       print("Headers:");
//       response.headers.forEach((k, v) => print('$k: $v'));
//       print("Response: ${response.data}");
//       print("<-- END HTTP");
//     }
//     super.onResponse(response, handler);
//   }
//
//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) {
//     if(kDebugMode){
//       print(
//           "<-- ${err.message} ${(err.response?.requestOptions != null ? (err.response?.requestOptions.baseUrl + err.response.requestOptions.path) : 'URL')}");
//       print(
//           "${err.response != null ? err.response?.data : 'Unknown Error'}");
//       print("<-- End error");
//     }
//     super.onError(err, handler);
//   }
// }
