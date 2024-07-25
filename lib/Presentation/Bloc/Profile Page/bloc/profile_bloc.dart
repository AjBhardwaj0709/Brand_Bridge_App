// bloc/profile_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Services/profile_services.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileService _profileService = ProfileService();

  ProfileBloc({required ProfileService profileservice}) : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LoadProfile) {
      yield ProfileLoading();
      try {
        final profile = await _profileService.getUserProfile(event.username);
        if (profile != null) {
          yield ProfileLoaded(profile);
        } else {
          yield ProfileError('Profile not found');
        }
      } catch (e) {
        yield ProfileError('Error: $e');
      }
    } else if (event is UpdateProfile) {
      yield ProfileLoading();
      try {
        await _profileService.updateUserProfile(event.username, event.profile);
        yield ProfileUpdated(event.profile);
      } catch (e) {
        yield ProfileError('Error:$e');
      }
    }
  }
}
