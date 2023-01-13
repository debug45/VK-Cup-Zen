//
//  FakeData.swift
//  Zen
//
//  Created by Sergey Moskvin on 10.01.2023.
//

final class FakeData {
    
    static let elementsMatchingModels: [ElementsMatchingModel] = [
        .init(
            title: "Флаги мира",
            pairs: [
                ("🇷🇺", "Россия"),
                ("🇺🇦", "Украина"),
                ("🇧🇾", "Белоруссия"),
                ("🇺🇸", "США"),
                ("🇪🇺", "Евросоюз")
            ]
        ),
        
        .init(
            title: "Виды транспорта",
            pairs: [
                ("Автомобиль", "🚗"),
                ("Автобус", "🚌"),
                ("Велосипед", "🚲"),
                ("Мотоцикл", "🏍️"),
                ("Самолёт", "✈️"),
                ("Вертолёт", "🚁"),
                ("Метро", "🚇"),
                ("Трамвай", "🚃"),
                ("Лодка", "🛶"),
                ("Корабль", "🛳️"),
                ("Фуникулёр", "🚠")
            ]
        ),
        
        .init(
            title: "Эмоции",
            pairs: [
                ("Весело", "🙂"),
                ("Нейтрально", "😕"),
                ("Грустно", "🙁")
            ]
        ),
        
        .init(
            title: "Номера экстренных служб",
            pairs: [
                ("101", "🚒 Пожарная охрана"),
                ("102", "🚓 Полиция"),
                ("103", "🚑 Скорая помощь")
            ]
        )
    ]
    
    static let ratingStarsModels: [RatingStarsModel] = [
        .init(title: "Зелёная миля"),
        .init(title: "Список Шиндлера"),
        .init(title: "Побег из\u{00A0}Шоушенка"),
        .init(title: "Форрест Гамп"),
        .init(title: "Властелин колец: Возвращение короля"),
        .init(title: "Тайна Коко"),
        .init(title: "Назад в\u{00A0}будущее"),
        .init(title: "Интерстеллар"),
        .init(title: "Криминальное чтиво"),
        .init(title: "Властелин колец: Братство кольца"),
        .init(title: "Властелин колец: Две крепости"),
        .init(title: "Иван Васильевич меняет профессию"),
        .init(title: "Король Лев"),
        .init(title: "1+1"),
        .init(title: "Бойцовский клуб"),
        .init(title: "Тёмный рыцарь"),
        .init(title: "Унесённые призраками"),
        .init(title: "Приключения Шерлока Холмса и\u{00A0}доктора Ватсона"),
        .init(title: "ВАЛЛ·И"),
        .init(title: "Гладиатор")
    ]
    
}
