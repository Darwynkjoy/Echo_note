import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AppwriteService {
  late Client client;
  late Databases databases;

  static const endpoint="https://cloud.appwrite.io/v1";
  static const projectId="67a6f0050022482db0f5";
  static const databasesId="67a6f0900020b4e16021";
  static const collectionId="67a6f0b3003aed7bfcc0";

  AppwriteService(){
    client =Client();
    client.setEndpoint(endpoint);
    client.setProject(projectId);
    databases=Databases(client);
  }

  Future<List<Document>> getTextDetails()async{
    try{
      final result=await databases.listDocuments(databaseId: databasesId, collectionId: collectionId);
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
        collectionId: collectionId,
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
      collectionId:collectionId,
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
        collectionId: collectionId,
        documentId: documentId
        );
    }catch(e){
      print("error updating text:$e");
      rethrow;
    }
  }
}