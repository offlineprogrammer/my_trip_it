// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppException {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() profileNotFound,
    required TResult Function() userfetchError,
    required TResult Function() unKnownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? profileNotFound,
    TResult Function()? userfetchError,
    TResult Function()? unKnownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? profileNotFound,
    TResult Function()? userfetchError,
    TResult Function()? unKnownError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileNotFound value) profileNotFound,
    required TResult Function(UserFetchError value) userfetchError,
    required TResult Function(UnKnownError value) unKnownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ProfileNotFound value)? profileNotFound,
    TResult Function(UserFetchError value)? userfetchError,
    TResult Function(UnKnownError value)? unKnownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileNotFound value)? profileNotFound,
    TResult Function(UserFetchError value)? userfetchError,
    TResult Function(UnKnownError value)? unKnownError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppExceptionCopyWith<$Res> {
  factory $AppExceptionCopyWith(
          AppException value, $Res Function(AppException) then) =
      _$AppExceptionCopyWithImpl<$Res>;
}

/// @nodoc
class _$AppExceptionCopyWithImpl<$Res> implements $AppExceptionCopyWith<$Res> {
  _$AppExceptionCopyWithImpl(this._value, this._then);

  final AppException _value;
  // ignore: unused_field
  final $Res Function(AppException) _then;
}

/// @nodoc
abstract class _$$ProfileNotFoundCopyWith<$Res> {
  factory _$$ProfileNotFoundCopyWith(
          _$ProfileNotFound value, $Res Function(_$ProfileNotFound) then) =
      __$$ProfileNotFoundCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProfileNotFoundCopyWithImpl<$Res>
    extends _$AppExceptionCopyWithImpl<$Res>
    implements _$$ProfileNotFoundCopyWith<$Res> {
  __$$ProfileNotFoundCopyWithImpl(
      _$ProfileNotFound _value, $Res Function(_$ProfileNotFound) _then)
      : super(_value, (v) => _then(v as _$ProfileNotFound));

  @override
  _$ProfileNotFound get _value => super._value as _$ProfileNotFound;
}

/// @nodoc

class _$ProfileNotFound implements ProfileNotFound {
  const _$ProfileNotFound();

  @override
  String toString() {
    return 'AppException.profileNotFound()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProfileNotFound);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() profileNotFound,
    required TResult Function() userfetchError,
    required TResult Function() unKnownError,
  }) {
    return profileNotFound();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? profileNotFound,
    TResult Function()? userfetchError,
    TResult Function()? unKnownError,
  }) {
    return profileNotFound?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? profileNotFound,
    TResult Function()? userfetchError,
    TResult Function()? unKnownError,
    required TResult orElse(),
  }) {
    if (profileNotFound != null) {
      return profileNotFound();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileNotFound value) profileNotFound,
    required TResult Function(UserFetchError value) userfetchError,
    required TResult Function(UnKnownError value) unKnownError,
  }) {
    return profileNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ProfileNotFound value)? profileNotFound,
    TResult Function(UserFetchError value)? userfetchError,
    TResult Function(UnKnownError value)? unKnownError,
  }) {
    return profileNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileNotFound value)? profileNotFound,
    TResult Function(UserFetchError value)? userfetchError,
    TResult Function(UnKnownError value)? unKnownError,
    required TResult orElse(),
  }) {
    if (profileNotFound != null) {
      return profileNotFound(this);
    }
    return orElse();
  }
}

abstract class ProfileNotFound implements AppException {
  const factory ProfileNotFound() = _$ProfileNotFound;
}

