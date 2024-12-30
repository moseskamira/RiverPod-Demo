import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_project/screens/re_usable_widgets/add_user_section.dart';
import 'package:riverpod_project/screens/re_usable_widgets/users_section.dart';

class UserContainer extends ConsumerStatefulWidget {
  const UserContainer({super.key});

  @override
  ConsumerState<UserContainer> createState() => _UserContainerState();
}

class _UserContainerState extends ConsumerState<UserContainer> {
  bool showAddUserWidget = true;

  @override
  void initState() {
    super.initState();
  }

  updatingDocument(DocumentSnapshot document) {
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      showAddUserWidget = true;
                      setState(() {});
                    },
                    child: Text(
                      'Add User',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showAddUserWidget = false;
                      setState(() {});
                    },
                    child: Text(
                      'View Users',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: showAddUserWidget
                    ? const AddUserSection()
                    : const UsersSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
