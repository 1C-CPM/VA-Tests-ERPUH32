﻿#language: ru
@tree

@ERPUH32_Purchases

Функционал: 01. Инициализация системы

	Как Аналитик я хочу
	наполнить базу НСИ
	чтобы использовать её в сценарных тестах

Контекст:

	И Я закрыл все окна клиентского приложения	

Сценарий: 01.01. Создание пользователя системы [Администратор]

	И Я подключаю клиент тестирования "Этот клиент" из таблицы клиентов тестирования
	И Пауза 5
	И Я закрыл все окна клиентского приложения
	
	* Создаем группу доступа "Открытие внешних отчетов и обработок", если ее нет
		И В командном интерфейсе я выбираю 'НСИ и администрирование' 'Настройки пользователей и прав'
		Тогда открылось окно 'Настройки пользователей и прав'
		И я нажимаю на кнопку с именем 'ОткрытьГруппыДоступа'
		Тогда открылось окно 'Группы доступа'
		Если в таблице 'Список' есть строка Тогда
			| 'Наименование'           |
			| 'Открытие внешних отчетов и обработок' |
		Иначе
			И я нажимаю на кнопку с именем 'ФормаСоздать'
			Тогда открылось окно 'Группа доступа (создание)'
			И в поле с именем 'Наименование' я ввожу текст 'Открытие внешних отчетов и обработок'
			И я нажимаю кнопку выбора у поля с именем "Профиль"
			Тогда открылось окно 'Выбор профиля групп доступа'
			И в таблице "Список" я перехожу к строке:
				| 'Наименование'           |
				| 'Дополнительные профили' |
			И в таблице "Список" я выбираю текущую строку
			И в таблице "Список" я перехожу к строке:
				| 'Наименование'                         |
				| 'Открытие внешних отчетов и обработок' |
			И в таблице "Список" я выбираю текущую строку
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Группа доступа (создание) *' в течение 20 секунд
		И Я закрыл все окна клиентского приложения		
					
				
	* Настройка прав доступа
		И В командном интерфейсе я выбираю "НСИ и администрирование" "Настройки пользователей и прав"
		Тогда открылось окно "Настройки пользователей и прав"
		И я устанавливаю флаг с именем 'ИспользоватьГруппыПользователей'
		И я устанавливаю флаг с именем 'ОграничиватьДоступНаУровнеЗаписей'
		Если открылось окно "1С:Предприятие" Тогда
			И я нажимаю на кнопку с именем 'Button0'
		Тогда открылось окно "Настройки пользователей и прав"
		И из выпадающего списка с именем 'ОграничиватьДоступНаУровнеЗаписейУниверсально' я выбираю точное значение "Стандартный"
		Если открылось окно "1С:Предприятие" Тогда
			И я нажимаю на кнопку с именем 'Button0'

	* Создаем пользователя с правами Администратор

		* Открываем список
			И В командном интерфейсе я выбираю "НСИ и администрирование" "Настройки пользователей и прав"
			Тогда открылось окно "Настройки пользователей и прав"
			И я нажимаю на кнопку с именем 'ОткрытьПользователи'
			Тогда открылось окно "Пользователи"
			И я закрываю все окна клиентского приложения кроме "Пользователи"
       
		* Ищем или создаем нужного пользователя		
			И я выбираю пункт контекстного меню с именем 'ПользователиСписокКонтекстноеМенюНайти' на элементе формы с именем 'ПользователиСписок'
			Тогда открылось окно "Найти"
			И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Полное имя"
			И я меняю значение переключателя с именем 'CompareType' на "По точному совпадению"
			И в поле с именем 'Pattern' я ввожу текст 'Администратор'
			И я нажимаю на кнопку с именем 'Find'
			Тогда открылось окно 'Пользователи'
			И пауза 1
			Если в таблице 'ПользователиСписок' количество строк "равно" 0 Тогда
				И я нажимаю на кнопку с именем 'СоздатьПользователя'
				Тогда открылось окно "Пользователь (создание)"
				И в поле с именем 'Наименование' я ввожу текст 'Администратор'
				И Я заполняю электронную почту пользователя "AnyAdress@mail.ru"
			Иначе
				И в таблице 'ПользователиСписок' я выбираю текущую строку
        
		* Обновляем настройки		
			И я нажимаю на кнопку с именем 'ФормаЗаписать'			
			Если открылось окно 'Запись пользователя информационной базы' Тогда
				И я нажимаю на кнопку с именем 'Button0'
			Если открылось окно "Обсуждения (система взаимодействий)" Тогда
				И я устанавливаю флаг с именем 'БольшеНеЗадаватьЭтотВопрос'
				И я нажимаю на кнопку с именем 'Команда2'
		
		* Добавляем группы доступа
			Тогда открылось окно "Администратор (Пользователь)"
			И В текущем окне я нажимаю кнопку командного интерфейса "Права доступа"

			* Группа "Администраторы"
				Если в таблице 'ГруппыДоступа' есть строка Тогда
					| "Наименование"   | "Профиль"        |
					| "Администраторы" | "Администратор"  |
				Иначе
					И в таблице 'ГруппыДоступа' я нажимаю на кнопку с именем 'ГруппыДоступаВключитьВГруппу'
					Тогда открылось окно "Группы доступа"
					И в таблице 'ГруппыДоступа' я перехожу к строке:
						| "Наименование"   |
						| "Администраторы" |
					И в таблице 'ГруппыДоступа' я выбираю текущую строку
			
			* Группа "Открытие внешних отчетов и обработок"			
				Если в таблице 'ГруппыДоступа' есть строка Тогда
					| "Наименование"                         | "Профиль"                              |
					| "Открытие внешних отчетов и обработок" | "Открытие внешних отчетов и обработок" |
				Иначе
					И в таблице 'ГруппыДоступа' я нажимаю на кнопку с именем 'ГруппыДоступаВключитьВГруппу'
					Тогда открылось окно "Группы доступа"	
					И в таблице 'ГруппыДоступа' я перехожу к строке:
						| "Наименование"                         |
						| "Открытие внешних отчетов и обработок" |
					И в таблице 'ГруппыДоступа' я выбираю текущую строку	

	* Создаем физическое лицо	
			Когда открылось окно 'Администратор (Пользователь)'
			И В текущем окне я нажимаю кнопку командного интерфейса 'Основное'		
			И я нажимаю кнопку выбора у поля "Физическое лицо"
			Тогда открылось окно 'Физические лица'
			И я нажимаю на кнопку с именем 'ФормаСоздать'
			Тогда открылось окно 'Физическое лицо (создание)'
			И в поле с именем 'ФИО' я ввожу текст 'Старк Бран'
			И я перехожу к следующему реквизиту
			Если открылось окно 'Найден человек с похожим именем' Тогда
				И я нажимаю на кнопку с именем 'ДаЭтоТотКтоМнеНужен'
			Иначе			
				И в поле с именем 'ФизлицоДатаРождения' я ввожу текст '01.01.2000'
				И я перехожу к следующему реквизиту
				И из выпадающего списка с именем "ФизлицоПол" я выбираю точное значение 'Мужской'
				И я перехожу к следующему реквизиту
				И я нажимаю на кнопку с именем 'КомандаЗаписать'
				И я нажимаю на кнопку с именем 'КомандаЗаписатьИЗакрыть'
				И я жду закрытия окна 'Физическое лицо (создание) *' в течение 20 секунд
				Тогда открылось окно 'Физические лица'
				И я нажимаю на кнопку с именем 'ФормаВыбрать'
		
		* Записываем пользователя
			Тогда открылось окно 'Администратор (Пользователь) *'
			И я нажимаю на кнопку 'Записать и закрыть'
			И я жду закрытия окна 'Администратор (Пользователь)' в течение 20 секунд
			Тогда открылось окно 'Пользователи'
			И я закрываю окно 'Пользователи'

	И я закрываю сеанс текущего клиента тестирования
	
