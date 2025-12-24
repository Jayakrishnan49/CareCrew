import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:project_2/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:project_2/constants/app_color.dart';
import 'package:project_2/controllers/user_provider/user_provider.dart';
import 'package:project_2/view/bottom_nav/bottom_nav_screen.dart';
import 'package:project_2/widgets/custom_button.dart';

class LocationConfirmDialog extends StatelessWidget {
  final double lat;
  final double long;

  const LocationConfirmDialog({
    super.key,
    required this.lat,
    required this.long,
  });

  void _confirmLocation(BuildContext context, UserProvider provider) async {
    bool success = await provider.saveLocationToFirestore(lat, long);

    if (!context.mounted) return;

    if (success) {
      Navigator.of(context).pop(); // Close dialog
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MainScreenWithNavigation(),
        ),
      );
    } else {
      CustomSnackBar.show(
        context: context,
        title: 'Error',
        message: 'Failed to save location. Please try again.',
        icon: Icons.error_rounded,
        iconColor: Colors.red,
        accentColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        final isSaving = provider.isSavingLocation;

        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.location_on_rounded,
                          color: AppColors.secondary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Confirm Your Location',
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Is this your current location?',
                              style: TextStyle(
                                color: AppColors.hintText,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Map View
                Container(
                  height: 300,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      FlutterMap(
                        options: MapOptions(
                          initialCenter: LatLng(lat, long),
                          initialZoom: 15,
                          interactionOptions: const InteractionOptions(
                            flags: InteractiveFlag.pinchZoom |
                                InteractiveFlag.drag,
                          ),
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.goserve.user',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(lat, long),
                                width: 50,
                                height: 50,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.primary.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Icon(
                                      Icons.location_on,
                                      size: 40,
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Coordinates overlay
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.my_location,
                                size: 14,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${lat.toStringAsFixed(4)}, ${long.toStringAsFixed(4)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Accuracy Info
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'We\'ll use this location to show nearby professionals',
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Buttons
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Change',
                          height: 50,
                          color: AppColors.secondary,
                          textColor: AppColors.primary,
                          borderRadius: 12,
                          borderColor: AppColors.primary,
                          onTap: isSaving
                              ? null
                              : () {
                                  provider.resetLocationState();
                                  Navigator.of(context).pop();
                                },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: CustomButton(
                          text: isSaving ? 'Confirming...' : 'Confirm Location',
                          height: 50,
                          textColor: AppColors.secondary,
                          color: AppColors.buttonColor,
                          borderRadius: 12,
                          icon: isSaving
                              ? null
                              : Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.secondary,
                                  size: 20,
                                ),
                          onTap: isSaving
                              ? null
                              : () => _confirmLocation(context, provider),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}