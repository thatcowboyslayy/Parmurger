import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/utils/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnboardingScreenWidget extends StatelessWidget {
  const OnboardingScreenWidget({
    super.key,
    required this.imageUrl,
    required this.textContent1,
    required this.textContent2,
  });

  final String imageUrl;
  final String textContent1;
  final String textContent2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textContent1,
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
              color: Colors.black,
            ),
          ),
          Text(
            textContent2,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: AppTheme.green,
            ),
          ),
          const Spacer(),
          Container(
            height: 40.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imageUrl), fit: BoxFit.contain),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
