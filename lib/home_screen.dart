
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api/api_provider.dart';
import 'multi_part_request.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rest Api'),
        backgroundColor: Colors.lightGreen,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Call the getapi function from the ApiProvider
              Provider.of<ApiProvider>(context, listen: false).getApi();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MultiPartTask()),
              );
              // Call the getapi function from the ApiProvider
              Provider.of<ApiProvider>(context, listen: false)
                  .postApi(1,"Manam", "Intern");
            },
          ),
        ],
      ),
      body: Consumer<ApiProvider>(
        builder: (context, apiProvider, child) {
          // Check if data is still loading
          if (apiProvider.dataList.isEmpty) {
            // print('');
            return Center(child: CircularProgressIndicator());
          } else {
            // Render your UI with the dataList
            return ListView.builder(
              itemCount: apiProvider.dataList.length,
              itemBuilder: (context, index) {
                var list = apiProvider.dataList[index];
                return ListTile(
                  title: Text(list.firstName),
                  subtitle: Text(list.email),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(list.avatar),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

}

// return Scaffold(
//     appBar:
//         AppBar(title: Text('Rest Api'), backgroundColor: Colors.lightGreen,
//           actions: [
//             IconButton(
//               icon: Icon(Icons.refresh),
//               onPressed: () {
//                 // Call the getapi function from the ApiProvider
//                 Provider.of<ApiProvider>(context, listen: false).getApi();
//               },
//             ),
//           ],),
//     body: Consumer<ApiProvider>(builder: (context, provider, child) {
//       var list = provider.dataList;
//       print(list);
//       return list.isEmpty
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Container(
//               color: Colors.amber,
//               child: ListView(
//                 children: list.map((ModelClass modelClass) {
//                   return Card(
//                     color: Colors.white,
//                     child: ListTile(
//                       title: Text(modelClass.email),
//                       subtitle: Text('name: ${modelClass.firstName}'),
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(modelClass.avatar),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             );
//
//     }));
// }
//}
// for (Map<String, dynamic> user in data['data']) {
// dataList.add(ModelClass(
// id: user['id'].toString(),
// email: user['email'],
// firstName: user['first_name'],
// lastName: user['last_name'],
// avatar: user['avatar'],
// ));
// print(dataList);
// }
//
// if (response.statusCode == 200) {
// final Map<String, dynamic> responseData = jsonDecode(response.body);
// final dynamic data = responseData['data'];
//
// if (data is List) {
// dataList = List<Map<String, dynamic>>.from(data)
//     .map((i) => ModelClass.fromJson(i))
//     .toList();
// return dataList;
// } else {
// throw Exception('Unexpected JSON structure: $data');
// }
// }
