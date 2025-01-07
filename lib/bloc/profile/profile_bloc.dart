import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:irwaves/bloc/profile/profile_state.dart';

import 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  String? _photoPath;
  String? _selectedGender;
  final ImagePicker _imagePicker = ImagePicker();

  ProfileBloc() : super(ProfileInitial()) {
    on<UploadPhotoEvent>(_onUploadPhoto);
    on<SelectGenderEvent>(_onSelectGender);
    on<SubmitProfileEvent>(_onSubmitProfile);
  }

  void _onUploadPhoto(UploadPhotoEvent event, Emitter<ProfileState> emit) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery, // Or ImageSource.camera
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        _photoPath = pickedFile.path;
        emit(PhotoUploadedState(_photoPath!));
      } else {
        emit(ProfileSubmissionFailure("No photo selected"));
      }
    } catch (e) {
      emit(ProfileSubmissionFailure("Failed to pick photo: ${e.toString()}"));
    }
  }

  void _onSelectGender(SelectGenderEvent event, Emitter<ProfileState> emit) {
    _selectedGender = event.gender;
    emit(GenderSelectedState(event.gender));
  }

  void _onSubmitProfile(SubmitProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileSubmissionLoading());

    // Validate inputs
    if (event.bio.isEmpty) {
      emit(ProfileSubmissionFailure("Bio cannot be empty"));
      return;
    }

    if (event.gender.isEmpty) {
      emit(ProfileSubmissionFailure("Gender must be selected"));
      return;
    }

    if (event.photoPath.isEmpty || !File(event.photoPath).existsSync()) {
      emit(ProfileSubmissionFailure("Photo must be uploaded"));
      return;
    }

    // Simulate profile submission
    await Future.delayed(Duration(seconds: 2)); // Simulate API call

    try {
      emit(ProfileSubmissionSuccess());
    } catch (e) {
      emit(ProfileSubmissionFailure("Failed to submit profile: ${e.toString()}"));
    }
  }
}
