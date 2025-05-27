// isinya atribut iphone seperti nama, harga, deskripsi, gambar, dll.

class Iphone {
  final String title;
  final String imageUrl;
  final String price;
  final List<String> storageVariants;

  Iphone({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.storageVariants,
  });
}

final List<Iphone> iphones = [
  Iphone(
    title: 'iPhone 14 Pro',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    price: 'Rp200.000',
    storageVariants: ['128GB', '256GB', '512GB'],
  ),
  Iphone(
    title: 'iPhone 14',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    price: 'Rp160.000',
    storageVariants: ['128GB', '256GB'],
  ),
  Iphone(
    title: 'iPhone 13 Pro',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    price: 'Rp150.000',
    storageVariants: ['128GB', '256GB', '512GB'],
  ),
  Iphone(
    title: 'iPhone 13',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    price: 'Rp120.000',
    storageVariants: ['128GB', '256GB'],
  ),
  Iphone(
    title: 'iPhone 12 Pro',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    price: 'Rp110.000',
    storageVariants: ['128GB', '256GB', '512GB'],
  ),
  Iphone(
    title: 'iPhone 12',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    price: 'Rp90.000',
    storageVariants: ['64GB', '128GB'],
  ),
  Iphone(
    title: 'iPhone SE (2022)',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    price: 'Rp70.000',
    storageVariants: ['64GB', '128GB'],
  ),
  Iphone(
    title: 'iPhone 11',
    imageUrl: 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
    price: 'Rp60.000',
    storageVariants: ['64GB', '128GB'],
  ),
];