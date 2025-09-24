// lib/data/services/api_service.dart
import 'package:dio/dio.dart';
import '../../core/constants/app_config.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.apiBaseUrl));

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? query}) async {
    // TODO: снять условие, когда будет бекенд
    if (AppConfig.useMock) {
      throw UnimplementedError('Mock для GET $path не реализован'); // мок обработается в конкретных сервисах
    }
    return _dio.get<T>(path, queryParameters: query);
  }

  Future<Response<T>> post<T>(String path, {dynamic data}) async {
    if (AppConfig.useMock) {
      throw UnimplementedError('Mock для POST $path не реализован');
    }
    return _dio.post<T>(path, data: data);
  }
}
