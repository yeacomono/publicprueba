part of 'agends_bloc.dart';

sealed class AgendsEvent extends Equatable {
  const AgendsEvent();

  @override
  List<Object> get props => [];
}

class RegisterAgends extends AgendsEvent {
  final AgendCourtTennis agendCourtTennis;

  const RegisterAgends({
    required this.agendCourtTennis,
  });

  @override
  List<Object> get props => [agendCourtTennis];
}

class UnRegisterAgends extends AgendsEvent {
  final DateTime dateTime;
  final String type;
  const UnRegisterAgends({required this.type,required this.dateTime});
  @override
  List<Object> get props => [dateTime];
}

class ListItemAgens extends AgendsEvent {
  const ListItemAgens();
  @override
  List<Object> get props => [];
}
