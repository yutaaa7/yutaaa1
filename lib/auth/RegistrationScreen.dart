import 'dart:convert';
import 'package:fitness/auth/LoginScreen.dart';
import 'package:fitness/custom/CustomWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../Api Services/api_end_points.dart';
import '../bottomdrawer/homeScreen.dart';
import '../colors.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomContainer.dart';
import '../custom/CustomText.dart';
import '../custom/CustomTextFormField.dart';
import '../custom/Fonts.dart';
import '../custom/ShowSnackbar.dart';
import '../utils/Demo_Localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPhoneNo = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  String? mobile;
  int? otp;
  bool isLoading = false;


  // Create the method to handle Google Sign-In
  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;
        return user;

        // return userCredential.user;

      }
    } catch (e) {
      print('Google sign-in failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login Failed: $e"),
      ));
    }
    return null;
  }

  void _validateAndSubmit() {
    if (_controllerName.text == "") {
      CustomSnackbar.show(context, "name is required");
      return;
    }else if (_controllerPhoneNo.text == "") {
      CustomSnackbar.show(context, "phone number is required");
      return;
    } if (_controllerPhoneNo.text.length < 10) {
      CustomSnackbar.show(context, "Please enter valid mobile number!");
      return;
    } if (_controllerEmail.text == "") {
      CustomSnackbar.show(context, "email is required");
      return;
    } if (_controllerPassword.text == "") {
      CustomSnackbar.show(context, "password is required");
      return;
    }
    else {
      registrationApi();
    }
  }

  Future<void> registrationApi() async {
    setState(() {
      isLoading =  true;
    });

    var headers = {
      'Cookie': 'ci_session=5nbd4rujnmj58327kb67h560njukte8i'
    };
    var request = http.MultipartRequest('POST', Uri.parse("${Endpoints.baseUrl}${Endpoints.getRegistration}"));
    request.fields.addAll({
      'name':_controllerName.text.toString(),
      'email':_controllerEmail.text.toString(),
      'phone':_controllerPhoneNo.text.toString(),
      'password':_controllerPassword.text.toString(),

    });
    /*name:Rahul Parmar
    email:rahulraj10@gmail.com
    phone:9197654325
    password:123456*/
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);

      setState(() {
        isLoading =  false;
      });
      // if(finalResult['error']== true){
      //   CustomSnackbar.show(context, "${finalResult['message']}");

      // }else {
      //   otp = finalResult['user'];
        CustomSnackbar.show(context, "${finalResult['message']}");
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            LoginScreen())).then((value) {
          _controllerName.clear();
          _controllerEmail.clear();
          _controllerPhoneNo.clear();
          _controllerPassword.clear();
        });
        /* Navigator.push(context, MaterialPageRoute(builder: (context) =>
            VerifyOtpScreen(mobile: mobileC.text, otp: otp,))).then((value) {
          mobileC.clear();
        });*/
      // }

      setState(() {
        isLoading =  false;
      });
    }
    else {
      setState(() {
        isLoading =  false;
      });
      print(response.reasonPhrase);
    }

  }



  @override
  void dispose() {
    _controllerName.dispose();
    _controllerPhoneNo.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
               CustomTextWidget(title:  DemoLocalization.of(context)!.translate('Skip').toString(),/*"Skip"*/fontFamily:Fonts.montserrat,icon: Icons.arrow_back_ios,imageAsset: ""),

                const SizedBox(height: 20),
                CustomText(
                  text: DemoLocalization.of(context)!.translate('CreateAccounts').toString(),// "Create Accounts",
                  fontSize: 8.0,
                  color: MyColorName.colorTextFour,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.roboto,
                ),

                const SizedBox(height: 10),
                CustomText(
                  text: DemoLocalization.of(context)!.translate('Pleaseenteryourcredentialstoproceed').toString(),//"Please enter your credentials to \nproceed",
                  fontSize: 4,
                  color: MyColorName.colorTextPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily:Fonts.dmsans// Fonts.roboto,
                ),
                const SizedBox(height: 20),
                CustomText(
                  text: DemoLocalization.of(context)!.translate('FullName').toString(),//"Full Name",
                  fontSize: 4,
                  color: MyColorName.colorTextPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.montserrat,
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  // labelText: 'Email',
                  hintText: DemoLocalization.of(context)!.translate('Enterfullname').toString(),//'Enter full name',
                  keyboardType: TextInputType.text,
                  controller: _controllerName,
                  // icon: "Icons.email",
                  secondaryIcon: Icons.check,
                  onChanged: (value) {
                    print('name: $value');
                  },

                ),
                const SizedBox(height: 10),


                CustomText(
                  text: DemoLocalization.of(context)!.translate('Phone').toString(),//"Phone",
                  fontSize: 4,
                  color: MyColorName.colorTextPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.montserrat,
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  // labelText: 'Email',
                  hintText: DemoLocalization.of(context)!.translate('Enterphonenumber').toString(),//'Enter phone number',
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: _controllerPhoneNo,
                  // icon: "Icons.email",
                //  secondaryIcon: Icons.check,
                  onChanged: (value) {
                    print('phone: $value');
                  },

                ),
                const SizedBox(height: 10),
                CustomText(
                  text:DemoLocalization.of(context)!.translate('Emailaddress').toString(),// "Email address",
                  fontSize: 4,
                  color: MyColorName.colorTextPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.montserrat,
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                 // labelText: 'Email',
                  hintText: DemoLocalization.of(context)!.translate('Enteryouremail').toString(),//'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  controller: _controllerEmail,
                  // icon: "Icons.email",
                //  secondaryIcon: Icons.check,
                  onChanged: (value) {
                    print('Email: $value');
                  },

                ),
                const SizedBox(height: 10),
                CustomText(
                  text: DemoLocalization.of(context)!.translate('Password').toString(),//"Password",
                  fontSize: 4,
                  color: MyColorName.colorTextPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.montserrat,
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                //  labelText: '',
                  hintText: DemoLocalization.of(context)!.translate('Enteryourpassword').toString(),//'Enter your password',
                  controller: _controllerPassword,
                  // icon: Icons.lock,
                  obscureText: true,
                  onChanged: (value) {
                    print('Password: $value');
                  },
                           ),
                const SizedBox(height: 10),
              /*  Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerRight,
                  child:  CustomText(
                    text: "Forgot Password?",
                    fontSize: 4,
                    color: MyColorName.colorTextThird,
                    fontWeight: FontWeight.bold,
                    fontFamily:Fonts.roboto,
                  ),
                ),*/
                const SizedBox(height: 18),

                // SizedBox(height: 8),
                Center(
                  child: isLoading
                      ? const Center(child: SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(color: MyColorName.primaryLite)))
                      : CustomButton(
                    text: DemoLocalization.of(context)!.translate('CreateAccount').toString(),//'Create Account',
                    fontFamily:Fonts.roboto,
                    fontSize: 22,
                    color: MyColorName.colorTextThird,
                    onPressed: _validateAndSubmit,
                  ),
                ),
                const SizedBox(height: 18),
                Center(
                  child: CustomText(
                    text: DemoLocalization.of(context)!.translate('OrRegisterwith').toString(),// "Or Register with",
                    fontSize: 3.5,
                    color: MyColorName.colorTextThird,
                    fontWeight: FontWeight.normal,
                    fontFamily: Fonts.montserrat,
                  ),
                ),
                const SizedBox(height: 18),
                GestureDetector(
                  onTap: () async {
                    User? user = await signInWithGoogle(context);
                    if (user != null) {
                      // Navigate to the home screen after a successful login
                      Navigator.pushReplacement( context,
                        MaterialPageRoute(builder: (context) => MyHomePage(title: '',)),
                      );
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Google Sign-In Failed')),
                      );
                    }


                  },
                  child: CustomContainer(
                    imageAsset: "assets/images/googlecon.png",
                    text: DemoLocalization.of(context)!.translate('ConnectWithGoogle').toString(),//"Connect with Google",
                    fontFamily: Fonts.montserrat,
                    borderColor: MyColorName.primaryLite,
                    fillColor:MyColorName.primaryLite.withOpacity(0.15),
                    textColor: MyColorName.colorsociallogintext,
                  ),
                ),
                const SizedBox(height: 15),
                CustomContainer(imageAsset:"assets/images/facebookicon.png",
                  text: DemoLocalization.of(context)!.translate('ConnectwithFacebook').toString(),// "Connect With Facebook",
                  fontFamily: Fonts.montserrat,
                  borderColor: MyColorName.colorButton,
                  fillColor: MyColorName.colorButton,
                  textColor: MyColorName.colorfillBOx),

                // SizedBox(height: 10),
                SizedBox(height: MediaQuery.of(context).size.height/14,),
                // SizedBox(height: 70,),
                Container(
                  //color:MyColorName.colorfillBOx,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                   alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: DemoLocalization.of(context)!.translate('AlreadyhaveanaccountLogin').toString(),//"Already have an account? ",
                      style: const TextStyle(
                        fontFamily: Fonts.montserrat,
                        color: MyColorName.colorfillText,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: DemoLocalization.of(context)!.translate('Logintext').toString(),//"Login!",
                          style: const TextStyle(
                            fontFamily: Fonts.montserrat,
                            color: MyColorName.colorTextThird,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => LoginScreen()));
                            },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}