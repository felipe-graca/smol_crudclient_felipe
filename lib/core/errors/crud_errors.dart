// ignore_for_file: overridden_fields

class SmolExeption implements Exception {
  final String message;
  SmolExeption([
    this.message =
        'Ocorreu um erro. Por favor, verifique sua conexão e tente novamente.',
  ]);
}

class UpdateUserFailure extends SmolExeption {
  @override
  final String message;

  UpdateUserFailure([
    this.message =
        'Ocorreu um erro. Por favor, verifique sua conexão e tente novamente.',
  ]);

  factory UpdateUserFailure.fromCode(String code) {
    String preFixMessage = '';
    switch (code) {
      case 'nome':
        preFixMessage = 'Nome invalido';
        break;
      case 'email':
        preFixMessage = 'E-mail invalido';
        break;
      case 'telefone':
        preFixMessage = 'Telefone invalido';
        break;
      case 'cpf':
        preFixMessage = 'CPF invalido';
        break;
      case 'data_nascimento':
        preFixMessage = 'Data de nascimento invalida';
        break;
      case 'sexo':
        preFixMessage = 'Sexo invalido';
        break;
      default:
        return UpdateUserFailure();
    }

    return UpdateUserFailure(
      '$preFixMessage. Por favor, verifique os dados e tente novamente.',
    );
  }
}

class DeleteUserFailure extends SmolExeption {
  @override
  final String message;

  DeleteUserFailure([
    this.message =
        'Ocorreu um erro. Por favor, verifique sua conexão e tente novamente.',
  ]);
}

class CreateAccountFailure extends SmolExeption {
  @override
  final String message;

  CreateAccountFailure([
    this.message =
        'Ocorreu um erro. Por favor, verifique sua conexão e tente novamente.',
  ]);

  factory CreateAccountFailure.fromCode(String code) {
    String preFixMessage = '';
    switch (code) {
      case 'nome':
        preFixMessage = 'Nome invalido';
        break;
      case 'email':
        preFixMessage = 'E-mail invalido';
        break;
      case 'telefone':
        preFixMessage = 'Telefone invalido';
        break;
      case 'cpf':
        preFixMessage = 'CPF invalido';
        break;
      case 'data_nascimento':
        preFixMessage = 'Data de nascimento invalida';
        break;
      case 'sexo':
        preFixMessage = 'Sexo invalido';
        break;
      default:
        return CreateAccountFailure();
    }

    return CreateAccountFailure(
      '$preFixMessage. Por favor, verifique os dados e tente novamente.',
    );
  }
}
