# Wuthering Wares

Aplikasi mobile e-commerce bertema Wuthering Waves untuk jual beli resonator equipment dan terminal supplies.

## Tentang Aplikasi

Wuthering Wares adalah aplikasi Flutter yang memungkinkan pengguna untuk browse dan membeli berbagai equipment untuk resonator mereka. Admin dapat mengelola katalog produk secara penuh melalui aplikasi yang sama.

## Fitur

- Login & Register (email/password dan Google OAuth)
- Browse katalog equipment lengkap dengan detail produk
- Beli equipment dengan autentikasi bearer token
- Admin panel untuk kelola produk (tambah, edit, hapus)

## Tech Stack

| Layer | Teknologi |
|---|---|
| Mobile App | Flutter 3.32.2 (Dart) |
| Backend | Node.js 22.16.0 + Express |
| Database | MySQL via XAMPP 8.2.12 |
| Auth | JWT Bearer Token + Google OAuth |

## Cara Menjalankan

### Backend
```bash
cd wuthering_wares_backend
npm install
npm run dev
```

### Flutter
```bash
flutter pub get
flutter run
```

## Struktur Project

```
project_wutheringwares/
├── lib/
│   ├── models/
│   ├── services/
│   ├── screens/
│   └── widgets/
└── wuthering_wares_backend/
    ├── config/
    ├── controllers/
    ├── middleware/
    └── routes/
```

## Mata Kuliah

COSC6094 - Mobile Hybrid Solution | Computer Science BINUS University