
import 'package:q_event_scanner/model/loginModel.dart';
import 'package:q_event_scanner/model/ticketModel.dart';
import 'package:q_event_scanner/model/userTicket.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
 final  LoginModel loginModel ;
 LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginState {
   final String error ;
   // final  LoginModel loginModel ;
   LoginErrorState( this.error  ) ;
}


class TicketLoadingState extends LoginState {}

class TicketSuccessState extends LoginState {
  final  TicketModel ticketModel ;
  TicketSuccessState(this.ticketModel);
}

class TicketErrorState extends LoginState {
  final String error ;
  TicketErrorState( this.error) ;
}


class ShowHidden extends LoginState {}


class InfoDataSuccessState extends LoginState {}

class ReferenceIdSuccessState extends LoginState {}




class GetAllCurrentEventLoadingState extends LoginState {}
class GetAllCurrentEventSuccessState extends LoginState {}
class GetAllCurrentEventErrorState extends LoginState {}


class GetUserEventLoadingState extends LoginState {}
class GetUserEventSuccessState extends LoginState {
  final UserTicket? userTicket ;
  GetUserEventSuccessState({this.userTicket});
}
class GetUserEventErrorState extends LoginState {}



class GetUserEventScanLoadingState extends LoginState {}
class GetUserEventScanSuccessState extends LoginState {

  final UserTicket? userTicket ;
  GetUserEventScanSuccessState({this.userTicket});
}
class GetUserEventScanErrorState extends LoginState {}



class CheckAttendanceLoadingState extends LoginState {}
class CheckAttendanceSuccessState extends LoginState {}
class CheckAttendanceErrorState extends LoginState {}


class RemoveDataSuccessState extends LoginState {}



