import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notifer/src/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class LoginController extends StateNotifier<AsyncValue<bool>> {
  LoginController({required this.authRepo}) : super(const AsyncData(false));

  final AuthRepository authRepo;
  late BuildContext context;

  //bool isAuthenticated() => authRepo.uid

  Future<bool> doStart(String deviceId) async {
    state = const AsyncValue.loading();

    final newState =
        await AsyncValue.guard(() => authRepo.doStart(deviceId));

    if (mounted) {
      state = newState;
    }
    return newState.hasValue;
  }

}

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, AsyncValue<bool>>((ref) {
  return LoginController(authRepo: ref.watch(authRepositoryProvider));
});
