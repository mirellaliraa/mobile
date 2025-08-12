# json_shared_preferences

Shared Preferences (Armazenamento interno do aplicativo)

Armazenamento   Chave -> Valor
                "config" -> "Texto" texto em formato Json

O que é um texto em formato Json ->
[
    config:{
        "NomedoUsuario" : "nome do usuário",
        "IdadedoUsuario" : 25,
        "TemaEscuro" : true,
    }
]

dart    -> Linguagem de programação do flutter que não lê JSON
        -> converter => ( json.decode => converte Text:Json em Map:Dart)
                     => ( json.enconde => converte Map:Dart em Text:Json)