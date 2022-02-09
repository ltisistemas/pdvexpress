import 'package:pdvexpress/app/core/domain/entities/api_response.dart';
import 'package:pdvexpress/app/core/domain/entities/cliente.dart';

abstract class ClientesDatasource {
  Future<ApiResponse> store(Cliente cliente);
}
