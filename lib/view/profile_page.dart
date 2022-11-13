import 'package:ecommerce_faza/common/my_colors.dart';
import 'package:ecommerce_faza/common/my_styles.dart';
import 'package:ecommerce_faza/model/user_model.dart';
import 'package:ecommerce_faza/providers/auth_provider.dart';
import 'package:ecommerce_faza/widgets/loading_button.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    TextEditingController emailController =
        TextEditingController(text: user.email);

    TextEditingController nameController =
        TextEditingController(text: user.name);

    TextEditingController usernameController =
        TextEditingController(text: user.username);

    void handleUpdate() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.update(
        name: nameController.text,
        email: emailController.text,
        username: usernameController.text,
      )) {
        // ignore: prefer_const_constructors
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: const Text(
              "Profile berhasil diupdate",
              textAlign: TextAlign.center,
            )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: MyColors.alertColor,
            content: const Text(
              'Gagal update, email atau username sudah digunakan!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget updateButton() {
      return Container(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 12)),
            backgroundColor: MaterialStateProperty.all(MyColors.primaryOrange),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          onPressed: handleUpdate,
          child: Text(
            'Update',
            style: MyStyle.pageTitle.copyWith(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xffF4F2F2),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.white,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          'My Profile',
          style: MyStyle.pageTitle.copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(30),
            child: Column(children: [
              Container(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      'https://ui-avatars.com/api/?background=0D8ABC&color=fff&name=' +
                          user.name!,
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama Lengkap ",
                    style: MyStyle.productCartTitle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      hintText: "Nama Lengkap",
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                      hintStyle: MyStyle.regularText,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Username ",
                    style: MyStyle.productCartTitle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      hintText: "Username",
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                      hintStyle: MyStyle.regularText,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email ",
                    style: MyStyle.productCartTitle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      hintText: "Email",
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                      hintStyle: MyStyle.regularText,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              isLoading ? LoadingButton() : updateButton(),
            ]),
          ),
        ),
      ),
    );
  }
}
