import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totalxproject/core/common/error_text.dart';
import 'package:totalxproject/core/common/filter_dialog.dart';
import 'package:totalxproject/core/common/loader.dart';
import 'package:totalxproject/core/constants/color_constants.dart';
import 'package:totalxproject/core/constants/text_constants.dart';
import 'package:totalxproject/core/providers/providers.dart';
import 'package:totalxproject/features/home/controller/home_controller.dart';
import 'package:totalxproject/features/user_management/screen/add_user_screen.dart';

import '../../auth/controller/auth_controller.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {


  void logout(){
    ref.read(authControllerProvider).logout(context);
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(streamUserProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final activeFilter = ref.watch(filterProvider);
    return Scaffold(
      backgroundColor:AppColors.homeBg,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        ref.read(searchQueryProvider.notifier).state = value;
                      },
                      decoration: InputDecoration(
                        hintText: "search by name",
                        hintStyle: TextStyle(
                          color: AppColors.black.withAlpha(90),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.black,
                            ),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.black,
                          ),
                          borderRadius: BorderRadius.circular(30)
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Icon(Icons.search,size: 30),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async{
                      await showDialog(
                          context: context,
                          builder: (context) => FilterDialog(),
                      );
                      },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Icon(Icons.filter_list,color: Colors.white,),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("User Lists",
                    style:AppTextStyles.title,),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentBlue,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                      onPressed: () {
                       logout();
                      },
                      child: Icon(
                        Icons.logout,
                        color: AppColors.filterBtn,
                      )
                  )
                ],
              ),
              SizedBox(height: 20,),
              userAsync.when(
                  data: (allUsers) {
                      final filteredList = allUsers.where((user) {
                      final matchSearch = user.name.toLowerCase().contains(searchQuery.toLowerCase());

                      bool matchesFilter = true;

                      if(activeFilter == "Younger"){
                         matchesFilter = user.age <60;
                      } else if (activeFilter == "Older"){
                         matchesFilter = user.age  >60;
                      }

                      return matchesFilter && matchSearch;


                    },).toList();

                    if (filteredList.isEmpty) {
                      String message = "No users found";
                      if (searchQuery.isNotEmpty) {
                        message = "No search user found!";
                      } else {
                        if (activeFilter == "Younger") {
                          message = "No Younger user available";
                        } else if (activeFilter == "Older") {
                          message = "No Older user available";
                        } else {
                          message = "No users found in the list";
                        }
                      }
                      return Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person_off, size: 50, color: Colors.grey),
                                SizedBox(height: 10),
                                Text(
                                  message,
                                  style: AppTextStyles.subTitle.copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                      );

                    }

                 return   Expanded(
                   child: ListView.separated(itemBuilder: (context, index) {
                     final data = filteredList[index];
                        return Container(
                          padding: EdgeInsetsDirectional.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withAlpha(40),
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(data.image),
                            ),
                            title: Text(data.name,
                              style:AppTextStyles.title,),
                            subtitle: Text("age:${data.age.toString()}",
                              style: AppTextStyles.subTitle,
                            ),
                          ),
                        );
                      },
                        physics: BouncingScrollPhysics(),
                        itemCount: filteredList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 15,);
                        },
                      ),
                 );
                  },
                  error: (error, stackTrace) => ErrorText(error: error.toString()),
                  loading: () => Loader(),)
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
         onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => AddUserScreen(),));
         },
        child: CircleAvatar(
          radius: 40,
          backgroundColor: AppColors.black,
           child: Icon(
               Icons.add,
               size: 38,
               color: AppColors.white,

           ),
        ),
      ),
    );
  }
}
