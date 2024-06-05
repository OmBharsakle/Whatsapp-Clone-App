import 'package:flutter/material.dart';
import 'package:navbar_router/navbar_router.dart';
import '../../Utils/global.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff0B141B),
      appBar: AppBar(
        title: Text(
          'WhatsApp',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1,color: Colors.green),
        ),
        actions: [
          Icon(Icons.qr_code_scanner_rounded,color: Colors.black,),
          SizedBox(
            width: 18,
          ),
          Icon(Icons.camera_alt_outlined,color: Colors.black,),
          SizedBox(
            width: 15,
          ),
          Icon(Icons.search_rounded,color: Colors.black,),
          IconButton(onPressed: () {
            setState(() {
              isGrid=!isGrid;
            });
          },icon: (isGrid)? Icon(Icons.grid_view_rounded,color: Colors.black,):Icon(Icons.view_column_rounded,color: Colors.black,),),
          Icon(Icons.more_vert_rounded,color: Colors.black,),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: (isGrid)? ListView.builder(physics: BouncingScrollPhysics(),itemCount: Users.length,itemBuilder:  (context, index) => ListTile(
        title: Text(Users[index]['name'],style: TextStyle(fontWeight: FontWeight.w500),),
        subtitle: Text(Users[index]['subtitle'],),
        leading: CircleAvatar(
          backgroundImage: NetworkImage('https://as2.ftcdn.net/v2/jpg/05/89/93/27/1000_F_589932782_vQAEAZhHnq1QCGu5ikwrYaQD0Mmurm0N.jpg',),
          radius: 25,
        ),
        trailing: Container(
          width: 80,
          height: 33,
          decoration: BoxDecoration(
            color: Colors.greenAccent.shade100,
            borderRadius: BorderRadius.circular(20)
          ),
          alignment: Alignment.center,
          child: Text('Follow',style: TextStyle(color: Colors.green.shade900,fontWeight: FontWeight.w600,fontSize: 12),),
        )
      ),)
      : GridView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: Users.length,
        itemBuilder: (context, index) => Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage('https://as2.ftcdn.net/v2/jpg/05/89/93/27/1000_F_589932782_vQAEAZhHnq1QCGu5ikwrYaQD0Mmurm0N.jpg'),
                ),
                SizedBox(height: 5,),
                Text(Users[index]['name'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                Text(Users[index]['subtitle'],style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 80,
                  height: 33,
                  decoration: BoxDecoration(
                      color: Colors.greenAccent.shade100,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  alignment: Alignment.center,
                  child: Text('Follow',style: TextStyle(color: Colors.green.shade900,fontWeight: FontWeight.w600,fontSize: 12),),
                )
              ],
            )),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, ),
      ),
      // bottomNavigationBar: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  List<NavbarItem> items = [
    NavbarItem(Icons.home_outlined, 'Home',
        backgroundColor: mediumPurple,
        selectedIcon: Icon(
          Icons.home,
          size: 26,
        )),
    NavbarItem(Icons.shopping_bag_outlined, 'Products',
        backgroundColor: Colors.orange,
        selectedIcon: Icon(
          Icons.shopping_bag,
          size: 26,
        )),
    NavbarItem(Icons.person_outline, 'Me',
        backgroundColor: Colors.teal,
        selectedIcon: Icon(
          Icons.person,
          size: 26,
        )),
  ];

  final Map<int, Map<String, Widget>> _routes = const {
    0: {
      '/': Home_Page(),
      // FeedDetail.route: FeedDetail(),
    },
    1: {
      '/': Home_Page(),
      // ProductDetail.route: ProductDetail(),
    },
    2: {
      '/': Home_Page(),
      // ProfileEdit.route: ProfileEdit(),
    },
  };

  @override
  Widget build(BuildContext context) {
    return NavbarRouter(
      errorBuilder: (context) {
        return const Center(child: Text('Error 404'));
      },
      onBackButtonPressed: (isExiting) {
        return isExiting;
      },
      destinationAnimationCurve: Curves.fastOutSlowIn,
      destinationAnimationDuration: 600,
      decoration:
      NavbarDecoration(navbarType: BottomNavigationBarType.shifting),
      destinations: [
        for (int i = 0; i < items.length; i++)
          DestinationRouter(
            navbarItem: items[i],
            destinations: [
              for (int j = 0; j < _routes[i]!.keys.length; j++)
                Destination(
                  route: _routes[i]!.keys.elementAt(j),
                  widget: _routes[i]!.values.elementAt(j),
                ),
            ],
            initialRoute: _routes[i]!.keys.first,
          ),
      ],
    );
  }
}

bool isGrid=true;