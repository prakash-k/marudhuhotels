import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/reservation_provider.dart';

class ReservationModal extends ConsumerWidget {
  const ReservationModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reservationProvider);
    final notifier = ref.read(reservationProvider.notifier);

    return Dialog(
      backgroundColor: AppColors.background,
      elevation: 20,
      shadowColor: AppColors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(32),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: state.isSubmitting
              ? _buildLoadingState()
              : (state.isSubmitted ? _buildSuccessState(context, state, notifier) : _buildFormState(context, state, notifier)),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      key: const ValueKey('loading'),
      mainAxisSize: MainAxisSize.min,
      children: const [
        SizedBox(height: 48),
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
          strokeWidth: 3,
        ),
        SizedBox(height: 24),
        Text(
          'Securing your table...',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 48),
      ],
    );
  }

  Widget _buildSuccessState(BuildContext context, ReservationState state, ReservationNotifier notifier) {
    final formattedDate = state.date != null
        ? '${state.date!.year}/${state.date!.month}/${state.date!.day}'
        : 'N/A';

    return Column(
      key: const ValueKey('success'),
      mainAxisSize: MainAxisSize.min,
      children: [
        // Success Ring Check
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFFE8F5E9),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Colors.green,
            size: 40,
          ),
        ),
        const SizedBox(height: 24),

        // Success Header
        Text(
          'Reservation Confirmed!',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 26,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'We look forward to serving you.',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 28),

        // Premium Styled Ticket Box
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.secondary.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Confirmation ID Block
              const Text(
                'CONFIRMATION CODE',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  letterSpacing: 1.5,
                  color: AppColors.textLight,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                state.reservationId ?? '',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  letterSpacing: 1.0,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, color: AppColors.border),
              const SizedBox(height: 16),

              // Detail Grid List
              _buildTicketRow(Icons.person_outline, 'Guest Name', state.name),
              const SizedBox(height: 12),
              _buildTicketRow(Icons.calendar_month_outlined, 'Date', formattedDate),
              const SizedBox(height: 12),
              _buildTicketRow(Icons.access_time_outlined, 'Time', state.time),
              const SizedBox(height: 12),
              _buildTicketRow(Icons.group_outlined, 'Party Size', '${state.guestsCount} Guests'),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Close Action button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              notifier.reset();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Done'),
          ),
        ),
      ],
    );
  }

  Widget _buildTicketRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 18),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildFormState(BuildContext context, ReservationState state, ReservationNotifier notifier) {
    final formattedDate = state.date != null
        ? '${state.date!.year}/${state.date!.month}/${state.date!.day}'
        : 'Select dining date...';

    return SingleChildScrollView(
      key: const ValueKey('form'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Book a Table',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: AppColors.textLight),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Validation Error Alert banner
          if (state.errorMessage != null)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Text(
                state.errorMessage!,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.red.shade800,
                ),
              ),
            ),

          const SizedBox(height: 16),

          // Name Input
          _buildFieldLabel('YOUR FULL NAME *'),
          TextField(
            onChanged: notifier.updateName,
            style: const TextStyle(fontFamily: 'Inter', fontSize: 14),
            decoration: _buildInputDecoration('e.g. Priya Sharma'),
          ),
          const SizedBox(height: 16),

          // Email & Phone Inputs in split row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('EMAIL ADDRESS *'),
                    TextField(
                      onChanged: notifier.updateEmail,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontFamily: 'Inter', fontSize: 14),
                      decoration: _buildInputDecoration('e.g. priya@domain.com'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('CONTACT PHONE *'),
                    TextField(
                      onChanged: notifier.updatePhone,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(fontFamily: 'Inter', fontSize: 14),
                      decoration: _buildInputDecoration('e.g. 080-XXXX-XXXX'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Date Selector
          _buildFieldLabel('DINING DATE *'),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 90)),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: AppColors.secondary,
                          onPrimary: AppColors.primary,
                          onSurface: AppColors.primary,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (date != null) {
                  notifier.updateDate(date);
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: state.date != null ? AppColors.textPrimary : AppColors.textLight,
                      ),
                    ),
                    const Icon(Icons.calendar_today, color: AppColors.accent, size: 18),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Time & Guest Counters
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('DINING TIME'),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: state.time,
                          isExpanded: true,
                          style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: AppColors.textPrimary),
                          onChanged: (val) {
                            if (val != null) notifier.updateTime(val);
                          },
                          items: <String>[
                            '11:00', '11:30', '12:00', '12:30', '13:00', '13:30',
                            '17:00', '17:30', '18:00', '18:30', '19:00', '19:30', '20:00', '20:30'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('NUMBER OF GUESTS'),
                    Row(
                      children: [
                        _buildCounterButton(Icons.remove, () {
                          if (state.guestsCount > 1) {
                            notifier.updateGuests(state.guestsCount - 1);
                          }
                        }),
                        Expanded(
                          child: Text(
                            '${state.guestsCount}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        _buildCounterButton(Icons.add, () {
                          if (state.guestsCount < 20) {
                            notifier.updateGuests(state.guestsCount + 1);
                          }
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Dietary requests Input
          _buildFieldLabel('SPECIAL REQUESTS (DIETARY / OCCASION)'),
          TextField(
            onChanged: notifier.updateRequests,
            maxLines: 2,
            style: const TextStyle(fontFamily: 'Inter', fontSize: 14),
            decoration: _buildInputDecoration('e.g. Vegetarian only, peanut allergies, wheelchair seating...'),
          ),
          const SizedBox(height: 32),

          // Confirm Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                notifier.submitReservation();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: const Text('Confirm Reservation'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.bold,
          fontSize: 10,
          letterSpacing: 1.0,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildCounterButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.lightBackground,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, size: 14, color: AppColors.textPrimary),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.textLight, fontSize: 13),
      fillColor: AppColors.white,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.border),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.secondary, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
