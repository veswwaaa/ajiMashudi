# Struktur Project Dashboard User

## 📁 Struktur Folder

```
lib/
├── main.dart                          # Entry point aplikasi
├── models/
│   ├── vehicle_type.dart             # Model untuk jenis kendaraan
│   └── location_marker.dart          # Model untuk marker lokasi di maps
├── screens/
│   └── home_screen.dart              # Screen utama aplikasi
└── widgets/
    ├── vehicle_card.dart             # Widget card untuk pilih kendaraan
    ├── google_map_widget.dart        # Widget Google Maps terintegrasi
    └── map_placeholder.dart          # Widget placeholder untuk map (opsional)
```

## 📄 File-File Penting

### Models

#### `models/vehicle_type.dart`
Mendefinisikan model untuk jenis kendaraan (Small, Medium, Large) dengan property:
- `name` - Nama kendaraan
- `capacity` - Kapasitas beban
- `price` - Harga layanan
- `icon` - Icon untuk kendaraan

#### `models/location_marker.dart`
Mendefinisikan model untuk marker lokasi di map dengan:
- `id` - Unique identifier
- `position` - Koordinat LatLng
- `title` & `description` - Informasi marker
- `type` - MarkerType (UserLocation, PickupPoint, DeliveryPoint, Vehicle)

### Widgets

#### `widgets/vehicle_card.dart`
Card component untuk menampilkan pilihan kendaraan dengan:
- Icon dan nama kendaraan
- Kapasitas
- Harga
- State selected/unselected dengan visual feedback

#### `widgets/google_map_widget.dart`
Widget untuk menampilkan Google Maps dengan:
- Integrasi Google Maps SDK
- Custom markers dengan berbagai warna
- Info window untuk setiap marker
- Auto-fit camera ke semua markers
- Callback saat marker di-tap

#### `widgets/map_placeholder.dart`
Mock map widget (dapat digunakan untuk development tanpa API key)

### Screens

#### `screens/home_screen.dart`
Screen utama yang menggabungkan:
- Google Map di bagian atas
- DraggableScrollableSheet dengan konten di bawah
- Search bar "Mau kirim kemana?"
- List pilihan kendaraan
- Button "Pesan Sekarang"
- Bottom navigation bar dengan 4 tab

## 🎨 Sistem Marker Warna

| Type | Warna | Icon | Keterangan |
|------|-------|------|-----------|
| userLocation | Biru | location_on | Lokasi pengguna saat ini |
| pickupPoint | Ungu | store_mall_directory | Titik jemput barang |
| deliveryPoint | Merah | home | Titik pengiriman |
| vehicle | Orange | local_shipping | Kendaraan pengiriman |

## 🚀 Features

✅ Google Maps terintegrasi
✅ Custom markers dengan icon sesuai peran
✅ Pilih jenis kendaraan dengan visual feedback
✅ Search bar untuk input lokasi
✅ Bottom navigation bar
✅ DraggableScrollableSheet untuk smooth UX
✅ Responsive design

## 📋 Dependencies

Lihat `pubspec.yaml` untuk daftar lengkap:
- `google_maps_flutter: ^2.6.0` - Integrasi Google Maps
- `geolocator: ^11.0.0` - Akses lokasi perangkat
- `permission_handler: ^12.0.1` - Handle permission

## 🔧 Setup

1. Dapatkan Google Maps API Key (lihat `GOOGLE_MAPS_SETUP.md`)
2. Tambahkan API Key ke Android dan iOS
3. Jalankan `flutter pub get`
4. Jalankan `flutter run`

## 📝 Catatan Pengembangan

- Setiap component terpisah dalam filenya sendiri untuk mudah di-maintain
- Menggunakan enum `MarkerType` untuk type-safety
- Extension methods untuk `MarkerType` memudahkan akses icon, warna, dan label
- Home screen menggunakan `initState` untuk setup markers data
- Map secara otomatis fit camera ke semua markers saat dibuka
