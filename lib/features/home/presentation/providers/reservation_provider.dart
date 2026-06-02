import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

// Data model for a Reservation
class ReservationState {
  final String name;
  final String email;
  final String phone;
  final DateTime? date;
  final String time;
  final int guestsCount;
  final String specialRequests;
  final String? reservationId;
  final bool isSubmitting;
  final bool isSubmitted;
  final String? errorMessage;

  ReservationState({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.date,
    this.time = '18:00',
    this.guestsCount = 2,
    this.specialRequests = '',
    this.reservationId,
    this.isSubmitting = false,
    this.isSubmitted = false,
    this.errorMessage,
  });

  ReservationState copyWith({
    String? name,
    String? email,
    String? phone,
    DateTime? date,
    String? time,
    int? guestsCount,
    String? specialRequests,
    String? reservationId,
    bool? isSubmitting,
    bool? isSubmitted,
    String? errorMessage,
  }) {
    return ReservationState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      date: date ?? this.date,
      time: time ?? this.time,
      guestsCount: guestsCount ?? this.guestsCount,
      specialRequests: specialRequests ?? this.specialRequests,
      reservationId: reservationId ?? this.reservationId,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ReservationNotifier extends StateNotifier<ReservationState> {
  ReservationNotifier() : super(ReservationState());

  void updateName(String name) => state = state.copyWith(name: name);
  void updateEmail(String email) => state = state.copyWith(email: email);
  void updatePhone(String phone) => state = state.copyWith(phone: phone);
  void updateDate(DateTime date) => state = state.copyWith(date: date);
  void updateTime(String time) => state = state.copyWith(time: time);
  void updateGuests(int count) => state = state.copyWith(guestsCount: count);
  void updateRequests(String req) => state = state.copyWith(specialRequests: req);

  Future<bool> submitReservation() async {
    // Basic validations
    if (state.name.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your name');
      return false;
    }
    if (state.email.trim().isEmpty || !state.email.contains('@')) {
      state = state.copyWith(errorMessage: 'Please enter a valid email address');
      return false;
    }
    if (state.phone.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your contact number');
      return false;
    }
    if (state.date == null) {
      state = state.copyWith(errorMessage: 'Please select a dining date');
      return false;
    }

    state = state.copyWith(isSubmitting: true, errorMessage: null);

    // Simulate database network latency (1.5 seconds)
    await Future.delayed(const Duration(milliseconds: 1500));

    // Generate random premium reservation code
    final randomDigits = Random().nextInt(9000) + 1000;
    final generatedId = 'MRD-$randomDigits-NAG';

    state = state.copyWith(
      isSubmitting: false,
      isSubmitted: true,
      reservationId: generatedId,
    );

    return true;
  }

  void reset() {
    state = ReservationState();
  }
}

// Global Provider
final reservationProvider = StateNotifierProvider<ReservationNotifier, ReservationState>((ref) {
  return ReservationNotifier();
});
