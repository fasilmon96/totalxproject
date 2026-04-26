import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totalxproject/core/constants/color_constants.dart';
import 'package:totalxproject/core/constants/text_constants.dart';
import 'package:totalxproject/core/providers/providers.dart';

class FilterDialog extends ConsumerStatefulWidget {
  const FilterDialog({super.key});

  @override
  ConsumerState createState() => _FilterDialogState();
}

class _FilterDialogState extends ConsumerState<FilterDialog> {
  @override
  Widget build(BuildContext context ) {
    final draftFilter = ref.watch(draftFilterProvider);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)),
      backgroundColor: AppColors.white,
      title: Text("Sort By",style: AppTextStyles.title,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFilterOption(ref, "All", "all" , draftFilter),
          _buildFilterOption(ref,"Age: Above60", "Older" ,draftFilter),
          _buildFilterOption(ref,"Age: Below60", "Younger" ,draftFilter)
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel",style: AppTextStyles.subTitle,)
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentBlue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () {
            ref.read(filterProvider.notifier).state = draftFilter;
           Navigator.pop(context);
          },
          child: const Text("Apply", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}


 Widget _buildFilterOption(WidgetRef ref ,String title , String value , String groupValue) {
   return RadioListTile<String>(
       title: Text(title,
         style: AppTextStyles.subTitle.copyWith(
           fontWeight: FontWeight.w500
         )
       ),
       value: value,
       groupValue: groupValue,
       activeColor: AppColors.accentBlue,
       contentPadding: EdgeInsets.zero,
       onChanged: (String? newValue) {
          if(newValue != null){
            ref.read(draftFilterProvider.notifier).state = newValue;
          }
       },
   );
 }
