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
  final _formKey = GlobalKey<FormState>();
  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                return value == null || value.isEmpty
                    ? 'Provide missing field'
                    : null;
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
                return value == null || value.isEmpty
                    ? 'Provide missing field'
                    : null;
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
                return value == null || value.isEmpty
                    ? 'Provide missing field'
                    : null;
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
                return value == null || value.isEmpty
                    ? 'Provide missing field'
                    : null;
              },
            ),
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  ref.read(addUserProvider.notifier).postUser(user);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Save User',
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
