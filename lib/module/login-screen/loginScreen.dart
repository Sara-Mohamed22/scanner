import 'dart:async';
import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:q_event_scanner/cubit/loginCubit.dart';
import 'package:q_event_scanner/cubit/loginState.dart';
import 'package:q_event_scanner/data/local/cash_helper.dart';
import 'package:q_event_scanner/module/drop-screen/drop.dart';
import 'package:q_event_scanner/shared/components.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  ConnectivityResult? _connectivityResult;
  late StreamSubscription _connectivitySubscription;
  bool? _isConnectionSuccessful;


  Future<void> _checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.wifi) {
      print('Connected to a Wi-Fi network');
    } else if (result == ConnectivityResult.mobile) {
      print('Connected to a mobile network');
    } else {
      print('Not connected to any network');
      showToast(msg: 'check your Internet', state: ToastState.ERROR );
      _tryConnection().then((value) {
        print('plz try connect again');
      }).catchError((e){
        print('error in try net ${e.toString()}');
      });

    }

    setState(() {
      _connectivityResult = result;
    });
  }


  @override
  void initState() {
    super.initState();
    _checkConnectivityState().then((value) {
      print('connecttttt');
    }).catchError((e){
      print('error in connection ${e.toString()}');
    });

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
        ConnectivityResult result
        ) {
      print('Current connectivity status: $result');
      setState(() {
        _connectivityResult = result;
      });
    });

  }


  Future<void> _tryConnection() async {
    try {
      final response = await InternetAddress.lookup('www.google.com');

      setState(() {
        _isConnectionSuccessful = response.isNotEmpty;
      });
    } on SocketException catch (e) {
      print(e);
      setState(() {
        _isConnectionSuccessful = false;
      });
    }
  }


  @override
  dispose() {
    super.dispose();

    _connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {



    var formKey = GlobalKey<FormState>();
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();



    return BlocProvider(
      create: (BuildContext context)=> LoginCubit(),
      child: BlocConsumer< LoginCubit , LoginState >(
        listener: (context , state){
          if(state is LoginSuccessState )
          {

              if(state.loginModel.data != null) {

                showToast( msg: '${state.loginModel.message}' , state: ToastState.SUCCESS );

                CashHelper.saveData(
                    key: 'token', value: state.loginModel.data?.access_token).
                then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  DropScreen()));
                  CashHelper.saveData(
                      key: 'pnoneNum', value: state.loginModel.data?.phone)
                      .then((value) {

                  }).catchError((e) {});

                  CashHelper.saveData(
                      key: 'id', value: state.loginModel.data?.id).then((
                      value) {

                  }).catchError((e) {});
                });
              }

              else
                {
                  showToast( msg: '${state.loginModel.message}' ,
                      state: ToastState.ERROR );
                }

          }


        },
        builder: (context , state) {

          LoginCubit  cubit = LoginCubit.get(context);

          return WillPopScope(
            onWillPop: () async {
              return true ;
            },
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(65.0),
                child: AppBar(
                  backgroundColor: HexColor('#053F80'),

                  title: const Text('Log In '),
                  centerTitle: true,
                  automaticallyImplyLeading: false ,
                /*  actions: [
                    InkWell(child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Icon( Icons.logout ),
                    ) , onTap: (){
                      CashHelper.removeData(key: 'token').then((value) {

                        print('logout successfully');


                      }).catchError((e){
                        print(e.toString());
                      });
                    },),
                  ],*/

                ),
              ),
              body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child:
                      Form(
                        key: formKey ,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start ,
                          children: [

                            SizedBox(height: 160, child:  Image.asset('assets/images/bk.png' ,),),

                            SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: usernameController ,
                                keyboardType: TextInputType.emailAddress ,
                                validator: (value){
                                  if(value!.isEmpty) return 'Please enter your email address or phone' ;
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    label: Text('Email / Phone *')

                                ),
                              ),
                            ),

                            const SizedBox(height: 20,),

                            SizedBox(
                              height: 60,
                              child: TextFormField(
                                  controller: passwordController ,
                                  keyboardType: TextInputType.visiblePassword ,
                                  obscureText: cubit.obscuretext ,

                                  validator: (value){
                                    if(value!.isEmpty) return 'Please enter your password' ;
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userLogin(phone: usernameController.text , password: passwordController.text );

                                    }
                                  },
                                  decoration: InputDecoration(

                                    border: const OutlineInputBorder(),
                                    label: const Text('Password *' ,),
                                    suffixIcon: GestureDetector(
                                      onTap: (){
                                        cubit.changevisibiliy();
                                      },
                                      child: cubit.visible ,
                                    ),
                                  )
                              ),



                                  ),


                            const SizedBox(height: 30,),

                            SizedBox(

                              width: double.infinity,
                              height: 45,

                              child:
                              ConditionalBuilder(
                                condition: state is !LoginLoadingState ,
                                builder: (BuildContext context)=>
                                    MaterialButton(
                                  shape:  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  color: Colors.indigo,
                                  onPressed: ()
                                  {
                                    if(formKey.currentState!.validate())
                                    {
                                      cubit.userLogin(phone: usernameController.text , password: passwordController.text );
                                     /* Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => ScanScreen(phone: usernameController.text,)));*/

                                    }



                                  }
                                  ,
                                  child: const Text('Log In' ,
                                    style: TextStyle(
                                        color: Colors.white ,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 19
                                    ),),) ,
                                fallback: (context)=> const Center(child: CircularProgressIndicator()) ,
                              ),

                            ),


                            const SizedBox(height: 15,),

                          /*  Column(
                              children: [
                                TextButton(
                                    onPressed: ()
                                    {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgetPassScreen()));

                                    }, child: Center(
                                      child: Text('Forget Password?' ,
                                  style: TextStyle(color: Colors.orange ,
                                        fontWeight: FontWeight.w600),),
                                    )),

                                SizedBox(height: 5,),

                              ],
                            )*/
                          ],
                        ),
                      ),
                      // ]
                    ),
                  ),
                ),
            //  ),

              // )
            ),
          );
        },

      ),
    );
  }
}


