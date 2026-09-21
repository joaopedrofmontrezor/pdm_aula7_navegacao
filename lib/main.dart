import 'package:flutter/material.dart';
import 'tela_resumo.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aula 7 - Navegação',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const TelaContador(),
    );
  }
}

class TelaContador extends StatefulWidget {
  const TelaContador({super.key});

  @override
  State<TelaContador> createState() => _TelaContadorState();
}

class _TelaContadorState extends State<TelaContador> {
  int _quantidade = 1;
  final String _nomeProduto = 'Smartphone Galaxy S24';

  
  final double _precoUnitario = 150.00;

  void _incrementar() {
    setState(() {
      _quantidade++;
    });
  }

  void _decrementar() {
    if (_quantidade > 1) {
      setState(() {
        _quantidade--;
      });
    }
  }

  
  void _zerarContador() {
    setState(() {
      _quantidade = 1;
    });
  }

  
  void _avancarParaResumo() async {
    final double valorTotal = _quantidade * _precoUnitario;

    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaResumo(
          item: _nomeProduto,
          quantidade: _quantidade,
          valorTotal: valorTotal,
        ),
      ),
    );

    
    if (resultado == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pedido Confirmado com Sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double valorTotalAtual = _quantidade * _precoUnitario;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleção de Itens'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _nomeProduto,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              
              Text(
                'Preço unitário: R\$ ${_precoUnitario.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                'Total: R\$ ${valorTotalAtual.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filledTonal(
                    onPressed: _decrementar,
                    icon: const Icon(Icons.remove),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      '$_quantidade',
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: _incrementar,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              OutlinedButton.icon(
                onPressed: _zerarContador,
                icon: const Icon(Icons.refresh),
                label: const Text('Zerar Contador'),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _avancarParaResumo,
                child: const Text('Avançar para Resumo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}