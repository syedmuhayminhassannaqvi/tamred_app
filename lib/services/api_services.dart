import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class APIService {
  final Dio _dio = Dio();
  final baseUrl = "https://morally-smiling-viper.ngrok-free.app/api";

  Future<void> setToken(String token) async {
    final box = await Hive.openBox('auth');
    await box.put('token', token);
  }

  Future<String?> getToken() async {
    final box = await Hive.openBox('auth');
    final token = box.get('token');
    return token;
  }

  Future<void> setPersonID(String id) async {
    final box = await Hive.openBox('auth');
    await box.put('_id', id);
  }

  Future<String?> getPersonID() async {
    final box = await Hive.openBox('auth');
    final id = box.get('_id');
    return id;
  }

  Future<void> deleteID(String id) async {
    final box = await Hive.openBox('auth');
    await box.delete(id);
  }

  Future<List<dynamic>> getList(String route) async {
    try {
      String? accessToken = await getToken();
      final res = await _dio.get(
        "$baseUrl/$route",
        options: Options(
          headers: {
            'Authorization': 'Bearer ${accessToken ?? ''}',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );
      switch (res.statusCode) {
        case 200:
          List<dynamic> data = res.data;
          return data;
        case 401:
          throw Exception('Unauthorized');
        case 404:
          throw Exception('Not found');
        case 500:
          throw Exception('Internal server error');
        default:
          throw Exception(res.data);
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<dynamic> get(String route) async {
    try {
      String? accessToken = await getToken();
      Response res = await _dio.get(
        "$baseUrl/$route",
        options: Options(
          headers: {
            'Authorization': 'Bearer ${accessToken ?? ''}',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      switch (res.statusCode) {
        case 200:
          return res.data;
        case 401:
          throw Exception('Unauthorized');
        case 404:
          throw Exception('Not found');
        case 500:
          throw Exception('Internal server error');
        default:
          throw Exception(res.data);
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<dynamic> post(route, Map<String, dynamic> data) async {
    String? accessToken = await getToken();
    Response res = await _dio.post(
      "$baseUrl/$route",
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer ${accessToken ?? ''}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ),
    );
    switch (res.statusCode) {
      case 200:
        return res.data;
      case 202:
        return res.data;
      case 401:
        throw Exception('Unauthorized');
      case 404:
        throw Exception('Not found');
      case 500:
        throw Exception('Internal server error');
      default:
        throw Exception('An unexpected error occurred');
    }
  }

  Future<void> patch(String route, Map<String, dynamic> data) async {
    try {
      String? accessToken = await getToken();
      Response res = await _dio.patch(
        "$baseUrl/$route",
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${accessToken ?? ''}',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );
      switch (res.statusCode) {
        case 200:
          return res.data;
        case 202:
          return res.data;
        case 401:
          throw Exception('Unauthorized');
        case 404:
          throw Exception('Not found');
        case 500:
          throw Exception('Internal server error');
        default:
          throw Exception(res.data);
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<dynamic> delete(String route) async {
    try {
      String? accessToken = await getToken();
      Response res = await _dio.delete(
        "$baseUrl/$route",
        options: Options(
          headers: {
            'Authorization': 'Bearer ${accessToken ?? ''}',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );
      switch (res.statusCode) {
        case 200:
          return null;
        default:
          throw Exception(res.data);
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
