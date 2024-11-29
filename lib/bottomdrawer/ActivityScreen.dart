import 'package:flutter/material.dart';
import '../auth/SignOutScreen.dart';
import '../colors.dart';
import '../custom/CstAppbarWithtextimage.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../onbordingpage/onboardingScreen.dart';
import '../utils/Demo_Localization.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              // SizedBox(height: 20),
              Padding(padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                child:  // CustomWidgetImage(title: 'Support', imageAsset: 'assets/images/logo.png',fontFamily: Fonts.anton, onTextTap: () {})
                      CstAppbarWithtextimage(
                  title:DemoLocalization.of(context)!.translate('Activities').toString(), //'Activities',
                  icon: Icons.arrow_back_ios,
                  fontFamily: Fonts.anton,
                  imageAsset: "assets/images/logo.png",
                  onImageTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: SignOutScreen(),
                          inheritTheme: true,
                          ctx: context),
                    );

                    // Navigator.push(context,createRoute(),);
                  },
                ),
              ),
              SizedBox(height: 20),
              // Navigator.push(context, _createRoute());
              // Padding(
              // padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
              /* CstAppbarWithtextimage(
                title: 'Activities',
                icon: Icons.arrow_back_ios,
                fontFamily: Fonts.anton,
                  onImageTap: (){

                  }
              ),
              //   ),
              SizedBox(height: 30),*/
              Container(
                height: 140,
                // width: 120,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),

              CustomText(text: DemoLocalization.of(context)!.translate('TakeYour').toString(),//"Take your running to the next level",
                  fontSize: 6,
                  textAlign: TextAlign.center,
                  color: MyColorName.colorTextPrimary,
                  fontWeight: FontWeight.normal,
                  fontFamily: Fonts.roboto //Fonts.roboto,
                  ),
              SizedBox(height: 5),
              CustomText(text:DemoLocalization.of(context)!.translate('Onceyou').toString(),
                     // "Once you complete a run with FTB, you can see your mileage, stats, and achievements here.",
                  fontSize: 3.5,
                  textAlign: TextAlign.center,
                  color: MyColorName.colorTextThird,
                  fontWeight: FontWeight.normal,
                  fontFamily: Fonts.montserrat),
              SizedBox(height: 20),
              CustomText(textAlign: TextAlign.center,
                text: DemoLocalization.of(context)!.translate('Lets').toString(),//"Let's log some miles!",
                fontSize: 3.5,
                color: MyColorName.colorTextThird,
                fontWeight: FontWeight.normal,
                fontFamily: Fonts.montserrat,),
              SizedBox(height: 20),
              // Spacer(),
              CustomButton(
                text: DemoLocalization.of(context)!.translate('RecordRun').toString(),//'Record Run',
                fontFamily: Fonts.roboto,
                fontSize: 22,
                color: MyColorName.colorTextThird,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OnboardingScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
