// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginController on LoginControllerBase, Store {
  late final _$isLoginPasswordVisibleAtom = Atom(
      name: 'LoginControllerBase.isLoginPasswordVisible', context: context);

  @override
  bool get isLoginPasswordVisible {
    _$isLoginPasswordVisibleAtom.reportRead();
    return super.isLoginPasswordVisible;
  }

  @override
  set isLoginPasswordVisible(bool value) {
    _$isLoginPasswordVisibleAtom
        .reportWrite(value, super.isLoginPasswordVisible, () {
      super.isLoginPasswordVisible = value;
    });
  }

  late final _$isSignupPasswordVisibleAtom = Atom(
      name: 'LoginControllerBase.isSignupPasswordVisible', context: context);

  @override
  bool get isSignupPasswordVisible {
    _$isSignupPasswordVisibleAtom.reportRead();
    return super.isSignupPasswordVisible;
  }

  @override
  set isSignupPasswordVisible(bool value) {
    _$isSignupPasswordVisibleAtom
        .reportWrite(value, super.isSignupPasswordVisible, () {
      super.isSignupPasswordVisible = value;
    });
  }

  @override
  String toString() {
    return '''
isLoginPasswordVisible: ${isLoginPasswordVisible},
isSignupPasswordVisible: ${isSignupPasswordVisible}
    ''';
  }
}
