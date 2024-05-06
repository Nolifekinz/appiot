import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appiot/blocs/login_bloc.dart';
import 'package:appiot/events/login_event.dart';
import 'package:appiot/pages/buttons/google_login_button.dart';
import 'package:appiot/pages/buttons/login_button.dart';
import 'package:appiot/pages/buttons/register_user_button.dart';
import 'package:appiot/repositories/user_repository.dart';
import 'package:appiot/states/login_state.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  final UserRepository _userRepository;

  LoginPage({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool isLoginButtonEnabled(LoginState loginState) =>
      loginState.isValidEmailAndPassword &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      !loginState.isSubmitting;

  void _onEmailChanged() {
    _loginBloc.add(LoginEventEmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc
        .add(LoginEventPasswordChanged(password: _passwordController.text));
  }

  void _onLoginEmailAndPassword() {
    if (isLoginButtonEnabled(_loginBloc.state)) {
      _loginBloc.add(LoginEventWithEmailAndPasswordPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, loginState) {
          if (loginState.isFailure) {
            print('Login failed');
          } else if (loginState.isSubmitting) {
            print('Logging in');
          } else if (loginState.isSuccess) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => MyHomePage()));
          }
        },
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Căn giữa theo chiều dọc
              children: <Widget>[
                Image.asset('assets/images/Logo.jpg', width: 100, height: 100),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Nhập email của bạn',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (_) {
                    return _loginBloc.state.isValidEmail
                        ? null
                        : 'Định dạng email không hợp lệ';
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Nhập mật khẩu',
                  ),
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (_) {
                    return _loginBloc.state.isValidPassword
                        ? null
                        : 'Mật khẩu phải chứa ít nhất 6 ký tự';
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: LoginButton(
                                onPressed: () => _onLoginEmailAndPassword(),
                              ),
                            ),
                            SizedBox(width: 10), // Khoảng cách giữa hai nút
                            Expanded(
                              child: RegisterUserButton(
                                userRepository: widget._userRepository,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      GoogleLoginButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
