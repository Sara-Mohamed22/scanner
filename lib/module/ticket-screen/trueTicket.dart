
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:q_event_scanner/data/local/cash_helper.dart';
import 'package:q_event_scanner/module/drop-screen/drop.dart';

import '../../cubit/loginCubit.dart';
import '../../cubit/loginState.dart';
import '../login-screen/loginScreen.dart';
class TrueTicketScreen extends StatefulWidget {
  const TrueTicketScreen({Key? key}) : super(key: key);

  @override
  State<TrueTicketScreen> createState() => _TrueTicketScreenState();
}

class _TrueTicketScreenState extends State<TrueTicketScreen> {
  @override

  Widget build(BuildContext context) {
    print('phonx ${CashHelper.getData(key: 'pnoneNum')}');
    print('idx ${CashHelper.getData(key: 'id')}');



    LoginCubit cubit = LoginCubit.get(context);


    return BlocConsumer<LoginCubit , LoginState>(
      listener: (context , state ){
      },
      builder:(context , state ){

        return WillPopScope(

          onWillPop: () async {
            return false ;
          },

          child: Scaffold(
              appBar: AppBar(
                backgroundColor: HexColor('#053F80'),
                title:  const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text('Confirmation Process' , textAlign: TextAlign.center ,
                    style: TextStyle(
                        fontWeight: FontWeight.bold ,
                        color: Colors.white ,
                        fontSize: 16
                    ),
                  ),
                ) ,

                automaticallyImplyLeading: false ,

                actions: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:
                  InkWell(child: const Icon(Icons.logout , size: 30, ),
                      onTap: (){
                        CashHelper.removeData(key: 'token').then((value) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));

                        });
                      }),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Center(
                 child:
                 Column(
                   children: [
                    /* Container(
                       height: 100 ,
                       width: double.infinity ,
                       color: Colors.indigo ,
                       child:  Padding(
                         padding: EdgeInsets.symmetric(vertical: 40.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround ,
                           children: [
                             Text('Confirmation Process' , textAlign: TextAlign.center ,
                               style: TextStyle(
                                   fontWeight: FontWeight.bold ,
                                   color: Colors.white ,
                                   fontSize: 18
                               ),),
                               InkWell(child: Icon( Icons.logout , color: Colors.white,) , onTap: (){
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
                     ) ,*/
                     Padding(
                       padding: const EdgeInsets.only(top: 70.0),
                       child: Column(
                         children: [
                           // if (CashHelper.getData(key: 'status') == 200 )
                             Container(
                               height: 170,
                               decoration: const BoxDecoration(
                                   shape: BoxShape.circle ,
                                   color: Colors.green
                               ),
                               child: const Icon(Icons.check_circle_outline_outlined , color: Colors.white , size: 90,),
                             ),



                         /*  const SizedBox(height: 120,),*/

                           // if (CashHelper.getData(key: 'status') == 200 )

                           Text('Thank you , You are Allowed to enter' , style: TextStyle( color: HexColor('#053F80'))),








                         const SizedBox(height: 170,),
                           // Spacer(),

                           ElevatedButton(

                             onPressed: (){
                              // CashHelper.removeData(key: 'token').then((value) {
                               cubit.removeData();
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>   DropScreen()));

                              // });
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
                 ),
                ),
            ),
            // ),
          ),
        ) ;
      } ,
    );
  }
}
