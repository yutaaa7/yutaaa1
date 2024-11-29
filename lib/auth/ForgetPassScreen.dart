import 'package:fitness/auth/VerifyOtpScreen.dart';
import 'package:fitness/custom/CustomWidget.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomText.dart';
import '../custom/CustomTextFormField.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {



  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        duration:Duration(seconds: 1) ,
        content: Text(message,style: TextStyle(color: MyColorName.colorfillBOx),),
        backgroundColor: MyColorName.colorTextThird,
      ),
    );
  }

  void _validateAndSubmit() {

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => VerifyOtpScreen()));

    /*   if (_controllerEmail.text.isEmpty) {
      _showSnackbar('Please Enter your Email...');
      return null;
    }
   else {
      _showSnackbar('Please correct the errors in the form.');
    }*/

  }

  @override
  void dispose() {
    _controllerEmail.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
               CustomTextWidget(title: DemoLocalization.of(context)!.translate('Skip').toString(),fontFamily: Fonts.montserrat,icon: Icons.arrow_back_ios,imageAsset: ""),

                const SizedBox(height: 20),
                CustomText(
                  text:  DemoLocalization.of(context)!.translate('ForgotPassword').toString(),//"Forgot Password",
                  fontSize: 8.0,
                  color: MyColorName.colorTextFour,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.roboto,
                ),

                const SizedBox(height: 10),
                CustomText(
                  text: DemoLocalization.of(context)!.translate('Pleaseenteryourcredentialstoproceed').toString(),//"Please enter your email below to receive your password reset code.",
                  fontSize: 4,
                  color: MyColorName.colorTextPrimary,
                  fontWeight: FontWeight.normal,
                  fontFamily: Fonts.dmsans,
                ),
                SizedBox(height: screenSize.height/9),
                CustomText(
                  text: DemoLocalization.of(context)!.translate('Emailaddress').toString(),//"Email",
                  fontSize: 4,
                  color: MyColorName.colorTextPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.montserrat,
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                 // labelText: 'Email',
                  hintText: DemoLocalization.of(context)!.translate('Enteryouremail').toString(),//'Enter your email',

                  controller: _controllerEmail,
                  // icon: "Icons.email",
                  secondaryIcon: Icons.check,
                  onChanged: (value) {
                    print('Email: $value');
                  },
                ),
                SizedBox(height: screenSize.height/8),
                Center(
                  child: CustomButton(
                    text:  DemoLocalization.of(context)!.translate('ResetPassword').toString(),//'Reset Password',
                    fontFamily:Fonts.roboto,
                    fontSize: 22,
                    color: MyColorName.colorTextThird,
                    onPressed: _validateAndSubmit,
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