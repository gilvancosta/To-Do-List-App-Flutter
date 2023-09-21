import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:app_todo_list/src/core/exception/local_storage_exception.dart';

class LocalStorageService {
  
  Future<void> set(String key, String? data) async {
    const storage = FlutterSecureStorage();

    try {
      storage.write(key: key, value: data);
    } catch (error, st) {
      final errorMessage = "Error storing data: $data with key: $key";
      log(errorMessage, error: error, stackTrace: st);
      throw LocalStorageException(message: errorMessage);
    }
  }

  Future<String?> get(String key) async {
    const storage = FlutterSecureStorage();
    try {
      return await storage.read(key: key);
    } catch (error, st) {
      final errorMessage = "Error reading key: $key";
      log(errorMessage, error: error, stackTrace: st);
      throw LocalStorageException(message: errorMessage);
    }
  }

  Future<void> clearStorage() async {
    const storage = FlutterSecureStorage();
    try {
      await storage.deleteAll();
    } catch (error, st) {
      const errorMessage = "Error clearing storage";
      log(errorMessage, error: error, stackTrace: st);
      throw LocalStorageException(message: errorMessage);
    }
  }
}
