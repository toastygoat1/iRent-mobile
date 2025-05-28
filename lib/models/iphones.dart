// isinya atribut iphone seperti nama, harga, deskripsi, gambar, dll.

class Iphone {
  final String title;
  final String imageUrl;
  final Map<String, int> storagePrices; // key: storage, value: price
  final String description;

  Iphone({
    required this.title,
    required this.imageUrl,
    required this.storagePrices,
    required this.description,
  });
}


final iphones = [
  Iphone(
    title: 'iPhone 14 Pro',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    storagePrices: {
      '128GB': 200000,
      '256GB': 225000,
      '512GB': 250000,
    },
    description: '''Layar: 6,1 inci Super Retina XDR dengan ProMotion 120Hz

Chipset: A16 Bionic

Kamera: Tiga kamera (48MP wide, 12MP ultra-wide, dan telefoto)

Fitur Unggulan:
- Dynamic Island interaktif
- Always-on Display
- ProRAW & ProRes untuk foto dan video profesional

Cocok Untuk: Kreator konten dan pengguna intensif'''
  ),
  Iphone(
    title: 'iPhone 14',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    storagePrices: {
      '128GB': 160000,
      '256GB': 180000,
      '512GB': 200000,
    },
    description: '''Layar: 6,1 inci Super Retina XDR OLED

Chipset: A15 Bionic

Kamera: Kamera ganda 12MP (wide dan ultra-wide)

Fitur Unggulan:
- Mode Sinematik untuk video bokeh otomatis
- Tahan air dan debu (IP68)
- Baterai lebih tahan lama dibanding iPhone 13

Cocok Untuk: Pengguna harian yang butuh performa kencang dan kualitas kamera stabil'''
  ),
  Iphone(
    title: 'iPhone 13 Pro',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    storagePrices: {
      '128GB': 150000,
      '256GB': 170000,
      '512GB': 190000,
    },
    description: '''Layar: 6,1 inci Super Retina XDR OLED dengan refresh rate 120Hz

Chipset: A15 Bionic dengan 5-core GPU

Kamera: Tiga kamera Pro + LiDAR scanner

Fitur Unggulan:
- Mode makro dan malam yang lebih baik
- ProMotion untuk tampilan mulus
- Material stainless steel premium

Cocok Untuk: Fotografer, editor, dan profesional'''
  ),
  Iphone(
    title: 'iPhone 13',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    storagePrices: {
      '128GB': 120000,
      '256GB': 135000,
      '512GB': 150000,
    },
    description: '''Layar: 6,1 inci Super Retina XDR OLED

Chipset: A15 Bionic

Kamera: Kamera ganda 12MP

Fitur Unggulan:
- Mode sinematik dan HDR Dolby Vision
- Desain kokoh dengan Ceramic Shield
- Efisiensi baterai sangat baik

Cocok Untuk: Pengguna umum dengan kebutuhan multimedia dan gaming ringan'''
  ),
  Iphone(
    title: 'iPhone 12 Pro',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    storagePrices: {
      '128GB': 110000,
      '256GB': 115000,
      '512GB': 130000,
    },
    description: '''Layar: 6,1 inci Super Retina XDR OLED

Chipset: A14 Bionic

Kamera: Tiga kamera + LiDAR scanner

Fitur Unggulan:
- Rekaman Dolby Vision HDR
- Sensor LiDAR untuk AR dan fokus cepat
- Material lebih premium (stainless steel)

Cocok Untuk: Pengguna yang butuh fitur pro dengan harga di bawah seri Pro terbaru'''
  ),
  Iphone(
    title: 'iPhone 12',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    storagePrices: {
      '128GB': 90000,
      '256GB': 100000,
      '512GB': 115000,
    },
    description: '''Layar: 6,1 inci Super Retina XDR OLED

Chipset: A14 Bionic

Kamera: Dual 12MP kamera (wide dan ultra-wide)

Fitur Unggulan:
- Desain flat-edge yang modern
- Night Mode di semua kamera
- Dukungan 5G

Cocok Untuk: Pengguna yang ingin fitur flagship dengan harga lebih terjangkau'''
  ),
  Iphone(
    title: 'iPhone SE (2022)',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    storagePrices: {
      '128GB': 70000,
      '256GB': 85000,
      '512GB': 100000,
    },
    description: '''Layar: 4,7 inci Retina HD

Chipset: A15 Bionic (sama seperti iPhone 13)

Kamera: Kamera tunggal 12MP

Fitur Unggulan:
- Ukuran compact dan ringan
- Touch ID dengan tombol fisik
- Harga terjangkau dengan performa flagship

Cocok Untuk: Pengguna yang menyukai desain klasik atau butuh iPhone kecil & kencang'''
  ),
  Iphone(
    title: 'iPhone 11',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    storagePrices: {
      '128GB': 60000,
      '256GB': 70000,
      '512GB': 80000,
    },
    description: '''Layar: 6,1 inci Liquid Retina HD LCD

Chipset: A13 Bionic

Kamera: Dual 12MP (wide dan ultra-wide)

Fitur Unggulan:
- Kinerja mulus untuk aktivitas sehari-hari
- Banyak pilihan warna menarik
- Daya tahan baterai cukup awet

Cocok Untuk: Pengguna pemula atau yang mencari iPhone entry-level dengan fitur solid'''
  ),
];
