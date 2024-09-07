import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/utils/app_theme.dart';
import 'package:my_project/widgets/onboarding_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int pageNumber = 0;

  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) => Container(),
                ),
              ),
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(15),
                child: Text(
                  pageNumber != 2 ? 'Passer' : "",
                  style:
                      GoogleFonts.poppins(fontSize: 17.sp, color: Colors.grey),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 70.h,
              child: PageView(
                onPageChanged: (value) => setState(
                  () {
                    pageNumber = value;
                  },
                ),
                controller: _pageController,
                children: const [
                  OnboardingScreenWidget(
                    imageUrl: 'assets/images/page2.png',
                    textContent1: 'No more food waste',
                    textContent2: "We've got the solution",
                  ),
                  OnboardingScreenWidget(
                    imageUrl: 'assets/images/page3.png',
                    textContent1: 'No more food waste',
                    textContent2: "We've got the solution",
                  ),
                  OnboardingScreenWidget(
                    imageUrl: 'assets/images/page1.png',
                    textContent1: 'No more food waste',
                    textContent2: "We've got the solution",
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(20.0),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: SlideEffect(
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                    type: SlideType.slideUnder,
                    paintStyle: PaintingStyle.stroke,
                    dotColor: Colors.grey,
                    activeDotColor: AppTheme.green),
              ),
            ),
            InkWell(
              onTap: pageNumber == 2
                  ? () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => Container(),
                        ),
                      )
                  : () => _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn),
              child: Container(
                width: 90.w,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    pageNumber == 2 ? "Get Started" : "Continue",
                    style: GoogleFonts.poppins(
                        fontSize: 16.sp, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
