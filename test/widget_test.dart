import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:detatest/main.dart';
import 'dart:convert';

void runPostTest() async {
  await postMessage("hello, world", 42, "russell").then((response) {
    print('${response.statusCode}');
    print(response.body);
  });
}

void makeManyPosts() async {
  final values = [1, 2, 3, 4, 5];
  for (var element in values) {
    await postMessage("many posts $element", element, "russell manyposts")
        .then((response) => print(response.body));
  }
}

void queryPosts() async {
  await queryMessages().then(
    (response) {
      final wrapper = jsonDecode(response.body);
      print(wrapper);
      final list = wrapper['items'];
      final posts = list.map((e) => Post.fromJson(e)).toList();
      print(posts.length);
      print(posts[1].message);
    },
  );
}

void main() {
  test('that the post occurs', runPostTest);

  test('many posts', makeManyPosts);

  test('query posts', queryPosts);
}
