import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:task/Bloc/login_bloc.dart';
import 'package:task/Utils/constants.dart';
import 'package:task/Views/Login/components/background.dart';

import 'package:task/components/rounded_input_field.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _emailController.text = "vidhi.m1@gmail.com";
    _passController.text = "123456";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Enter your Email",
              obscure: false,
              icon: Icons.person,
              controller: _emailController,
            ),
            RoundedInputField(
              icon: Icons.remove_red_eye,
              obscure: true,
              hintText: "Enter your Email",
              controller: _passController,
            ),
            SizedBox(
              height: size.height / 11,
            ),
            GestureDetector(
              onTap: () {
                loginBloc.login(
                    context, _emailController.text, _passController.text);
              },
              child: Container(
                  width: size.width / 1.5,
                  height: 45,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: Text(
                    "LOGIN",
                    style: TextStyle(
                      fontFamily: 'Josefin',
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.5000000286102295,
                    ),
                  ))),
            ),
          ],
        ),
      ),
    );
  }
}
