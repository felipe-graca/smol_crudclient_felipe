import 'package:dio/dio.dart';
import 'package:smol_crudclient_felipe/core/services/http/http_service_interface.dart';

class HttpService implements IHttpService {
  late final Dio _dio = Dio();

  @override
  Future get(String? url, {Options? options}) async {
    final response = await _dio.get(url!, options: options);

    return response;
  }

  @override
  Future post(String path, {dynamic data, Options? options}) async {
    final response = await _dio.post(path, data: data, options: options);
    return response;
  }

  @override
  Future put(String path, {dynamic data, Options? options}) async {
    final response = await _dio.put(path, data: data, options: options);
    return response;
  }

  @override
  Future delete(String path, {dynamic data, Options? options}) async {
    final response = await _dio.delete(path, data: data, options: options);
    return response;
  }
}
