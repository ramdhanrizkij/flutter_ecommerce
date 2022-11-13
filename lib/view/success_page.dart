import 'package:ecommerce_faza/common/my_colors.dart';
import 'package:ecommerce_faza/common/my_styles.dart';
import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/icons/success.png",
                  width: 300,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Pemesanan berhasil dilakukan",
                  style: MyStyle.sectionTitle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                    child: Text(
                  "Mohon tunggu admin akan menghubungi anda",
                  style: MyStyle.sectionTitle.copyWith(fontSize: 14),
                )),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/dashboard', (Route<dynamic> route) => false);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: MyColors.primaryOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Belanja Lagi',
                      style: MyStyle.pageTitle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
