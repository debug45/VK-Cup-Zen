//
//  FakeData.swift
//  Zen
//
//  Created by Sergey Moskvin on 10.01.2023.
//

final class FakeData {
    
    static let elementsMixingModels: [ElementsMixingModel] = [
        .init(
            title: "Традиционные салаты",
            resultIcon: "🥗",
            possibleCombinations: [
                .init(
                    components: [
                        (title: "Картофель", count: 1),
                        (title: "Морковь", count: 1),
                        (title: "Горох", count: 1),
                        (title: "Яйца", count: 1),
                        (title: "Колбаса", count: 1),
                        (title: "Солёные огурцы", count: 1),
                        (title: "Майонез", count: 1)
                    ],
                    result: "Оливье"
                ),
                
                .init(
                    components: [
                        (title: "Картофель", count: 1),
                        (title: "Морковь", count: 1),
                        (title: "Свёкла", count: 1),
                        (title: "Яйца", count: 1),
                        (title: "Сельдь", count: 1),
                        (title: "Майонез", count: 1)
                    ],
                    result: "Сельдь под\u{00A0}шубой"
                ),
                
                .init(
                    components: [
                        (title: "Картофель", count: 1),
                        (title: "Морковь", count: 1),
                        (title: "Яйца", count: 1),
                        (title: "Сайра", count: 1),
                        (title: "Майонез", count: 1)
                    ],
                    result: "Мимоза"
                ),
                
                .init(
                    components: [
                        (title: "Картофель", count: 1),
                        (title: "Морковь", count: 1),
                        (title: "Свёкла", count: 1),
                        (title: "Горох", count: 1),
                        (title: "Солёные огурцы", count: 1),
                        (title: "Масло", count: 1)
                    ],
                    result: "Винегрет"
                )
            ],
            isOrderImportant: false,
            isLowercasingAllowed: true
        ),
        
        .init(
            title: "Приготовление кофе",
            resultIcon: "☕️",
            possibleCombinations: [
                .init(
                    components: [
                        (title: "Эспрессо", count: 1),
                        (title: "Вода", count: 1)
                    ],
                    result: "Американо"
                ),
                
                .init(
                    components: [
                        (title: "Эспрессо", count: 1),
                        (title: "Молоко", count: 1),
                        (title: "Молочная пена", count: 1)
                    ],
                    result: "Капучино"
                ),
                
                .init(
                    components: [
                        (title: "Сироп", count: 1),
                        (title: "Эспрессо", count: 1),
                        (title: "Молочная пена", count: 1)
                    ],
                    result: "Раф"
                ),
                
                .init(
                    components: [
                        (title: "Эспрессо", count: 1),
                        (title: "Взбитые сливки", count: 1)
                    ],
                    result: "По-венски"
                )
            ],
            isOrderImportant: true,
            isLowercasingAllowed: true
        ),
        
        .init(
            title: "Химические соединения",
            resultIcon: "⚗️",
            possibleCombinations: [
                .init(
                    components: [
                        (title: "H", count: 2)
                    ],
                    result: "Молекула водорода (H₂)"
                ),
                
                .init(
                    components: [
                        (title: "O", count: 2)
                    ],
                    result: "Молекула кислорода (O₂)"
                ),
                
                .init(
                    components: [
                        (title: "S", count: 1)
                    ],
                    result: "Молекула серы (S)"
                ),
                
                .init(
                    components: [
                        (title: "H", count: 2),
                        (title: "O", count: 1)
                    ],
                    result: "Вода (H₂O)"
                ),
                
                .init(
                    components: [
                        (title: "H", count: 2),
                        (title: "O", count: 2)
                    ],
                    result: "Пероксид водорода (H₂O₂)"
                ),
                
                .init(
                    components: [
                        (title: "H", count: 2),
                        (title: "S", count: 1)
                    ],
                    result: "Сероводород (H₂S)"
                ),
                
                .init(
                    components: [
                        (title: "H", count: 2),
                        (title: "S", count: 1),
                        (title: "O", count: 3)
                    ],
                    result: "Сернистая кислота (H₂SO₃)"
                ),
                
                .init(
                    components: [
                        (title: "H", count: 2),
                        (title: "S", count: 1),
                        (title: "O", count: 4)
                    ],
                    result: "Серная кислота (H₂SO₄)"
                )
            ],
            isOrderImportant: false,
            isLowercasingAllowed: false
        )
    ]
    
