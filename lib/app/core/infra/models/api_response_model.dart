import 'package:pdvexpress/app/core/domain/entities/api_response.dart';

class ApiResponseModel<T> extends ApiResponse {
  @override
  late bool ok;

  @override
  final String message;

  @override
  final T? result;

  ApiResponseModel.ok(this.result, this.message) {
    ok = true;
  }

  ApiResponseModel.error(this.message, {this.result}) {
    ok = false;
  }
}
