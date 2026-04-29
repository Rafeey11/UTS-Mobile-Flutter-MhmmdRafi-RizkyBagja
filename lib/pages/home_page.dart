import 'package:flutter/material.dart';
import '../models/participant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Participant> participants = [
    Participant(name: "Rizky Bagja", role: "Leader", isReady: true),
    Participant(name: "Rafeey", role: "Sweeper", isReady: true),
    Participant(name: "Steven", role: "Member", isReady: false),
    Participant(name: "Faqih", role: "Member", isReady: true),
  ];

  void _showFormDialog({int? index}) {
    final bool isEdit = index != null;

    final nameController = TextEditingController(
      text: isEdit ? participants[index].name : '',
    );
    final roleController = TextEditingController(
      text: isEdit ? participants[index].role : '',
    );
    bool isReadyStatus = isEdit ? participants[index].isReady : false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(isEdit ? 'Edit Peserta' : 'Tambah Peserta Baru'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap',
                        hintText: 'Masukkan nama...',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: roleController,
                      decoration: const InputDecoration(
                        labelText: 'Peran di Rombongan',
                        hintText: 'Contoh: Leader / Member / Sweeper',
                      ),
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Motor Siap Touring?'),
                      value: isReadyStatus,
                      activeColor: Colors.orange,
                      onChanged: (bool? value) {
                        setDialogState(() {
                          isReadyStatus = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal', style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {
                    if (nameController.text.isNotEmpty && roleController.text.isNotEmpty) {
                      setState(() {
                        final newParticipant = Participant(
                          name: nameController.text,
                          role: roleController.text,
                          isReady: isReadyStatus,
                        );

                        if (isEdit) {
                          participants[index] = newParticipant;
                        } else {
                          participants.add(newParticipant);
                        }
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Simpan', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteParticipant(int index) {
    setState(() {
      participants.removeAt(index);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Peserta berhasil dihapus'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rombongan Curug'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: participants.length,
        itemBuilder: (context, index) {
          final p = participants[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: const Color(0xFF1E1E1E),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: p.role == 'Leader' ? Colors.orange : Colors.grey[800],
                child: const Icon(Icons.sports_motorsports, color: Colors.white, size: 20),
              ),
              title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(p.role),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    p.isReady ? Icons.check_circle : Icons.warning,
                    color: p.isReady ? Colors.green : Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blueAccent, size: 20),
                    onPressed: () => _showFormDialog(index: index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent, size: 20),
                    onPressed: () => _deleteParticipant(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () => _showFormDialog(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}