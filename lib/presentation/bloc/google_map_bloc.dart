import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_googel_map_app/core/response_status/google_map_response.dart';
import 'package:flutter_googel_map_app/domain/use_case/get_marker_use_case.dart';
import 'package:flutter_googel_map_app/presentation/bloc/google_map_event.dart';
import 'package:flutter_googel_map_app/presentation/bloc/google_map_state.dart';

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  final GetMarkerUseCase getMarkersUseCase;

  GoogleMapBloc({required this.getMarkersUseCase})
      : super(GoogleMapState(markers: GoogleMapResponse.loading())) {
    on<LoadMarkerEvent>(_onLoadMarkerEvent);
  }

  Future<void> _onLoadMarkerEvent(LoadMarkerEvent event, Emitter<GoogleMapState> emit) async {
    final response = await getMarkersUseCase.execute();;
    if (response.status == Status.completed) {
      emit(state.copyWith(markers: response, status: Status.completed));
    } else {
      emit(state.copyWith(markers: GoogleMapResponse.error(response.message), status: Status.error));
    }
  }
}