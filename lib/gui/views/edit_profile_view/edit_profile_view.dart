import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/app_bar.dart';
import 'package:mr_fix/gui/widgets/activity_indicator.dart';
import 'package:mr_fix/gui/views/edit_profile_view/edit_profile_widgets/form_widget.dart';

import 'edit_profile_controller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final EditProfileController _controller;

  bool _isLoading = true;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    _controller = EditProfileController(context);
    await _controller.init();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Editar perfil"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: _isLoading
            ? const ActivityIndicator()
            : FormEditProfile(controller: _controller),
      ),
    );
  }
}
