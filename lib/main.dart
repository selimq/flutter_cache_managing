import 'package:flutter/material.dart';
import 'package:flutter_app/cacheManager.dart';
import 'package:flutter_app/models/user/user.dart';

Future<void> main() async {
  await CacheManager.instance.initStorage();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User user = User(
      dateOfBirth: DateTime.now(),
      email: 'test',
      firstName: 'jl',
      lastName: 'test',
      id: 0);
  User user2 = User(
      dateOfBirth: DateTime.now(),
      email: 'test',
      firstName: 'sd',
      lastName: 'test',
      id: 2);

  User? user1;
  List<User>? list;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Column(
              children: [
                Text('Hello World'),
                TextButton(
                  onPressed: () {
                    CacheManager.instance
                        .addCacheItem<User>('${user.id}', user);
                  },
                  child: Text('test'),
                ),
                TextButton(
                  onPressed: () {
                    CacheManager.instance
                        .addCacheItem<User>('${user2.id}', user2);
                  },
                  child: Text('test'),
                ),
                TextButton(
                    onPressed: () async {
                      user1 = CacheManager.instance
                          .getCacheItem<User>('${user.id}', User());
                      setState(() {});
                    },
                    child: Text('get')),
                TextButton(
                    onPressed: () async {
                      print(list?.first.firstName);

                      list = CacheManager.instance.getCacheList<User>(User());
                      setState(() {});
                    },
                    child: Text('ghj')),
                Text(user1 != null ? user1!.firstName! : 'null')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
