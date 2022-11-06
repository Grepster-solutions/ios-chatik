//
//  MessageList.swift
//  Chat
//
//  Created by Дарья on 02.11.2022.
//

import Foundation

struct MessageList {
    let massage: [Message]
}

extension MessageList {
    static let mock = MessageList(massage: [Message(messateType: "incoming",
                                                    text: "Привет!"),
                                            Message(messateType: "outcoming",
                                                    text: "Привет)"),
                                            Message(messateType: "incoming",
                                                    text: "Знаешь это?"),
                                            Message(messateType: "incoming",
                                                    text: "Три самые богатые семьи в мире имеют больше активов, чем 48 беднейших стран."),
                                            Message(messateType: "incoming",
                                                    text: "Половина населения Земли (а по некоторым подсчетам, даже две трети) никогда не видели снега."),
                                            Message(messateType: "outcoming",
                                                    text: "Эверест – не самая высокая гора на планете. Конечно, Эверест выше над уровнем моря, чем любая другая гора на Земле, – 8848 м. Но если брать за точку отсчета дно океана, то наивысшей горной вершиной следует считать щитовой вулкан Мауна-Кеа на Гавайях. Его высота над уровнем моря составляет 4207 м, но от подножия на дне океана – 10 203 м."),
                                            Message(messateType: "incoming",
                                                    text: "Самое сухое место на Земле находится в Антарктиде. Как ни странно это звучит, но некоторые участки антарктической долины Мак-Мердо не видели осадков уже 2 миллиона лет."),
                                            Message(messateType: "outcoming",
                                                    text: "Кубик Рубика – товар, который больше всего продается в мире. На втором месте – iPhone."),
                                            Message(messateType: "incoming",
                                                    text: "Чтобы пересмотреть все видео на YouTube, понадобится 1000 лет."),
                                            Message(messateType: "outcoming",
                                                    text: "Самый сильный мускул человеческого тела – язык."),
                                            Message(messateType: "incoming",
                                                    text: "Вероятность того, что молния ударит в мужчину в 6 раз выше, чем в женщину."),
                                            Message(messateType: "outcoming",
                                                    text: "Если бы в Coca-Cola не добавляли краситель, она была бы зеленого цвета."),
                                            Message(messateType: "incoming",
                                                    text: "Четырехлетний ребенок в среднем задает 400 вопросов в день."),
                                            Message(messateType: "outcoming",
                                                    text: "Коровы могут становиться настоящими друзьями и испытывают боль расставания, если их отрывают друг от друга. Они также понимают, когда их обзывают, и могут плакать."),
                                            Message(messateType: "incoming",
                                                    text: "Половина всех людей, которые достигли 65-летнего возраста за всю историю человечества, все еще живы."),
                                            Message(messateType: "outcoming",
                                                    text: "На шлемах астронавтов есть специальное устройство, чтобы чесать нос."),
                                            Message(messateType: "incoming",
                                                    text: "Вероятность стать президентом у каждого человека выше, чем выиграть в лотерею. Кстати, умереть по дороге за лотерейным билетом также более вероятно, чем победить.")])
}

