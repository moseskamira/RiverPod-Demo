import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:riverpod_project/models/product_model.dart';
import 'package:riverpod_project/models/user.dart';

import 'apis.dart';

class ApiService {
  String baseUrl = 'https://dummyjson.com/';

  Future<List> fetchProducts() async {
    Response response = await get(Uri.parse('$baseUrl${Apis.products}'));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['products'];
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<ProductModel> getProductDetails(String id) async {
    Response response =
        await get(Uri.parse('$baseUrl${Apis.productDetails}$id'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return ProductModel.fromJson(result);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<User>> returnUsers() async {
    List<User> users = [];
    final fireStore = FirebaseFirestore.instance;
    final userQuerySnapShot = fireStore.collection('users').snapshots();
    userQuerySnapShot.map((snapshot) {
      List<DocumentSnapshot> documentSnapshots = snapshot.docs;
      if (documentSnapshots.isNotEmpty) {
        for (DocumentSnapshot el in documentSnapshots) {
          print('NEWDATAIS: ${el}');
        }
        print('NOTEMPTY');
        final usersList = documentSnapshots
            .map((element) => User.fromJson(element as Map<String, dynamic>))
            .toList();
        users.addAll(usersList);
        print('MYDOCS: ${documentSnapshots}');
      }
    });
    return users;
  }
}
