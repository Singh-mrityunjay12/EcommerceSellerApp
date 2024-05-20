import 'package:get_storage/get_storage.dart';

class MLocalStorage {
  // static final MLocalStorage _instance = MLocalStorage._internal();

  late final GetStorage _storage;

  //Singleton instance
  static MLocalStorage? _instance;

  MLocalStorage._internal();

  factory MLocalStorage.instance() {
    _instance ??= MLocalStorage._internal();
    return _instance!;
  }

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = MLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  //Generic method to save data or write data

  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  //Generic method to read data

  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  //Generic method to remove data
  Future<void> removeData(String key) {
    return _storage.remove(key);
  }

  //Clear all data in storage
  Future<void> clearData() async {
    await _storage.erase();
  }
}
