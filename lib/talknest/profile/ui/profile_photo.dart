import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_complete/utils/commont_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show FilteringTextInputFormatter, LengthLimitingTextInputFormatter;

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/common_button.dart';
import '../controller/profile_con.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({super.key});

  final _formKey = GlobalKey<FormState>();

  final con = Get.put<ProfileController>(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(100),
                              elevation: 10,
                              child: Container(
                                height: 95,
                                width: 95,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: con.image.value != null
                                      ? Image.file(con.image.value!,
                                          fit: BoxFit.cover)
                                      : (con.profileUrl.isNotEmpty)
                                          ? CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: con.profileUrl.value,
                                            )
                                          : const Icon(Icons.person),
                                ),
                              ),
                            ),
                            Positioned(
                              right: -5,
                              bottom: 10,
                              child: GestureDetector(
                                onTap: () => showModalBottomSheet(
                                  context: context,
                                  builder: (_) =>
                                      _buildImagePickerSheet(context),
                                ),
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 5,
                                            spreadRadius: 2,
                                            offset: const Offset(4, 4)),
                                      ],
                                    ),
                                    child: Icon(Icons.edit)),
                              ),
                            ),
                          ],
                        ),
                        Text("Update Your Profile"),
                        buildSection(
                          title: "Personal Details",
                          children: [
                            CommonTextField(
                              con: con.nameCon,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z ]')),
                              ],
                              labelText: "User Name",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Name';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        SafeArea(
                          bottom: true,
                          top: false,
                          child: CommonButton(
                            buttonBorderColor: Colors.grey,
                            label: "Update",
                            labelColor: Colors.blue,
                            load: con.upload.value,
                            buttonColor: Colors.white,
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                con.updateProfile();

                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildImagePickerSheet(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              con.pickImage(ImageSource.camera);
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Gallery'),
            onTap: () {
              con.pickImage(ImageSource.gallery);
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
