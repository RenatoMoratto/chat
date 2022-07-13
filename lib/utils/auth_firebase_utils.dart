class AuthFirebaseUtils {
  static const Map<String, String> errors = {
    'email-already-exists':
        'O e-mail fornecido já está em uso por outro usuário.',
    'internal-error':
        'Ocorreu um erro no servidor. Tente novamente mais tarde.',
    'invalid-display-name': 'O nome de usuário é inválido.',
    'invalid-email': 'O e-mail informado é inválido.',
    'invalid-password':
        'A senha informada é inválida. Deve possuir pelo menos seis caracteres.',
    'invalid-photo-url':
        'A imagem inserida é inválida. Não foi possível salvar.',
    'session-cookie-expired': 'Sessão de usuário expirou.',
    'user-not-found': 'Usuário não encontrado.',
  };

  static String getErrorMessage(String key) {
    return errors[key] ?? 'Ocorreu um erro no processo de authenticação.';
  }
}
