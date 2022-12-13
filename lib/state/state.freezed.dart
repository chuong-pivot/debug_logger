// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DebugLoggerState {
  bool get isButtonCollapsed => throw _privateConstructorUsedError;
  bool get isTakingScreenshot => throw _privateConstructorUsedError;
  bool get isHandling => throw _privateConstructorUsedError;
  bool get isEditingImage => throw _privateConstructorUsedError;
  String? get imagePath => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DebugLoggerStateCopyWith<DebugLoggerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DebugLoggerStateCopyWith<$Res> {
  factory $DebugLoggerStateCopyWith(
          DebugLoggerState value, $Res Function(DebugLoggerState) then) =
      _$DebugLoggerStateCopyWithImpl<$Res, DebugLoggerState>;
  @useResult
  $Res call(
      {bool isButtonCollapsed,
      bool isTakingScreenshot,
      bool isHandling,
      bool isEditingImage,
      String? imagePath});
}

/// @nodoc
class _$DebugLoggerStateCopyWithImpl<$Res, $Val extends DebugLoggerState>
    implements $DebugLoggerStateCopyWith<$Res> {
  _$DebugLoggerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isButtonCollapsed = null,
    Object? isTakingScreenshot = null,
    Object? isHandling = null,
    Object? isEditingImage = null,
    Object? imagePath = freezed,
  }) {
    return _then(_value.copyWith(
      isButtonCollapsed: null == isButtonCollapsed
          ? _value.isButtonCollapsed
          : isButtonCollapsed // ignore: cast_nullable_to_non_nullable
              as bool,
      isTakingScreenshot: null == isTakingScreenshot
          ? _value.isTakingScreenshot
          : isTakingScreenshot // ignore: cast_nullable_to_non_nullable
              as bool,
      isHandling: null == isHandling
          ? _value.isHandling
          : isHandling // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditingImage: null == isEditingImage
          ? _value.isEditingImage
          : isEditingImage // ignore: cast_nullable_to_non_nullable
              as bool,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DebugLoggerStateCopyWith<$Res>
    implements $DebugLoggerStateCopyWith<$Res> {
  factory _$$_DebugLoggerStateCopyWith(
          _$_DebugLoggerState value, $Res Function(_$_DebugLoggerState) then) =
      __$$_DebugLoggerStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isButtonCollapsed,
      bool isTakingScreenshot,
      bool isHandling,
      bool isEditingImage,
      String? imagePath});
}

/// @nodoc
class __$$_DebugLoggerStateCopyWithImpl<$Res>
    extends _$DebugLoggerStateCopyWithImpl<$Res, _$_DebugLoggerState>
    implements _$$_DebugLoggerStateCopyWith<$Res> {
  __$$_DebugLoggerStateCopyWithImpl(
      _$_DebugLoggerState _value, $Res Function(_$_DebugLoggerState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isButtonCollapsed = null,
    Object? isTakingScreenshot = null,
    Object? isHandling = null,
    Object? isEditingImage = null,
    Object? imagePath = freezed,
  }) {
    return _then(_$_DebugLoggerState(
      isButtonCollapsed: null == isButtonCollapsed
          ? _value.isButtonCollapsed
          : isButtonCollapsed // ignore: cast_nullable_to_non_nullable
              as bool,
      isTakingScreenshot: null == isTakingScreenshot
          ? _value.isTakingScreenshot
          : isTakingScreenshot // ignore: cast_nullable_to_non_nullable
              as bool,
      isHandling: null == isHandling
          ? _value.isHandling
          : isHandling // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditingImage: null == isEditingImage
          ? _value.isEditingImage
          : isEditingImage // ignore: cast_nullable_to_non_nullable
              as bool,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_DebugLoggerState implements _DebugLoggerState {
  _$_DebugLoggerState(
      {this.isButtonCollapsed = true,
      this.isTakingScreenshot = false,
      this.isHandling = false,
      this.isEditingImage = false,
      this.imagePath});

  @override
  @JsonKey()
  final bool isButtonCollapsed;
  @override
  @JsonKey()
  final bool isTakingScreenshot;
  @override
  @JsonKey()
  final bool isHandling;
  @override
  @JsonKey()
  final bool isEditingImage;
  @override
  final String? imagePath;

  @override
  String toString() {
    return 'DebugLoggerState(isButtonCollapsed: $isButtonCollapsed, isTakingScreenshot: $isTakingScreenshot, isHandling: $isHandling, isEditingImage: $isEditingImage, imagePath: $imagePath)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DebugLoggerState &&
            (identical(other.isButtonCollapsed, isButtonCollapsed) ||
                other.isButtonCollapsed == isButtonCollapsed) &&
            (identical(other.isTakingScreenshot, isTakingScreenshot) ||
                other.isTakingScreenshot == isTakingScreenshot) &&
            (identical(other.isHandling, isHandling) ||
                other.isHandling == isHandling) &&
            (identical(other.isEditingImage, isEditingImage) ||
                other.isEditingImage == isEditingImage) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isButtonCollapsed,
      isTakingScreenshot, isHandling, isEditingImage, imagePath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DebugLoggerStateCopyWith<_$_DebugLoggerState> get copyWith =>
      __$$_DebugLoggerStateCopyWithImpl<_$_DebugLoggerState>(this, _$identity);
}

abstract class _DebugLoggerState implements DebugLoggerState {
  factory _DebugLoggerState(
      {final bool isButtonCollapsed,
      final bool isTakingScreenshot,
      final bool isHandling,
      final bool isEditingImage,
      final String? imagePath}) = _$_DebugLoggerState;

  @override
  bool get isButtonCollapsed;
  @override
  bool get isTakingScreenshot;
  @override
  bool get isHandling;
  @override
  bool get isEditingImage;
  @override
  String? get imagePath;
  @override
  @JsonKey(ignore: true)
  _$$_DebugLoggerStateCopyWith<_$_DebugLoggerState> get copyWith =>
      throw _privateConstructorUsedError;
}
