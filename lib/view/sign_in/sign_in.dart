import 'package:ecommerce_faza/common/my_colors.dart';
import 'package:ecommerce_faza/common/my_styles.dart';
import 'package:ecommerce_faza/providers/auth_provider.dart';
import 'package:ecommerce_faza/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isLoading = false;
  TextEditingController usernameController = TextEditingController(text: '');

  TextEditingController passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    void handleSignIn() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.login(
          username: usernameController.text,
          password: passwordController.text)) {
        Navigator.pushNamed(context, "/dashboard");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: MyColors.alertColor,
            content: const Text(
              'Gagal Login!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget signInButton() {
      return ElevatedButton(
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
        onPressed: handleSignIn,
        child: Text(
          'Sign In',
          style: MyStyle.pageTitle.copyWith(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/logo/main-logo.png'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sign In", style: MyStyle.pageTitle),
                ],
              ),
              const SizedBox(height: 44),
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
              const SizedBox(height: 32),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  prefixIcon: const Icon(Icons.lock_outline),
                  hintText: "Password",
                  hintStyle: MyStyle.regularText,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text("Forgot Password?", style: MyStyle.regularText),
                  ),
                ],
              ),
              isLoading ? LoadingButton() : signInButton(),
              const SizedBox(height: 11),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ", style: MyStyle.regularText),
                  InkWell(
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/sign-up');
                    },
                    child: Text("Sign Up",
                        style: MyStyle.regularText
                            .copyWith(color: MyColors.primaryOrange)),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    onPressed: null,
                    icon: Image.asset('assets/images/icons/twitter.png'),
                  ),
                  IconButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    onPressed: null,
                    icon: Image.asset('assets/images/icons/google.png'),
                  ),
                  IconButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    onPressed: null,
                    icon: Image.asset('assets/images/icons/facebook.png'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
