import 'package:firebase_auth/firebase_auth.dart';
import 'package:pdvexpress/app/core/domain/entities/user_logged.dart';

class UserLoggedModel extends UserLogged {
  UserLoggedModel(
    String? uuid,
    String? token,
    String? name,
    String? email,
    String? avatarUrl,
  ) : super(uuid, token, name, email, avatarUrl);

  factory UserLoggedModel.fromJson(Map json) {
    return UserLoggedModel(
      json['user']['id'],
      json['token'],
      json['user']['name'],
      json['user']['email'],
      json['user']['avatarUrl'],
    );
  }

  factory UserLoggedModel.fromUserCredential(UserCredential value) {
    final uuid = value.user!.uid;
    final token = uuid;
    final name = value.user!.displayName;
    final email = value.user!.email;
    final avatarUrl = value.user!.photoURL;

    print('----> Avatar URL');
    print(avatarUrl);

    return UserLoggedModel(
      uuid,
      token,
      name,
      email,
      avatarUrl,
    );
  }

  factory UserLoggedModel.fromPref(Map json) {
    return UserLoggedModel(
      json['id'],
      json['token'],
      json['name'],
      json['email'],
      json['avatarUrl']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = uuid;
    data['name'] = name;
    data['email'] = email;
    data['token'] = token;
    return data;
  }
}
