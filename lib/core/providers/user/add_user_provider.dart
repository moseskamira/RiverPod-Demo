import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../ui/utils/reusable_functions.dart';
import '../../models/user.dart';

class _AddUserNotifier extends StateNotifier<bool> {
  _AddUserNotifier() : super(false);

  postUser(User user, BuildContext context, AppLocalizations appLocal,
      GlobalKey<FormState> formKey) {
    state = true;
    final fireStore = FirebaseFirestore.instance;
    final docRef = fireStore.collection('users').doc();
    fireStore.runTransaction((transaction) async {
      transaction.set(docRef, {
        'firstName': user.firstName,
        'lastName': user.lastName,
        'gender': user.gender,
        'dob': user.dob,
      });
    }).whenComplete(() {
      state = false;
      formKey.currentState!.reset();
    }).onError((error, st) {
      state = false;
    }).then((_) {
      if (context.mounted) {
        final snackBar = ReUsableFunctions.awesomeSnackBar(
            appLocal.userAddedSuccessfully,
            appLocal.userHasBeenSubmittedSuccessfully,
            ContentType.success,
            context);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    });
  }
}

final addUserProvider = StateNotifierProvider<_AddUserNotifier, bool>((ref) {
  return _AddUserNotifier();
});
