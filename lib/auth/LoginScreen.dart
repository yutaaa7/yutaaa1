import 'dart:convert';
import 'package:fitness/auth/ForgetPassScreen.dart';
import 'package:fitness/auth/RegistrationScreen.dart';
import 'package:fitness/auth/VerifyOtpScreen.dart';
import 'package:fitness/auth/settings_page.dart';
import 'package:fitness/custom/CustomWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Api Services/api_end_points.dart';
import '../ConnectivityService.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  late ConnectivityService _connectivityService;
  String? userName, userEmail;
 int? userId;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // Sign in aborted by user
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      return user;
    } catch (e) {
      debugPrint('Google Sign-In Failed: $e'); // Log the error message
      return null;
    }
  }



  @override
  void initState() {
    super.initState();
    _connectivityService = ConnectivityService(context);
  }

  @override
  void dispose() {
    _connectivityService.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();

    super.dispose();
  }

  String? mobile;
  int? otp;
  bool isLoading = false;

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
          message,
          style: TextStyle(color: MyColorName.colorfillBOx),
        ),
        backgroundColor: MyColorName.colorTextThird,
      ),
    );
  }

  void _validateAndSubmit() {
    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => ProfileScreen()));
    if (_controllerEmail.text == "") {
      CustomSnackbar.show(context, "Email address is required");
      return;
    }
    if (_controllerPassword.text.isEmpty) {
      CustomSnackbar.show(context, "Password is required");
      return;
    } else {
      loginApi();
    }
   /* Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>  MyHomePage(title: '',)));*/
  }

  Future<void> getStavaAuthLogin() async {
    setState(() {
      isLoading = true;
    });
    var headers = {
      'Cookie':'XSRF-TOKEN=eyJpdiI6ImlDeGN2NytIaWlaNjk5ZU5qa212M2c9PSIsInZhbHVlIjoiaTVhMlNsdy9CdzZnK0NBVkFoNWtvQVVMYUVYKzJoWWtFV0s5NE5GeTlTbUlpSm11U0EwbEVrMWtPMVRVczlMTFl3bXBmMVUzTmd6S2tmTFpseHg2aG9jdG1TUGlIUjRjZ1NBNW9FSU1yQW1EdVVhTmxKZ0hNQzkvN0Y0NGxtdFYiLCJtYWMiOiI5ZGEwMTJjOTlhODMyN2ZhMzYwMTI5MjdmMTlmNmQ2MjJlYTY0MDM2MTE3ZWMxZDY3NDc1YTMwZTMzZmE5MjExIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IjRZVjc0enlqclVTQ3BVN2pOSjQyVkE9PSIsInZhbHVlIjoibVlpczdHc09BUzhTTSttUVluTncreFd4UGdDQUhSQ0N3dXFmMVdzdEN1R210cEh6aUtoVm81T0tvUmZVaWdPODFzckFpeWZCUFBnbkhZakh2dVZFZ1VncUtNWEFOa3hId0dDcytPZEI5TWJuRlM5UGppQzlTbnBtMkhKN3dpNDYiLCJtYWMiOiIzNDZmMTE4Mjk5YTU0NTIwY2Q4MTAxYzE1YTg1NzRhYzYyMTdlY2I5NTk0ZTA2ODNiNzAwMTQ5NjA4N2ZjOGVjIiwidGFnIjoiIn0%3D'
    };
    var request = http.Request(
        'GET',
        Uri.parse('${Endpoints.baseUrl}auth/strava?client_id=133232&redirect_uri=http://tfbfitness.com&response_type=code&scope=read,activity:read'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      CustomSnackbar.show(context, "${finalResult['message']}");
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.reasonPhrase);
    }
  }


  Future<void> getStavaTokenLogin() async {
    setState(() {
      isLoading = true;
    });
    var headers = {
      'Cookie': '_strava4_session=s941ub560974bdkh4balvr4l5ormkd4l'
    };
    var request = http.Request('POST', Uri.parse('${Endpoints.baseUrlStava}oauth/token?client_id=133232&client_secret=5f9015580cfa5567aa2f68b13167b86300d37f75&code=58782651ffdcefd8ad8b65341a9a001ce0c10fb0&grant_type=authorization_code'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }
  Future<void> loginApi() async {
    /*var request = http.Request('POST', Uri.parse('http://tfbfitness.com/api/login?email=testuser@example.com&password=password123'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }*/

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });
    var request = http.MultipartRequest(
        'POST', Uri.parse("${Endpoints.baseUrl}${Endpoints.getLogin}"));
    request.fields.addAll({
      'email': _controllerEmail.text,
      'password': _controllerPassword.text,
      // 'type': _selectedUserType
    });
    // print(request.fields);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      setState(() {
        isLoading = false;
      });
      if (finalResult['error'] == false) {
        CustomSnackbar.show(context, "${finalResult['message']}");
      } else {
        // otp = finalResult['otp'];
        CustomSnackbar.show(context, "${finalResult['message']}");
        userName = finalResult['user']['name'];
        userEmail = finalResult['user']['email'];
        userId = finalResult['user']['id'];
        prefs.setString('username', userName.toString());
        prefs.setString('useremail', userEmail.toString());
        prefs.setString('userid', userId.toString());
       // print("Type=================username ${userName}");
        print("Type=================userId ${userId}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const VerifyOtpScreen())).then((value) {
          _controllerEmail.clear();
          _controllerPassword.clear();
        });
      }
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.reasonPhrase);
    }
  }

  /* @override
  void dispose() {

    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* backgroundColor:MyColorName.colorfillBOx,
      bottomSheet: Container(

         color:MyColorName.colorfillBOx,
        padding: const EdgeInsets.symmetric(vertical: 15),
        // alignment: Alignment.center,
        child: RichText(
          text: TextSpan(
            text: "Don't have an account? ",
            style: const TextStyle(
              color: MyColorName.colorfillText,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            children: <TextSpan>[
              TextSpan(
                text: "Register!",
                style: const TextStyle(
                  color: MyColorName.colorTextThird,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Navigate to registration screen
                  },
              ),
            ],
          ),
        ),
      ),*/
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                InkWell(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SettingsPage()));
                  },
                  child:  CustomTextWidget(
                      title: DemoLocalization.of(context)!.translate('Language').toString(),
                      fontFamily: Fonts.montserrat,
                      icon: Icons.arrow_back_ios,
                      imageAsset: ""),
                ),

                const SizedBox(height: 20),
                CustomText(
                  text:  DemoLocalization.of(context)!.translate('WelcometoProFitness').toString(),
                  fontSize: 8.0,
                  color: MyColorName.colorTextFour,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.roboto,
                ),

                const SizedBox(height: 10),
                CustomText(
                    text:  DemoLocalization.of(context)!.translate('HellothereSignintocontinue').toString(),//"Hello there, sign in to \ncontinue!",
                    fontSize: 4,
                    color: MyColorName.colorTextPrimary,
                    fontWeight: FontWeight.bold,
                    fontFamily: Fonts.dmsans //Fonts.roboto,
                    ),
                const SizedBox(height: 20),
                CustomText(
                  text: DemoLocalization.of(context)!.translate('Emailaddress').toString(),// "Email address",
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
                  secondaryIcon: Icons.check,
                  onChanged: (value) {
                    print('Email: $value');
                  },
                ),
                const SizedBox(height: 10),
                CustomText(
                  text: DemoLocalization.of(context)!.translate('Password').toString(),//"",
                  fontSize: 4,
                  color: MyColorName.colorTextPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.montserrat,
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  hintText: DemoLocalization.of(context)!.translate('Enteryourpassword').toString(),//'Enter your password',
                  controller: _controllerPassword,
                  // icon: Icons.lock,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  onChanged: (value) {
                    print('Password: $value');
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ForgetPassScreen()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerRight,
                    child: CustomText(
                      text: DemoLocalization.of(context)!.translate('ForgotPassword').toString(),//"Forgot Password?",
                      fontSize: 4,
                      color: MyColorName.colorTextThird,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.montserrat,
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // SizedBox(height: 8),
                Center(
                  child: isLoading
                      ? const Center(
                          child: SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                  color: MyColorName.primaryLite)))
                      : CustomButton(
                          text: DemoLocalization.of(context)!.translate('Login').toString(),
                          fontFamily: Fonts.roboto,
                          fontSize: 22,
                          color: MyColorName.colorTextThird,
                          onPressed: _validateAndSubmit,
                        ),
                ),
                const SizedBox(height: 18),
                Center(
                  child: CustomText(
                    text: DemoLocalization.of(context)!.translate('OrLoginwith').toString(),//"Or Login with",
                    fontSize: 3.5,
                    color: MyColorName.colorTextThird,
                    fontWeight: FontWeight.normal,
                    fontFamily: Fonts.montserrat,
                  ),
                ),
                 SizedBox(height: 18),
                GestureDetector(
                  // onTap: () async {

    onTap: () async {
    User? user = await signInWithGoogle(context);
    if (user != null) {
    // Navigate to the home screen after a successful login
    Navigator.pushReplacement(
    context,
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
                    text:  DemoLocalization.of(context)!.translate('ConnectWithGoogle').toString(),//"Connect with Google",
                    fontFamily: Fonts.montserrat,
                    borderColor: MyColorName.primaryLite,
                    fillColor: MyColorName.primaryLite.withOpacity(0.15),
                    textColor: MyColorName.colorsociallogintext),
                ),
                const SizedBox(height: 15),
                CustomContainer(
                  imageAsset: "assets/images/facebookicon.png",
                  text: DemoLocalization.of(context)!.translate('ConnectwithFacebook').toString(),//"Connect With Facebook",
                  fontFamily: Fonts.montserrat,
                  borderColor: MyColorName.colorButton,
                  fillColor: MyColorName.colorButton,
                  textColor: MyColorName.colorBg1,
                ),

                // SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 14,
                ),
                // SizedBox(height: 70,),
                Container(
                  //color:MyColorName.colorfillBOx,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: DemoLocalization.of(context)!.translate('DonthaveanaccountRegister').toString(),//"Don't have an account? ",
                      style: const TextStyle(
                        fontFamily: Fonts.montserrat,
                        color: MyColorName.colorfillText,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: DemoLocalization.of(context)!.translate('Register').toString(),//"Register!",
                          style: const TextStyle(
                            fontFamily: Fonts.montserrat, //Fonts.roboto,
                            color: MyColorName.colorTextThird,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrationScreen()));
                              // Navigate to registration screen
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
