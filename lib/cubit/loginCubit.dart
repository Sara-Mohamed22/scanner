

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_event_scanner/data/end-points.dart';
import 'package:q_event_scanner/data/local/cash_helper.dart';
import 'package:q_event_scanner/data/remote/dio_helper.dart';
import 'package:q_event_scanner/model/eventModel.dart';
import 'package:q_event_scanner/model/loginModel.dart';
import 'package:q_event_scanner/model/ticketModel.dart';
import 'package:q_event_scanner/model/userTicket.dart';

import 'loginState.dart';

class LoginCubit extends Cubit<LoginState>
{
    LoginCubit():super(LoginInitialState()) ;

  static LoginCubit get(context)=> BlocProvider.of(context);

    LoginModel? loginModel ;
    TicketModel? ticketModel ;

  void userLogin(
    {
      @required String? phone ,
      @required String? password ,
      String lang = 'en' ,

     }
      )
  {
    emit(LoginLoadingState());

    DioHelper.postData(
        url: 'employee/$LOGIN' ,
        data:
        {
          'phone' : phone ,
           'password' : password ,
            'lang' : lang ,
            'device_token' : 'ddab3ea4-39c6-4930-8fc9-77dbaf8f5ff6' ,

        }).then((value)
    {


        loginModel = LoginModel.fromJson(value.data);

           print('data : ${loginModel?.message}') ;

         //  getInfoTicket(id: '0000002' , token: 'Bearer ${loginModel?.data?.access_token}');
          emit(LoginSuccessState(loginModel!));

       }).catchError((e){
          print('error ${e.toString()}');
          emit(LoginErrorState(e.toString() ));
    });
  }

    bool isHidden =true ;
    Widget visible = const Icon(Icons.visibility_outlined);
    bool obscuretext =true ;

    void changevisibiliy()
    {
      if(isHidden) {
        isHidden = false;
        obscuretext = false ;
        visible = const Icon(Icons.visibility_off_outlined);

        emit(ShowHidden());
      }
      else {
        visible = const Icon(Icons.visibility_outlined);
        isHidden = true;
        obscuretext = true ;
        emit(ShowHidden());
      }
    }


   /* getInfoTicket({
             @required String? id   ,
             @required String? token   ,
              String lang = 'en' ,
                })async
  {



    emit(TicketLoadingState());

    CashHelper.removeData(key: 'status');
    CashHelper.removeData(key: 'msg');

     DioHelper.postData(
         url:'https://qevents-test.appclouders.com/api/attend'
         , data: {
            "reference_id" : id ,
            "lang" : lang ,},
       token: token ,
     ).then((value){


       print('ticket Data : $value ') ;
       ticketModel = TicketModel.FromJson(value.data);

       CashHelper.saveData(key: 'status', value: ticketModel?.status);
       CashHelper.saveData(key: 'msg', value: ticketModel?.msg );

       emit(TicketSuccessState(ticketModel!));


     }).
        catchError((e){
       print('erxx ${e.toString()}');
       emit(TicketErrorState(e.toString() ));
            });


  }*/


  bool InfoShow = false ;

    changeInfoStatus(bool isShow)
    {
      InfoShow = isShow ;
      emit(InfoDataSuccessState());
    }


    EventModel? eventModel ;
    List<String> eventList = [];
    List<String> eventListID = [];
    Map<String , dynamic> eventMap = {};


    getAllCurrentEvent(
        {
          String lang = 'en' ,
          int no_page = 5 ,
          String? token
         })
      {
        emit(GetAllCurrentEventLoadingState());
      DioHelper.getData(
          url:'current/events' ,
          query:
           {
            'lang' : lang ,
            'per_page' : no_page ,
            },

          token: 'Bearer ${CashHelper.getData(key: 'token')}'

         ).then((value){

           print('data ${value.data}');
           eventModel = EventModel.FromJson(value.data) ;
           eventModel?.data .forEach((k,v) {
             print('ke $k: val $v');
             eventList.add(v);
             eventListID.add(k);

            eventMap = eventModel?.data ;



           });

           emit(GetAllCurrentEventSuccessState());
      }).
      catchError((e)
      {
        print('error ${e.toString()}');
        emit( GetAllCurrentEventErrorState());
      });
    }


    // ? eventID ;

