import 'package:ecommerce_faza/common/my_colors.dart';
import 'package:ecommerce_faza/common/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 78, left: 32, right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Reset password", style: MyStyle.pageTitle),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'An email with the reset link will be',
                  style: MyStyle.regularText,
                ),
              ],
            ),
            const SizedBox(height: 90),
            TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                hintText: "E-mail",
                prefixIcon: const Icon(Icons.person_outline_rounded),
                hintStyle: MyStyle.regularText,
              ),
            ),
            const SizedBox(height: 37),
            ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 45),
                ),
                backgroundColor:
                    MaterialStateProperty.all(MyColors.primaryOrange),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: null,
              child: Text(
                'Reset',
                style: MyStyle.pageTitle.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
