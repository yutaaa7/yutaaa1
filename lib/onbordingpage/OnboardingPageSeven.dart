import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CustomText.dart';
import '../custom/CustomWidget.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';

class OnboardingPageSeven extends StatelessWidget {
  final List<Map<String, String>> fitnessGoals = [
    {
      'title': 'About 10 min',
      'image': 'assets/images/f7img1.png', // replace with actual image path
    },
    {
      'title': '10-20 min',
      'image': 'assets/images/f7img1.png', // replace with actual image path
    },
    {
      'title': 'Above 20 min',
      'image': 'assets/images/f7img1.png', // replace with actual image path
    },
    {
      'title': 'Leave the decision to us',
      'image': 'assets/images/f7img1.png', // replace with actual image path
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              CustomTextWidget(title: "",fontFamily: Fonts.montserrat,icon: Icons.arrow_back_ios,imageAsset: ""),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: CustomText(
                  text: DemoLocalization.of(context)!.translate('Howmuchtimecanyoudedicatetoexercise').toString(),//"How much time can you dedicate to exercise?",
                  fontSize: 7.0,
                  color: MyColorName.colorTextFour,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.anton,
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: CustomText(
                  text: DemoLocalization.of(context)!.translate('Helpustodevelopaprogramthatsuitsyourschedule').toString(),//"Help us to develop a program that suits your schedule",
                  fontSize: 5.0,
                  color: MyColorName.colorTextFour,
                  fontWeight: FontWeight.normal,
                  fontFamily: Fonts.montserrat,
                  textAlign: TextAlign.start,
                ),
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
                      height: screenSize.height * 0.15, // Adjust the height as needed
                      child: InkWell(
                        onTap: () {
                          // Handle card tap
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0,right: 16),
                              child: Container(
                                // width: screenSize.width * 0.25, // Set fixed width
                                // height: screenSize.height * 0.25, // Set fixed height
                                width : 40,
                                height: 40,
                                //  width: screenSize.width * 0.25, // Make the image container square
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(10.0),
                                  //    borderRadius: BorderRadius.only(
                                  //   // topRight: Radius.circular(10.0),
                                  //   // bottomRight: Radius.circular(10.0),
                                  //
                                  // ),
                                  image: DecorationImage(
                                    image: AssetImage(fitnessGoals[index]['image']!
                                    ),

                                    fit: BoxFit.cover,


                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  fitnessGoals[index]['title']!,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: Fonts.montserrat,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),

                          ],
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
}