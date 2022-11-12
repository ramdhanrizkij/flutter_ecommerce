import 'package:ecommerce_faza/common/my_colors.dart';
import 'package:ecommerce_faza/common/my_styles.dart';
import 'package:flutter/material.dart';
import '../theme.dart';

class LoadingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53,
      width: double.infinity,
      // margin: EdgeInsets.only(top: 30),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: MyColors.primaryOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(
                  MyColors.white,
                ),
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              'Loading',
              style: MyStyle.pageTitle.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
