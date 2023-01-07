import 'package:flutter/material.dart';
// import 'package:guitarshop/model/customer.dart';
// import 'package:guitarshop/repository/customer_repository.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter/icons/simple_icons.dart';
import 'package:medicine_finder/model/user.dart';
import 'package:medicine_finder/repository/user_repository.dart';
import 'package:medicine_finder/utils/show_message.dart';

import '../model/customappbarlogin.dart';
// import '../utils/show_message.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? name, address, contact, gender, username, email, password;

  final _formKey = GlobalKey<FormState>();

  final _fullnameController = TextEditingController();
  final _contactnoController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool? isChecked = false;

  _registerUser(User user) async {
    bool isRegister = await UserRepository().registerUser(user);
    if (isRegister) {
      _displayMessage(true);
    } else {
      _displayMessage(false);
    }
  }

  _displayMessage(bool isRegister) {
    if (isRegister) {
      displaySuccessMessage(context, "Register Success");
    } else {
      displayErrorMessage(context, "Register Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 180,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          flexibleSpace: ClipPath(
            clipper: CustomAppBar(),
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xFF6BB3ED),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    child: Image.asset(
                      'assets/images/logo2.png',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Title(
                  color: const Color(0xFF6BB3ED),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Color(0xFF6BB3ED),
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      fontFamily: 'Merienda',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // //=============================FulName Text Field==============================
                      // Container(
                      //   padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      //   width: double.infinity,
                      //   height: 50,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //       color: const Color(0xFF6BB3ED),
                      //       width: 2,
                      //     ),
                      //     borderRadius: BorderRadius.circular(10),
                      //     // color: const Color(0xFF6BB3ED),
                      //   ),
                      //   alignment: Alignment.center,
                      //   child: TextFormField(
                      //     key: const ValueKey("full_name"),
                      //     controller: _fullnameController,
                      //     cursorColor: const Color(0xFF6BB3ED),
                      //     style: const TextStyle(
                      //       color: Color(0xFF6BB3ED),
                      //       fontFamily: 'Merienda',
                      //     ),
                      //     keyboardType: TextInputType.text,
                      //     decoration: const InputDecoration(
                      //       icon: Iconify(
                      //         Ri.user_4_fill,
                      //         color: Color(0xFF6BB3ED),
                      //         size: 30,
                      //       ),
                      //       // labelText: 'Full Name',
                      //       // labelStyle: TextStyle(fontSize: 18),
                      //       hintText: 'Full Name',
                      //       enabledBorder: InputBorder.none,
                      //       focusedBorder: InputBorder.none,
                      //     ),
                      //     validator: (value) {
                      //       if (value!.isEmpty) {
                      //         return 'Please Enter Your Full Name';
                      //       }
                      //       return null;
                      //     },
                      //   ),
                      // ),

                      //=============================Username Text Field==============================
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF6BB3ED),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          // color: const Color(0xFF6BB3ED),
                        ),
                        alignment: Alignment.center,
                        child: TextFormField(
                          key: const ValueKey("username"),
                          controller: _usernameController,
                          cursorColor: const Color(0xFF6BB3ED),
                          style: const TextStyle(
                            color: Color(0xFF6BB3ED),
                            fontFamily: 'Merienda',
                          ),
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Iconify(
                              Ri.user_4_fill,
                              color: Color(0xFF6BB3ED),
                              size: 30,
                            ),
                            // labelText: 'Username',
                            hintText: 'Username',
                            // labelStyle: TextStyle(fontSize: 18),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Username';
                            }
                            return null;
                          },
                        ),
                      ),

                      //=============================Contact Text Field==============================
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF6BB3ED),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          // color: const Color(0xFF6BB3ED),
                        ),
                        alignment: Alignment.center,
                        child: TextFormField(
                          key: const ValueKey("contact_no"),
                          controller: _contactnoController,
                          cursorColor: const Color(0xFF6BB3ED),
                          style: const TextStyle(
                            color: Color(0xFF6BB3ED),
                            fontFamily: 'Merienda',
                          ),
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Iconify(
                              Ic.baseline_call,
                              color: Color(0xFF6BB3ED),
                              size: 30,
                            ),
                            // labelText: 'Full Name',
                            // labelStyle: TextStyle(fontSize: 18),
                            hintText: 'Contact No.',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Contact No.';
                            }
                            return null;
                          },
                        ),
                      ),

                      //=============================Email Text Field==============================
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF6BB3ED),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          // color: const Color(0xFF6BB3ED),
                        ),
                        alignment: Alignment.center,
                        child: TextFormField(
                          key: const ValueKey("email"),
                          controller: _emailController,
                          cursorColor: const Color(0xFF6BB3ED),
                          style: const TextStyle(
                            color: Color(0xFF6BB3ED),
                            fontFamily: 'Merienda',
                          ),
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Iconify(
                              Ic.baseline_email,
                              color: Color(0xFF6BB3ED),
                              size: 30,
                            ),
                            // labelText: 'Full Name',
                            // labelStyle: TextStyle(fontSize: 18),
                            hintText: 'Email',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Email Address';
                            }
                            return null;
                          },
                        ),
                      ),

                      //===========================Password Text Field================================
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF6BB3ED),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          // color: const Color(0xFF6BB3ED),
                        ),
                        alignment: Alignment.center,
                        child: TextFormField(
                          key: const ValueKey("password"),
                          controller: _passwordController,
                          cursorColor: const Color(0xFF6BB3ED),
                          style: const TextStyle(
                            color: Color(0xFF6BB3ED),
                            fontFamily: 'Merienda',
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Iconify(
                              Ph.lock_key_fill,
                              color: Color(0xFF6BB3ED),
                              size: 30,
                            ),
                            // labelText: 'Password',
                            hintText: 'Password',
                            // labelStyle: TextStyle(fontSize: 18),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Password';
                            }
                            return null;
                          },
                        ),
                      ),
                      //=================================SignUp Button=================================
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 40,
                        width: 120,
                        child: ElevatedButton(
                          key: const ValueKey("signUpBtn"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6BB3ED),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                User user = User(
                                  username: _usernameController.text,
                                  contact_no: _contactnoController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                _registerUser(user);
                              }
                            });
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'Merienda',
                            ),
                          ),
                        ),
                      ),

                      //=================================Or Bar=======================================
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Expanded(
                            child: Divider(
                              color: Color(0xFF6BB3ED),
                              indent: 5,
                              endIndent: 5,
                              thickness: 2,
                            ),
                          ),
                          Text(
                            "Or",
                            style: TextStyle(
                              color: Color(0xFF6BB3ED),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'Merienda',
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Color(0xFF6BB3ED),
                              indent: 5,
                              endIndent: 5,
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),

                      //==============================Social Media Links==============================
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.grey.shade200,
                                child: const Iconify(
                                  Ri.user_4_fill,
                                  color: Color(0xFF6BB3ED),
                                  size: 40,
                                )),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.grey.shade200,
                                child: const Iconify(
                                  SimpleIcons.facebook,
                                  color: Color(0xFF6BB3ED),
                                  size: 40,
                                )),
                          ),
                        ],
                      ),

                      //==============================Sign Up Button Link=============================
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already Have An Account?",
                            style: TextStyle(
                              // color: Color(0xFF6BB3ED),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'Merienda',
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.pushNamed(
                                  context,
                                  '/login',
                                );
                              });
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                color: Color(0xFF6BB3ED),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'Merienda',
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget selectImage() {
  //   return SizedBox(
  //     height: 120,
  //     child: Column(
  //       children: [
  //         const SizedBox(height: 8),
  //         SizedBox(
  //           width: 350,
  //           child: ElevatedButton.icon(
  //             onPressed: () {
  //               requestCameraPermission();
  //               _loadImage(ImageSource.camera);
  //             },
  //             icon: const Icon(Icons.camera_enhance),
  //             label: const Text('Open Camera'),
  //           ),
  //         ),
  //         const SizedBox(height: 8),
  //         SizedBox(
  //           width: 350,
  //           child: ElevatedButton.icon(
  //             onPressed: () {
  //               requestGalleryPermission();
  //               _loadImage(ImageSource.gallery);
  //             },
  //             icon: const Icon(Icons.browse_gallery_sharp),
  //             label: const Text('Open Gallery'),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
