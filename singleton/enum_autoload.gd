extends Node

enum ItemType {
    NONE,
    CONSUMABLE = 1,
    EQUIPMENT = 2,
    KEY = 3
}

enum ItemId {
    NONE,
    # FOOD
    FRIED_RICE = 1000,
    OCTO_BENTO = 1001,
}

enum ServiceSpecialCase {
    NONE,
    NEXT_DAY = 100
}
