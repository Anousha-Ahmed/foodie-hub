import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/user_model.dart';
import '../../data/services/auth_service.dart';
import '../profile/profile_controller.dart';

class EditProfileController extends GetxController {
  final _profile = Get.find<ProfileController>();
  final _auth = AuthService();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();
  final countryController = TextEditingController();

  final pickedBytes = Rxn<Uint8List>();
  String? _newPhotoBase64;
  final isLoading = false.obs;

  String get currentPhoto => _profile.user.value?.photoBase64 ?? '';

  @override
  void onInit() {
    super.onInit();
    final u = _profile.user.value;
    if (u != null) {
      nameController.text = u.fullName;
      emailController.text = u.email;
      phoneController.text = u.phone;
      addressController.text = u.address;
      cityController.text = u.city;
      stateController.text = u.state;
      zipController.text = u.zipCode;
      countryController.text = u.country;
    }
  }

  Future<void> pickImage() async {
    final x = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
      maxHeight: 400,
      imageQuality: 60,
    );
    if (x == null) return;
    final bytes = await x.readAsBytes();
    pickedBytes.value = bytes;
    _newPhotoBase64 = base64Encode(bytes);
  }

  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) return;
    final old = _profile.user.value;
    if (old == null) return;

    isLoading.value = true;
    try {
      final updated = UserModel(
        uid: old.uid,
        fullName: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: old.phone, // phone login ki identity hai, change nahi hota
        address: addressController.text.trim(),
        city: cityController.text.trim(),
        state: stateController.text.trim(),
        zipCode: zipController.text.trim(),
        country: countryController.text.trim(),
        photoBase64: _newPhotoBase64 ?? old.photoBase64,
      );
      await _auth.updateUser(updated);
      _profile.user.value = updated;
      Get.back();
      Get.snackbar('Profile updated', 'Your changes have been saved',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Update failed', 'Something went wrong, please try again',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}