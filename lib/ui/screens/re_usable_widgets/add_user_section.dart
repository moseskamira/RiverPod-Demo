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

  Widget _buildTextField(BuildContext context, String hintText,
      String labelText, Function(String) onChanged) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
      ),
      onChanged: onChanged,
      validator: (value) => _validateField(
        value,
        labelText,
        appLocalizations,
      ),
    );
  }

  String? _validateField(
      String? value, String fieldName, AppLocalizations appLocalizations) {
    if (value == null || value.isEmpty) {
      return appLocalizations.provideMissingFields;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final isLoading = ref.watch(addUserProvider);
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(appLocalizations.kindlyFillTheFormBelow),
            _buildTextField(
              context,
              appLocalizations.enterFirstName,
              appLocalizations.firstName,
              (value) => user.firstName = value.trim(),
            ),
            _buildTextField(
              context,
              appLocalizations.enterLastName,
              appLocalizations.lastName,
              (value) => user.lastName = value.trim(),
            ),
            _buildTextField(
              context,
              appLocalizations.enterGender,
              appLocalizations.gender,
              (value) => user.gender = value.trim(),
            ),
            _buildTextField(
              context,
              appLocalizations.enterDOB,
              appLocalizations.dob,
              (value) => user.dob = value.trim(),
            ),
            const SizedBox(height: 10),
            isLoading == AddUserState.loading
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
                        side: const BorderSide(color: Colors.blue, width: 2),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          await Future.wait<void>([
                            ref.read(addUserProvider.notifier).postUser(
                                  user,
                                  context,
                                  appLocalizations,
                                )
                          ]).then((_) {
                            _formKey.currentState!.reset();
                          });
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
