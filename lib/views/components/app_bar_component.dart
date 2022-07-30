import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_app/views/theme/app_colors.dart';
import 'package:rick_and_morty_app/views/theme/app_images.dart';
import 'package:rick_and_morty_app/views/theme/app_text_style.dart';

PreferredSizeWidget appBarComponent(BuildContext context,
    {bool displayLead = false,
    bool displaySearch = false,
    void Function(String)? onFilter}) {
  Widget? leadWdg = displayLead ? const BackButton(color: Colors.white) : null;
  Widget titleWgd = getWdgTitle(displaySearch, onFilter);

  return AppBar(
    toolbarHeight: kToolbarHeight * 2.2,
    backgroundColor: AppColors.appBarColor,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    leading: leadWdg,
    title: titleWgd,
    flexibleSpace: SafeArea(
        child: Column(
      children: [
        Image.asset(AppImages.logo),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            'RICK AND MORTY',
            style: GoogleFonts.shadowsIntoLight(
              textStyle: AppTextStyle.styleAppBar,
            ),
          ),
        ),
      ],
    )),
  );
}

Widget getWdgTitle(bool displaySearch, void Function(String)? onFilter) {
  if (displaySearch) {
    var delgFilter = onFilter != null ? onFilter : () {};
    return TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            labelText: 'Search a character...',
            prefixIcon: const Icon(Icons.search),
            fillColor: AppColors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            )),
        onChanged: (text) => delgFilter(text));
  } else {
    return Text('');
  }
}