Сценарий: 01.02. Включение подсистем и констант

	* Подключаем клиент текстирования
		И я подключаю TestClient "ЕРПУХ - НСИ" логин "Администратор" пароль ""
		И Пауза 5
		И Я закрыл все окна клиентского приложения

	* Запрещаем новости от ЕРП
		И я устанавливаю в константу 'РазрешенаРаботаСНовостями' значение 'Ложь'
		И я устанавливаю в константу 'РазрешенаРаботаСНовостямиЧерезИнтернет' значение 'Ложь'

	* Разрешаем открытие внешних оработок
		Если открылось окно 'Предупреждение безопасности' Тогда
			И я нажимаю на кнопку с именем 'НеЗапрещать'

		Если открылось окно '1С:Предприятие' Тогда
			И я нажимаю на кнопку с именем 'Button1'

	* Включаем подсистему "Корпоративные закупки"	
		И Я устанавливаю в константу "ИспользоватьЦентрализованноеУправлениеЗакупками" значение "Истина"	
	
	* Включаем подсистему "Механизмы управления НСИ"
	
		И В командном интерфейсе я выбираю 'Общие справочники и настройки' 'Общие настройки'
		Тогда открылось окно 'Общие настройки'
		И я устанавливаю флаг с именем 'ИспользоватьУправлениеНСИ'

	* Включаем подсистему "Управление активами"
		И я устанавливаю флаг с именем 'ИспользуетсяУправлениеАктивами'
		И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
		И я жду закрытия окна 'Общие настройки' в течение 20 секунд
	
	* Включаем использование нескольких валют
		И Я устанавливаю в константу "ИспользоватьНесколькоВалют" значение "Истина"
	
	* Включаем использование нескольких видов цен
		И Я устанавливаю в константу "ИспользоватьНесколькоВидовЦен" значение "Истина"
		
	* Включаем использование нескольких организаций
		И Я устанавливаю в константу "ИспользоватьНесколькоОрганизаций" значение "Истина"
		И Я устанавливаю в константу "ИспользоватьМногострановойУчет" значение "Истина"				
	
	* Включаем использование нескольких складов
		И Я устанавливаю в константу "ИспользоватьНесколькоСкладов" значение "Истина"
	
	* Включаем использование нескольких касс
		И Я устанавливаю в константу "ИспользоватьНесколькоКасс" значение "Истина"

	* Включаем использование розничных продаж
		И Я устанавливаю в константу "ИспользоватьРозничныеПродажи" значение "Истина"		

	* Включаем раздельное ведедние партнеров и контрагентов
		И Я устанавливаю в константу "ИспользоватьПартнеровИКонтрагентов" значение "Истина"		

	* Включаем использование актов выполненных работ по нескольким заказам
		И Я устанавливаю в константу "ИспользоватьАктыВыполненныхРаботПоНесколькимЗаказам" значение "Истина"		
	
	* Включаем использование внутреннее потребление по нескольким заказам
		И Я устанавливаю в константу "ИспользоватьВнутреннееПотреблениеПоНесколькимЗаказам" значение "Истина"		
	
	* Включаем использование начислений зарплаты в нескольких организациях
		И Я устанавливаю в константу "ИспользоватьНачислениеЗарплатыВНесколькихОрганизациях" значение "Истина"		

	* Включаем использование нескольких видов номенклатуры
		И Я устанавливаю в константу "ИспользоватьНесколькоВидовНоменклатуры" значение "Истина"			

	* Включаем использование нескольких касс ККМ
		И Я устанавливаю в константу "ИспользоватьНесколькоКассККМ" значение "Истина"

	* Включаем использование нескольких классифкаций задолжденности
		И Я устанавливаю в константу "ИспользоватьНесколькоКлассификацийЗадолженности" значение "Истина"
	
	* Включаем использование нескольких расчетных счетов
		И Я устанавливаю в константу "ИспользоватьНесколькоРасчетныхСчетов" значение "Истина"
	
	* Включаем использование классификаторов номенклатуры
		И Я устанавливаю в константу "ИспользованиеКлассификаторовНоменклатуры" значение "Истина"
	
	* Включаем использование характеристик номенклатуры
		И Я устанавливаю в константу "ИспользоватьХарактеристикиНоменклатуры" значение "Истина"
	
	* Включаем использование планов закупок
		И Я устанавливаю в константу "ИспользоватьПланированиеЗакупок" значение "Истина"	

	* Включаем использование заказов поставщикам
		И Я устанавливаю в константу "ИспользоватьЗаказыПоставщикам" значение "Истина"	

	* Включаем использование заказы на внутреннее потребление
		И Я устанавливаю в константу "ИспользоватьЗаказыНаВнутреннееПотребление" значение "Истина"	

	* Включаем использование планов на внутреннее потребление
		И Я устанавливаю в константу "ИспользоватьПланированиеВнутреннихПотреблений" значение "Истина"	

	* Включаем использование статусов внутренних потреблений
		И Я устанавливаю в константу "ИспользоватьСтатусыВнутреннихПотреблений" значение "Истина"	

	* Включаем использование статусов заказов на внутреннее потребление
		//И Я устанавливаю в константу "ИспользоватьСтатусыЗаказовНаВнутреннееПотребление" значение "Истина"	
	
	* Включаем использование поступление по нескольким заказам
		И Я устанавливаю в константу "ИспользоватьПоступлениеПоНесколькимЗаказам" значение "Истина"	
		
	* Включаем использование многостранового учета
		И Я устанавливаю в константу "ИспользоватьМногострановойУчет" значение "Истина"	
	
	* Включаем использование банковских счетов физическими лицами
		Дано Я открываю основную форму регистра сведений "НастройкиВзаиморасчетовПоПрочимДоходам"
		И я устанавливаю флаг с именем 'ИспользоватьВзаиморасчетыПоПрочимДоходам'
		И я устанавливаю флаг с именем 'ИспользоватьВедомостиДляВыплатыПрочихДоходов'
		И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
		Если открылось окно "1С:Предприятие" Тогда
			И я нажимаю на кнопку с именем 'OK'
			Тогда открылось окно "Настройки взаиморасчетов по прочим доходам (создание) *"
			И Я закрываю окно "Настройки взаиморасчетов по прочим доходам (создание) *"
			Тогда открылось окно "1С:Предприятие"
			И я нажимаю на кнопку с именем 'Button1'			
		И я жду закрытия окна 'Настройки взаиморасчетов по прочим доходам (создание) *' в течение 20 секунд
	
	* Включаем передачу и прием на комиссию
		
		И Я устанавливаю в константу "ИспользоватьКомиссиюПриЗакупках" значение "Истина"
		И Я устанавливаю в константу "ИспользоватьКомиссиюПриПродажах" значение "Истина"
		И Я устанавливаю в константу "ИспользоватьОказаниеАгентскихУслугПриЗакупке" значение "Истина"

	* Включаем использование договоров кредитов и депозитов

		И Я устанавливаю в константу "ИспользоватьДоговорыКредитовИДепозитов" значение "Истина"
	
	* Испортные закупки

		И Я устанавливаю в константу "ИспользоватьИмпортныеЗакупки" значение "Истина"

	* Включение договоров с поклажедателем

		И Я устанавливаю в константу "ИспользоватьОтветственноеХранениеВПроцессеЗакупки" значение "Истина"
	
	* Авто создание внутригрупповых договоров

		И Я устанавливаю в константу "АвтоматическиСоздаватьВнутригрупповыеДоговорыИЦессии" значение "Истина"

	* Использование нескольких видов цен

		И Я устанавливаю в константу "ИспользоватьНесколькоВидовЦен" значение "Истина"


	* Закрываем клиент тестирования
	
		И я закрываю TestClient "ЕРПУХ - НСИ"
