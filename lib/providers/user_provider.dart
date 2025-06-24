import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/services/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userListProvider = StateNotifierProvider<UserListNotifier, List<User>>((ref) {
  return UserListNotifier();
});

class UserListNotifier extends StateNotifier<List<User>> {
  UserListNotifier() : super([]) {
    fetch();
  }

  Future<void> fetch() async {
    try {
      final users = await ApiService.fetchUsers();
      state = users;
    } catch (_) {
      state = [];
    }
  }

  void addUser(User user) {
    state = [...state, user];
  }

  void search(String query) {
    fetch().then((_) {
      state = state
          .where((u) => u.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
