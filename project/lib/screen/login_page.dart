import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project/tab_item/home_page.dart';
import 'package:project/tab_item/tab_menu.dart';
import 'package:project/widget/custom_TextField.dart';
import 'package:http/http.dart' as http;
import 'package:project/widget/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  String loginLink = "https://apihomechef.antopolis.xyz/api/admin/sign-in";

  late SharedPreferences sharedPreferences;

  isLogin() async {
    // eTa holo ekbar login korle porer bar na korar jonno..................
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => TabMenu()));
    } else {
      print("Token is empty");
    }
  }

  getLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var map = Map<String, dynamic>();
    map["email"] = emailController.text.toString();
    map["password"] = passwordController.text.toString();
    var responce = await http.post(
      Uri.parse(loginLink),
      body: map,
    );
    if (responce.statusCode == 200) {
      showInToast("Login Successfull");
      var data = jsonDecode(responce.body);
      setState(() {
        sharedPreferences.setString("token", data["access_token"]);
      });
      token = sharedPreferences.getString("token");
      // sharedPreferences
      //     .clear(); // log out korar jonno...........................
      print("token is $token");
    } else {
      showInToast("Invalid Email or password");
    }
  }

  String? token;

  @override
  void initState() {
    // eTa holo ekbar login korle porer bar na korar jonno.........................
    // TODO: implement initState
    isLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading == true,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
        child: Scaffold(
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomTextField(
              controller: emailController,
              hintText: "Enter Your email: ",
            ),
            CustomTextField(
              controller: passwordController,
              hintText: "Enter Password: ",
            ),
            MaterialButton(
              onPressed: () {
                getLogin();

                
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) => HomePage()));  ..................nije nijei likhsilam
              },
              color: Colors.blue,
              child: Text("Log In"),
            )
          ]),
        ),
      ),
    );
  }
}
