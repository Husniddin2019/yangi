import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:yangi/page/create.dart';
import 'package:yangi/servise/authser.dart';

import '../model/postmodel.dart';
import '../servise/realtime.dart';

class MainPage extends StatefulWidget {
  static final String id = "main_page";

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isLoading = false;
  List <Post> items=[];

  Future _callCreatePage()async{
    Map results = await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context){
          return createPage();
        }));
    if (results!=null && results.containsKey("data")){ print(results["data"]);
    _apiPostList();
    }
  }

  @override
  void initState() {
   _apiPostList();
    super.initState();
  }
  _apiPostList()async{
    setState(() {
      isLoading=true;

    });
    var list = await RTBServise.getPost();
    items.clear();
    setState(() {

      items = list;
      isLoading =false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase"),
        actions: [
           IconButton(
          onPressed: (){AuthService.signOutUser(context);},
            color: Colors.white54,
              icon: Icon(Icons.logout),

           )],
      ),
      body: Stack(
        children: [
          ListView.builder(itemBuilder:(ctx,index){
            return itemOfPost(items[index]);
          }, itemCount: items.length,),
          isLoading ? Center(child: CircularProgressIndicator(),):SizedBox.shrink(),
        ],


        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: (){
          _callCreatePage();
        },
        child: Icon(Icons.add),
      ),

    );


  }
  Widget itemOfPost(Post post){
    return Slidable(child:
      Container(
      padding: EdgeInsets.all(20), child: Row(
      children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              width: 70,
              height: 70,
              child: post.img_url!=null? Image.network(post.img_url!, fit: BoxFit.cover,):Image.asset("assets/images/1.png") ,
            ),
            SizedBox(width: 15,),
            Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                  Text(post.title!,style: TextStyle(color: Colors.black, ),),
                  SizedBox(width:250,child: Text(post.body!,),),
              ],
            ),


          ],
        )
      ],
    ),
    ),
          startActionPane: ActionPane(
            motion: ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: (){},),
            children: [
              SlidableAction(
              onPressed: (BuildContext context){},
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,icon: Icons.edit,
                label: "Update",)
        ],
      ),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: (){},),
        children: [
          SlidableAction(
            onPressed: (BuildContext context){},
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,icon: Icons.delete,
            label: "Delete",)
        ],
      ),
      

    );

  }


}
