import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:sonproje/home_page.dart';
import 'package:sonproje/register_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: Text(
          "Giriş Yap",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: _SignInBody(),
    );
  }
}

class _SignInBody extends StatefulWidget {
  @override
  __SignInBodyState createState() => __SignInBodyState();
}

class __SignInBodyState extends State<_SignInBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        scrollDirection: Axis.vertical,
        children: [
          _EmailPasswordForm(),
        ],
      ),
    );
  }
}

class _EmailPasswordForm extends StatefulWidget {
  @override
  __EmailPasswordFormState createState() => __EmailPasswordFormState();
}

class __EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Email ve Şifre ile Giriş Yap",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.center,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "E-Mail"),
                validator: (String mail) {
                  if (mail.isEmpty) return "Lütfen bir mail yazın";
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Şifre"),
                validator: (String password) {
                  if (password.isEmpty) return "Lütfen bir şifre yazın";
                  return null;
                },
                obscureText: true,
              ),
              Container(
                padding: const EdgeInsets.only(top: 16.0),
                alignment: Alignment.center,
                child: SignInButton(Buttons.Email, text: "Email ile giriş yap",
                    onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => _auth.currentUser == null
                          ? HomePage()
                          : RegisterPage(),
                    ));
                    _signInWithEmailAndPassword();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// [Email] ve [Password] ile kullanıcı girişi yapar.
  void _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("${user.email} ile giriş yapıldı."),
      ));
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("${e.message}"),
      ));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Email & Şifre ile giriş yaparken bir sorun oluştu"),
      ));
    }
  }
}

class _SignInProvider extends StatefulWidget {
  final String infoText;
  final Buttons buttonType;
  final Function signInMethod;

  const _SignInProvider({
    Key key,
    @required this.infoText,
    @required this.buttonType,
    @required this.signInMethod,
  }) : super(key: key);

  @override
  __SignInProviderState createState() => __SignInProviderState();
}

class __SignInProviderState extends State<_SignInProvider> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                widget.infoText,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              alignment: Alignment.center,
              child: SignInButton(
                widget.buttonType,
                text: widget.infoText,
                onPressed: () async => widget.signInMethod(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
