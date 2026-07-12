import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  static final supabase = Supabase.instance.client;

  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    return await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        "full_name": fullName,
      },
    );
  }

  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  static Future<void> resetPassword(
      String email,
      ) async {
    await supabase.auth.resetPasswordForEmail(
      email,
    );
  }

  static User? get currentUser =>
      supabase.auth.currentUser;
}