import 'package:selly/model/category_model.dart';

class ProductModel {
  final String imageUrl;
  final String name;
  final String description;
  final int price;
  final int fidelityPoint;
  final List<int> categoryId;
  bool inShoppingCart;

  ProductModel({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.fidelityPoint,
    required this.categoryId,
    this.inShoppingCart = false,
  });
}

/*final products = [
  ProductModel(
    imageUrl:
        "https://images.unsplash.com/photo-1512568400610-62da28bc8a13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    name: "Caffé gusto Arabica",
    description:
        "Un gusto delicato, che esprime un profilo aromatico complesso, è la descrizione perfetta del caffè Arabica. Questa varietà di caffè ha origine nello Yemen e in Etiopia. Attualmente, le maggiori coltivazioni si trovano in America Latina e in alcune zone dell’Africa. Rappresenta il 70% del caffè prodotto in tutto il mondo.",
    price: 5,
    fidelityPoint: 2,
    categoryId: "1",
  ),
  ProductModel(
    imageUrl:
        "https://images.unsplash.com/photo-1507133750040-4a8f57021571?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    name: "Caffé gusto Robusto",
    description:
        "Intenso, forte e dalla crema densa di colore brunastro: stiamo parlando del caffè Robusta. Questa varietà di caffè viene coltivata in Africa, nel Sud-Est asiatico e in Brasile ed è la seconda più prodotta al mondo dopo l’Arabica. Ha un elevato contenuto di caffeina ed è la scelta ideale per chi preferisce un gusto corposo e deciso. Si contraddistingue per chicchi dalla tonalità scura e dalla forma arrotondata.",
    price: 8,
    fidelityPoint: 5,
    categoryId: "1",
  ),
  ProductModel(
    imageUrl:
        "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    name: "Caffé gusto Liberica",
    description:
        "Meno diffuso rispetto alle altre varietà, il caffè Liberica ha origine dalle foreste della Liberia e della Costa d’Avorio. I chicchi della pianta liberica permettono di ottenere un caffè aromatico e dal gusto gradevole. Può costituire una soluzione alternativa e piacevole al classico Arabica.",
    price: 7,
    fidelityPoint: 1,
    categoryId: "2",
  ),
  ProductModel(
    imageUrl:
        "https://images.unsplash.com/photo-1506619216599-9d16d0903dfd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1738&q=80",
    name: "Caffé gusto Excelsa",
    description:
        "Il caffè Excelsa ha un gusto profumato e delicato che ricorda la qualità Arabica. Scoperta in Africa agli inizi del ‘900, questa miscela è adatta agli amanti del caffè tradizionale, dall’intensità media e dal corpo morbido e vellutato.",
    price: 12,
    fidelityPoint: 3,
    categoryId: "3",
  ),
  ProductModel(
    imageUrl:
        "https://images.unsplash.com/photo-1485808191679-5f86510681a2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    name: "Caffé Decaffeinato",
    description:
        "Il caffè decaffeinato è un particolare tipo di caffè depurato della presenza della caffeina, una delle sostanze neurostimolanti più note tra quelle contenute nel caffè. Sebbene si creda che il caffè decaffeinato sia totalmente privo di caffeina, in realtà nessuno dei metodi attualmente impiegati per estrarre questa sostanza dai chicchi è in grado di eliminarla del tutto; una tazzina di decaffeinato contiene circa 2 mg di caffeina contro i 50-120 mg di caffè normale.",
    price: 13,
    fidelityPoint: 7,
    categoryId: "4",
  ),
  ProductModel(
    imageUrl:
        "https://images.unsplash.com/photo-1610632380989-680fe40816c6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    name: "Caffé liquirizia",
    description:
        "Il Caffè alla Liquirizia di 101CAFFE’ è una selezionata miscela di Arabica e Robusta pregiati, con aggiunta di liquirizia macinata. Il suo gusto e il suo aroma pieno ed armonioso è frutto di una sapiente lavorazione e della tostatura su legno di faggio, procedimento lento che consente al chicco di non bruciarsi. Dal profumo tipico di questa pianta e dal sapore inconfondibile, il Caffè alla Liquirizia di 101CAFFE’ è perfetto per quei momenti della giornata in cui si desidera un espresso molto personale. Per Moka. ",
    price: 21,
    fidelityPoint: 5,
    categoryId: "5",
  ),
];*/
