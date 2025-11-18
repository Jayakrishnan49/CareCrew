import 'package:flutter/material.dart';
import 'package:project_2/controllers/booking_provider/booking_request_provider.dart';
import 'package:project_2/widgets/custom_text_form_field.dart';

class AddressField extends StatelessWidget {
  final BookingRequestProvider bookingProvider;

  const AddressField({super.key, required this.bookingProvider});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: bookingProvider.addressController,
      hintText: 'Enter service location address',
      labelText: null,
      prefixIcon: Icons.location_on_outlined,
      maxLines: 3,
      minLines: 3,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter service location';
        }
        return null;
      },
    );
  }
}