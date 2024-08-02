import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_project/models/user.dart';

import '../providers/user/user_stream_provider.dart';

class AccountContainer extends ConsumerStatefulWidget {
  const AccountContainer({super.key});

  @override
  ConsumerState<AccountContainer> createState() => _AccountContainerState();
}

class _AccountContainerState extends ConsumerState<AccountContainer> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
  }

  String returnDocValue(DocumentSnapshot document, String property) {
    return document[property];
  }

  updatingDocument1(DocumentSnapshot document) {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot freshSnapShot =
          await transaction.get(document.reference);
      transaction.update(
          freshSnapShot.reference, {'firstName': document['firstName'] + '4'});
    });
  }

  updateDocument2(DocumentSnapshot document) {
    document.reference.update({'firstName': 'Joyce'});
  }

  @override
  Widget build(BuildContext context) {
    final myValue = ref.watch(userStreamProvider).value;
    if (myValue != null) {
      users.clear();
      users.addAll(myValue);
    }

    return Container(
      color: Colors.grey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: users.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('FirstName: '),
                        Text('${users[index].firstName}'),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('LastName: '),
                        Text(users[index].lastName),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Date of Birth: '),
                        Text(users[index].dob),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