/// @nodoc
abstract class _$$UserFetchErrorCopyWith<$Res> {
  factory _$$UserFetchErrorCopyWith(
          _$UserFetchError value, $Res Function(_$UserFetchError) then) =
      __$$UserFetchErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserFetchErrorCopyWithImpl<$Res>
    extends _$AppExceptionCopyWithImpl<$Res>
    implements _$$UserFetchErrorCopyWith<$Res> {
  __$$UserFetchErrorCopyWithImpl(
      _$UserFetchError _value, $Res Function(_$UserFetchError) _then)
      : super(_value, (v) => _then(v as _$UserFetchError));

  @override
  _$UserFetchError get _value => super._value as _$UserFetchError;
}

/// @nodoc

class _$UserFetchError implements UserFetchError {
  const _$UserFetchError();

  @override
  String toString() {
    return 'AppException.userfetchError()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserFetchError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() profileNotFound,
    required TResult Function() userfetchError,
    required TResult Function() unKnownError,
  }) {
    return userfetchError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? profileNotFound,
    TResult Function()? userfetchError,
    TResult Function()? unKnownError,
  }) {
    return userfetchError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? profileNotFound,
    TResult Function()? userfetchError,
    TResult Function()? unKnownError,
    required TResult orElse(),
  }) {
    if (userfetchError != null) {
      return userfetchError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileNotFound value) profileNotFound,
    required TResult Function(UserFetchError value) userfetchError,
    required TResult Function(UnKnownError value) unKnownError,
  }) {
    return userfetchError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ProfileNotFound value)? profileNotFound,
    TResult Function(UserFetchError value)? userfetchError,
    TResult Function(UnKnownError value)? unKnownError,
  }) {
    return userfetchError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileNotFound value)? profileNotFound,
    TResult Function(UserFetchError value)? userfetchError,
    TResult Function(UnKnownError value)? unKnownError,
    required TResult orElse(),
  }) {
    if (userfetchError != null) {
      return userfetchError(this);
    }
    return orElse();
  }
}

abstract class UserFetchError implements AppException {
  const factory UserFetchError() = _$UserFetchError;
}

/// @nodoc
abstract class _$$UnKnownErrorCopyWith<$Res> {
  factory _$$UnKnownErrorCopyWith(
          _$UnKnownError value, $Res Function(_$UnKnownError) then) =
      __$$UnKnownErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnKnownErrorCopyWithImpl<$Res>
    extends _$AppExceptionCopyWithImpl<$Res>
    implements _$$UnKnownErrorCopyWith<$Res> {
  __$$UnKnownErrorCopyWithImpl(
      _$UnKnownError _value, $Res Function(_$UnKnownError) _then)
      : super(_value, (v) => _then(v as _$UnKnownError));

  @override
  _$UnKnownError get _value => super._value as _$UnKnownError;
}

/// @nodoc

class _$UnKnownError implements UnKnownError {
  const _$UnKnownError();

  @override
  String toString() {
    return 'AppException.unKnownError()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnKnownError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() profileNotFound,
    required TResult Function() userfetchError,
    required TResult Function() unKnownError,
  }) {
    return unKnownError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? profileNotFound,
    TResult Function()? userfetchError,
    TResult Function()? unKnownError,
  }) {
    return unKnownError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? profileNotFound,
    TResult Function()? userfetchError,
    TResult Function()? unKnownError,
    required TResult orElse(),
  }) {
    if (unKnownError != null) {
      return unKnownError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileNotFound value) profileNotFound,
    required TResult Function(UserFetchError value) userfetchError,
    required TResult Function(UnKnownError value) unKnownError,
  }) {
    return unKnownError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ProfileNotFound value)? profileNotFound,
    TResult Function(UserFetchError value)? userfetchError,
    TResult Function(UnKnownError value)? unKnownError,
  }) {
    return unKnownError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileNotFound value)? profileNotFound,
    TResult Function(UserFetchError value)? userfetchError,
    TResult Function(UnKnownError value)? unKnownError,
    required TResult orElse(),
  }) {
    if (unKnownError != null) {
      return unKnownError(this);
    }
    return orElse();
  }
}

abstract class UnKnownError implements AppException {
  const factory UnKnownError() = _$UnKnownError;
}
