import 'package:dio/dio.dart';
import 'package:user_hub_app/model/post_model.dart';
import 'package:user_hub_app/model/to_do_model.dart';
import 'package:user_hub_app/model/user_model.dart';
import 'package:user_hub_app/server/network/network_consent.dart';

class NetworkMethod {
  final _dio = Dio(
    BaseOptions(
      baseUrl: NetworkConsent.baseURL,
      headers: {"Accept": "application/json"},
    ),
  );

  Future<List<UserModel>> getAllUser() async {
    final response = await _dio.get(NetworkConsent.endpointGetAllUser);
    List<UserModel> user = [];

    ((response.data ?? []) as List)
        .map((element) => user.add(UserModel.fromMap(element)))
        .toList();

    return user;
  }

  Future<UserModel> getUserById(int userId) async {
    final response = await _dio.get(
      '${NetworkConsent.endpointGetAllUser}/$userId',
    );
    return UserModel.fromMap(response.data);
  }

  Future<List<PostModel>> getPostsByUserId(int userId) async {
    final response = await _dio.get(
      NetworkConsent.endpointGetAllPosts,
      queryParameters: {'userId': userId},
    );
    List<PostModel> post = [];

    ((response.data ?? []) as List)
        .map((element) => post.add(PostModel.fromMap(element)))
        .toList();

    return post;
  }

  Future<List<ToDoModel>> getTodosByUserId(int userId) async {
    final response = await _dio.get(
      NetworkConsent.endpointGetAllToDo,
      queryParameters: {'userId': userId},
    );
    List<ToDoModel> todo = [];

    ((response.data ?? []) as List)
        .map((element) => todo.add(ToDoModel.fromMap(element)))
        .toList();

    return todo;
  }
}
