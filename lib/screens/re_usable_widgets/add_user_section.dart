import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_project/providers/user/add_user_provider.dart';
import 'package:riverpod_project/utils/reusable_functions.dart';

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
            ref.read(addUserProvider.notifier).loading
                ? const Center(child: CircularProgressIndicator())
                : InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        final resp =
                            ref.read(addUserProvider.notifier).postUser(user);
                        if (resp.isNotEmpty) {
                          final snackBar = ReUsableFunctions.awesomeSnackBar(
                              'User added successfully',
                              resp,
                              ContentType.success,
                              context);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                          //_formKey.currentState!.reset();
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Save User',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
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
