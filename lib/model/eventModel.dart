class EventModel
{
   dynamic data ;
  String? message ;
  int? status ;
  bool? success ;
  dynamic errors ;

  EventModel({this.data , this.status , this.message , this.errors , this.success });

  Map<String , dynamic> toJson()
   {
     return
       {
         "data": data ,
         "message": message ,
         "status": status,
         "success": success,
         "errors": errors
       };
   }

  EventModel.FromJson(Map<String , dynamic> json)
  {
    data =json["data"];
    message = json["message"] ;
    status = json["status"] ;
    success = json["success"] ;
    errors = json["errors"];
  }
}


/*
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

}*/