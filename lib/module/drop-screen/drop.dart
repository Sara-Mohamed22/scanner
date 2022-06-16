import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:q_event_scanner/cubit/loginCubit.dart';
import 'package:q_event_scanner/cubit/loginState.dart';
import 'package:q_event_scanner/data/local/cash_helper.dart';
import 'package:q_event_scanner/module/login-screen/loginScreen.dart';
import 'package:q_event_scanner/module/scanner-screen/ScanScreen.dart';
import 'package:q_event_scanner/shared/constant.dart';

import '../ticket-screen/trueTicket.dart';


class DropScreen extends StatefulWidget {

   String? eventIDFromScan ;
   DropScreen({Key? key , this.eventIDFromScan }) : super(key: key);

  @override
  State<DropScreen> createState() => _DropScreenState();

}

class _DropScreenState extends State<DropScreen> {
  String? dropdownvalue  ;
  String? eventID ;



  @override
  Widget build(BuildContext context) {


      var formKey = GlobalKey<FormState>();
    var scanController = TextEditingController( text: widget.eventIDFromScan );

    LoginCubit cubit = LoginCubit.get(context);
    print('xx ${widget.eventIDFromScan}');



    return BlocConsumer< LoginCubit , LoginState>(
      listener: (context , state){

           /* if(state is GetUserEventSuccessState )
              {

              print('111111111111111111111111111111');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${cubit.userTicket?.msg}'),
                ),
                   backgroundColor: cubit.userTicket?.status == 200 ? Colors.green :  Colors.black ,
                  action: SnackBarAction(
                    label: cubit.userTicket?.status != 200 ? 'Try Again' : '',
                    textColor: Colors.white ,
                   onPressed: () {

                     setState((){
                          CashHelper.removeData(key: 'eventName').then((value) {
                                    dropdownvalue = '' ;
                                    eventID = '' ;
                                    widget.eventIDFromScan = '' ;
                                    scanController.text ='';

                                    });


                      });

                    },
                  )
                // duration: Duration(microseconds: 1500),
              ));


            }*/

      },
      builder:(context , state){

        // if( cubit.userTicket?.data != null ||  cubit.userTicket?.status == 404 )
        if(cubit.userTicket !=null )
        {
          dropdownvalue = CashHelper.getData(key: 'eventName') ;

        }



     return   WillPopScope(
       onWillPop: () async {

         return false ;
       },
       child: Scaffold(
            appBar: AppBar(
              title:  Image.asset('assets/images/logo.png', height: 40, width: 40, ),
              centerTitle: true,
              backgroundColor: HexColor('#053F80'),
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
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0 , ),
                      child:
                      Row(
                        children: [
                          // Icon(Icons.),
                          Image.asset('assets/images/appointment.png'),
                          const SizedBox(width: 10,),
                          Text('Event' , style: TextStyle(fontWeight: FontWeight.bold , color: defColor , fontSize: 16 ),),
                        ],
                      ),
                    ) ,
                    Container(
                      height: 50,
                      margin:  const EdgeInsets.all(15.0),
                      width: MediaQuery.of(context).size.width-50,
                      decoration: BoxDecoration(
                        // color: Colors.blueAccent,
                          border: Border.all(color: HexColor('#000000').withOpacity(0.2) ),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                          value:  dropdownvalue ,
                              style: TextStyle(color: defColor),
                              menuMaxHeight: 150 ,
                              hint:  Text('Select your  Event' , style: TextStyle(color: HexColor('#777777') ,
                                  fontSize: 14),)
                                    //: Text('${CashHelper.getData(key: 'eventName')}')
                                ,
                              underline: Container(),
                               items:
                               cubit.eventList.map((String item) {
                            return
                               DropdownMenuItem(
                                value: item ,
                                child: Text(item),
                            );
                          }).toList() ,

                          onChanged: (String? newValue) {
                            setState(() {
                              print(newValue);
                              dropdownvalue = newValue! ;
                             eventID = cubit.getIDEvent(newValue);
                             print('10 $eventID');
                             
                             CashHelper.saveData(key: 'eventName', value: newValue);
                             print('1010101$dropdownvalue');

                            });
                          },
                        ),

                        /*  child:  CustomDropdownButton(
                            hint: Text('Select your  Event' , style: TextStyle(color: HexColor('#777777') ,
                                fontSize: 14),),
                            value: dropdownvalue ,
                            style: TextStyle(color: defColor),
                            items:  cubit.eventList.map((String item) {
                              return
                                DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );

                            }).toList() ,
                            onChanged: (String? newValue) {
                              setState(() {
                                print(newValue);
                                dropdownvalue = newValue! ;
                              });
                            },
                          ),*/
                        ),
                      ),
                    ),

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0 , vertical: 30),
                        child: SizedBox(child: Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width-55 ,
                          decoration: BoxDecoration(
                              color: HexColor('#053F80').withOpacity(.3),
                              borderRadius: BorderRadius.circular(5)

                          ),
                        ),),
                      ),
                    ),

                    // SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0 , vertical: 10),

                      child: Row(
                        children: [
                          // Icon(Icons.),
                          Image.asset('assets/images/contact.png'),
                          const SizedBox(width: 10,),
                          Text('Reference Id' , style: TextStyle(fontWeight: FontWeight.bold , color: defColor , fontSize: 16 ),),
                        ],
                      ),
                    ),

                    Container(
                      margin:  const EdgeInsets.all(15.0),
                      width: MediaQuery.of(context).size.width-50,
                      decoration: BoxDecoration(
                          border: Border.all(color: HexColor('#000000').withOpacity(0.2),
                              width: 1 ),
                          borderRadius: BorderRadius.circular(5)

                      ),
                      child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 0 , vertical: 0 ),
                        child: SizedBox(
                          height: 50,

                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:  const EdgeInsets.symmetric(horizontal: 17.0 ),
                                  child: Form(
                                    key: formKey ,
                                    child:
                                    TextFormField(

                                      controller: scanController ,
                                      // autofocus: true,
                                      keyboardType: TextInputType.emailAddress ,
                                      style: TextStyle(color: defColor ),
                                      onTap: (){

                                        if(dropdownvalue == null )
                                          {
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              backgroundColor: Colors.red,

                                              content: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text('Please Select your Event !'),
                                              ),
                                              // duration: Duration(microseconds: 1500),
                                            ));
                                          }

                                      },

                                      onFieldSubmitted: (value){
                                        print('0. ${value}');
                                        if(dropdownvalue == null )
                                        {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(

                                            backgroundColor: Colors.red,
                                            content: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text('Please Select your Event !'),
                                            ),
                                            // duration: Duration(microseconds: 1500),
                                          ));
                                        }
                                        else if(value.length <6 )
                                          {
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text('Please Enter 6 Digit Number!'),
                                              ),
                                              // duration: Duration(microseconds: 1500),
                                            ));
                                          }
                                      },
                                      onChanged : (value){
                                        cubit.changeInfoStatus(true);
                                        if(scanController.text.length == 6 && eventID != null)
                                          {
                                          cubit.getUserTicket(
                                          refID: scanController.text,
                                          eventID: eventID).then((value) {
                                            print('88888888888888888${value.msg}');
                                            print('111111111111111111111111111111');
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                content: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(''
                                                      // '${cubit.userTicket?.msg}'
                                                      '${value.msg}'

                                                  ),
                                                ),
                                                backgroundColor:
                                                // cubit.userTicket?.status
                                                value.status

                                                    == 200 ? Colors.green :  Colors.black ,
                                                action: SnackBarAction(
                                                  label:
                                                  // cubit.userTicket?.status
                                                  value.status

                                                      != 200 ? 'Try Again' : '',
                                                  textColor: Colors.white ,
                                                  onPressed: () {

                                                      setState((){
                                                    // eventID = '' ;
                                                    // widget.eventIDFromScan = '' ;
                                                    // scanController.text ='';

                                                       CashHelper.removeData(key: 'eventName').then((value) {
                                                         // dropdownvalue = '' ;
                                                       });

                                                      });

                                                  },
                                                )
                                              // duration: Duration(microseconds: 1500),
                                            ));
                                          });




                                          }

                                      /*  else if(scanController.text.length > 6)
                                          {
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              backgroundColor: Colors.red ,
                                              content: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text('Reference ID Must be 6 Numbers'),
                                              ),
                                              // duration: Duration(microseconds: 1500),
                                            ));
                                          }*/



                                      },

                                      validator: (value){
                                        if(value!.isEmpty) return 'This fields required' ;
                                        return null;
                                      },

                                      decoration:  InputDecoration(
                                         // border: OutlineInputBorder(),
                                       // label: Text('Reference ID*', style: TextStyle(color: Colors.grey.shade500  ), ),
                                        border: InputBorder.none,
                                         hintText:'Reference ID*' ,
                                        errorStyle: const TextStyle( height: .1 ),
                                        fillColor: defColor ,
                                         errorBorder: InputBorder.none ,
                                          focusedErrorBorder: InputBorder.none


                                      ),
                                    ),


                                  ),
                                ),
                              ),

                              Container(
                                height: 50,
                                width: 45,
                                decoration: BoxDecoration(
                                  color: defColor,
                                  // border: Border.all(color: Colors.grey,
                                  //     width: 1 ),
                                ),
                                child: InkWell(
                                  onTap: (){
                                    print('scan');

                                    if(dropdownvalue != null) {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                              ScanScreen(eventID: eventID,)));
                                      cubit.changeInfoStatus(true);


                                    }
                                    else
                                      {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Please Select your Event !'),
                                          ),
                                          // duration: Duration(microseconds: 1500),
                                        ));
                                      }

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.asset('assets/images/qr.png' ,
                                      color: Colors.white ,height: 50, width: 50,),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),



                    if( cubit.userTicket?.data != null )

                    // if( cubit.InfoShow == true )
                   Center(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 17.0 , vertical: 30),
                            child: SizedBox(child: SizedBox(
                                height: 1,

                                child:ListView.separated(
                                    shrinkWrap: false,
                                    scrollDirection: Axis.horizontal ,
                                    itemBuilder: (context , index)=> Container(
                                      width: 5,
                                      height: 1,
                                      color: HexColor('#053F80').withOpacity(.3),
                                    ),
                                    separatorBuilder:(context , index)=> const SizedBox(width: 2,) ,
                                    itemCount: 500 )

                            ),

                            ))),
                    // SizedBox(height: 30,),
                    // if( cubit.InfoShow == true )

                    if( cubit.userTicket?.data != null )

                      Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0 , vertical: 10),

                      child: Row(
                        children: [
                          // Icon(Icons.),
                          Image.asset('assets/images/user.png'),
                          const SizedBox(width: 10,),
                          Text('User Data' , style: TextStyle(fontWeight: FontWeight.bold , color: defColor , fontSize: 16 ),),
                        ],
                      ),
                    ),

                    // if( cubit.InfoShow == true )
                    //   if( state is GetUserEventSuccessState && state.userTicket?.data?.full_name != null  )
                    // if( state is GetUserEventSuccessState  )

                    if( cubit.userTicket?.data != null )

                       Container(
                      height: 100,
                      margin:  const EdgeInsets.all(15.0),
                      width: MediaQuery.of(context).size.width-50,
                      decoration: BoxDecoration(
                          border: Border.all( color: HexColor('#000000').withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(5)


                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center ,
                          children: [

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14.0 ),
                              child: Row(children: [
                                Text('Name :' , style: TextStyle(fontWeight: FontWeight.w500 , color:HexColor('#777777')  ), ) ,
                                const Spacer(),
                                Text('${cubit.userTicket?.data?.full_name}' , style: TextStyle(fontWeight: FontWeight.w500 , color: defColor ),) ,

                              ],),
                            ),

                            const SizedBox(height: 10,),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14.0 ),
                              child: Row(children: [
                                Text('Mobile Number :' , style: TextStyle(fontWeight: FontWeight.w500 , color:HexColor('#777777') ),) ,
                                const Spacer(),
                                Text('${cubit.userTicket?.data?.phone}' , style: TextStyle(fontWeight: FontWeight.w500 , color: defColor ),) ,

                              ],),
                            ),
                          ]
                      ),
                    ),

                    cubit.InfoShow ==false ?
                    const SizedBox(height: 70,)
                   : const SizedBox(height: 30,),

                    cubit.userTicket?.data != null ?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0 , vertical: 100 ),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        width: MediaQuery.of(context).size.width-50,
                        height: 45,

                        child: MaterialButton(
                          shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          color: btnColor,
                          onPressed: ()
                          {

                            if(dropdownvalue == null ){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Please Select your Event !'),
                                ),
                                // duration: Duration(microseconds: 1500),
                                    ));

                             }

                            else
                              {
                                  if(formKey.currentState!.validate())
                                    {
                                      print('ok$eventID');

                                     if(cubit.userTicket?.status == 200 )
                                       {

                                         cubit.checkAttendance(refID: scanController.text );
                                         Navigator.push(context, MaterialPageRoute(builder: (context)=> const TrueTicketScreen()));

                                       }

                                     else
                                       {
                                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                           content: Padding(
                                             padding: EdgeInsets.all(8.0),
                                             child: Text('Error Happen '),
                                           ),
                                           // duration: Duration(microseconds: 1500),
                                         ));
                                       }


                                    }


                              }


                          }
                          ,
                          child: const Text('NEXT'  ,
                            style: TextStyle(
                                color: Colors.white ,
                                fontWeight: FontWeight.w500,
                                fontSize: 19
                            ),),) ,
                      ),
                    ) :


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0 , vertical: 100 ),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        width: MediaQuery.of(context).size.width-50,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400 ,
                          borderRadius: BorderRadius.circular(5.0),
                          ),
                        child: MaterialButton(
                          shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          onPressed: null ,
                          child: const Text('NEXT'  ,
                            style: TextStyle(
                                color: Colors.white ,
                                fontWeight: FontWeight.w500,
                                fontSize: 19
                            ),),) ,
                      ),
                    )
                    // ),
                  ],
                ),
              ),
            ),
          ),
     );
      } ,
    );
  }


}










