import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/image_constants.dart';
import '../../../core/constants/text_constants.dart';
import '../controller/auth_controller.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState createState() => _LoginScreenState();
}


class _LoginScreenState extends ConsumerState<LoginScreen> {

  void signInWithGoogle(){
    ref.read(authControllerProvider).signInWithGoogle(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 40),
            child: Column(
              children: [
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text("Login or create an Account",
                    style: AppTextStyles.title,),
                ),
                SizedBox(height: 70,),
                Text("Welcome \nTOTAL-X",
                    style: AppTextStyles.mainHeading),

                Image(
                  image: AssetImage(AppImages.loginLogo),
                  height:270,width: 270,),
                SizedBox(height: 70,),
                GestureDetector(
                  onTap: () {
                    signInWithGoogle();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 15),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.textSecondary,
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        SvgPicture.asset(AppImages.googleIcon),
                        Text("Continue With Google",
                            style: AppTextStyles.title.
                            copyWith(fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                RichText(text:TextSpan(text:"By Continuing, I agree to TotalX’s  " ,
                    children: [
                      TextSpan(
                          text: "Terms and condition & privacy policy",
                          style: AppTextStyles.caption.
                          copyWith(color: AppColors.accentBlue)
                      )
                    ],
                    style: AppTextStyles.caption
                ),
                  textAlign: TextAlign.start,
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}

