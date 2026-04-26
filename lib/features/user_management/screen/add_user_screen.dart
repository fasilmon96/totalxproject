import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totalxproject/core/constants/color_constants.dart';
import 'package:totalxproject/core/constants/image_constants.dart';
import 'package:totalxproject/core/constants/text_constants.dart';
import 'package:totalxproject/core/providers/providers.dart';
import 'package:totalxproject/core/providers/utils..dart';
import 'package:totalxproject/features/user_management/controller/add_user_controller.dart';
import 'package:totalxproject/model/user_model.dart';
import 'package:uuid/uuid.dart';

import '../../../core/common/validattion.dart';

class AddUserScreen extends ConsumerStatefulWidget {
  const AddUserScreen({super.key});

  @override
  ConsumerState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends ConsumerState<AddUserScreen> {
  final _formKey =GlobalKey<FormState>();
  final TextEditingController nameController =TextEditingController();
  final TextEditingController ageController =TextEditingController();
  final TextEditingController phoneController =TextEditingController();


  void selectImage()async{
    final image = await pickImageGallery();
    ref.read(imageProvider.notifier).state=image;
  }

  void addUser(File? imageFile)async{
    final userId = const Uuid().v1();
    UserModel userModel = UserModel(
        uid: userId,
        name: nameController.text.trim(),
        age: int.parse(ageController.text.trim()),
        phone: phoneController.text.trim(),
        image: ""
    );

    await ref.read(addUserControllerProvider).
     addUser(userModel, imageFile, context);

     nameController.clear();
     ageController.clear();
     phoneController.clear();
     ref.read(imageProvider.notifier).state =null;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(imageProvider.notifier).state = null;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final image = ref.watch(imageProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20 ,vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Add A New User",
                    style: AppTextStyles.title
                ),
                SizedBox(height: 50,),
                GestureDetector(
                   onTap: () {
                     selectImage();
                   },
                  child: Center(
                      child:
                     CircleAvatar(
                           radius: 57,
                           backgroundColor: AppColors.filterBtn,
                        child: CircleAvatar(
                          radius: image == null ? 57 : 55,
                          backgroundImage:
                          image == null ?
                           AssetImage(AppImages.addUserImage):
                           FileImage(image),
                        ),
                      )
                  ),
                ),

                SizedBox(height: 60,),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name",
                          style: AppTextStyles.subTitle
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          return Validation.nameValidation(value!);
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textSecondary
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textSecondary
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          hintText: "Enter the name",
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Age",
                          style: AppTextStyles.subTitle
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: ageController,
                        cursorColor: AppColors.black,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        enableSuggestions: false,
                        validator: (value) {
                          return Validation.ageValidation(value!);
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textSecondary
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textSecondary
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          hintText: "Enter the age",
                          counterText: ""
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Phone",
                          style: AppTextStyles.subTitle
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: phoneController,
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          return Validation.phoneValidation(value!);
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textSecondary
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textSecondary
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          hintText: "Enter the number",
                          counterText: ""
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 12,
                  children: [
                    GestureDetector(
                      onTap: () {
                        nameController.clear();
                        ageController.clear();
                        phoneController.clear();
                        ref.read(imageProvider.notifier).state=null;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        decoration: BoxDecoration(
                            color: AppColors.cancelBtnGrey,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text("Cancel",
                          style: AppTextStyles.subTitle.
                          copyWith(
                            fontWeight: FontWeight.w500
                          )
                        ),
                      ),
                    ),
                    GestureDetector(
                       onTap: () {
                         if(_formKey.currentState!.validate()){
                           addUser(image);
                         }

                       },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        decoration: BoxDecoration(
                            color: AppColors.buttonBg,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text("Save",
                          style: AppTextStyles.subTitle.
                          copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500
                          )
                        ),
                      ),
                    )
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
