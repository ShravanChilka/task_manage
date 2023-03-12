// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:task_manage/features/task/data/models/task_model.dart';
// import 'package:task_manage/features/task/data/repository/task_repository.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({Key? key}) : super(key: key);

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TaskRepository repository =
//       TaskRepository(firestore: FirebaseFirestore.instance);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           TextField(
//             controller: _titleController,
//           ),
//           TextField(
//             controller: _descriptionController,
//           ),
//           ElevatedButton(
//             onPressed: () => saveClickEvent(),
//             child: const Text('Save'),
//           ),
//           StreamBuilder<QuerySnapshot<TaskModel>>(
//             stream: repository.getRef(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Text(snapshot.error.toString());
//               }
//               if (!snapshot.hasData) {
//                 return const CircularProgressIndicator();
//               }
//               final data = snapshot.requireData;
//               return Expanded(
//                 child: ListView.builder(
//                   itemCount: data.docs.length,
//                   itemBuilder: (context, index) {
//                     return Slidable(
//                       startActionPane: ActionPane(
//                         // A motion is a widget used to control how the pane animates.
//                         motion: const ScrollMotion(),

//                         // A pane can dismiss the Slidable.

//                         // All actions are defined in the children parameter.
//                         children: [
//                           // A SlidableAction can have an icon and/or a label.
//                           SlidableAction(
//                             onPressed: (context) {
//                               final doc = data.docs[index];
//                               repository.delete(doc: doc);
//                             },
//                             backgroundColor: Color(0xFFFE4A49),
//                             foregroundColor: Colors.white,
//                             icon: Icons.delete,
//                             label: 'Delete',
//                           ),
//                           SlidableAction(
//                             onPressed: (context) {},
//                             backgroundColor: Color(0xFF21B7CA),
//                             foregroundColor: Colors.white,
//                             icon: Icons.share,
//                             label: 'Share',
//                           ),
//                         ],
//                       ),

//                       // The end action pane is the one at the right or the bottom side.
//                       endActionPane: ActionPane(
//                         motion: ScrollMotion(),
//                         children: [
//                           SlidableAction(
//                             // An action can be bigger than the others.
//                             flex: 2,
//                             onPressed: (context) {},
//                             backgroundColor: Color(0xFF7BC043),
//                             foregroundColor: Colors.white,
//                             icon: Icons.archive,
//                             label: 'Archive',
//                           ),
//                           SlidableAction(
//                             onPressed: (context) {
//                               repository.updateNew(
//                                 doc: data.docs[index],
//                                 taskModel: TaskModel(
//                                   title: _titleController.text,
//                                   description: _descriptionController.text,
//                                   dateTime: DateTime.now(),
//                                 ),
//                               );
//                             },
//                             backgroundColor: Color(0xFF0392CF),
//                             foregroundColor: Colors.white,
//                             icon: Icons.save,
//                             label: 'Save',
//                           ),
//                         ],
//                       ),
//                       child: ListTile(
//                         title: Text(data.docs[index].data().title),
//                         subtitle: Text(data.docs[index].data().description),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }

//   void saveClickEvent() async {
//     final response = repository.create(
//       taskModel: TaskModel(
//         title: _titleController.text,
//         description: _descriptionController.text,
//         dateTime: DateTime.now(),
//       ),
//     );
//     response.fold(
//       (l) => log(l.toString()),
//       (r) => log(r),
//     );
//   }
// }
