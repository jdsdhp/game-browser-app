# 📌 Proyecto: Game Browser App

## 📖 Descripción
Esta aplicación permite a los usuarios explorar y gestionar una lista de videojuegos obtenida desde una API pública. Los juegos se almacenan en una base de datos local para permitir búsquedas y gestión sin necesidad de recurrir constantemente a la API.

## 🚀 Características principales
- ✅ **Listado de juegos** con información detallada.
- 🔍 **Búsqueda** por título y categoría.
- 🗑 **Eliminación** de juegos desde la lista o pantalla de detalle.
- 📦 **Almacenamiento local** con `SwiftData` para un acceso rápido.

---

## 📌 Decisiones Técnicas

### 📂 Arquitectura
Se implementó una **arquitectura MVVM + Clean Architecture**, asegurando una separación clara de responsabilidades:

- **View (SwiftUI):** Renderiza la UI y maneja la interacción con el usuario.
- **ViewModel:** Actúa como intermediario entre la Vista y el Dominio, gestionando la lógica de presentación.
- **Domain:** Contiene las reglas de negocio y las interfaces de los repositorios.
- **Data:** Implementa la persistencia con `SwiftData` y la obtención de datos desde la API.

### 🏗 Inyección de Dependencias
Se implementó una **factoría de ViewModels** (`ViewModelFactory`) para centralizar la creación de ViewModels, reduciendo el acoplamiento en las vistas y facilitando la escalabilidad.

### 📌 Persistencia con `SwiftData`
Se decidió utilizar `SwiftData` para almacenar los juegos localmente y evitar llamadas innecesarias a la API. Esto permite que la aplicación funcione offline.

### 🔄 Gestión de Eliminación y Sincronización
- Al eliminar un juego desde **Home o GameDetailView**, se actualiza la UI automáticamente sin necesidad de recargar la API.
- Se reutilizó la lógica de `onDelete` para evitar código duplicado.
- Se implementó un filtrado eficiente de juegos en memoria para mejorar el rendimiento.
