import 'dart:convert';

import 'package:flutter_app/models/baseModel.dart';
import 'package:get_storage/get_storage.dart';

abstract class ICacheManager {
  late GetStorage storage;
  Future<void> addCacheItem<T>(String id, T model);
  Future<void> removeCacheItem<T>(String id);
  T getCacheItem<T extends IBaseModel>(String id, IBaseModel model);
  List<T> getCacheList<T extends IBaseModel>(IBaseModel model);
}

class CacheManager implements ICacheManager {
  static CacheManager? _instance;
  static CacheManager get instance {
    if (_instance != null) return _instance!;
    _instance = CacheManager._init();
    return _instance!;
  }

  late GetStorage storage;

  CacheManager._init() {
    initStorage();
  }
  Future<void> initStorage() async {
    await GetStorage.init();
    storage = GetStorage();
  }

  String _key<T>(String id) {
    return '${T.toString()}-$id';
  }

  @override
  Future<void> addCacheItem<T>(String id, T model) async {
    final _stringModel = jsonEncode(model);
    await storage.write(_key<T>(id), _stringModel);
  }

  @override
  T getCacheItem<T extends IBaseModel>(String id, IBaseModel model) {
    final cachedData = storage.read(_key<T>(id));
    final normalModelJson = jsonDecode(cachedData);
    return model.fromJson(normalModelJson);
  }

  @override
  Future<bool> removeCacheItem<T>(String id) {
    // TODO: implement removeCacheItem
    throw UnimplementedError();
  }

  @override
  List<T> getCacheList<T extends IBaseModel>(IBaseModel model) {
    Iterable<String> cachedDataList = storage.getKeys();
    cachedDataList =
        cachedDataList.where((element) => element.contains('User-'));
    //.where((element) => element.contains('$T-')).toList();
    print(cachedDataList.runtimeType);

    if (cachedDataList.isNotEmpty) {
      return cachedDataList
          .map((e) => model.fromJson(jsonDecode(storage.read(e) ?? '')) as T)
          .toList();
    }
    return [];
  }
}
