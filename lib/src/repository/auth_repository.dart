import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:notifer/src/exceptions/app_exception.dart';
import 'package:notifer/src/model/dio_client.dart';
import 'package:notifer/src/widgets/dialogs.dart';

class AuthRepository {
  String? _uid; // AuthRepository will not use data model.
  String? _aid;
  String? get uid => _uid;
  String? get aid => _aid;

  set setUid(String str) {
    this._uid = str;
  }

  set setAid(String str) {
    this._aid = str;
  }

  Future<bool> doStart(String deviceId) async {

    final data = await DioClient.doSaveDeviceId(deviceId);
    var result = data['result'];
    if (result == 'Login Successfully') {
      showToastMessage("Login Successfully");
      return true;
    } else if (result == 'Invalid School Infomation') {
      throw const AppException.userNotFound();
    } else if (result == 'Invalid Code Info') {
      throw const AppException.wrongPassword();
    }
    return false;
  }

}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});
