import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/user/create_user_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/user/sign_in_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/user/sign_up_usecase.dart';

part 'credential_state.dart';
class CredentialCubit extends Cubit<CredentialState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final CreateUserUseCase createUserUseCase;

  CredentialCubit(
      {
        required this.signUpUseCase,
        required this.signInUseCase,
        required this.createUserUseCase})
      : super(CredentialInitial());


  Future<void> signInSubmit({
    required String email,
    required String password,
  }) async {
    emit(CredentialLoading());
    try {
      await signInUseCase.call(UserEntity(email: email, password: password));
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }


  Future<void> signUpSubmit({required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      await signUpUseCase
          .call(UserEntity(email: user.email, password: user.password));
      await createUserUseCase.call(user);
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

}