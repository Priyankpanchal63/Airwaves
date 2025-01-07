abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class PhotoUploadedState extends ProfileState {
  final String photoPath;

  PhotoUploadedState(this.photoPath);
}

class GenderSelectedState extends ProfileState {
  final String gender;

  GenderSelectedState(this.gender);
}

class ProfileSubmissionLoading extends ProfileState {}

class ProfileSubmissionSuccess extends ProfileState {}

class ProfileSubmissionFailure extends ProfileState {
  final String errorMessage;

  ProfileSubmissionFailure(this.errorMessage);
}