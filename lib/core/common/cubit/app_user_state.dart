part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

class AppUserInitial extends AppUserState {}

///  core can not depend on other features
///  other features can depend on core
///  so entities moved from domain to core
class AppUserLoggedIn extends AppUserState {
  final User user;
  AppUserLoggedIn(this.user);
}