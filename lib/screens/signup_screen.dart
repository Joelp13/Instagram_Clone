import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
    print(res);

    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResoponsiveLayout(
              mobScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout())));
    }
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            //svg image
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 64,
            ),
            const SizedBox(
              height: 64,
            ),
            //circular widget to show and accept our selected file
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            "data:image/jpeg;base64,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"),
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            //text field input for username
            TextFieldInput(
                textEditingController: _usernameController,
                hintText: 'Enter your username',
                textInputType: TextInputType.text),
            const SizedBox(
              height: 24,
            ),

            //text filed input for email
            TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 24,
            ),
            //text filled input for password
            TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                isPass: true),
            const SizedBox(
              height: 24,
            ),
            //text field input for bio
            TextFieldInput(
                textEditingController: _bioController,
                hintText: 'Enter your bio',
                textInputType: TextInputType.text),
            const SizedBox(
              height: 24,
            ),
            //login button
            InkWell(
              onTap: signUpUser,
              child: Container(
                // ignore: sort_child_properties_last
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text("Sign up"),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    color: blueColor),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Flexible(
              // ignore: sort_child_properties_last
              child: Container(),
              flex: 2,
            ),
            //transition to signing up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text("Dont have an account?"),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: navigateToLogin,
                  child: Container(
                    // ignore: sort_child_properties_last
                    child: const Text(
                      "Login",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
