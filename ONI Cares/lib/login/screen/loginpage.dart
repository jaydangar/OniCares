import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onicares/login/bloc/login_bloc.dart';
import 'package:onicares/login/loginoption.dart';
import 'package:onicares/utils/routes.dart';
import 'package:onicares/utils/utils.dart';
import 'package:onicares/widgets/widgets.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(seconds: 3),
        value: 1,
        lowerBound: 0,
        upperBound: 1,
        vsync: this);
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryUtils _mediaQueryUtils = MediaQueryUtils(context);
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.of(context).pushReplacementNamed(Routing.HomePageRoute,
                  arguments: state.user);
            } else if (state is LoginFailure) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(state.failureMessage)));
            }
          },
          listenWhen: (previous, current) => previous != current,
          child: Column(
            children: [
              Container(
                height: _mediaQueryUtils.height * 0.3,
              ),
              Container(
                height: _mediaQueryUtils.height * 0.6,
                alignment: Alignment.topCenter,
                child: InkWell(
                  onTap: () => animate(),
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white30,
                        clipBehavior: Clip.antiAlias,
                        shape: CircleBorder(),
                        elevation: 4,
                        shadowColor: Colors.purple,
                        child: ScaleTransition(
                          scale: _animation,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('asset/icons/app_icon.webp'),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        alignment: Alignment.center,
                        child: Text(
                          'Lets get started with Sign in...',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .fontSize),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Builder(
                  builder: (context) => LoginButton(
                    mediaQueryUtils: _mediaQueryUtils,
                    imagePath: 'asset/icons/google.png',
                    labelText: 'Login with Google',
                    onPressedAction: () => BlocProvider.of<LoginBloc>(context)
                        .add(LoginInitiated(logInOption: LogInOption.Google)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animate() {
    _animationController.forward(from: 0.9);
  }
}
