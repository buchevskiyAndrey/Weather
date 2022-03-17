# Weather

<img src="https://user-images.githubusercontent.com/99677952/158530222-805bdd8b-bf4e-49bc-aaab-c747fa73e149.png" width="300" /> <img src="https://user-images.githubusercontent.com/99677952/158530234-14b0deff-e98e-4b8b-8765-6e6c28f9dd97.png" width="300" /> <img src="https://user-images.githubusercontent.com/99677952/158530242-32c526fb-5a5a-41da-86b4-8a9fe003e572.png" width="300" />

Приложение построено на архитектуре MVVM. В нем присутствует табличное представление и обычное, переходами между которыми осуществляется с помощью коордирнатора, а передача данных осуществляется с помощью Boxing. 

Первый экран - это tableView, который содержит два типа ячеек, меняющиется в зависимости от того активирован ли SeachConroller. Пользователя встречает список с его избранными городами, а также небольшой справке о погоде. C помощью SecgemtedController можно выбрать единицу измерения температуры. Правая кнопка на навигэйшн бар перебрасывает на вью с детальной информацией о погоде в локации пользователя.

Поиск осуществляется по данному заранее json файлу, который парсится при загрузке. При нажатии на ячейку открывается вью с более детальной информацией о погоде. В офлайн режиме можно посмотреть последнюю погоду в избранных городах.

# Идеи для развития:
Моменты, которые я бы хотел проработать, но не смог из-за нехватки времени или знаний:
* Зафиксировал первую ячейку с геопозицией пользователя, которую нельзя было бы изменять;
* Добавить отслеживание добавлен ли город в избранное, чтобы кнопка в DetailView не появлялась;
* Переработать сохранения, возможно использовать Coredata.
