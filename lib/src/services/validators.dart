import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email obrigatório';
  }

  if (!email.isEmail) return 'Email inválido';

  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Senha obrigatória';
  }

  if (password.length < 6) {
    return 'Senha deve ter no mínimo 6 caracteres';
  }

  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Nome obrigatório';
  }

  final names = name.split(' ');

  if (names.length == 1) {
    return 'Digite seu nome completo';
  }

  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return 'Celular obrigatório';
  }

  if (phone.length < 14 || !phone.isPhoneNumber) return 'Celular inválido';

  return null;
}

String? cpfValidator(String? cpf) {
  print(cpf);
  if (cpf == null || cpf.isEmpty) {
    return 'CPF obrigatório';
  }

  if (!cpf.isCpf) return 'CPF inválido';

  return null;
}
