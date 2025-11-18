import 'package:flutter/material.dart';
import 'package:project_2/constants/app_color.dart';
import 'package:project_2/controllers/booking_provider/booking_request_provider.dart';
import 'package:project_2/model/service_model.dart';

class DateTimeSelectors extends StatelessWidget {
  final ServiceProviderModel provider;
  final BookingRequestProvider bookingProvider;

  const DateTimeSelectors({
    super.key,
    required this.provider,
    required this.bookingProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _DateSelector(bookingProvider: bookingProvider),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _TimeSelector(bookingProvider: bookingProvider),
        ),
      ],
    );
  }
}

class _DateSelector extends StatelessWidget {
  final BookingRequestProvider bookingProvider;

  const _DateSelector({required this.bookingProvider});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: bookingProvider.selectedDate != null
                ? AppColors.primary
                : AppColors.grey.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: bookingProvider.selectedDate != null
                      ? AppColors.primary
                      : AppColors.hintText,
                ),
                const SizedBox(width: 8),
                Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.hintText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              bookingProvider.selectedDate != null
                  ? '${bookingProvider.selectedDate!.day}/${bookingProvider.selectedDate!.month}/${bookingProvider.selectedDate!.year}'
                  : 'Select date',
              style: TextStyle(
                fontSize: 14,
                fontWeight: bookingProvider.selectedDate != null
                    ? FontWeight.w600
                    : FontWeight.normal,
                color: bookingProvider.selectedDate != null
                    ? AppColors.textColor
                    : AppColors.hintText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: bookingProvider.selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      bookingProvider.setSelectedDate(picked);
    }
  }
}

class _TimeSelector extends StatelessWidget {
  final BookingRequestProvider bookingProvider;

  const _TimeSelector({required this.bookingProvider});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectTime(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: bookingProvider.selectedTime != null
                ? AppColors.primary
                : AppColors.grey.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 18,
                  color: bookingProvider.selectedTime != null
                      ? AppColors.primary
                      : AppColors.hintText,
                ),
                const SizedBox(width: 8),
                Text(
                  'Time',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.hintText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              bookingProvider.selectedTime != null
                  ? bookingProvider.selectedTime!.format(context)
                  : 'Select time',
              style: TextStyle(
                fontSize: 14,
                fontWeight: bookingProvider.selectedTime != null
                    ? FontWeight.w600
                    : FontWeight.normal,
                color: bookingProvider.selectedTime != null
                    ? AppColors.textColor
                    : AppColors.hintText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: bookingProvider.selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      bookingProvider.setSelectedTime(picked);
    }
  }
}