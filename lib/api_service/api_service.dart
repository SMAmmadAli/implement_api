// import 'package:api_practice/dto/home_screen_dto.dart';
// import 'package:dio/dio.dart';

// class ApiService {
//   final Dio _dio = Dio(
//     BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"),
//   );

//   Future<List<HomeScreenModel>> fetchPosts(int start, int limit) async {
//     try {
//       final response = await _dio.get(
//         "/posts",
//         queryParameters: {'_start': start, '_limit': limit},
//       );
//       if (response.statusCode == 200) {
//         final List<dynamic> jsonList = response.data as List<dynamic>;
//         return jsonList.map((json) => HomeScreenModel.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to fetch posts: Status ${response.statusCode}');
//       }
//     } catch (e) {
//       print(e);
//       throw Exception('Failed to fetch posts: $e');
//     }
//   }
// }

import 'package:api_practice/dto/home_screen_dto.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"),
  );

  Future<List<HomeScreenModel>> fetchPosts(
    // int start, int limit
  ) async {
    try {
      final response = await _dio.get(
        "/posts/",
        // queryParameters: {'_start': start, '_limit': limit},
        //       options: Options(
        //   headers: {
        //     "Authorization": "Bearer YOUR_TOKEN_HERE",
        //   },
        // ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data as List<dynamic>;
        return jsonList.map((json) => HomeScreenModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch posts: Status ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
