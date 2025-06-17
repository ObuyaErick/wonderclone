import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Text("Home")),
            SizedBox(width: 8),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfileScreen();
                    },
                  ),
                );
              },
              icon: Icon(Icons.account_circle_rounded),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Jpesa"),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _callCloudFunction("createJpesaRecipient", {
                  'mobile': '256712345678',
                }).then((res) {
                  if (res != null && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(res),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                });
              },
              child: const Text("Create Jpesa Recipient"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _callCloudFunction("withdrawJpesaGWalletFunds", {
                  'weddingId': '2MavJJ4uRjh0Qji5C8B2',
                }).then((res) {
                  if (res != null && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(res),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                });
              },
              child: const Text("Withdraw Jpesa G-Wallet Funds"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _callCloudFunction("creditJpesaGWallet", {
                  'weddingId': '2MavJJ4uRjh0Qji5C8B2',
                  'mobile': '256712345678',
                  'amount': 100,
                }).then((res) {
                  if (res != null && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(res),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 10),
                      ),
                    );
                  }
                });
              },
              child: const Text("Initiate Jpesa G-Wallet Contibution"),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _callCloudFunction(
    String functionName, [
    dynamic payload,
  ]) async {
    print("Calling $functionName");
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable(functionName)
          .call(payload);

      print("Result: ${result.data}");
      return "${result.data}";
    } on FirebaseFunctionsException catch (e) {
      print(
        "FirebaseFunctionsException: ${e.code} - ${e.message} - ${e.details}",
      );
      return "${e.message} ${e.details ?? ''}";
    } catch (e) {
      print("Error: $e");
      return e.toString();
    }
  }
}
