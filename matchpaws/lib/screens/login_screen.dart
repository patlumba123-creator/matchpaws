import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final Function(String, String, String) onSave;

  LoginScreen({required this.onSave});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _aboutController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _remember = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('savedEmail');
    final pass = prefs.getString('savedPassword');
    final remember = prefs.getBool('rememberMe') ?? false;

    if (email != null) _emailController.text = email;
    if (pass != null) _passwordController.text = pass;
    setState(() {
      _remember = remember;
      _loading = false;
    });
  }

  Future<void> _saveCredentialsIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    if (_remember) {
      await prefs.setString('savedEmail', _emailController.text);
      await prefs.setString('savedPassword', _passwordController.text);
      await prefs.setBool('rememberMe', true);
    } else {
      await prefs.remove('savedEmail');
      await prefs.remove('savedPassword');
      await prefs.setBool('rememberMe', false);
    }
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await _saveCredentialsIfNeeded();

    widget.onSave(
      _nameController.text.trim(),
      _locationController.text.trim(),
      _aboutController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (_loading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 520),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.primary.withOpacity(0.12),
                        ),
                        child: Icon(Icons.pets, size: 48, color: theme.colorScheme.primary),
                      ),
                      SizedBox(height: 12),
                      Text("Welcome to MatchPaws", style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      SizedBox(height: 18),

                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: "Email"),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) => (v == null || v.trim().isEmpty) ? "Enter email" : null,
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: "Password"),
                        obscureText: true,
                        validator: (v) => (v == null || v.trim().isEmpty) ? "Enter password" : null,
                      ),
                      SizedBox(height: 6),
                      Row(children: [
                        Checkbox(value: _remember, onChanged: (v) => setState(() => _remember = v ?? false)),
                        GestureDetector(onTap: () => setState(() => _remember = !_remember), child: Text("Remember me")),
                        Spacer(),
                        TextButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Forgot placeholder"))), child: Text("Forgot")),
                      ]),

                      Divider(height: 28),

                      TextFormField(controller: _nameController, decoration: InputDecoration(labelText: "Your name"), validator: (v) => (v == null || v.trim().isEmpty) ? "Enter your name" : null),
                      SizedBox(height: 12),
                      TextFormField(controller: _locationController, decoration: InputDecoration(labelText: "Location"), validator: (v) => (v == null || v.trim().isEmpty) ? "Enter your location" : null),
                      SizedBox(height: 12),
                      TextFormField(controller: _aboutController, decoration: InputDecoration(labelText: "About you"), maxLines: 2, validator: (v) => (v == null || v.trim().isEmpty) ? "Enter something about you" : null),
                      SizedBox(height: 18),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          child: Text("Save & Continue"),
                        ),
                      ),

                      SizedBox(height: 8),
                      TextButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.remove('savedEmail');
                          await prefs.remove('savedPassword');
                          await prefs.setBool('rememberMe', false);
                          setState(() {
                            _remember = false;
                            _emailController.clear();
                            _passwordController.clear();
                          });
                        },
                        child: Text("Clear saved credentials"),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
