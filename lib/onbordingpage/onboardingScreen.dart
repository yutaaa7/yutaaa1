import 'package:fitness/onbordingpage/OnboardingPageFour.dart';
import 'package:fitness/onbordingpage/OnboardingPageSecond.dart';
import 'package:fitness/onbordingpage/OnboardingPageThird.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CustomText.dart';
import '../custom/CustomWidget.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';
import 'OnboardingPage.dart';
import 'OnboardingPageEight.dart';
import 'OnboardingPageEleven.dart';
import 'OnboardingPageFive.dart';
import 'OnboardingPageFourteen.dart';
import 'OnboardingPageNine.dart';
import 'OnboardingPageSeven.dart';
import 'OnboardingPageSix.dart';
import 'OnboardingPageTen.dart';
import 'OnboardingPageThirteen.dart';
import 'OnboardingPageTwelve.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final List<Map<String, String>> fitnessGoals = [
    {
      'title': 'Lose Weight',
      'image': 'assets/images/fimg1.png', // replace with actual image path
    },
    {
      'title': 'Get Fitter And Tone Muscle',
      'image': 'assets/images/fimg2.png', // replace with actual image path
    },
    {
      'title': 'Increase Muscle Atrength And Size',
      'image': 'assets/images/fimg3.png', // replace with actual image path
    },
    // Add more items as needed
  ];
  List<Widget> _buildPages() {
    return [
      OnboardingPage(),
      OnboardingPageSecond(),
      OnboardingPageThird(),
      OnboardingPageFour(),
      OnboardingPageFive(),
      OnboardingPageSix(),
      OnboardingPageSeven(),
      OnboardingPageEight(),
      OnboardingPageNine(),
      OnboardingPageTen(),
      OnboardingPageEleven(),
      OnboardingPageTwelve(),
      OnboardingPageThirteen(),
      OnboardingPageFourteen(),
      /*  _buildPage(
        title: "Eat Fast food everytime",
       // description: "You can find fast food anytime in this app and will\n give you happiness while you keep healthy.",
        image: "assets/images/fimg1.png",
       // buttonText: "Next",
        buttonAction: () {
          _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
        isFullWidth: false,
        isRectangle: false,
      ),
      _buildPage(
          title: "Super fast food delivery",
         // description: "Your orders will be delivered super fast\nat your doorstep.",
          image: "assets/images/fimg2.png",
         // buttonText: "Get Started",
          buttonAction: () {
          },
          isFullWidth: true,
          isRectangle: true
      ),*/
    ];
  }

  Widget _buildPage({required String title,
    required String image,
    required VoidCallback buttonAction,required bool isFullWidth,    required bool isRectangle,

  }) {
    return
      Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                CustomTextWidget(title: "",fontFamily: Fonts.montserrat,icon: Icons.arrow_back_ios,imageAsset: ""),
                const SizedBox(height: 20),
                CustomText(
                  text:DemoLocalization.of(context)!.translate('WhatisyourFitnessgoal').toString(), //"What's your Fitness goal?",
                  fontSize: 7.0,
                  color: MyColorName.colorTextFour,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.anton,
                  textAlign: TextAlign.start,
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: fitnessGoals.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {

                    return Card(
                      color: Colors.black,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 4,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.15, // Adjust the height as needed
                        child: InkWell(
                          onTap: () {
                            // Handle card tap
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    fitnessGoals[index][title].toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontFamily: Fonts.montserrat,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),

                            ]
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: _buildPages(),
        ),
      );
  }
}
