import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/validators.dart';
import '../auth/controller/auth_controller.dart';
import '../commom_widgets/custom_text_field.dart';


class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do usuário'),
        actions: [
          IconButton(
              onPressed: () {
                authController.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          // Email
          CustomTextField(
              readOnly: true,
              initialValue: authController.user.email,
              icon: Icons.email,
              label: 'Email'),

          // Nome
          CustomTextField(
              readOnly: true,
              initialValue: authController.user.name,
              icon: Icons.person,
              label: 'Nome'),

          // Celular
          CustomTextField(
              readOnly: true,
              initialValue: authController.user.phone,
              icon: Icons.phone,
              label: 'Celular'),

          // CPF
          CustomTextField(
            readOnly: true,
            initialValue: authController.user.cpf,
            icon: Icons.file_copy,
            label: 'CPF',
            isSecret: true,
          ),

          // Botão
          SizedBox(
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {
                  updatePassword();
                },
                child: const Text('Atualizar senha'),
              ))
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    final newPasswordController = TextEditingController();
    final currentPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // titulo
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text('Atualização de senha',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )),
                        ),

                        // senhas
                        CustomTextField(
                          controller: currentPasswordController,
                          isSecret: true,
                          icon: Icons.lock,
                          label: 'Senha atual',
                          validator: passwordValidator,
                        ),
                        CustomTextField(
                          controller: newPasswordController,
                          isSecret: true,
                          icon: Icons.lock_outline,
                          label: 'Nova senha',
                          validator: passwordValidator,
                        ),
                        CustomTextField(
                          isSecret: true,
                          icon: Icons.lock_outline,
                          label: 'Confirmar nova senha',
                          validator: (password) {
                            final result = passwordValidator(password);
                            if (result != null) return result;
                            if (password != newPasswordController.text) {
                              return 'As senhas não conferem';
                            }
                            return null;
                          },
                        ),

                        // Botao Confirmação
                        SizedBox(
                          height: 45,
                          child: Obx(() => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        authController.changePassword(
                                          currentPassword: currentPasswordController.text,
                                          newPassword: newPasswordController.text,
                                        );
                                      }
                                    },
                              child: authController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Text('Atualizar'))),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 5,
                    right: 5,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                    ))
              ],
            ),
          );
        });
  }
}
