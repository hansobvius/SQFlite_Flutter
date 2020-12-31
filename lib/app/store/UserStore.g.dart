// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  final _$mUserAtom = Atom(name: '_UserStore.mUser');

  @override
  ObservableList<User> get mUser {
    _$mUserAtom.reportRead();
    return super.mUser;
  }

  @override
  set mUser(ObservableList<User> value) {
    _$mUserAtom.reportWrite(value, super.mUser, () {
      super.mUser = value;
    });
  }

  final _$queryUserAsyncAction = AsyncAction('_UserStore.queryUser');

  @override
  Future<dynamic> queryUser() {
    return _$queryUserAsyncAction.run(() => super.queryUser());
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  void insertUser(String name, String genre, int value) {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.insertUser');
    try {
      return super.insertUser(name, genre, value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteUser() {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.deleteUser');
    try {
      return super.deleteUser();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mUser: ${mUser}
    ''';
  }
}
