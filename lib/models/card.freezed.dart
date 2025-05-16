// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CardModel {

 String get title; DateTime? get startDate; bool? get isActive; String? get hostId;
/// Create a copy of CardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardModelCopyWith<CardModel> get copyWith => _$CardModelCopyWithImpl<CardModel>(this as CardModel, _$identity);

  /// Serializes this CardModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardModel&&(identical(other.title, title) || other.title == title)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.hostId, hostId) || other.hostId == hostId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,startDate,isActive,hostId);

@override
String toString() {
  return 'CardModel(title: $title, startDate: $startDate, isActive: $isActive, hostId: $hostId)';
}


}

/// @nodoc
abstract mixin class $CardModelCopyWith<$Res>  {
  factory $CardModelCopyWith(CardModel value, $Res Function(CardModel) _then) = _$CardModelCopyWithImpl;
@useResult
$Res call({
 String title, DateTime? startDate, bool? isActive, String? hostId
});




}
/// @nodoc
class _$CardModelCopyWithImpl<$Res>
    implements $CardModelCopyWith<$Res> {
  _$CardModelCopyWithImpl(this._self, this._then);

  final CardModel _self;
  final $Res Function(CardModel) _then;

/// Create a copy of CardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? startDate = freezed,Object? isActive = freezed,Object? hostId = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,hostId: freezed == hostId ? _self.hostId : hostId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CardModel implements CardModel {
  const _CardModel({required this.title, this.startDate, this.isActive, this.hostId});
  factory _CardModel.fromJson(Map<String, dynamic> json) => _$CardModelFromJson(json);

@override final  String title;
@override final  DateTime? startDate;
@override final  bool? isActive;
@override final  String? hostId;

/// Create a copy of CardModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardModelCopyWith<_CardModel> get copyWith => __$CardModelCopyWithImpl<_CardModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CardModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardModel&&(identical(other.title, title) || other.title == title)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.hostId, hostId) || other.hostId == hostId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,startDate,isActive,hostId);

@override
String toString() {
  return 'CardModel(title: $title, startDate: $startDate, isActive: $isActive, hostId: $hostId)';
}


}

/// @nodoc
abstract mixin class _$CardModelCopyWith<$Res> implements $CardModelCopyWith<$Res> {
  factory _$CardModelCopyWith(_CardModel value, $Res Function(_CardModel) _then) = __$CardModelCopyWithImpl;
@override @useResult
$Res call({
 String title, DateTime? startDate, bool? isActive, String? hostId
});




}
/// @nodoc
class __$CardModelCopyWithImpl<$Res>
    implements _$CardModelCopyWith<$Res> {
  __$CardModelCopyWithImpl(this._self, this._then);

  final _CardModel _self;
  final $Res Function(_CardModel) _then;

/// Create a copy of CardModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? startDate = freezed,Object? isActive = freezed,Object? hostId = freezed,}) {
  return _then(_CardModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,hostId: freezed == hostId ? _self.hostId : hostId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
