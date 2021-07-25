import 'package:flutter/material.dart';
import 'package:newsapp/api/authintication.dart';
import 'package:newsapp/screens/home_screen.dart';
import 'package:newsapp/screens/threedot_pages/login.dart';

class Register extends StatefulWidget {
  //const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthinticationAPI authinticationAPI = AuthinticationAPI();

  TextEditingController _usernameController;
  TextEditingController _useremailController;
  TextEditingController _passwordController;

  String email;
  String password;
  String name;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _useremailController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _useremailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("REGIST"),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: (isLoading) ? _drawLoading() : _drawLoginForm(),
            )));
  }

  Widget _drawLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          SizedBox(
            height: 40,
          ),
          TextFormField(
            controller: _useremailController,
            decoration: InputDecoration(labelText: 'Useremail'),
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
                  name = _usernameController.text;
                  password = _passwordController.text;
                  email = _useremailController.text;
                  var response =
                      await authinticationAPI.register(name, email, password);
                  print(response);
                   setState(() {
                    isLoading = false;
                  });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Login();
                    }));

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
                "Regist",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 80),
                child: Text("have account !! login",
                    style: TextStyle(
                        color: Colors.red.shade800,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Login();
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right:10),
                  child: Icon(
                    Icons.login,
                    size: 50.0,
                    color: Colors.red.shade800,
                  ),
                ),
              )
            ],
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
