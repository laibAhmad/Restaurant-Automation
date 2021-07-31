import 'package:LaFoodie/services/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shimmer/shimmer.dart';
import 'package:form_validator/form_validator.dart';

import '../services/auth.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> nformKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  //top Logo image
  Widget logoImage() {
    // TODO: implement build
    return Center(
      child: Container(
        height: 70,
        width: 70,
        child: Shimmer.fromColors(
          baseColor: Colors.purple,
          highlightColor: Colors.white,
          child: Image.asset("assets/img/1.png"),
        ),
      ),
    );
  }

  //white container
  Widget whiteContainer() {
    return Form(
      autovalidate: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 18,
                      ),
                      Text(
                        "Register",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 40,
                        ),
                      ),
                    ],
                  ),
                  emailRow(),
                  passwordRow(),
                  registerbtn(),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget emailRow() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        autovalidate: true,
        child: TextFormField(
          onChanged: (val) {
            setState(() => email = val);
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.email, color: Colors.purple),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              labelText: "Email"),
          validator: ValidationBuilder().email().maxLength(50).build(),
        ),
      ),
    );
  }

  Widget passwordRow() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: formKey,
        autovalidate: true,
        child: TextFormField(
          onChanged: (val) {
            setState(() => password = val);
          },
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock, color: Colors.purple),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              labelText: "Password"),
          validator: ValidationBuilder().minLength(6).maxLength(15).build(),
        ),
      ),
    );
  }

  Widget registerbtn() {
    return Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 1.4 * (MediaQuery.of(context).size.height / 25),
              width: 1.4 * (MediaQuery.of(context).size.width / 5),
              child: RaisedButton(
                elevation: 5.0,
                color: Colors.purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                onPressed: () async {
                  if (_formKey.currentState.validate() &&
                      formKey.currentState.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailandPassword(
                        email, password);

                    if (result == null) {
                      setState(() {
                        loading = false;
                        error = 'Please Enter a valid email';
                      });
                    }
                  }
                },
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height / 50,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget signinBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: FlatButton(
            onPressed: () {
              widget.toggleView();
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => LoginScreen()));
            },
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Already have an account?  ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.height / 50,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: 'Log In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height / 50,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.purple,
              body: Stack(
                children: <Widget>[
                  //top purple area
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.only(
                            bottomLeft: const Radius.circular(80),
                            bottomRight: const Radius.circular(80),
                          )),
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      logoImage(),
                      Padding(padding: EdgeInsets.only(bottom: 50.0)),
                      whiteContainer(),
                      signinBtn(),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
