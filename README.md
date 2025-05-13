# Erste iOS Mobile Case Study

## 🎨 Screenshots
![Simulator Screenshot - iPhone 16 Pro - 2025-05-13 at 18 41 31](https://github.com/user-attachments/assets/59e54cf7-ba91-4f1e-bd71-dcd6745acf6a)
![Simulator Screenshot - iPhone 16 Pro - 2025-05-13 at 18 41 36](https://github.com/user-attachments/assets/50ff1bec-5598-406c-9727-568eae400aea)
![Simulator Screenshot - iPhone 16 Pro - 2025-05-13 at 18 41 40](https://github.com/user-attachments/assets/5eaa3d01-5548-4e53-8a0a-e687eba5b6b6)
![Simulator Screenshot - iPhone 16 Pro - 2025-05-13 at 18 41 27](https://github.com/user-attachments/assets/41717f90-997a-4b63-9b7e-99cfbb978382)


## 🛠️ Tech Stack & Libraries

### Tech Stack
- **Language:** Swift  
- **Development Environment:** Xcode  
- **Architecture:** MVVM (Model-View-ViewModel)  

### Libraries
- **Alamofire:** For networking and API requests  
- **Factory:** For dependency injection and object management  

## 📲 Features

### Core Features
- Fetch and display a list of transparent accounts  
- View detailed information about specific accounts  
- Paginated data loading for large account datasets  
- Offline data persistence for cached accounts and account details  

### Additional Features
- Error handling for API responses and data parsing  
- Modularized codebase with a focus on reusability and scalability  

## 📡 API Integration

### API Manager
The `TransparentAccountAPIManager` handles communication with the backend API. It leverages Alamofire for request management and a custom JSON decoder for parsing responses.

### API Configuration
- Base URL: Defined in AppConfig.xcconfig
- API Key: Defined in AppConfig.xcconfig
