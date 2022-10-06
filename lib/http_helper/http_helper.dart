import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHelper {
  //// ---- fetching all items ------/////
  Future<List<Map>> fetchItems() async {
    List<Map> items = [];

    //// -- Get the data from the api
    http.Response response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    if (response.statusCode == 200) {
      // get the data from the respones
      String jsonString = response.body;
      // convert to List<Map>
      List data = jsonDecode(jsonString);
      items = data.cast();
    }

    return items;
  }

  //// ----- Fetch dertails of one item ----//////
  Future<Map> getItem(itemId) async {
    Map item = {};

    /// -- Get the item from api
    http.Response response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/posts/$itemId"));

    if (response.statusCode == 200) {
      String jsonString = response.body;
      item = jsonDecode(jsonString);
    }
    return item;
  }

  ///// ---- Add one item -------/////////
  Future<bool> addItem(Map data) async {
    bool status = false;

    /// -- Add item to the database, call the api
    http.Response response = await http.post(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        body: jsonEncode(data),
        headers: {'Content-type': 'application/json'});

    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }
    return status;
  }

  //// -------Update one item ---- ////////
  Future<bool> updateItem(Map data, String itemId) async {
    bool status = false;

    /// -- Update the item,call the api
    http.Response response = await http.put(
        Uri.parse("https://jsonplaceholder.typicode.com/posts/$itemId"),
        body: jsonEncode(data),
        headers: {'Content-type': 'application/json'});

    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }
    return status;
  }

  //// ------ Delete one item ---- ////////
  Future<bool> deleteItem(String itemId) async {
    bool status = false;

    ///--Delete the item from database
    http.Response response = await http.delete(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/$itemId"),
    );
    if (response.statusCode == 200) {
      status = true;
    }
    return status;
    ;
  }
}
