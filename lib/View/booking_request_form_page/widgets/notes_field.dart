import 'package:flutter/material.dart';
import 'package:project_2/controllers/booking_provider/booking_request_provider.dart';
import 'package:project_2/widgets/custom_text_form_field.dart';

class NotesField extends StatelessWidget {
  final BookingRequestProvider bookingProvider;

  const NotesField({super.key, required this.bookingProvider});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: bookingProvider.notesController,
      hintText:
          'Add any specific requirements, instructions, or details about the work...',
      labelText: null,
      prefixIcon: Icons.note_outlined,
      maxLines: 4,
      minLines: 4,
      validator: null,
    );
  }
}