    static let stepwisePollModels: [StepwisePollModel] = [
        .init(
            title: "Всё самое, самое, самое",
            questions: [
                .init(
                    title: "Какое сооружение самое высокое в\u{00A0}мире?",
                    answers: [
                        .init(
                            id: "e6a01709-e83e-4686-a927-b7973dd7d026",
                            title: "Empire State Building 🇺🇸",
                            numberOfVotes: 690
                        ),
                        .init(
                            id: "918d83d9-4897-4f89-8187-9672b392323d",
                            title: "Лахта Центр 🇷🇺",
                            numberOfVotes: 315
                        ),
                        .init(
                            id: "0fbaa0ea-cea0-45e7-91c0-813e54b7a370",
                            title: "Телебашня Гуанчжоу 🇨🇳",
                            numberOfVotes: 605
                        ),
                        .init(
                            id: "7c33162c-28eb-4176-805d-47ace243e2de",
                            title: "Бурдж-Халифа 🇦🇪",
                            numberOfVotes: 838
                        )
                    ],
                    correctAnswerID: "7c33162c-28eb-4176-805d-47ace243e2de"
                ),
                
                .init(
                    title: "А\u{00A0}какова высочайшая вершина Земли?",
                    answers: [
                        .init(
                            id: "85791a5d-6f92-4474-ac6b-4d80df396f78",
                            title: "Эльбрус",
                            numberOfVotes: 574
                        ),
                        .init(
                            id: "c7da2931-e4b8-4b5f-bf54-eb10987cc7d2",
                            title: "Килиманджаро",
                            numberOfVotes: 131
                        ),
                        .init(
                            id: "33429319-e6ff-48cb-9d38-d2a474452e08",
                            title: "Эверест",
                            numberOfVotes: 631
                        ),
                        .init(
                            id: "0342c7d0-2cdd-4c7f-9f9e-2c88f2afe2d6",
                            title: "Макалу",
                            numberOfVotes: 64
                        )
                    ],
                    correctAnswerID: "33429319-e6ff-48cb-9d38-d2a474452e08"
                ),
                
                .init(
                    title: "Какое дерево самое высокое в\u{00A0}мире?",
                    answers: [
                        .init(
                            id: "b301c8c4-9e74-47ae-9f57-cda679c9c813",
                            title: "Пихта сибирская",
                            numberOfVotes: 599
                        ),
                        .init(
                            id: "3d91bee8-581c-4aec-989d-1da9f19adb8d",
                            title: "Секвойя вечнозелёная",
                            numberOfVotes: 841
                        ),
                        .init(
                            id: "66c60e1c-27de-400a-a1f9-bc75710c9396",
                            title: "Эвкалипт царственный",
                            numberOfVotes: 943
                        ),
                        .init(
                            id: "75eed4b3-e2bc-4cd1-90c5-e421d436adc5",
                            title: "Псевдотсуга Мензиса",
                            numberOfVotes: 153
                        ),
                    ],
                    correctAnswerID: "3d91bee8-581c-4aec-989d-1da9f19adb8d"
                )
            ]
        ),
        
        .init(
            title: "Немного английского языка",
            questions: [
                .init(
                    title: "development",
                    answers: [
                        .init(
                            id: "43eedd80-cd06-4d89-af29-b701b92071c5",
                            title: "разработка",
                            numberOfVotes: 8157
                        ),
                        .init(
                            id: "d30cd1ab-55e8-45ca-9d33-3ed5840fdfc3",
                            title: "существование",
                            numberOfVotes: 3589
                        ),
                        .init(
                            id: "a1dce767-abce-42e6-ab00-063c83f94911",
                            title: "прокрастинация",
                            numberOfVotes: 6606
                        )
                    ],
                    correctAnswerID: "43eedd80-cd06-4d89-af29-b701b92071c5"
                ),
                
                .init(
                    title: "speech",
                    answers: [
                        .init(
                            id: "e7d49f75-9156-4423-b904-a00807a43188",
                            title: "огурец",
                            numberOfVotes: 3328
                        ),
                        .init(
                            id: "25eaf6f7-e1fc-4908-9eba-ac7a660ed255",
                            title: "речь",
                            numberOfVotes: 6419
                        ),
                        .init(
                            id: "a48511e1-7106-42b9-8bf2-5169933cba21",
                            title: "специя",
                            numberOfVotes: 7720
                        )
                    ],
                    correctAnswerID: "25eaf6f7-e1fc-4908-9eba-ac7a660ed255"
                ),
                
                .init(
                    title: "thought",
                    answers: [
                        .init(
                            id: "61069b0b-d9c4-4590-9332-73e25bdf949f",
                            title: "значение",
                            numberOfVotes: 4214
                        ),
                        .init(
                            id: "1d3c2d17-27c6-42a8-a428-1a2d76b25bdd",
                            title: "мысль",
                            numberOfVotes: 5179
                        ),
                        .init(
                            id: "f34a622d-6680-4f3c-9ef6-08a744d44699",
                            title: "трава",
                            numberOfVotes: 4333
                        )
                    ],
                    correctAnswerID: "1d3c2d17-27c6-42a8-a428-1a2d76b25bdd"
                ),
                
                .init(
                    title: "election",
                    answers: [
                        .init(
                            id: "e7438f76-5638-4d7e-935f-3a315b869e9e",
                            title: "производство",
                            numberOfVotes: 3635
                        ),
                        .init(
                            id: "6597bd6c-17ad-438b-abfe-3867312883a2",
                            title: "исполнение",
                            numberOfVotes: 8393
                        ),
                        .init(
                            id: "5a2df90b-4e44-4795-b224-91d6d3bff23b",
                            title: "выборы",
                            numberOfVotes: 2537
                        )
                    ],
                    correctAnswerID: "5a2df90b-4e44-4795-b224-91d6d3bff23b"
                ),
                
                .init(
                    title: "chase",
                    answers: [
                        .init(
                            id: "889217b2-a6cf-4dbf-9758-a58bc158d475",
                            title: "погоня",
                            numberOfVotes: 6399
                        ),
                        .init(
                            id: "bdd76632-a5e8-480e-b0c0-0e74438d0140",
                            title: "шахматы",
                            numberOfVotes: 7565
                        ),
                        .init(
                            id: "aaed627f-60b6-411c-954f-d7c3e2d97c30",
                            title: "уравнение",
                            numberOfVotes: 110
                        )
                    ],
                    correctAnswerID: "889217b2-a6cf-4dbf-9758-a58bc158d475"
                )
            ]
        ),
        
        .init(
            title: "Флаги мира",
            questions: [
                .init(
                    title: "🇧🇬",
                    answers: [
                        .init(
                            id: "1882bd16-2362-49be-83c3-3d5bb8af258f",
                            title: "Россия",
                            numberOfVotes: 4478
                        ),
                        .init(
                            id: "ad3efd6d-399e-4928-8144-0c0044671638",
                            title: "Гайана",
                            numberOfVotes: 162
                        ),
                        .init(
                            id: "2c7c969a-bb30-4175-a14a-dfe66bbcbf23",
                            title: "Болгария",
                            numberOfVotes: 7181
                        ),
                        .init(
                            id: "c45be25a-a58d-4b66-bd10-dc186fb184b3",
                            title: "Словакия",
                            numberOfVotes: 1708
                        ),
                        .init(
                            id: "d05ec665-ba66-4ea8-a7b5-bf4286ab656e",
                            title: "Хорватия",
                            numberOfVotes: 3332
                        )
                    ],
                    correctAnswerID: "2c7c969a-bb30-4175-a14a-dfe66bbcbf23"
                ),
                
                .init(
                    title: "🇲🇽",
                    answers: [
                        .init(
                            id: "4407f91e-ec4a-4c94-a1a7-43f398cc72ec",
                            title: "Мексика",
                            numberOfVotes: 5346
                        ),
                        .init(
                            id: "473b6461-f27a-42b5-b3c7-4a53c9615090",
                            title: "Франция",
                            numberOfVotes: 4999
                        ),
                        .init(
                            id: "f835dd41-eb12-40b8-95f2-cc9a5355cf97",
                            title: "Италия",
                            numberOfVotes: 9223
                        ),
                        .init(
                            id: "c2438f9e-63ea-47c7-b855-42d4a89ac18c",
                            title: "Чили",
                            numberOfVotes: 749
                        ),
                        .init(
                            id: "916b7efc-4191-48a4-9f3c-122f7b76a2b8",
                            title: "Марокко",
                            numberOfVotes: 2718
                        )
                    ],
                    correctAnswerID: "4407f91e-ec4a-4c94-a1a7-43f398cc72ec"
                ),
                
                .init(
                    title: "🇮🇱",
                    answers: [
                        .init(
                            id: "df7f6ae2-bd13-4090-87c1-ecff4c087d7e",
                            title: "Египет",
                            numberOfVotes: 3686
                        ),
                        .init(
                            id: "694ddc38-ea96-43b6-8a16-39da5709581c",
                            title: "Бразилия",
                            numberOfVotes: 7002
                        ),
                        .init(
                            id: "930a9293-94bb-4bb7-bf3f-5d1d85875173",
                            title: "Израиль",
                            numberOfVotes: 8333
                        ),
                        .init(
                            id: "0b6b7a3a-7794-4d42-a8ff-899595ac3747",
                            title: "Турция",
                            numberOfVotes: 3953
                        ),
                        .init(
                            id: "7a77a959-b5cb-484a-b095-d34afd82e11e",
                            title: "Иордания",
                            numberOfVotes: 5127
                        )
                    ],
                    correctAnswerID: "930a9293-94bb-4bb7-bf3f-5d1d85875173"
                ),
                
                .init(
                    title: "🇰🇿",
                    answers: [
                        .init(
                            id: "3da056de-6f6d-4186-95af-5abeb3f1787c",
                            title: "Казахстан",
                            numberOfVotes: 7708
                        ),
                        .init(
                            id: "bafc7643-1be2-4088-a4b1-f6d3840ab218",
                            title: "Молдавия",
                            numberOfVotes: 4746
                        ),
                        .init(
                            id: "ae7f9cb8-2549-4159-be8b-bf1f14e7c893",
                            title: "Тунис",
                            numberOfVotes: 5505
                        ),
                        .init(
                            id: "d265e4d9-8cec-468b-b1a8-bae87646ea52",
                            title: "Узбекистан",
                            numberOfVotes: 6897
                        ),
                        .init(
                            id: "eebab80e-4420-4a24-b4fa-200d7f370f31",
                            title: "Монголия",
                            numberOfVotes: 6855
                        )
                    ],
                    correctAnswerID: "3da056de-6f6d-4186-95af-5abeb3f1787c"
                )
            ]
        )
    ]
    
