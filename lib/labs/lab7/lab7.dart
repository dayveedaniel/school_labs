import 'package:flutter/material.dart';
import 'package:school_labs/labs/lab7/api_provider.dart';
import 'package:school_labs/labs/lab7/project_model.dart';

class Lab7 extends StatefulWidget {
  const Lab7({super.key});

  @override
  State<Lab7> createState() => _Lab7State();
}

class _Lab7State extends State<Lab7> {
  final apiProvider = ApiProvider();
  final controller = TextEditingController();
  bool isLoading = false;
  final List<ProjectModel> projects = [];
  ProjectModel? selectedProject;

  void clearData() {
    if (projects.isNotEmpty) projects.clear();
    if (selectedProject != null) selectedProject = null;
    setState(() {});
  }

  Future<void> findProjects() async {
    if (controller.text.trim().isEmpty) return;
    clearData();
    isLoading = true;
    setState(() {});
    final fetched = await apiProvider.fetchProjects(controller.text);
    isLoading = false;
    projects.addAll(fetched);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Лаб 7 Семенов Михаил')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            child: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      suffix: IconButton(
                        onPressed: () async => findProjects(),
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                if (isLoading)
                  const SliverToBoxAdapter(
                      child: CircularProgressIndicator.adaptive()),
                SliverFillRemaining(
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: projects.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                selectedProject = projects[index];
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.green),
                                ),
                                child: Text(
                                  projects[index].name,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (selectedProject == null && projects.isNotEmpty)
                              const Text('Choose the project'),
                            if (selectedProject != null && projects.isNotEmpty)
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.green),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                        'Project name: ${selectedProject!.name}'),
                                    Divider(color: Colors.green[400]),
                                    Text(
                                      "User: ${selectedProject!.owner.login}",
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 10),
                                    Image.network(
                                      selectedProject!.owner.avatarUrl,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Description:\n${selectedProject!.description}',
                                      textAlign: TextAlign.center,
                                    ),
                                    Divider(color: Colors.green[400]),
                                    Text(
                                      'Forks: ${selectedProject!.forksCount}',
                                      textAlign: TextAlign.center,
                                    ),
                                    Divider(color: Colors.green[400]),
                                    Text(
                                      'Score: ${selectedProject!.score}',
                                      textAlign: TextAlign.center,
                                    ),
                                    Divider(color: Colors.green[400]),
                                    Text(
                                      'Watchers count: ${selectedProject!.watchersCount}',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
