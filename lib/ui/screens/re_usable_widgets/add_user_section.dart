import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/models/user.dart';
import '../../../core/providers/user/add_user_provider.dart';

class AddUserSection extends ConsumerStatefulWidget {
  const AddUserSection({super.key});

  @override
  ConsumerState<AddUserSection> createState() => _AddUserSectionState();
}

class _AddUserSectionState extends ConsumerState<AddUserSection> {
  final _formKey = GlobalKey<FormState>();
  final User user = User();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    isLoading = ref.watch(addUserProvider);
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(appLocalizations.kindlyFillTheFormBelow),
            TextFormField(
              decoration: InputDecoration(
                hintText: appLocalizations.enterFirstName,
                labelText: appLocalizations.firstName,
              ),
              onChanged: (String value) {
                user.firstName = value.trim();
              },
              onSaved: (String? value) {},
              validator: (String? value) {
                return value == null || value.isEmpty
                    ? appLocalizations.provideMissingFields
                    : null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: appLocalizations.enterLastName,
                labelText: appLocalizations.lastName,
              ),
              onChanged: (String value) {
                user.lastName = value.trim();
              },
              onSaved: (String? value) {},
              validator: (String? value) {
                return value == null || value.isEmpty
                    ? appLocalizations.provideMissingFields
                    : null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: appLocalizations.enterGender,
                labelText: appLocalizations.gender,
              ),
              onChanged: (String value) {
                user.gender = value.trim();
              },
              onSaved: (String? value) {},
              validator: (String? value) {
                return value == null || value.isEmpty
                    ? appLocalizations.provideMissingFields
                    : null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: appLocalizations.enterDOB,
                labelText: appLocalizations.dob,
              ),
              onChanged: (String value) {
                user.dob = value.trim();
              },
              onSaved: (String? value) {},
              validator: (String? value) {
                return value == null || value.isEmpty
                    ? appLocalizations.provideMissingFields
                    : null;
              },
            ),
            const SizedBox(height: 10),
            isLoading == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          FocusScope.of(context).unfocus();
                          await ref
                              .read(addUserProvider.notifier)
                              .postUser(user, context, appLocalizations);
                        }
                        if (context.mounted) {
                          FocusScope.of(context).unfocus();
                        }
                      },
                      child: Text(
                        appLocalizations.saveUser,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
