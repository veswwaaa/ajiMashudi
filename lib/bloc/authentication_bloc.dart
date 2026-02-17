import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ajimashudi/providers/auth_provider.dart';

// --- EVENTS ---
abstract class AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}

class AuthenticationStatusChecked extends AuthenticationEvent {}

// --- STATES ---
abstract class AuthenticationState {}

class Unauthenticated extends AuthenticationState {}

class AuthenticationLoadInProgress extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String message;
  AuthenticationFailure(this.message);
}

class Authenticated extends AuthenticationState {
  final String role;
  final String? name;
  final String? uid;
  Authenticated({required this.role, this.name, this.uid});
}

// 1. Tambahkan parameter di Event
class LoginSubmitted extends AuthenticationEvent {
  final String email;
  final String password;
  LoginSubmitted(this.email, this.password);
}

class GoogleLoginSubmitted extends AuthenticationEvent {}

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(Unauthenticated()) {
    // Triggered saat user klik login
    on<LoggedIn>((event, emit) async {
      emit(AuthenticationLoadInProgress());
      // Kamu bisa memanggil fungsi loginUser(email, password) di sini jika perlu
      emit(Authenticated(role: ''));
    });

    // Triggered saat user klik logout
    on<LoggedOut>((event, emit) async {
      emit(AuthenticationLoadInProgress());
      final result = await logOutUser(); // Memanggil fungsi logOutUser milikmu
      if (result['success']) {
        emit(Unauthenticated());
      }
    });

    // Triggered saat aplikasi baru dibuka (cek session)
    on<AuthenticationStatusChecked>((event, emit) async {
      final session = await checkSession();
      if (session['isAuthenticated'] == true) {
        emit(
          Authenticated(
            role: session['role'] ?? '',
            name: session['name'],
            uid: session['uid'],
          ),
        );
      } else {
        emit(Unauthenticated());
      }
    });

    on<LoginSubmitted>((event, emit) async {
      emit(AuthenticationLoadInProgress()); // Tampilkan loading di UI

      // Panggil fungsi loginUser milikmu
      final result = await loginUser(event.email, event.password);

      if (result != null && result['success'] == true) {
        print("[bloc] Login berhasil! "); // Debug: pastikan login berhasil
        emit(
          Authenticated(
            role: result['role'] ?? '',
            name: result['name'],
            uid: result['uid'],
          ),
        ); // Berhasil! UI akan otomatis pindah halaman
      } else {
        emit(
          AuthenticationFailure(result?['error'] ?? 'Login gagal'),
        ); // Gagal! Tampilkan pesan error
      }
    });

    on<GoogleLoginSubmitted>((event, emit) async {
      emit(AuthenticationLoadInProgress());
      final result = await LoginOauthUser();
      if (result['success'] == true) {
        emit(
          Authenticated(
            role: result['role'] ?? '',
            name: result['name'],
            uid: result['uid'],
          ),
        );
      } else {
        emit(
          AuthenticationFailure(result['error'] ?? 'Login Google gagal'),
        );
      }
    });
  }
}
