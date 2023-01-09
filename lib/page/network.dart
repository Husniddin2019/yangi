import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../model/postmodel.dart';
import '../servise/httpService.dart';
import '../servise/loservese.dart';
class NetworkPage extends StatefulWidget {
  static final String id = "/netwerk_page";
  const NetworkPage({Key? key}) : super(key: key);

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  var isLoading = false;
  var items=[];
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPostList();
  }
  void _apiPostList()async{
    setState(() {
      isLoading= true;
    });
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if(response!=null){
    setState(() {
      isLoading=false;
      items = Network.parsePostList(response);
      print(response);

    });}
    else{}
  }

  void _apiCreate(Post post){
    Network.POST(Network.API_CREATE, Network.paramsCreate(post)).then((response) => {
      LogServise.i(response.toString()),

    });
  }

  void _apiUpdate(Post post){
    Network.PUT(Network.API_UPDETE+post.id.toString(), Network.paramsUpdate(post)).then((response) => {
      LogServise.i(response.toString()),
    });
  }
  void _apiDel(Post post){
    Network.DEL(Network.API_DELETE+post.id.toString(), Network.paramsEmpty()).then((response) => {
      _apiPostList(),
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("PDP"),

      ),
      body: Stack(
      children: [
          ListView.builder(itemCount: items.length,itemBuilder: (ctx,index){return itemHomePost(items[index]);},
          ),
        isLoading ? Center(
          child: CircularProgressIndicator(),
        ):
            SizedBox.shrink(),
],
      ),
    );
  }
   Widget itemHomePost(Post post){
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
              onPressed: (BuildContext context){_apiDel(post);

              }, flex: 3,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "delete",
              ),
          SlidableAction(
            onPressed: (BuildContext context){_apiDel(post);

            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.update,
            label: "update",
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(left: 20,right: 20,top: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title!.toUpperCase(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text(post.body!.toUpperCase(),style: TextStyle(color: Colors.black,),),

          ],
        ),
      ),
    );
   }
}
