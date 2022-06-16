
class UserTicket
{
  Data? data ;
  String? msg ;
  int? status ;
  bool? success ;
  dynamic errors ;

  UserTicket({this.errors , this.success , this.status , this.msg , this.data });

  Map<String , dynamic> toJson()
  {
    return
      {
        "data" : data?.toJson() ,
        "message": msg,
        "status": status,
        "success": success,
        "errors": errors
      };
  }

  UserTicket.FromJson(Map<String ,dynamic> json)
  {
    data = json['data'] !=null ? Data.FromJson(json['data']) : null ;
    msg = json["message"];
    status = json["status"];
    success =json["success"];
    errors = ["errors"];

  }
}




class Data
{
  int? id ;
  String? full_name ;
  String? first_name ;
  String? last_name ;
  String? email ;
  String? phone ;
  String? country_id ;
  String? gender ;
  int? verified ;
  String? created_at_date ;
  Avatar?  avatar ;

  Map<String , dynamic> toJson()
  {
    return
      {
         "id": id ,
        "full_name": full_name ,
        "first_name": first_name ,
        "last_name": last_name,
        "email": email ,
        "phone": phone ,
        "country_id": country_id ,
        "gender": gender ,
        "verified": verified ,
        "created_at_date": created_at_date ,
        "avatar": avatar?.toJson()

      };
  }

  Data.FromJson(Map<String ,dynamic> json)
  {
    id = json["id"] ;
    full_name = json["full_name"];
    first_name = json["first_name"];
    last_name =json["last_name"];
    email = json["email"];
   phone = json["phone"];
   country_id = json["country_id"];
  gender  = json["gender"];
    verified = json["verified"];
   created_at_date = json["created_at_date"];
   avatar = Avatar.fromJson( json["avatar"]);


  }

}




class Avatar
{
  String? thumb ;
  String? small ;
  String? medium ;
  String? large ;
  String? extraLarge ;
  String? original ;

  Avatar({this.original , this.extraLarge , this.large , this.medium , this.small , this.thumb});
  Map<String , dynamic> toJson ()
  {
    return {
      'thumb' : thumb ,
      'small' : small ,
      'medium' : medium ,
      'extra_large' : extraLarge ,
      'original' : original ,
      'large' : large
    };
  }

  Avatar.fromJson(Map<String ,dynamic> json)
  {
    thumb = json['thumb'];
    small = json['small'];
    medium = json['medium'];
    large =json['large'] ;
    extraLarge = json['extra_large'];
    original =json['original'];
  }

}