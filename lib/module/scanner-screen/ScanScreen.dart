
/*
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_event_scanner/cubit/loginCubit.dart';
import 'package:q_event_scanner/cubit/loginState.dart';
import 'package:q_event_scanner/module/ticket-screen/ticket.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {

  final String? phone ;
  const ScanScreen({Key? key , this.phone}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
     controller!.resumeCamera();
  }


  @override
  Widget build(BuildContext context) {

    return BlocConsumer< LoginCubit , LoginState>(
      listener: (context, state) => {},
      builder: (context, state) {
        return  Scaffold(
        appBar: AppBar(),
     body: Column(
    children: <Widget>[
    Expanded(flex: 4, child: _buildQrView(context)),
    /*   Expanded(
                flex: 1,
                child:
                FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        if (result != null)
                          Center(
                            child:
                            Text(' ${describeEnum(result!.format)} \n  Data: ${result!.code }',
                              style: TextStyle(fontSize: 13),),

                          )

                        else
                          Text('Scan a code' , style: TextStyle(fontSize: 10), ),

                      ]),


                )) ,*/


    ],
    ),
    );
      } ,
    );
  }

  Widget _buildQrView(BuildContext context) {

    // control width
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        // ? 200.0
        // : 350.0;
        ? 300.0
        : 400.0;

    return QRView(
      key: qrKey,
      onQRViewCreated:_onQRViewCreated ,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {

    setState(() {
      this.controller = controller;
    });

    // 0521463987

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        // print('++++ ${scanData.code}');

        if(scanData.code?.split('tel:')[1] == '${widget.phone}')
        {
           // print(scanData.code.split('tel:')[1]);
           Navigator.push(context, MaterialPageRoute(builder: (context)=> const TicketScreen()));
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {

    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }



}


*/




/*
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key,}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanScreen();
}

class _ScanScreen extends State<ScanScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),

         /* Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume', style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),*/



        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 400.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }


}*/




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:q_event_scanner/cubit/loginCubit.dart';
import 'package:q_event_scanner/cubit/loginState.dart';
import 'package:q_event_scanner/data/local/cash_helper.dart';
import 'package:q_event_scanner/module/drop-screen/drop.dart';


class ScanScreen extends StatefulWidget {
    String? eventID ;

    ScanScreen({Key? key , this.eventID}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {

  final MobileScannerController _mobileScanController = MobileScannerController() ;


  @override
  dispose() {
    _mobileScanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    LoginCubit cubit = LoginCubit.get(context);
    print('208 ${widget.eventID}');

    return BlocConsumer<LoginCubit , LoginState >(

       listener: (context , state ){

         /*if(state is GetUserEventScanSuccessState )

         {
              print('22222222222222222222');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${cubit.userTicket?.msg}'),

                ),
                backgroundColor: cubit.userTicket?.status == 200
                    ? Colors.green
                    : Colors.yellow,
                action: SnackBarAction(
                  label: cubit.userTicket?.status != 200 ? 'Try Again' : '',
                  textColor: Colors.white,
                  onPressed: () {
                    // setState((){
                    CashHelper.removeData(key: 'eventName');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DropScreen()));
                    // });

                  },

                )

              // duration: Duration(microseconds: 1500),
            ),

            );

         }
         */




      },
       builder: (context , state ){

         return WillPopScope(
            onWillPop :() async {
              print('Back Button pressed!');
              return true ;
            } ,
           child: Scaffold(
             backgroundColor: Colors.grey.withOpacity(0.6),
             appBar: AppBar(
               // backgroundColor:Colors.grey.withOpacity(0.6) ,
               elevation: 0,
               title:  const Text('SCAN ME' , style: TextStyle(color: Colors.white ),) ,
               centerTitle: true ,
               backgroundColor: HexColor('#053F80'),

               leading: InkWell(child: const Icon(Icons.arrow_back_ios_rounded),
                 onTap: (){
                   Navigator.pop(context);
                 },),

             ),

             body: SingleChildScrollView(
               child: Center(

                 child: Column(
                   children: [

                   //  const SizedBox(height: 100,),
                   //  Text('SCAN ME' , style: TextStyle(color: Colors.white ),),
                      const SizedBox(height: 120,),

                     Center(
                       child: SizedBox(
                         height: 350,
                         width: 300,
                         child: Stack(
                           children: [
                             MobileScanner(
                               allowDuplicates: false ,
                                 controller: _mobileScanController,
                                 onDetect: (barcode, args) {
                                 final  String  code = barcode.rawValue!;
                                   debugPrint('Barcode found! $code');
                                   print('88 ${code.substring(0,1)}');
                                 print('88088 ${code.substring(1)}');

                                 if( code.trim().substring(0,1) != '#' )

                               {
             //  Navigator.push(context, MaterialPageRoute(builder: (context)=> const TicketErrorScreen()));
              /* _mobileScanController.barcodes.listen((barcode) {
                                       _mobileScanController.dispose();
                                     });*/
                                 _mobileScanController.barcodes.listen((barcode) {
                                   _mobileScanController.dispose();

                                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                     backgroundColor: Colors.red ,
                                     content: Padding(
                                       padding: EdgeInsets.all(8.0),
                                       child: Text('Qr not valid , please try Again!'),
                                     ),
                                     // duration: Duration(microseconds: 50000),
                                   ));

                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                       DropScreen()));

                                 });

                       /*  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                         backgroundColor: Colors.red ,
                         content: Padding(
                         padding: const EdgeInsets.all(8.0),
                          child: Text('Qr not valid , please try Again!'),
                         ),
                           // duration: Duration(microseconds: 50000),
                         ));*/

                       /*  _mobileScanController.barcodes.listen((barcode) {
                         _mobileScanController.dispose();

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                             DropScreen()));

                                 });*/

                                     }


                                       else
                                         {

                                            _mobileScanController.barcodes.listen((barcode) {
                                         _mobileScanController.dispose();

                                         cubit.getUserTicketScan(
                                         refID: code.trim().substring(1) ,
                                         eventID: widget.eventID).then((value) {
                                           print('7777777777777777777777${value.msg}');
                                           ScaffoldMessenger.of(context)
                                               .showSnackBar(
                                             SnackBar(
                                                 content: Padding(
                                                   padding:
                                                   const EdgeInsets.all(8.0),
                                                   child:
                                                   Text(
                                                       // '${cubit.userTicket?.msg}'
                                                     '${value.msg}'
                                                   ) ,
                                                 ),
                                                 backgroundColor:
                                                 // cubit.userTicket?.status
                                                 value.status

                                                     ==
                                                     200
                                                     ? Colors.green
                                                     : Colors.black,
                                                 action: SnackBarAction(
                                                   label:
                                                   // cubit.userTicket?.status
                                                   value.status

                                                       !=
                                                       200
                                                       ? 'Try Again'
                                                       : '',
                                                   textColor: Colors.white,
                                                   onPressed: () {
                                                     // setState((){
                                                     CashHelper.removeData(
                                                         key: 'eventName');
                                                     Navigator.push(
                                                         context,
                                                         MaterialPageRoute(
                                                             builder: (context) =>
                                                                 DropScreen()));
                                                     // });
                                                   },
                                                 )

                                               // duration: Duration(microseconds: 1500),
                                             ),
                                           );


                                         });

                                         Navigator.push(context, MaterialPageRoute(builder: (context) {
                                         return DropScreen(eventIDFromScan: code.trim().substring(1) ,);
                                         }));






                                            });








                                       }

                                 }
                             ),

                             Column(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Container(
                                       width: 50,
                                       height: 5,
                                       color: Colors.white,
                                       /* decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide( //
                                          color: Colors.white,
                                        //  width: 3.0,

                                        ),
                                      /*  top: BorderSide( //                    <--- top side
                                          color: Colors.white,
                                          width: 3.0,
                                        ),*/
                                      ),
                                    ),*/
                                     ),
                                     Container(
                                       width: 50,
                                       height: 5,
                                       color: Colors.white,
                                       /* decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide( //
                                          color: Colors.white,
                                        //  width: 3.0,

                                        ),
                                      /*  top: BorderSide( //                    <--- top side
                                          color: Colors.white,
                                          width: 3.0,
                                        ),*/
                                      ),
                                    ),*/
                                     ),
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Container(
                                       width: 50,
                                       height: 5,
                                       color: Colors.white,
                                       /* decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide( //
                                          color: Colors.white,
                                        //  width: 3.0,

                                        ),
                                      /*  top: BorderSide( //                    <--- top side
                                          color: Colors.white,
                                          width: 3.0,
                                        ),*/
                                      ),
                                    ),*/
                                     ),
                                     Container(
                                       width: 50,
                                       height: 5,
                                       color: Colors.white,
                                       /* decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide( //
                                          color: Colors.white,
                                        //  width: 3.0,

                                        ),
                                      /*  top: BorderSide( //                    <--- top side
                                          color: Colors.white,
                                          width: 3.0,
                                        ),*/
                                      ),
                                    ),*/
                                     ),
                                   ],
                                 ),
                               ],
                             ),

                             Column(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Container(
                                       width: 5,
                                       height: 50,
                                       color: Colors.white,
                                       /* decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide( //
                                                  color: Colors.white,
                                                //  width: 3.0,

                                                ),
                                              /*  top: BorderSide( //                    <--- top side
                                                  color: Colors.white,
                                                  width: 3.0,
                                                ),*/
                                              ),
                                            ),*/
                                     ),
                                     Container(
                                       width: 5,
                                       height: 50,
                                       color: Colors.white,
                                       /* decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide( //
                                                  color: Colors.white,
                                                //  width: 3.0,

                                                ),
                                              /*  top: BorderSide( //                    <--- top side
                                                  color: Colors.white,
                                                  width: 3.0,
                                                ),*/
                                              ),
                                            ),*/
                                     ),
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Container(
                                       width: 5,
                                       height: 50,
                                       color: Colors.white,
                                       /* decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide( //
                                                  color: Colors.white,
                                                //  width: 3.0,

                                                ),
                                              /*  top: BorderSide( //                    <--- top side
                                                  color: Colors.white,
                                                  width: 3.0,
                                                ),*/
                                              ),
                                            ),*/
                                     ),
                                     Container(
                                       width: 5,
                                       height: 50,
                                       color: Colors.white,
                                       /* decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide( //
                                                  color: Colors.white,
                                                //  width: 3.0,

                                                ),
                                              /*  top: BorderSide( //                    <--- top side
                                                  color: Colors.white,
                                                  width: 3.0,
                                                ),*/
                                              ),
                                            ),*/
                                     ),
                                   ],
                                 ),
                               ],
                             ),
                           ],
                         ),
                       ),
                     ),



                   ],
                 ),
               ),
             ),


           ),
         );
       },
     );



  }
}




