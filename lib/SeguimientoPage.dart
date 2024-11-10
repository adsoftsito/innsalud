import "MyAppState.dart";
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

String linkPostMutation = """
mutation CreateRecord(\$talla : Int!,  
                      \$cintura : Int!,
                      \$cadera : Int!,
                      \$peso : Float!,  
                      \$actfisica : Int!,
                      \$actfisican : Int!,  
                      \$bebidasugar : Int!,
                      \$bebidasugarn : Int!,                      
                      ) {
  createRecord(
    talla: \$talla 
    cintura: \$cintura
    cadera: \$cadera 
    peso: \$peso
    actfisica: \$actfisica 
    actfisican: \$actfisican
    bebidasugar: \$bebidasugar 
    bebidasugarn: \$bebidasugarn
  ) {
    talla
    peso
    cintura
    cadera
    actfisica
    actfisican
    bebidasugar
    bebidasugarn
    postedBy {
      username
    }
  }
}
""";

class SeguimientoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var appState = context.watch<MyAppState>();

    var appState = context.watch<MyAppState>();

    if (appState.token.isEmpty) {
      return Center(
        child: Text('No login yet.'),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

                Text(
                   "Bienvenido :${appState.username}",

                ),
          SizedBox(height: 20),

            Text(
                  "Seguimiento Semanal",
            ),
          SizedBox(height: 20),

            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
              hintText: 'Talla, altura (cms)',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
              hintText: 'Peso (kg)',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
              hintText: 'Medida cintura (cms)',
              ),
            ),TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
              hintText: 'Medida de cadera (cms)',
              ),
            ),
          SizedBox(height: 20),

            Text(
                  "Realizaste actividad fisica ?",
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
              hintText: 'Cuantas veces ?',
              ),
            ),
                      SizedBox(height: 20),

            Text(
                  "Ingeriste bebidas azucaradas ?",
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
              hintText: 'Cuantas veces ?',
              ),
            ),
          SizedBox(height: 20),
          SizedBox(height: 20),

           Row(
            mainAxisSize: MainAxisSize.min,
            children: [
             Mutation(
               options: MutationOptions(
                 document: gql(linkPostMutation),
                 // ignore: void_checks
                 update: (cache, result) {
                     return cache;
                 },
                 onCompleted: (result) {
                 if (result == null) {
                      print('Completed with errors ');
                   }  else {
                     print('ok ...');
                     print(result);
                   }
                 },
                 onError: (error)  {
                   print('error :');
                   appState.error = error!.graphqlErrors[0].message.toString();
                   print(error?.graphqlErrors[0].message);
                 },

               ),
               builder: ( runMutation,  result) {

                 return ElevatedButton(
                 onPressed: ()  {
                   // ignore: await_only_futures
                   runMutation({  
                                  "talla": 190,
                                  "peso": 90.5,
                                  "cintura": 90,
                                  "cadera": 80,
                                  "actfisica": 1,
                                  "actfisican": 5,
                                  "bebidasugar" : 1,
                                  "bebidasugarn": 5

                               });
                 },
                 child: const Text('Guardar registro'),
                  );
               }          
              ),

              /*
              ElevatedButton(
                onPressed: () {
                  //appState.callModel();
                },
                child: Text('Guardar registro'),
              ),
              */
            ],
          ),
        ],
      ),
    );
  }
} 
