import 'package:LaFoodie/services/auth.dart';
import 'package:LaFoodie/services/loading.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:form_validator/form_validator.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  LoginScreen({this.toggleView});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  //top Logo image
  Widget logoImage() {
    return Center(
      child: Container(
        height: 70,
        width: 70,
        child: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.purple,
          child: Image.asset("assets/img/1.png"),
        ),
      ),
    );
  }

  //white container
  Widget whiteContainer() {
    return Form(
      // key: formKey,
      // ignore: deprecated_member_use
      autovalidate: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
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
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 40,
                        ),
                      ),
                    ],
                  ),
                  emailRow(),
                  passwordRow(),
                  loginbtn(),
                  SizedBox(
                    height: 20.0,
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
        key: formKey,
        // ignore: deprecated_member_use
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
    );
  }

  Widget loginbtn() {
    return Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 1.4 * (MediaQuery.of(context).size.height / 25),
              width: 1.4 * (MediaQuery.of(context).size.width / 5),
              // ignore: deprecated_member_use
              child: RaisedButton(
                elevation: 5.0,
                color: Colors.purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                onPressed: () async {
                  //validation
                  // validate();

                  if (formKey.currentState.validate()) {
                    setState(() => loading = true);
                    dynamic result =
                        await _auth.signInWithEmailandPassword(email, password);
                    if (result == null) {
                      setState(() {
                        loading = false;
                        error = "Wrong Email or Password!";
                      });
                    }
                  }
                },
                child: Text(
                  "Login",
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

  Widget signupBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40),
          // ignore: deprecated_member_use
          child: FlatButton(
            onPressed: () {
              widget.toggleView();
            },
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Don't have an account?  ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.height / 50,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'Sign Up',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: MediaQuery.of(context).size.height / 50,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey[300],
              body: Stack(
                children: <Widget>[
                  //top purple area
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.purple,
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
                      signupBtn(),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
