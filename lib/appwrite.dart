import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AppwriteService {
  late Client client;
  late Databases databases;

  static const endpoint="https://cloud.appwrite.io/v1";
  static const projectId="67a6f0050022482db0f5";
  static const databasesId="67a6f0900020b4e16021";
  static const textcollectionId="67a6f0b3003aed7bfcc0";
  static const taskcollectionId="67ab242f001f00f3a6d7";
  static const listcollectionId="67ac414700340080486d";

  AppwriteService(){
    client =Client();
    client.setEndpoint(endpoint);
    client.setProject(projectId);
    databases=Databases(client);
  }

  //text
  Future<List<Document>> getTextDetails()async{
    try{
      final result=await databases.listDocuments(databaseId: databasesId, collectionId: textcollectionId);
      return result.documents;
    }catch(e){
      print("error loading text:$e");
      rethrow;
    }
  }

  Future<Document> addText(String title,String content)async{
    try{
      final DocumentId=ID.unique();
      final result=await databases.createDocument(
        databaseId: databasesId,
        collectionId: textcollectionId,
        documentId: DocumentId,
        data: {
          "title":title,
          "content":content,
        });
        return result;
    }catch(e){
      print("error creating text:$e");
      rethrow;
    }
  }

  Future<Document> updateText(String documentId,String title,String content)async{
  try{
    final result= await databases.updateDocument(
      collectionId: textcollectionId,
      databaseId: databasesId,
      documentId: documentId,
      data:{
       "title":title,
       "content":content,
      },
    );
    return result;
  }catch(e){
    print("error updating text:$e");
    rethrow;
  }
}

  Future<void> deleteText(String documentId)async{
    try{
      await databases.deleteDocument(
        databaseId: databasesId,
        collectionId: textcollectionId,
        documentId: documentId
        );
    }catch(e){
      print("error updating text:$e");
      rethrow;
    }
  }

  //task 

  Future<List<Document>> getTaskDetails()async{
    try{
      final result=await databases.listDocuments(databaseId: databasesId, collectionId: taskcollectionId);
      return result.documents;
    }catch(e){
      print("error loading task:$e");
      rethrow;
    }
  }

  Future<Document> addTask(String title,String description,String date,String time)async{
    try{
      final DocumentId=ID.unique();
      final result=await databases.createDocument(
        databaseId: databasesId,
        collectionId: taskcollectionId,
        documentId: DocumentId,
        data: {
          "title":title,
          "description":description,
          "date":date,
          "time":time,
        });
        return result;
    }catch(e){
      print("error creating task:$e");
      rethrow;
    }
  }

  Future<Document> updateTask(String documentId,String title,String description,String date,String time)async{
  try{
    final result= await databases.updateDocument(
      collectionId: taskcollectionId,
      databaseId: databasesId,
      documentId: documentId,
      data:{
       "title":title,
       "description":description,
       "date":date,
       "time":time,
      },
    );
    return result;
  }catch(e){
    print("error updating task:$e");
    rethrow;
  }
}

  Future<void> deleteTask(String documentId)async{
    try{
      await databases.deleteDocument(
        databaseId: databasesId,
        collectionId: taskcollectionId,
        documentId: documentId
        );
    }catch(e){
      print("error updating task:$e");
      rethrow;
    }
  }

  //list
  Future<List<Document>> getListDetails()async{
    try{
      final result=await databases.listDocuments(databaseId: databasesId, collectionId: listcollectionId);
      return result.documents;
    }catch(e){
      print("error loading list:$e");
      rethrow;
    }
  }

  Future<Document> addList(String title,String items)async{
    try{
      final DocumentId=ID.unique();
      final result=await databases.createDocument(
        databaseId: databasesId,
        collectionId: listcollectionId,
        documentId: DocumentId,
        data: {
          "title":title,
          "items":items
        });
        return result;
    }catch(e){
      print("error creating list:$e");
      rethrow;
    }
  }

  Future<Document> updateList(String documentId,String title,String items)async{
  try{
    final result= await databases.updateDocument(
      collectionId: listcollectionId,
      databaseId: databasesId,
      documentId: documentId,
      data:{
       "title":title,
       "items":items,
      },
    );
    return result;
  }catch(e){
    print("error updating List:$e");
    rethrow;
  }
}

  Future<void> deleteList(String documentId)async{
    try{
      await databases.deleteDocument(
        databaseId: databasesId,
        collectionId: listcollectionId,
        documentId: documentId
        );
    }catch(e){
      print("error updating List:$e");
      rethrow;
    }
  }
}