
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_event_scanner/data/local/cash_helper.dart';
import 'package:q_event_scanner/module/login-screen/loginScreen.dart';
import 'package:q_event_scanner/module/scanner-screen/ScanScreen.dart';

import '../../cubit/loginCubit.dart';
import '../../cubit/loginState.dart';
class TicketErrorScreen extends StatefulWidget {
  const TicketErrorScreen({Key? key}) : super(key: key);

  @override
  State<TicketErrorScreen> createState() => _TicketErrorScreenState();
}

class _TicketErrorScreenState extends State<TicketErrorScreen> {
  @override

  Widget build(BuildContext context) {
    print('phonx ${CashHelper.getData(key: 'pnoneNum')}');
    print('idx ${CashHelper.getData(key: 'id')}');

    LoginCubit cubit = LoginCubit.get(context);


    return BlocConsumer<LoginCubit , LoginState>(
      listener: (context , state ){
      },
      builder:(context , state ){
        print('phonx ${CashHelper.getData(key: 'pnoneNum')}');
        print('idx ${CashHelper.getData(key: 'id')}');
        print('ticxx ${CashHelper.getData(key: 'status')}');
        print('ticxx ${CashHelper.getData(key: 'msg')}');


        return WillPopScope(
          onWillPop: () async {
            return true ;
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(child:
              Column(
                children: [
                  Container(
                    height: 100 ,
                    width: double.infinity ,
                    color: Colors.indigo ,
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceAround ,
                        children: [
                          const Text('Confirmation Process' , textAlign: TextAlign.center ,
                            style: TextStyle(
                                fontWeight: FontWeight.bold ,
                                color: Colors.white ,
                                fontSize: 18
                            ),),
                          InkWell(child: const Icon( Icons.logout , color: Colors.white,) , onTap: (){
                            CashHelper.removeData(key: 'token').then((value) {

                              print('logout successfully');
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>  const LoginScreen()));


                            }).catchError((e){
                              print(e.toString());
                            });
                          },),
                        ],
                      ),
                    ),
                  ) ,
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: Column(
                      children: [

                          Stack(
                            alignment: AlignmentDirectional.center,

                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(50.0),

                                ),

                              ),

                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50.0),

                                ),

                              ),

                              Container(
                                height: 53,
                                width: 53,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(25.0),

                                ),

                              ),


                              const Text('x' , style: TextStyle(fontSize: 50 , fontWeight: FontWeight.bold ,
                                  color: Colors.white ),
                                textAlign: TextAlign.center ,
                              )


                            ],
                          ),

                        const SizedBox(height: 120,),


                         const Text('oops! invalid QR code , Please Try Again later' , style: TextStyle(color: Colors.indigo),),






                        const SizedBox(height: 170,),

                        ElevatedButton(

                          onPressed: (){
                           // CashHelper.removeData(key: 'token').then((value) {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ScanScreen()));

                          //  });
                          }, child: const Text('Try Again') ,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.indigo,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25), // <-- Radius
                            ),
                          ),

                        )


                      ],
                    ),
                  )
                ],
              )
              ),
            ),
          ),
        ) ;
      } ,
    );
  }
}
