// isinya atribut iphone seperti nama, harga, deskripsi, gambar, dll.

class Iphone {
  final String title;
  final String imageUrl;
  final Map<String, int> storagePrices; // key: storage, value: price

  Iphone({
    required this.title,
    required this.imageUrl,
    required this.storagePrices,
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
  ),
  Iphone(
    title: 'iPhone 14',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    storagePrices: {
      '128GB': 160000,
      '256GB': 180000,
      '512GB': 200000,
    },
  ),
  Iphone(
    title: 'iPhone 13 Pro',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    storagePrices: {
      '128GB': 150000,
      '256GB': 170000,
      '512GB': 190000,
    },
  ),
  Iphone(
    title: 'iPhone 13',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    storagePrices: {
      '128GB': 120000,
      '256GB': 135000,
      '512GB': 150000,
    },
  ),
  Iphone(
    title: 'iPhone 12 Pro',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    storagePrices: {
      '128GB': 110000,
      '256GB': 115000,
      '512GB': 130000,
    },
  ),
  Iphone(
    title: 'iPhone 12',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    storagePrices: {
      '128GB': 90000,
      '256GB': 100000,
      '512GB': 115000,
    },
  ),
  Iphone(
    title: 'iPhone SE (2022)',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    storagePrices: {
      '128GB': 70000,
      '256GB': 85000,
      '512GB': 100000,
    },
  ),
  Iphone(
    title: 'iPhone 11',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    storagePrices: {
      '128GB': 60000,
      '256GB': 70000,
      '512GB': 80000,
    },
  ),
];