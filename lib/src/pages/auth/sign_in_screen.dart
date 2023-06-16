import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_world/src/pages/auth/controller/auth_controller.dart';
import 'package:hello_world/src/pages/commom_widgets/app_name_widget.dart';
import 'package:hello_world/src/pages/commom_widgets/custom_text_field.dart';
import 'package:hello_world/src/config/custom_colors.dart';
import 'package:hello_world/src/pages_routes/app_pages.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // APP NAME
                  const AppNameWidget(
                    greenTitleColor: Colors.white,
                    textSize: 40,
                  ),

                  // CATEGORY
                  SizedBox(
                    height: 30,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                      child: AnimatedTextKit(
                          pause: Duration.zero,
                          repeatForever: true,
                          animatedTexts: [
                            FadeAnimatedText('Frutas'),
                            FadeAnimatedText('Verduras'),
                            FadeAnimatedText('Legumes'),
                          ]),
                    ),
                  )
                ],
              ),
            ),

            // FORM
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 40,
              ),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(45))),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // EMAIL
                    CustomTextField(
                      controler: emailController,
                      icon: Icons.email,
                      label: 'Email',
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Email obrigatório';
                        }

                        if (!email.isEmail) return 'Email inválido';

                        return null;
                      },
                    ),

                    // SENHA
                    CustomTextField(
                      controler: passwordController,
                      icon: Icons.lock,
                      label: 'Senha',
                      isSecret: true,
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return 'Email obrigatório';
                        }
                        if (password.length < 6) {
                          return 'Digite uma senha com pelo menos 6 caracteres';
                        }
                        return null;
                      },
                    ),

                    // ENTER
                    SizedBox(
                      height: 50,
                      child: GetX<AuthController>(
                        builder: (authController) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18))),
                            onPressed: authController.isLoading.value ? null : () {

                              FocusScope.of(context).unfocus();

                              if (_formKey.currentState!.validate()) {
                                String email = emailController.text;
                                String password = passwordController.text;
                                authController.signIn(email: email, password: password);
                              }
                            },
                            child: authController.isLoading.value
                            ? const CircularProgressIndicator()
                            : const Text(
                              'Entrar',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // FORGOT PASSWORD?
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Esqueceu a senha?',
                          style: TextStyle(
                              color: CustomColors.customContrastColor),
                        ),
                      ),
                    ),

                    // OR
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.withAlpha(90),
                              thickness: 2,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text('Ou'),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey.withAlpha(90),
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // NEW ACCOUNT
                    SizedBox(
                      height: 50,
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              side: const BorderSide(
                                width: 2,
                                color: Colors.green,
                              )),
                          onPressed: () => Get.toNamed(PagesRoutes.signUpRoute),
                          child: const Text(
                            'Criar conta',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
