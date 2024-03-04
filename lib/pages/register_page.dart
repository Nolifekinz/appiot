import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appiot/blocs/register_bloc.dart';
import 'package:appiot/events/register_event.dart';
import 'package:appiot/repositories/user_repository.dart';
import 'package:appiot/states/register_state.dart';
import 'package:appiot/pages/buttons/register_button.dart';

class RegisterPage extends StatefulWidget {
  final UserRepository _userRepository;

  RegisterPage({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late RegisterBloc _registerBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isValidEmailAndPassword && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng ký')),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => _registerBloc,
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, registerState) {
              if (registerState.isFailure) {
                print('Đăng ký thất bại');
              } else if (registerState.isSubmitting) {
                print('Đang tiến hành đăng ký...');
              } else if (registerState.isSuccess) {
                // Thực hiện các hành động khi đăng ký thành công
              }
              return Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (_) {
                          return registerState.isValidEmail ? null : 'Email không hợp lệ';
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Mật khẩu',
                        ),
                        obscureText: true,
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (_) {
                          return registerState.isValidPassword ? null : 'Mật khẩu không hợp lệ';
                        },
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      RegisterButton(
                        onPressed: () {
                          if (isRegisterButtonEnabled(registerState)) {
                            _registerBloc.add(
                              RegisterEventPressed(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
