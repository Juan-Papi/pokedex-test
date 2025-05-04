import 'package:dio/dio.dart';
import 'package:pokedex/core/constants/app_api_constants.dart';

class ApiClient {
  final Dio dio;

  ApiClient({Dio? dio})
      : dio = dio ??
            Dio(BaseOptions(
              baseUrl: ApiConstants.baseUrl,
              connectTimeout:
                  Duration(milliseconds: ApiConstants.defaultTimeout),
              receiveTimeout:
                  Duration(milliseconds: ApiConstants.defaultTimeout),
            ));

  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      print("📡 GET request to: $endpoint");
      if (queryParams != null) {
        print("📡 Query params: $queryParams");
      }

      final response = await dio.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(validateStatus: (_) => true),
      );

      print("📡 Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        print("❌ Error ${response.statusCode}: ${response.statusMessage}");
        throw Exception(
            'Error en la petición: ${response.statusCode} - ${response.statusMessage}');
      }
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      if (e.response != null) {
        print("❌ Response data: ${e.response?.data}");
        print("❌ Response status: ${e.response?.statusCode}");
      }
      throw Exception('Error de conexión: ${e.message}');
    } catch (e) {
      print("❌ Exception: $e");
      throw Exception('Error inesperado: $e');
    }
  }
}
