part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateSessionStarted extends HomeState {
  final SharedSessionGenerated? data;

  const HomeStateSessionStarted({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}

class HomeStateSessionStartFailed extends HomeState {}

class HomeStateSessionHistoryLoaded extends HomeState {
  final SharedSessionHistory? data;

  const HomeStateSessionHistoryLoaded({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}

class HomeStateSessionHistoryFailed extends HomeState {}
