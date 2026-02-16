# Google Maps Integration Setup

## Langkah-langkah Setup Google Maps

### 1. Android Setup

Edit file `android/app/build.gradle`:
```gradle
android {
    ...
    compileSdkVersion 34
    ...
}
```

Edit file `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

<application>
    <meta-data
        android:name="com.google.android.geo.API_KEY"
        android:value="YOUR_API_KEY_HERE" />
    ...
</application>
```

### 2. iOS Setup

Edit file `ios/Runner/Info.plist`:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs to access your location to show it on the map.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app needs to access your location to show it on the map.</string>
<key>GMSAPIKey</key>
<string>YOUR_API_KEY_HERE</string>
```

Edit file `ios/Podfile`:
```ruby
# Uncomment this line untuk iOS 12
# platform :ios, '12.0'
```

### 3. Dapatkan API Key

1. Buka [Google Cloud Console](https://console.cloud.google.com/)
2. Buat project baru atau pilih project yang ada
3. Enable API:
   - Google Maps SDK for Android
   - Google Maps SDK for iOS
4. Buat API Key di "Credentials"
5. Ganti `YOUR_API_KEY_HERE` dengan API key Anda

### 4. Jalankan Aplikasi

```bash
flutter pub get
flutter run
```

## Struktur Markers

Aplikasi menggunakan sistem MarkerType dengan 4 jenis:

1. **userLocation** (Biru) - Lokasi pengguna saat ini
2. **pickupPoint** (Ungu) - Titik jemput barang
3. **deliveryPoint** (Merah) - Titik pengiriman
4. **vehicle** (Orange) - Kendaraan pengiriman

Setiap marker memiliki icon dan warna yang berbeda untuk membedakan fungsinya.
