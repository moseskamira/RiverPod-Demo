import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_project/providers/user/add_user_provider.dart';

import '../../models/user.dart';

class AddUserSection extends ConsumerStatefulWidget {
  const AddUserSection({super.key});

  @override
  ConsumerState<AddUserSection> createState() => _AddUserSectionState();
}

class _AddUserSectionState extends ConsumerState<AddUserSection> {
  final _formkey = GlobalKey<FormState>();
  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Kindly fill the form below!'),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter First Name',
                labelText: 'First Name*',
              ),
              onChanged: (String value) {
                user.firstName = value.trim();
              },
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return value!.contains('@') ? 'Do not use the @ char.' : null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter Last Name',
                labelText: 'Last Name*',
              ),
              onChanged: (String value) {
                user.lastName = value.trim();
              },
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return value!.contains('@') ? 'Do not use the @ char.' : null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter Gender',
                labelText: 'Gender*',
              ),
              onChanged: (String value) {
                user.gender = value.trim();
              },
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return value!.contains('@') ? 'Do not use the @ char.' : null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter Date of Birth',
                labelText: 'Dob *',
              ),
              onChanged: (String value) {
                user.dob = value.trim();
              },
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return value!.contains('@') ? 'Do not use the @ char.' : null;
              },
            ),
            InkWell(
              onTap: () {
                if (_formkey.currentState!.validate()) {
                  ref.read(newAddUserProvider.notifier).postUser(user);
                  print('USERFNAMEIS: ${user.firstName}');
                  print('FORMVALID');
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Save',
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
