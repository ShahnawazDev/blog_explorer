import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blog_explorer/models/user_model.dart';
import 'package:blog_explorer/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.signInWithEmailAndPassword(
            event.email, event.password);
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(const AuthError('Sign in failed'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.signUpWithEmailAndPassword(
            event.email, event.password);
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(const AuthError('Sign up failed'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AuthCheckRequested>((event, emit) async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        emit(AuthAuthenticated(UserModel(id: user.uid, email: user.email!)));
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<SignOutRequested>((event, emit) async {
      await authRepository.signOut();
      emit(AuthUnauthenticated());
    });
  }
}
