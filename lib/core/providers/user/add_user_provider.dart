import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../ui/utils/reusable_functions.dart';
import '../../models/user.dart';

enum AddUserState { idle, loading, success, error }

class AddUserNotifier extends StateNotifier<AddUserState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AddUserNotifier() : super(AddUserState.idle);

  Future<void> postUser(
    User user,
    BuildContext context,
    AppLocalizations appLocal,
  ) async {
    state = AddUserState.loading;
    final docRef = _firestore.collection('users').doc();
    await _firestore.runTransaction((transaction) async {
      transaction.set(docRef, {
        'firstName': user.firstName,
        'lastName': user.lastName,
        'gender': user.gender,
        'dob': user.dob,
      });
    }).whenComplete(() {
      state = AddUserState.success;
      if (context.mounted) {
        _showSnackBar(
          appLocal.userAddedSuccessfully,
          'User has been successfully created',
          ContentType.success,
          context,
        );
      }
    }).onError((error, _) {
      state = AddUserState.error;
      if (context.mounted) {
        _showSnackBar(
          'Error',
          'Unable to create new user',
          ContentType.failure,
          context,
        );
      }
    });
  }

  void _showSnackBar(String title, String message, ContentType contentType,
      BuildContext context) {
    final snackBar = ReUsableFunctions.awesomeSnackBar(
      title: title,
      message: message,
      type: contentType,
      context: context,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

final addUserProvider = StateNotifierProvider<AddUserNotifier, AddUserState>(
  (ref) => AddUserNotifier(),
);
