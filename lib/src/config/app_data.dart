import 'package:hello_world/src/models/item_model.dart';
import 'package:hello_world/src/models/user_model.dart';

import '../models/cart_item_model.dart';
import '../models/order_model.dart';

ItemModel apple = ItemModel(
  id: '1',
    description:
    'A melhor maçã da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
    imgUrl: 'assets/fruits/apple.png',
    itemName: 'Maçã',
    price: 5.5,
    unit: 'kg',
);

ItemModel grape = ItemModel(
  id: '2',
    imgUrl: 'assets/fruits/grape.png',
    itemName: 'Uva',
    price: 7.4,
    unit: 'kg',
    description:
    'A melhor uva da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel guava = ItemModel(
    id: '3',
    imgUrl: 'assets/fruits/guava.png',
    itemName: 'Goiaba',
    price: 11.5,
    unit: 'kg',
    description:
    'A melhor goiaba da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel kiwi = ItemModel(
  id: '4',
    imgUrl: 'assets/fruits/kiwi.png',
    itemName: 'Kiwi',
    price: 2.5,
    unit: 'un',
    description:
    'O melhor kiwi da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel mango = ItemModel(
  id: '5',
    imgUrl: 'assets/fruits/mango.png',
    itemName: 'Manga',
    price: 2.5,
    unit: 'un',
    description:
    'A melhor manga da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel papaya = ItemModel(
  id: '6',
    imgUrl: 'assets/fruits/papaya.png',
    itemName: 'Mamão papaya',
    price: 8,
    unit: 'kg',
    description:
    'O melhor mamão da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

// Lista de produtos
List<ItemModel> items = [
    apple,
    grape,
    guava,
    kiwi,
    mango,
    papaya,
];

List<CartItemModel> cartItems = [
    CartItemModel(quantity: 2, item: apple),
    CartItemModel(quantity: 1, item: mango),
    CartItemModel(quantity: 3, item: grape),
];

UserModel user = UserModel(
    phone: '11910028010',
    email: 'gustavo.avk@msn.com',
    cpf: '409-.370.738-30',
    name: 'Guga Araujo',
    password: '',
);

List<OrderModel> orders = [
    OrderModel(
        total: 11.0,
        items: [
            CartItemModel(
                item: apple,
                quantity: 2,
            ),
            CartItemModel(
                item: mango,
                quantity: 2,
            ),
        ],
        copyAndPast: 'q1w2e3r4t5y6',
        createdDateTime: DateTime.parse('2021-06-08 10:00:10.458'),
        id: 'asd6a54da6s2d1',
        overdueDateTime: DateTime.parse('2021-06-08 11:00:10.458'),
        status: 'pending_payment'
    ),
    OrderModel(
        total: 11.0,
        items: [
            CartItemModel(
                item: apple,
                quantity: 2,
            ),
            CartItemModel(
                item: mango,
                quantity: 2,
            ),
        ],
        copyAndPast: 'q1w2e3r4t5y6',
        createdDateTime: DateTime.parse('2024-06-08 10:00:10.458'),
        id: 'asd6a54da6s2d1',
        overdueDateTime: DateTime.parse('2024-06-08 11:00:10.458'),
        status: 'pending_payment'
    ),
    OrderModel(
        total: 11.0,
        items: [
            CartItemModel(
                item: grape,
                quantity: 1,
            ),
            CartItemModel(
                item: guava,
                quantity: 3,
            ),
        ],
        copyAndPast: 'q1w2e3r4t5y6',
        createdDateTime: DateTime.parse('2021-06-08 10:00:10.458'),
        id: 'asd6a54da6s2d2',
        overdueDateTime: DateTime.parse('2021-06-08 11:00:10.458'),
        status: 'refunded'
    ),
    OrderModel(
        total: 11.0,
        items: [
            CartItemModel(
                item: grape,
                quantity: 1,
            ),
            CartItemModel(
                item: guava,
                quantity: 3,
            ),
        ],
        copyAndPast: 'q1w2e3r4t5y6',
        createdDateTime: DateTime.parse('2024-06-08 10:00:10.458'),
        id: 'asd6a54da6s2d2',
        overdueDateTime: DateTime.parse('2024-06-08 11:00:10.458'),
        status: 'paid'
    ),
    OrderModel(
        total: 11.0,
        items: [
            CartItemModel(
                item: grape,
                quantity: 1,
            ),
            CartItemModel(
                item: guava,
                quantity: 3,
            ),
        ],
        copyAndPast: 'q1w2e3r4t5y6',
        createdDateTime: DateTime.parse('2024-06-08 10:00:10.458'),
        id: 'asd6a54da6s2d2',
        overdueDateTime: DateTime.parse('2024-06-08 11:00:10.458'),
        status: 'preparing_purchase'
    ),
    OrderModel(
        total: 11.0,
        items: [
            CartItemModel(
                item: grape,
                quantity: 1,
            ),
            CartItemModel(
                item: guava,
                quantity: 3,
            ),
        ],
        copyAndPast: 'q1w2e3r4t5y6',
        createdDateTime: DateTime.parse('2024-06-08 10:00:10.458'),
        id: 'asd6a54da6s2d2',
        overdueDateTime: DateTime.parse('2024-06-08 11:00:10.458'),
        status: 'shipping'
    ),
    OrderModel(
        total: 11.0,
        items: [
            CartItemModel(
                item: grape,
                quantity: 1,
            ),
            CartItemModel(
                item: guava,
                quantity: 3,
            ),
        ],
        copyAndPast: 'q1w2e3r4t5y6',
        createdDateTime: DateTime.parse('2024-06-08 10:00:10.458'),
        id: 'asd6a54da6s2d2',
        overdueDateTime: DateTime.parse('2024-06-08 11:00:10.458'),
        status: 'delivered'
    ),
];
