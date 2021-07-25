import 'package:flutter/material.dart';
import 'package:newsapp/api/authintication.dart';
import 'package:newsapp/screens/entry.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  bool loginerror = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthinticationAPI authinticationAPI = AuthinticationAPI();

  TextEditingController _usernameController;
  TextEditingController _passwordController;

  String email;
  String password;

  
  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("LOGIN"),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: (isLoading) ? _drawLoading() : _drawLoginForm(),
            )));
  }

  Widget _drawLoginForm() {
    if (loginerror) {
      return Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(" login Error"),
            RaisedButton(
              onPressed: () {
                setState(() {
                  loginerror = false;
                });
              },
              child: Text(
                "Try Again",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        )),
      );
    }
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          SizedBox(
            height: 40,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              color: Colors.red[800],
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  email = _usernameController.text;
                  password = _passwordController.text;
                  var response = await authinticationAPI.login(email, password);
                  print(response);
                  if (response) {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return HomeScreen();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Entry();
                    }));
                  } else {
                    print(email);
                    print(password);
                    loginerror = true;
                  }
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _drawLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
