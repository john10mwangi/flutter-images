import 'package:app/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'input_field.dart';
import 'validators.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  late AppProvider _provider;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _provider = ref.watch(appProvider);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: size.width > 600
            ? const EdgeInsets.symmetric(horizontal: 300.0)
            : const EdgeInsets.all(24.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("General", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _provider.selectedCategory,
                  items: _provider.categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _provider.selectedCategory = newValue!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Divider(
                  height: 1,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(height: 16),
                Text(
                  "Account",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputField(
                        controller: _nameController,
                        label: "Full Name",
                        autofillHints: [AutofillHints.password],
                        textInputType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          _provider.fullName = value;
                        },
                        validator: (value) => Validators.validateName(value),
                      ),
                      const SizedBox(height: 16),
                      InputField(
                        controller: _emailController,
                        label: "Email",
                        autofillHints: [AutofillHints.email],
                        textInputType: TextInputType.emailAddress,
                        onChanged: (value) {
                          _provider.email = value;
                        },
                        validator: (value) => Validators.validateEmail(value),
                      ),
                      const SizedBox(height: 16),
                      InputField(
                        controller: _passwordController,
                        label: "Password",
                        autofillHints: [AutofillHints.email],
                        obscureText: true,
                        textInputType: TextInputType.emailAddress,
                        onChanged: (value) {
                          _provider.password = value;
                        },
                        validator: (value) =>
                            Validators.validatePassword(value),
                      ),
                      const SizedBox(height: 16),
                      InputField(
                        controller: _confirmPasswordController,
                        label: "Password",
                        autofillHints: [AutofillHints.password],
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                        onChanged: (value) {
                          _provider.confirmPassword = value;
                        },
                        validator: (value) =>
                            Validators.validatePassword(value),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        child: _provider.updating
                            ? CircularProgressIndicator.adaptive()
                            : ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    print("Form is valid : ");
                                    var _response = await _provider
                                        .createUserAccount();
                                    if (_response) {
                                      _confirmPasswordController.clear();
                                      _emailController.clear();
                                      _nameController.clear();
                                      _passwordController.clear();
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Profile Updated. Profile id : ${_provider.userId}",
                                          ),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Error updating profile, please try again.",
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: const Text("Update Profile"),
                              ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
