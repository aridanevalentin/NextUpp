import 'package:equatable/equatable.dart';
import 'package:nextupp/domain/models/media_item.dart';
import 'package:nextupp/domain/models/media_status.dart';

class DetailState extends Equatable {
  final bool isLoading;
  final MediaItem? item;
  final MediaStatus status;
  final String? errorMessage;
  final String? snackbarSignal;

  const DetailState({
    this.isLoading = true,
    this.item,
    this.status = MediaStatus.notAdded,
    this.errorMessage,
    this.snackbarSignal,
  });

  DetailState copyWith({
    bool? isLoading,
    MediaItem? item,
    MediaStatus? status,
    String? errorMessage,
    String? snackbarSignal,
    bool clearSnackbar = false,
  }) {
    return DetailState(
      isLoading: isLoading ?? this.isLoading,
      item: item ?? this.item,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      snackbarSignal: clearSnackbar ? null : snackbarSignal ?? this.snackbarSignal,
    );
  }

  @override
  List<Object?> get props => [isLoading, item, status, errorMessage, snackbarSignal];
}