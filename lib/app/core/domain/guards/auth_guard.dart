import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:pdvexpress/app/core/domain/usecases/user_prefs.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/login');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    final useCase = Modular.get<UserPrefsImpl>();

    final response = await useCase.getUser();
    return response.fold(
      (l) => false,
      (r) => true,
    );
  }
}
