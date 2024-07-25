// bloc/profile_event.dart
import '../../../../Models/user_profile_model.dart';

abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {
  final String username;

  LoadProfile(this.username);
}

class UpdateProfile extends ProfileEvent {
  final String username;
  final UserProfile profile;

  UpdateProfile(this.username, this.profile);
}
