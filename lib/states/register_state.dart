import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  // Thêm constructor cho RegisterState
  RegisterState({
    required this.isValidEmail,
    required this.isValidPassword,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  // Thêm getter cho isValidEmailAndPassword
  bool get isValidEmailAndPassword => isValidEmail && isValidPassword;

  // Tạo các factory method để tạo các trạng thái khác nhau
  factory RegisterState.initial() {
    return RegisterState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  // Tạo phương thức cloneAndUpdate để tạo một bản sao của RegisterState với các thuộc tính đã được cập nhật
  RegisterState cloneAndUpdate({
    bool? isValidEmail,
    bool? isValidPassword,
  }) {
    return copyWith(
      isValidEmail: isValidEmail,
      isValidPassword: isValidPassword,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  // Tạo phương thức copyWith để tạo một bản sao của RegisterState với các thuộc tính đã được cập nhật
  RegisterState copyWith({
    bool? isValidEmail,
    bool? isValidPassword,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return RegisterState(
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isValidEmail: $isValidEmail,
      isValidPassword: $isValidPassword,      
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
