# Weather

<img src="https://user-images.githubusercontent.com/99677952/158836180-7b30d886-8192-473a-857f-acf2f1ff7c88.png" width="300" /> <img src="https://user-images.githubusercontent.com/99677952/158836224-cfa66da4-8018-4ef5-a48e-c70caeb7ff42.png" width="300" /> <img src="https://user-images.githubusercontent.com/99677952/158836206-d0a74937-e132-414a-a1a3-547c3033f7dc.png" width="300" />

Приложение построено на архитектуре MVVM. Состоит из табличного представления и обычного, переходами между которыми осуществляется с помощью коордирнатора, а передача данных осуществляется с помощью Boxing. 

Первый экран - это tableView, который содержит два типа ячеек, меняющиется в зависимости от того активирован ли SeachConroller. Пользователя встречает список с его избранными городами, а также небольшой справке о погоде. C помощью SecgemtedController можно выбрать единицу измерения температуры. Правая кнопка на навигэйшн бар перебрасывает на вью с детальной информацией о погоде в локации пользователя.

Поиск осуществляется по данному заранее json файлу, который парсится при загрузке. При нажатии на ячейку открывается вью с более детальной информацией о погоде. В офлайн режиме можно посмотреть последнюю погоду в избранных городах.

# Идеи для развития:
Моменты, которые я бы хотел проработать, но не смог из-за нехватки времени или знаний:
* Зафиксировал первую ячейку с геопозицией пользователя, которую нельзя было бы изменять;
* Добавить отслеживание добавлен ли город в избранное, чтобы кнопка в DetailView не появлялась;
* Переработать сохранения, возможно использовать Coredata.
