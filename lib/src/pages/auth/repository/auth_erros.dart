
String authErrorsString(String? code) {
  switch(code) {
    case 'INVALID_CREDENTIALS':
      return 'Email e/ou senha inválidos';

    case 'Invalid session token':
      return 'Token inválida';

    case 'INVALID_FULLNAME':
      return 'Nome inválido';

    case 'INVALID_PHONE':
      return 'Celular inválido';

    case 'INVALID_CPF':
      return 'CPF inválido';

    case 'Account already exists for this username.':
      return 'Email já cadastrado. Utilize um email diferente';

    default:
      return 'Não foi possível completar a operação';
  }
}