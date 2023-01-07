import 'package:flutter/material.dart';
// import 'package:guitarshop/model/customer.dart';
// import 'package:guitarshop/repository/customer_repository.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter/icons/simple_icons.dart';

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

  // _registerUser(Customer customer) async {
  //   bool isRegister = await CustomerRepository().registerUser(customer);
  //   if (isRegister) {
  //     _displayMessage(true);
  //   } else {
  //     _displayMessage(false);
  //   }
  // }

  // _displayMessage(bool isRegister) {
  //   if (isRegister) {
  //     displaySuccessMessage(context, "Register Success");
  //   } else {
  //     displayErrorMessage(context, "Register Failed");
  //   }
  // }

  // Future<void> requestCameraPermission() async {
  //   final cameraStatus = await Permission.camera.status;
  //   if (cameraStatus.isDenied) {
  //     await Permission.camera.request();
  //   }
  // }

  // Future<void> requestGalleryPermission() async {
  //   final galleryStatus = await Permission.photos.status;
  //   if (galleryStatus.isDenied) {
  //     await Permission.photos.request();
  //   }
  // }

  // File? img;
  // Future _loadImage(ImageSource imageSource) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: imageSource);
  //     if (image != null) {
  //       setState(() {
  //         img = File(image.path);
  //       });
  //     } else {
  //       return;
  //     }
  //   } catch (e) {
  //     debugPrint('Failed to pick Image $e');
  //   }
  // }

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
                      // GestureDetector(
                      //   child: SizedBox(
                      //     height: 100,
                      //     child: CircleAvatar(
                      //       radius: 60,
                      //       child: ClipOval(
                      //         child: Image.network(
                      //           'https://w7.pngwing.com/pngs/627/693/png-transparent-computer-icons-user-user-icon-thumbnail.png',
                      //           fit: BoxFit.cover,
                      //           height:
                      //               MediaQuery.of(context).size.height * 0.4,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      //   onTap: () {
                      //     setState(() {
                      //       showModalBottomSheet(
                      //           context: context,
                      //           builder: (BuildContext context) {
                      //             return selectImage();
                      //           });
                      //     });
                      //   },
                      // ),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      //=============================FulName Text Field==============================
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
                          key: const ValueKey("full_name"),
                          controller: _fullnameController,
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
                            // labelText: 'Full Name',
                            // labelStyle: TextStyle(fontSize: 18),
                            hintText: 'Full Name',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Full Name';
                            }
                            return null;
                          },
                        ),
                      ),

                      // //=============================Address Text Field==============================
                      // const SizedBox(height: 8),
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
                      //     cursorColor: const Color(0xFF6BB3ED),
                      //     style: const TextStyle(
                      //       color: Color(0xFF6BB3ED),
                      //       fontFamily: 'Merienda',
                      //     ),
                      //     onChanged: (value) {
                      //       setState(() {
                      //         address = value;
                      //       });
                      //     },
                      //     keyboardType: TextInputType.text,
                      //     decoration: const InputDecoration(
                      //       icon: Iconify(
                      //         Ph.address_book_fill,
                      //         color: Color(0xFF6BB3ED),
                      //         size: 30,
                      //       ),
                      //       // labelText: 'Full Name',
                      //       // labelStyle: TextStyle(fontSize: 18),
                      //       hintText: 'Address',
                      //       enabledBorder: InputBorder.none,
                      //       focusedBorder: InputBorder.none,
                      //     ),
                      //     validator: (value) {
                      //       if (value!.isEmpty) {
                      //         return 'Please Enter Your Address';
                      //       }
                      //       return null;
                      //     },
                      //   ),
                      // ),

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

                      // //=============================Gender Field==============================
                      //                     const SizedBox(height: 4),
                      //                     Container(
                      //                       padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      //                       width: double.infinity,
                      //                       height: 50,
                      //                       decoration: BoxDecoration(
                      //                         border: Border.all(
                      //                           color: const Color(0xFF6BB3ED),
                      //                           width: 2,
                      //                         ),
                      //                         borderRadius: BorderRadius.circular(10),
                      //                         // color: const Color(0xFF6BB3ED),
                      //                       ),
                      //                       alignment: Alignment.center,
                      //                       child: TextFormField(
                      //                         cursorColor: const Color(0xFF6BB3ED),
                      //                         style: const TextStyle(
                      //                           color: Color(0xFF6BB3ED),
                      //                           fontFamily: 'Merienda',
                      //                         ),
                      //                         onChanged: (value) {
                      //                           setState(() {
                      //                             username = value;
                      //                           });
                      //                         },
                      //                         keyboardType: TextInputType.text,
                      //                         decoration: const InputDecoration(
                      //                           icon: Iconify(
                      //                             Mdi.gender_male_female,
                      //                             color: Color(0xFF6BB3ED),
                      //                             size: 30,
                      //                           ),
                      //                           // labelText: 'Username',
                      //                           hintText: 'Gender',
                      //                           // labelStyle: TextStyle(fontSize: 18),
                      //                           enabledBorder: InputBorder.none,
                      //                           focusedBorder: InputBorder.none,
                      //                         ),
                      //                         validator: (value) {
                      //                           if (value!.isEmpty) {
                      //                             return 'Please Enter Your Gender';
                      //                           }
                      //                           return null;
                      //                         },
                      //                       ),
                      //                     ),

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
                      // //=================================Terms & Condition==============================
                      // Container(
                      //   margin: const EdgeInsets.only(top: 0),
                      //   // alignment: Alignment.centerRight,
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         shape: const RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.all(
                      //             Radius.circular(10.0),
                      //           ),
                      //         ),
                      //         value: isChecked,
                      //         onChanged: (v) {
                      //           setState(() {
                      //             isChecked = v!;
                      //           });
                      //         },
                      //       ),
                      //       const Text(
                      //         "I Accept All The Terms & Conditions.",
                      //         style: TextStyle(
                      //           // color: Colors.grey,
                      //           fontWeight: FontWeight.bold,
                      //           fontFamily: 'Merienda',
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      //   // child: GestureDetector(
                      //   //   child: const Text(
                      //   //     "Forget Password?",
                      //   //     style: TextStyle(
                      //   //       color: Color(0xFF6BB3ED),
                      //   //       fontWeight: FontWeight.bold,
                      //   //       fontFamily: 'Merienda',
                      //   //     ),
                      //   //   ),
                      //   //   onTap: () {},
                      //   // ),
                      // ),

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
                                //   Customer customer = Customer(
                                //     full_name: _fullnameController.text,
                                //     contact_no: _contactnoController.text,
                                //     username: _usernameController.text,
                                //     email: _emailController.text,
                                //     password: _passwordController.text,
                                //   );
                                //   _registerUser(customer);
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