    getIDEvent(String? dropValue)
    {
      String eventID  =  eventMap.keys.firstWhere(
              (k) => eventModel?.data[k] == dropValue );
      print(eventID);

      emit(ReferenceIdSuccessState());
      return eventID ;
    }



    UserTicket? userTicket ;

  /*  getUserTicket({
      String? lang ='en' ,
      required String? refID ,
      required String? eventID ,

                  })
    {

      emit(GetUserEventLoadingState());

      DioHelper.getData(
          url:'check-attendee' ,
          query:
          {
            'lang' : lang ,
            'reference_id' : refID ,
            'event_id' : eventID
          },

          token: 'Bearer ${CashHelper.getData(key: 'token')}'
      ).
      then((value){
        print('ticket ${value.data}');

        userTicket = UserTicket.FromJson(value.data);
        emit(GetUserEventSuccessState(userTicket: userTicket ));
      }).
      catchError((e)
      {
        print('eeror ${e.toString()}');
        emit(GetUserEventErrorState());
      });
    }
    */


    Future<UserTicket>  getUserTicket({
      String? lang ='en' ,
      required String? refID ,
      required String? eventID ,

    })async
    {

      try {
        emit(GetUserEventLoadingState());

        dynamic val = await DioHelper.getData(
            url: 'check-attendee',
            query:
            {
              'lang': lang,
              'reference_id': refID,
              'event_id': eventID
            },

            token: 'Bearer ${CashHelper.getData(key: 'token')}'
        );

        print('ticket val ${val.data}');

        userTicket = UserTicket.FromJson(val.data);
        emit(GetUserEventSuccessState(userTicket: userTicket));

        return await userTicket! ;

      }
      catch(e)
      {
        print('eeror ${e.toString()}');
        emit(GetUserEventErrorState());
      };

      return await userTicket! ;

    }





 /*  getUserTicketScan({
      String? lang ='en' ,
      required String? refID ,
      required String? eventID ,

    })
    {

      emit(GetUserEventScanLoadingState());

      DioHelper.getData(
          url:'check-attendee' ,
          query:
          {
            'lang' : lang ,
            'reference_id' : refID ,
            'event_id' : eventID
          },

          token: 'Bearer ${CashHelper.getData(key: 'token')}'
      ).
      then((value){
        print('ticket Scan ${value.data}');

        userTicket = UserTicket.FromJson(value.data);
        emit(GetUserEventScanSuccessState(userTicket: userTicket ));

      }).
      catchError((e)
      {
        print('eeror ${e.toString()}');
        emit(GetUserEventScanErrorState());
      });


    }*/



  Future<UserTicket>  getUserTicketScan({
      String? lang ='en' ,
      required String? refID ,
      required String? eventID ,

    }) async
    {

      try {
        emit(GetUserEventScanLoadingState());
        dynamic val = await DioHelper.getData(
            url: 'check-attendee',
            query:
            {
              'lang': lang,
              'reference_id': refID,
              'event_id': eventID
            },

            token: 'Bearer ${CashHelper.getData(key: 'token')}'
        );


        print('ticket Scan val ${val.data}');
        userTicket = UserTicket.FromJson(val.data);
        emit(GetUserEventScanSuccessState(userTicket: userTicket));
        return await userTicket! ;
      }

      catch (e)
      {
        print('eeror ${e.toString()}');
        emit(GetUserEventScanErrorState());
      };

      return await userTicket! ;

    }



    checkAttendance({
      String? lang ='en' ,
      required String? refID ,

    })
    {

      emit(CheckAttendanceLoadingState());

      DioHelper.postData(
          url:'attend' ,
          data:
          {
            'lang' : lang ,
            'reference_id' : refID ,
          },

          token: 'Bearer ${CashHelper.getData(key: 'token')}'
      ).
      then((value){
        print('ticketInfo ${value.data}');
        ticketModel = TicketModel.FromJson(value.data);
        emit(CheckAttendanceSuccessState());
      }).
      catchError((e)
      {
        print('eerox ${e.toString()}');
        emit(CheckAttendanceErrorState());
      });
    }



    removeData()
    {
      CashHelper.removeData(key: 'eventName');
      userTicket?.data = null ;
     emit(RemoveDataSuccessState());
    }




}


class Data
{
  String? id ;

  Data({this.id  });

  Map<String , dynamic> toJson()
  {
    return
      {
        "30":id ,

      };
  }

  Data.FromJson(Map<String , dynamic> json)
  {
    id = json["30"];

  }

}