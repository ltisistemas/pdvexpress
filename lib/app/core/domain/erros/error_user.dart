class ErrorUser implements Exception {}

class ErrorUserNotFound extends ErrorUser {}

class ErrorUserLoginFailure extends ErrorUser {}

class ErrorUserLoginAndPasswordNotFound extends ErrorUser {}