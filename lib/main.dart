import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_event_scanner/cubit/loginCubit.dart';

import 'data/local/cash_helper.dart';
import 'data/remote/dio_helper.dart';
import 'module/drop-screen/drop.dart';
import 'module/login-screen/loginScreen.dart';
import 'observer.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await CashHelper.init();
  DioHelper.init() ;

  dynamic token = CashHelper.getData(key: 'token');
  // print(token);

  Widget? start ;

  if(token != null )
    {
      start = DropScreen();
    }
  else
    {
      start = const LoginScreen() ;
    }

 return runApp( MyApp(start: start ,));
}

class MyApp extends StatelessWidget {
  final Widget? start ;

  const MyApp({Key? key , this.start}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> LoginCubit()..getAllCurrentEvent(),

        )],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.indigo,

        ),
        debugShowCheckedModeBanner: false ,
        home:
         start
        // ScanScreen()
       // const LoginScreen(),
      ),
    );
  }
}

