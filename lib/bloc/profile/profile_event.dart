import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class ProfileEvent {}

class UploadPhotoEvent extends ProfileEvent {}

class SelectGenderEvent extends ProfileEvent {
  final String gender;

  SelectGenderEvent(this.gender);
}

class SubmitProfileEvent extends ProfileEvent {
  final String bio;
  final String gender;
  final String photoPath;

  SubmitProfileEvent({
    required this.bio,
    required this.gender,
    required this.photoPath,
  });
}