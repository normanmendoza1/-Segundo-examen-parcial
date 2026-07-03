import 'package:flutter/material.dart';

// Punto de inicio de la aplicación.
void main() => runApp(const ExpenseApp());

// Configuración principal de la aplicación.
class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ExpenseScreen(),
    );
  }
}

// Se usa StatefulWidget para que la pantalla se actualice
// cuando se agregue o elimine un gasto.
class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  // Lista donde se almacenan los gastos registrados.
  final List<String> expenses = [
    'Comida: 15.50',
    'Transporte: 8.00',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior de la aplicación.
      appBar: AppBar(
        title: const Text('💸 Mis Gastos'),
      ),

      body: Column(
        children: [
          // Expanded evita errores de tamaño y permite que
          // la lista ocupe el espacio disponible.
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    // Muestra el gasto registrado.
                    title: Text(expenses[index]),

                    // Botón para eliminar un gasto.
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          expenses.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Botón para registrar un nuevo gasto.
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final controller = TextEditingController();

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Nuevo Gasto'),

                // Caja donde el usuario escribe el gasto.
                content: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: 'Ej: Café: 3.50',
                  ),
                ),

                actions: [
                  // Cierra la ventana sin guardar.
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar'),
                  ),

                  FilledButton(
                    onPressed: () {
                      // Evita guardar datos vacíos.
                      if (controller.text.trim().isNotEmpty) {
                        // Agrega el nuevo gasto y actualiza la pantalla.
                        setState(() {
                          expenses.add(controller.text.trim());
                        });
                      }

                      Navigator.pop(context);
                    },
                    child: const Text('Agregar'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
