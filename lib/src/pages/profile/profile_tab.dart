import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/commom_widgets/custom_text_field.dart';
import "package:greengrocer/src/config/app_data.dart" as appData;

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

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
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          CustomTextField(
            icon: Icons.email,
            label: "Email",
            initialValue: appData.user.email,
            readOnly: true,
          ),
          CustomTextField(
            icon: Icons.person,
            label: "Nome",
            initialValue: appData.user.name,
            readOnly: true,
          ),
          CustomTextField(
            icon: Icons.phone,
            label: "Celular",
            initialValue: appData.user.phone,
            readOnly: true,
          ),
          CustomTextField(
            icon: Icons.copy,
            label: "CPF",
            isScret: true,
            initialValue: appData.user.cpf,
            readOnly: true,
          ),
          SizedBox(
              height: 50,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.green,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onPressed: () {
                    updatePassword();
                  },
                  child: const Text('Atualizar senha')))
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: Text('Atualização de senha',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        const CustomTextField(
                          icon: Icons.lock,
                          label: 'Senha atual',
                          isScret: true,
                        ),
                        const CustomTextField(
                          icon: Icons.lock_outline,
                          label: 'Nova senha',
                          isScret: true,
                        ),
                        const CustomTextField(
                          icon: Icons.lock_outline,
                          label: 'Confirmar nova senha',
                          isScret: true,
                        ),
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                            onPressed: () {},
                            child: const Text('Atualizar'),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close)))
                ],
              ));
        });
  }
}
