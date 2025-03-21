import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsmine/profile/controllers/profile_controller.dart';
import 'package:itsmine/profile/models/city.dart';
import 'package:itsmine/profile/models/zone.dart';
import 'package:itsmine/widgets/custom_body_title.dart';
import 'package:itsmine/widgets/custom_button.dart';
import 'package:itsmine/widgets/custom_drop_down.dart';
import 'package:itsmine/widgets/custom_header.dart';
import 'package:itsmine/widgets/custom_text.dart';
import 'package:itsmine/widgets/custom_text_field.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _profileController = Get.put(ProfileController());
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _districtController = TextEditingController();
  Zone? zone;
  City? city;

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _districtController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomHeader(title: 'addNewAddress'.tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomBodyTitle(
              title: 'addNewAddress'.tr,
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'firstName'.tr,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              const SizedBox(
                                height: 9,
                              ),
                              CustomTextField(
                                controller: _firstNameController,
                                hintText: 'firstName'.tr,
                                textInputType: TextInputType.name,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'lastName'.tr,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              const SizedBox(
                                height: 9,
                              ),
                              CustomTextField(
                                controller: _lastNameController,
                                hintText: 'lastName'.tr,
                                textInputType: TextInputType.name,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    CustomText(
                      text: 'country'.tr,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomDropDown(
                      value: _profileController.countries.first,
                      hintText: 'country'.tr,
                      items: _profileController.countries,
                      enabled: false,
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    CustomText(
                      text: 'zone'.tr,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomDropDown(
                        value: zone,
                        hintText: 'zone'.tr,
                        items: _profileController.zones,
                        onChanged: (value) {
                          zone = value;
                          _profileController.getCitiesByZoneId(
                              zoneId: zone!.zoneId);
                        }),
                    const SizedBox(
                      height: 26,
                    ),
                    CustomText(
                      text: 'city'.tr,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(() {
                      if (_profileController.isCitiesLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return CustomDropDown(
                          value: city,
                          hintText: 'city'.tr,
                          items: _profileController.cities,
                          onChanged: (value) {
                            city = value;
                          });
                    }),
                    const SizedBox(
                      height: 26,
                    ),
                    CustomText(
                      text: 'district'.tr,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    CustomTextField(
                      controller: _districtController,
                      hintText: 'district'.tr,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Obx(() {
                      if (_profileController.isAddingAddress.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return CustomButton(
                        radius: 4,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final isSuccess =
                                await _profileController.addAddress(
                              context: context,
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              city: city!.name,
                              address: _districtController.text,
                              countryId: 184,
                              zoneId: int.parse(zone!.zoneId),
                            );
                            if (isSuccess) {
                              Get.back();
                            }
                          }
                        },
                        title: 'save'.tr,
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 27,
            ),
          ],
        ),
      ),
    );
  }
}
