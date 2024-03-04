import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  // Thêm constructor cho LoginState
  const LoginState({
    required this.isValidEmail,
    required this.isValidPassword,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  // Thêm getter cho isValidEmailAndPassword
  bool get isValidEmailAndPassword => isValidEmail && isValidPassword;

  // Tạo các factory method để tạo các trạng thái khác nhau
  factory LoginState.initial() {
    return LoginState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  // Tạo phương thức cloneWith để tạo một bản sao của LoginState với các thuộc tính đã được cập nhật
  LoginState cloneWith({
    bool? isValidEmail,
    bool? isValidPassword,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return LoginState(
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  // Tạo phương thức cloneAndUpdate để tạo một bản sao của LoginState với các thuộc tính đã được cập nhật
  LoginState cloneAndUpdate({
    bool? isValidEmail,
    bool? isValidPassword,
  }) {
    return cloneWith(
      isValidEmail: isValidEmail,
      isValidPassword: isValidPassword,
    );
  }
}
