part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {}

class LoginInitiated extends LoginEvent {
  final LogInOption logInOption;

  LoginInitiated({@required this.logInOption});

  @override
  List<Object> get props => [this.logInOption];
}
