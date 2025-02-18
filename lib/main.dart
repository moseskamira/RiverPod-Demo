import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:riverpod_project/core/locator/locator.dart';

import 'core/models/local_product_model.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(LocalProductModelAdapter());
  await Hive.openBox<LocalProductModel>('cart_box');
  setUp();
  runApp(
    ProviderScope(
      child: MyApp(
        appTitle: 'RiverPod Demo',
      ),
    ),
  );
}
