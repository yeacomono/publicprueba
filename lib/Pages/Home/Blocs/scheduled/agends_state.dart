part of 'agends_bloc.dart';

sealed class AgendsState extends Equatable {
  const AgendsState();

  @override
  List<Object> get props => [];
}

final class AgendsInitial extends AgendsState {}

final class AgendsLoading extends AgendsState {}

final class AgendsLoaded extends AgendsState {
  final List<AgendCourtTennis> agendas;

  const AgendsLoaded({required this.agendas});

  @override
  List<Object> get props => [agendas];
}

final class AgendsError extends AgendsState {
  final String message;
  const AgendsError({required this.message});
  @override
  List<Object> get props => [message];
}
