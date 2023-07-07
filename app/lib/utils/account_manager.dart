import 'package:chupp/routes/card.dart';
import 'package:chupp/services/data_service.dart';
import 'package:chupp/utils/app_manager.dart';
import 'package:chupp/utils/utils/context_extension.dart';
import 'package:chupp/widgets/cards/signout_card.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountManager {
  AccountManager._();

  static bool get isAnonymous {
    if (loggedIn) {
      return DataService.isAnonymous == true;
    }
    return false;
  }

  static bool get loggedIn => DataService.loggedIn;

  static bool get registered => false;

  static bool isOwner(String uid) => ownerUid == uid;

  static String? get ownerUid => DataService.uid;

  // Firebase Auth | Start

  static Future<void> signOut(BuildContext context) async {
    if (isAnonymous) return;
    final bool? result = await Navigator.push<bool>(
      context,
      CardRoute(
        context,
        child: const SignOutCard(),
      ),
    );
    if (result != true) return;
    if (context.mounted) {
      await AppManager.animateAndLoad(context, () => DataService.signOut());
    }
  }

  static Future<bool> emailRegister(
    BuildContext context,
    String email,
    String password,
    String passwordCheck,
  ) async {
    if (email.isEmpty || password.isEmpty || passwordCheck.isEmpty) {
      AppManager.flushBarShow(
        context,
        title: context.lang.current.registerFailTitle,
        message: "Fill the all fields and try again.",
      );
      return false;
    }
    if (password != passwordCheck) {
      AppManager.flushBarShow(
        context,
        title: context.lang.current.registerFailTitle,
        message: "The passwords you entered don't match.",
      );
      return false;
    }
    return await _load(
      context,
      run: () => DataService.emailRegister(email, password),
      errorTitle: context.lang.current.registerFailTitle,
    );
  }

  static Future<bool> emailLogin(
    BuildContext context,
    String email,
    String password,
  ) async {
    if (email.isEmpty || password.isEmpty) {
      AppManager.flushBarShow(
        context,
        title: context.lang.current.loginFailTitle,
        message: "Fill the all fields and try again.",
      );
      return false;
    }
    return await _load(
      context,
      run: () => DataService.emailLogin(email, password),
      errorTitle: context.lang.current.loginFailTitle,
    );
  }

  static Future<bool> signInAnonymously(BuildContext context) => _load(
        context,
        run: () => DataService.signInAnonymously(),
        errorTitle: context.lang.current.loginFailTitle,
      );

  static Future<bool> googleLogin(BuildContext context) => _load(
        context,
        run: () => DataService.googleLogin(),
        errorTitle: context.lang.current.loginFailTitle,
      );

  static Future<bool> appleLogin(BuildContext context) => _load(
        context,
        run: () => DataService.appleLogin(),
        errorTitle: context.lang.current.loginFailTitle,
      );

  // Firebase Auth | End

  static Future<bool> _load(
    context, {
    required Future Function() run,
    required String errorTitle,
  }) async {
    try {
      await AppManager.animateAndLoad(
        context,
        run,
      );
      return true;
    } catch (e) {
      _handleException(context, errorTitle, e);
      return false;
    }
  }

  static void _handleException(BuildContext context, String title, e,
      [String? unknownExceptionMessage]) {
    if (e == FirebaseAuthException) {
      AppManager.flushBarShow(
        context,
        title: title,
        message: (e as FirebaseAuthException).message ??
            unknownExceptionMessage ??
            context.lang.current.unknownException,
      );
    } else if (e.runtimeType == FirebaseFunctionsException) {
      AppManager.flushBarShow(
        context,
        title: title,
        message: (e as FirebaseFunctionsException).message ??
            unknownExceptionMessage ??
            context.lang.current.unknownException,
      );
    } else {
      AppManager.flushBarShow(
        context,
        title: title,
        message:
            unknownExceptionMessage ?? context.lang.current.unknownException,
      );
    }
  }

  static Future<bool> userRegister(
    BuildContext context, {
    required String username,
    required String about,
  }) async {
    if (username.length < 4) {
      AppManager.flushBarShow(
        context,
        title: context.lang.current.registerFailTitle,
        message: "Pick a longer username than 3 characters.",
      );
      return false;
    }
    if (registered) {
      AppManager.flushBarShow(
        context,
        title: context.lang.current.registerFailTitle,
        message: "The user has been registered already.",
      );
      return false;
    }
    if (!loggedIn) {
      AppManager.flushBarShow(
        context,
        title: context.lang.current.registerFailTitle,
        message: "The user isn't logged in.",
      );
      return false;
    }
    return await _load(
      context,
      run: () => DataService.userRegister(
        username,
        about,
      ),
      errorTitle: context.lang.current.registerFailTitle,
    );
  }
}