import '../../Bloc/Profile Page/bloc/profile_bloc.dart';
import '../../Bloc/Profile Page/bloc/profile_event.dart';
import '../../Bloc/Profile Page/bloc/profile_state.dart';
import '../../../Models/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  final String username; // Pass the username from the previous page

  const ProfilePage({super.key, required this.username});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileBloc _profileBloc;
  bool _isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(LoadProfile(widget.username));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: _profileBloc,
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileError) {
          return Center(child: Text(state.message));
        } else if (state is ProfileLoaded) {
          final profile = state.profile;

          if (_isEditing) {
            _nameController.text = profile.name;
            _usernameController.text = profile.username;
            _bioController.text = profile.bio ?? '';
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      // backgroundImage: NetworkImage(profile.profilePictureUrl ?? 'https://via.placeholder.com/150'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _bioController,
                    decoration: const InputDecoration(labelText: 'Bio'),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          final updatedProfile = UserProfile(
                            name: _nameController.text,
                            username: _usernameController.text,
                            bio: _bioController.text,
                          );
                          _profileBloc.add(UpdateProfile(profile.username, updatedProfile));
                        },
                        child: const Text('Save'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isEditing = false;
                          });
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      // backgroundImage: NetworkImage(profile.profilePictureUrl ?? 'https://via.placeholder.com/150'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Name: ${profile.name}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Username: ${profile.username}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Bio: ${profile.bio ?? 'No bio'}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            );
          }
        } else {
          return const Center(child: Text('Unexpected State'));
        }
      },
    );
  }
}
