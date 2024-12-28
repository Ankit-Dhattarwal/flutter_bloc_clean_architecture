# 🚀 Clean Architecture with S.O.L.I.D Principles in Flutter

This project is built using **Clean Architecture**, ensuring a robust and maintainable structure. It adheres to the **S.O.L.I.D principles** for better scalability, testability, and maintainability.

---

## 🏗️ Clean Architecture Layers

### 1. **Domain Layer** 🧠
- **Purpose**: Contains the core business logic.
- **Key Components**:
    - Entities: `User`, `Item`.
    - Use Cases: `find_user_by_id.dart`, `find_items.dart`.
    - Repositories: `IUserRepository`, `ItemRepository`.
- **S.O.L.I.D Principles**:
    - **SRP**: Each use case handles a specific business logic (e.g., finding a user by ID).
    - **LSP**: Entities like `UserModel` extend `User`, ensuring substitutability.
    - **OCP**: Repositories can be extended without modifying existing functionality.

---

### 2. **Data Layer** 🗂️
- **Purpose**: Manages data retrieval from APIs, local databases, or other sources.
- **Key Components**:
    - Models: `UserModel`, `ItemModel`.
    - Sources: `api_source`, `local_source`, `firestore_source`.
- **S.O.L.I.D Principles**:
    - **ISP**: Repositories only expose methods relevant to their functionality.
    - **DIP**: Data sources depend on abstractions provided by the domain layer.

---

### 3. **Presentation Layer** 🎨
- **Purpose**: Handles the user interface and interaction logic.
- **Key Components**:
    - State Management: `ItemBloc`, `UserBloc`.
    - UI: Pages, themes, components, routes.
- **S.O.L.I.D Principles**:
    - **DIP**: Uses dependency injection (`get_it`) to interact with the domain layer.

---

### 4. **Core Layer** ⚙️
- **Purpose**: Provides shared utilities, extensions, and error handling.
- **Key Components**:
    - Utilities: Error handling, extensions.
    - Services: Dependency injection (`get_it`).
- **S.O.L.I.D Principles**:
    - **SRP**: Each utility has a single purpose.

---

## 🔗 Dependency Injection
This project uses the **`get_it`** package for dependency injection, ensuring loose coupling and better testability.

---

## 🛠️ S.O.L.I.D Principles in Action

| Principle               | Layer             | Implementation                                                                 |
|--------------------------|-------------------|-------------------------------------------------------------------------------|
| **Single Responsibility** | Domain, Core      | Each class/module has one responsibility (e.g., `find_user_by_id` use case).  |
| **Open/Closed**           | Domain            | Repositories can be extended without modifying existing code.                 |
| **Liskov Substitution**   | Domain            | Entities like `UserModel` can substitute their parent (`User`).               |
| **Interface Segregation** | Data              | Repositories only expose relevant methods.                                    |
| **Dependency Inversion**  | Data, Presentation| Dependency injection (`get_it`) ensures layers depend on abstractions.        |

---

## 📈 Advantages

1. **Scalability**: Easily add new features without breaking existing code.
2. **Testability**: Clear separation of concerns makes it easy to test each layer.
3. **Maintainability**: Adherence to S.O.L.I.D ensures robust and predictable behavior.

---

🌟 I built this project using Clean Architecture and S.O.L.I.D principles! 🚀  