    static let elementsMatchingModels: [ElementsMatchingModel] = [
        .init(
            title: "Флаги мира",
            pairs: [
                "🇷🇺": "Россия",
                "🇺🇦": "Украина",
                "🇧🇾": "Белоруссия",
                "🇺🇸": "США",
                "🇪🇺": "Евросоюз"
            ]
        ),
        
        .init(
            title: "Виды транспорта",
            pairs: [
                "Автомобиль": "🚗",
                "Автобус": "🚌",
                "Велосипед": "🚲",
                "Мотоцикл": "🏍️",
                "Самолёт": "✈️",
                "Вертолёт": "🚁",
                "Метро": "🚇",
                "Трамвай": "🚃",
                "Лодка": "🛶",
                "Корабль": "🛳️",
                "Фуникулёр": "🚠"
            ]
        ),
        
        .init(
            title: "Эмоции",
            pairs: [
                "Весело": "🙂",
                "Нейтрально": "😕",
                "Грустно": "🙁"
            ]
        ),
        
        .init(
            title: "Номера экстренных служб",
            pairs: [
                "101": "🚒 Пожарная охрана",
                "102": "🚓 Полиция",
                "103": "🚑 Скорая помощь"
            ]
        )
    ]
    
    static let simpleTextGapsModels: [TextGapsModel] = [
        .init(
            template: "Без\u{00A0}%@ не\u{00A0}%@ и\u{00A0}%@ из\u{00A0}пруда",
            inserts: ["труда", "выловишь", "рыбку"]
        ),
        
        .init(
            template: "%@ едешь\u{00A0}— дальше %@",
            inserts: ["Тише", "будешь"]
        ),
        
        .init(
            template: "У\u{00A0}кого что %@, тот о\u{00A0}том и\u{00A0}%@",
            inserts: ["болит", "говорит"]
        ),
        
        .init(
            template: "Добрый %@\u{00A0}— всему %@ %@",
            inserts: ["конец", "делу", "венец"]
        ),
        
        .init(
            template: "Грамоте %@ всегда %@",
            inserts: ["учиться", "пригодится"]
        )
    ]
    
    static let editableTextGapsModels: [TextGapsModel] = [
        .init(
            template: "Любишь %@, люби и саночки %@",
            inserts: ["кататься", "возить"]
        ),
        
        .init(
            template: "Что %@\u{00A0}— не\u{00A0}%@, потерявши\u{00A0}— %@",
            inserts: ["имеем", "храним", "плачем"]
        ),
        
        .init(
            template: "Первый %@ комом",
            inserts: ["блин"]
        ),
        
        .init(
            template: "В\u{00A0}%@ омуте %@ водятся",
            inserts: ["тихом", "черти"]
        ),
        
        .init(
            template: "Что %@ %@, того не\u{00A0}%@ топором",
            inserts: ["написано", "пером", "вырубишь"]
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
