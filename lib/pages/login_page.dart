import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecom_app_admin/database/auth/auth_service.dart';
import 'package:flutter_ecom_app_admin/pages/launcher_page.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  String _errMsg = '';
  bool _obscureTxt = true;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(24.0),
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'provide a valid email';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _passController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.lock_open),
                      suffixIcon: IconButton(
                          onPressed: _toggle,
                          icon: Icon(_obscureTxt
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      labelText: 'Password'),
                  obscureText: _obscureTxt,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter a password';
                    } else if (value.length < 6) {}
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _authenticate,
                child: Text('Login as ADMIN'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  _errMsg,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureTxt = !_obscureTxt;
    });
  }

  void _authenticate() async{
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please wait...', dismissOnTap: false);
      final email = _emailController.text;
      final pass = _passController.text;

      try {
        final status = await AuthService.login(email, pass);
        EasyLoading.dismiss();
        if(status){
          if(mounted){
            Navigator.pushReplacementNamed(context, LauncherPage.routeName);
          }
        } else {
          await AuthService.logout();
          setState(() {
            _errMsg = 'This email address is not register as Admin';
          });
        }
      } on FirebaseAuthException catch (error) {
        EasyLoading.dismiss();
        setState(() {
          _errMsg = error.message!;
        });
      }
    }
  }
}
