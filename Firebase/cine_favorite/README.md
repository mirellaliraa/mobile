# CineFavorite - Formativa
Construir um aplicativo do zero - O CineFavorite permitirá criar uma conta e buscar filmes em uma API e montar uma galeria pessoal de filmes favoritos, com posters e notas

## Objetivos
- Criar uma galeria personalizada por Usuário de Filmes favoritos
- Conectar o APP com uma API(base de dados) de filmes
- Permitir a criação de contas para cada usuário
- Listar filmes por palavra-chave

## levantamento de requisitos do projeto
- ### Funcionais

- ### Não funcionais

## Recursos do projeto
- Flutter/Dart
- Firebase (Authentication / FireStore DataBase)
- API TMDB
- Figma
- VsCode

## Diagramas

1. ### Classes
    Demonstrar o funcionamento das entidades do sistema
    - Usuário (User) : classe já modela pelo FirebaseAuth
        - email
        - password
        - uid
        - login()
        - create()
        - logout()

    - FilmeFavorito: Classe modelada pelo DEV
        - number:id
        - String: Titulo
        - String: Poster
        - double: Rating
        - adicionar()
        - remover()
        - listar()
        - updateNota()

```mermaid
classDiagram
    class User{
        +String uid
        +String email
        +String password
        +createUser()
        +login()
        +logout()
    }

    class FavoriteMovie{
        +String id
        +String title
        +String posterPath
        +double rating
        +addFavorite()
        +removeFavorite()
        +updateFavorite()
        +readList()
    }

    User "1" -- "1+" FavoriteMovie : "save"

```

2. ### Uso
    Ações que os atores podem fazer
    - User:
        - Registrar
        - Login
        - Logout
        - Procurar filmes API
        - Salvar filmes favoritos
        - Dar nota aos filmes
        - Remover dos favoritos
```mermaid
graph TD
    subgraph "Ações"
        uc1([Register])
        uc2([Login])
        uc3([LogOut])
        uc4([Search Movie])
        uc5([Favorite Movie])
        uc6([Rating Movie])
        uc7([Remove Favorite Movie])
    end

    User([Usuário])

    user --> uc1
    user --> uc2
    user --> uc3
    user --> uc4
    user --> uc5
    user --> uc6
    user --> uc7

    uc1 --> uc2
    uc2 --> uc3
    uc2 --> uc4
    uc2 --> uc5
    uc2 --> uc6
    uc2 --> uc7

```

3. ### Fluxo
    Determina o caminho percorrido pelo ator para executar uma ação

    - Ação de login

```mermaid

graph TD
    A[Início] --> B{Login usuário}
    B --> C[Inserir email e senha]
    C --> D{Validar as credenciais}
    D --> E[Sim]
    C --> F[Tela de favoritos]
    D --> G[Não]
    G --> B

```

## Prototipagem

## Codificação