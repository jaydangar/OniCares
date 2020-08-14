part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  final FirebaseUser user;

  LoginSuccess({@required this.user});

  @override
  List<Object> get props => [this.user];
}

class LoggingIn extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginFailure extends LoginState {
  final String failureMessage;

  LoginFailure({@required this.failureMessage});

  @override
  List<Object> get props => [this.failureMessage];
}
