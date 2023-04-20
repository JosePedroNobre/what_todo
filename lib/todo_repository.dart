import 'package:dio/dio.dart';
import 'package:what_todo/network/api_error.dart';
import 'package:what_todo/network/api_service.dart';
import 'package:what_todo/network/models/todo.dart';

class TodoRepository {
  final ApiService apiService;

  const TodoRepository(this.apiService);

  Future<List<Todo>> getTodoList() async {
    try {
      Response response = await apiService.get('todos');

      var result = List<Todo>.from(response.data.map((i) => Todo.fromJson(i)));
      return result;
    } on DioError catch (e) {
      if (e.response != null) {
        throw ApiError.fromJson(e.response!.data['error']);
      } else {
        rethrow;
      }
    }
  }
}
