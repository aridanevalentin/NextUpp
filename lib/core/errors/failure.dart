abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Error de conexión con el servidor']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Error al cargar datos locales']);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Ha ocurrido un error inesperado']);
}
