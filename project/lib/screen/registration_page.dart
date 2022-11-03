import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project/http/custom_http_req.dart';
import 'package:project/widget/brand_colors.dart';
import 'package:project/widget/custom_TextField.dart';
import 'package:http/http.dart' as http;
import 'package:project/widget/widget.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  bool isLoading = false;
  getRegister() async {
    setState(() {
      isLoading = true;
    });
    var map = Map<String, dynamic>();
    map["name"] = nameController.text.toString();
    map["email"] = emailController.text.toString();
    map["password"] = passwordController.text.toString();
    map["password_confirmation"] = confirmPassController.text.toString();
    var responce = await http.post(
      Uri.parse("$uri/create/new/admin"),
      body: map,
      headers: CustomhttpRequest.defaultHeader,
    );
    var data = jsonDecode(responce.body);
    print("${responce.body}");
    if (responce.statusCode == 201) {
      showInToast("Registration Success");
    } else {
      showInToast("${data["errors"]["email"]}");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
/*
CircularProgressIndicator(
              value: controller.value,
              semanticsLabel: 'Circular progress indicator'
*/

      child: ModalProgressHUD(
        inAsyncCall: isLoading == true,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
        child: Scaffold(
          body: Column(children: [
            CustomTextField(
              controller: nameController,
              hintText: "Enter Your Name: ",
            ),
            CustomTextField(
              controller: emailController,
              hintText: "Enter Your email: ",
            ),
            CustomTextField(
              controller: passwordController,
              hintText: "Enter Password: ",
            ),
            CustomTextField(
              controller: confirmPassController,
              hintText: "Confirm Password: ",
            ),
            MaterialButton(
              onPressed: () {
                getRegister();
              },
              color: Colors.blue,
              child: Text("Registration"),
            )
          ]),
        ),
      ),
    );
  }
}
