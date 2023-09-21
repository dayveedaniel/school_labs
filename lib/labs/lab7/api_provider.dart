import 'dart:convert';
import 'dart:io';

import 'package:school_labs/labs/lab7/project_model.dart';

class ApiProvider {
  final client = HttpClient();

  Future<List<ProjectModel>> fetchProjects(String query) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: 'api.github.com',
      path: '/search/repositories',
      query: 'q=$query',
    );
    final request = await client.getUrl(uri);
    final response = await request.close();
    final stringData = await response.transform(utf8.decoder).join();
    final json = jsonDecode(stringData);
    final List<ProjectModel> projects = List<ProjectModel>.from(
      json['items'].map((e) => ProjectModel.fromJson(e)),
    );
    return projects;
  }
}
