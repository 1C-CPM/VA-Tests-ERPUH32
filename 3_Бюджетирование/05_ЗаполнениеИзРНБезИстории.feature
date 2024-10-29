﻿#language: ru
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Функционал: 05. Проверка видов отчета без сохранения истории, проверка заполнения данных из РБ

	Как Администратор я хочу
	Проверить что виды отчетов без истории корректно сохраняют версии
	чтобы версии записывались без ошибок

Контекст:
	
	И я закрыл все окна клиентского приложения

Сценарий: 05.00 Определение типа приложения

	И я закрываю TestClient "УХ - Бюджетирование"
	И я подключаю TestClient "УХ - Бюджетирование" логин "Администратор" пароль ''
	Пусть Инициализация переменных

Сценарий: 05.01 Создание вида отчета "ВА - Заполнение из РН (без истории)"

	И Я создаю вид отчета с именем "ВА - Заполнение из РН (без истории)" и родителем "ВА - Группа отчетов"
	И Я для вида отчета "ВА - Заполнение из РН (без истории)" изменяю флаг 'СохранятьИсториюИзменений'
	И Я для вида отчета "ВА - Заполнение из РН (без истории)" изменяю флаг 'РазделениеПоПроектам'
	
	* Редактируем структуру отчета
		И Я открываю контруктор отчета с именем "ВА - Заполнение из РН (без истории)"
		И Я в конструкторе отчета добавляю строку с именем "Статьи ДДС"
		И Я в конструкторе отчета добавляю колонку с именем "Сумма"
		И Я в конструкторе отчета добавляю аналитику с кодом "ВА0СтатДДС" в ячейку 'R2C2'

	И Я Для вида отчета "ВА - Заполнение из РН (без истории)" создаю бланк по умолчанию

Сценарий: 05.02 Создаем бланк сводной таблицы

	И Я нахожу в списке вид отчета с именем "ВА - Заполнение из РН (без истории)"
					
	* Создаем бланк сводной таблицы
		Когда открылось окно "Виды и бланки отчетов"
		И в таблице 'Список' я перехожу к строке:
			| "Наименование"                                          |
			| "ВА - Заполнение из РН (без истории) (сводная таблица)" |
		И в таблице 'Список' я выбираю текущую строку
		* Состав строк
			Когда Открылся бланк сводной таблицы для вида отчета "ВА - Заполнение из РН (без истории)"
			И я нажимаю на кнопку с именем 'ПоказатьСоставСтрок'
			Тогда открылось окно "Настройка состава строк"
			И в таблице 'ДеревоНастройки' я перехожу к строке:
				| "Вид аналитики 1" | "Группа аналитик" | "Код"       | "Предназначение"      | "Строка отчета" |
				| "Статьи ДДС"      | "ГР_Статьи ДДС"   | "СтатьиДДС" | "Произвольные данные" | "Статьи ДДС"    |
			И я нажимаю на кнопку с именем 'ПеренестиВлево'
			И я нажимаю на кнопку с именем 'ПрименитьИзменения'
		* Состав колонок	
			Тогда Открылся бланк сводной таблицы для вида отчета "ВА - Заполнение из РН (без истории)"
			И я запоминаю заголовок формы в переменную 'ЗаголовокОкна'				
			И я нажимаю на кнопку с именем 'ПоказатьСоставКолонок'
			Тогда открылось окно "Настройка состава колонок"
			И в таблице 'НастройкиСоставаКолонокСводнойТаблицы' я нажимаю на кнопку с именем 'НастройкиСоставаКолонокСводнойТаблицыДобавить'
			И в таблице 'НастройкиСоставаКолонокСводнойТаблицы' я нажимаю кнопку выбора у реквизита с именем 'НастройкиСоставаКолонокСводнойТаблицыКолонкаОтчета'
			Тогда открылось окно "Колонки отчетов"
			И в таблице 'Список' я выбираю текущую строку
			Тогда открылось окно "Настройка состава колонок"
			И в таблице 'НастройкиСоставаКолонокСводнойТаблицы' я завершаю редактирование строки
			И я нажимаю на кнопку с именем 'ФормаПрименить'
		* Расположение группировок
			Когда открылось окно '$ЗаголовокОкна$'
			И я нажимаю на кнопку с именем 'ПоказатьНастройкиТаблицыПоОсям'
			Тогда открылось окно "Настройка расположения полей"
			И в таблице 'ТаблицаДоступныеПоля' я перехожу к строке:
				| "Доступные аналитики" |
				| "Проект"              |
			И я выбираю пункт контекстного меню с именем 'ТаблицаДоступныеПоляКонтекстноеМенюПеренестиВОтборы' на элементе формы с именем 'ТаблицаДоступныеПоля'
			И в таблице 'ТаблицаДоступныеПоля' я перехожу к строке:
				| "Доступные аналитики" |
				| "Статьи ДДС"          |
			И я выбираю пункт контекстного меню с именем 'ТаблицаДоступныеПоляКонтекстноеМенюПеренестиВСтроки' на элементе формы с именем 'ТаблицаДоступныеПоля'
			И я нажимаю на кнопку с именем 'КнопкаПрименить'
		* Шкала с периодами
			Тогда открылось окно '$ЗаголовокОкна$'
			И я нажимаю на кнопку с именем 'ПоказатьНастройкиПериодов'
			И из выпадающего списка с именем 'Периодичность' я выбираю точное значение "Квартал"
			И из выпадающего списка с именем 'Периодичность' я выбираю точное значение "Месяц"
			И я изменяю флаг с именем 'ВыводитьИтогГод'
			И я изменяю флаг с именем 'ВыводитьИтогГод'
			И я изменяю флаг с именем 'ВыводитьИтогПолугодие'
			И я изменяю флаг с именем 'ВыводитьИтогПолугодие'
			И я изменяю флаг с именем 'ВыводитьИтогКвартал'
			И я изменяю флаг с именем 'ВыводитьИтогКвартал'
			И я нажимаю на кнопку с именем 'ФормаПрименить'
		* Расположение полей 
			Тогда открылось окно '$ЗаголовокОкна$'
			И я нажимаю на кнопку с именем 'ПоказатьНастройкуСоставаАналитики'
			Тогда открылось окно "Настройка состава аналитики строк и колонок"
			И я нажимаю на кнопку с именем 'ФормаПрименить'
		* Запись бланка
			Тогда открылось окно '$ЗаголовокОкна$'
			И я разворачиваю группу с именем 'ГруппаОсновныхРеквизитов'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна '$ЗаголовокОкна$ *' в течение 20 секунд		

Сценарий: 05.03 Создаем формулу расчета с заполнением из РН

	Если 'НЕ $$ЭтоPerform$$' Тогда

		И Я открываю контруктор отчета с именем "ВА - Заполнение из РН (без истории)"
					
		* Вводим формулу расчета
			* Создаем новый элемент	
				Тогда открылось окно "Конструктор отчета"
				И я меняю значение переключателя с именем 'РежимРаботы' на "Формулы"
				И в табличном документе 'ПолеТабличногоДокументаМакет' я перехожу к ячейке 'R2C2'
				И в табличном документе 'ПолеТабличногоДокументаМакет' я делаю двойной клик на текущей ячейке
				И в поле с именем 'ПолеТекстовогоДокументаПроцедура' я ввожу текст ' '
				И я нажимаю на кнопку с именем 'ДобавитьОперанд1'
				Когда открылось окно "Источники данных"
				И я нажимаю на кнопку с именем 'ФормаСоздать'
			* Заполняем источник получения, проверяем заполнение полей				
				Когда открылось окно "Источник данных (создание)"
				И из выпадающего списка с именем 'СпособПолучения' я выбираю точное значение "Регистр накопления текущей ИБ"
				Если '$$ЭтоЕРПУХ$$' Тогда
					И из выпадающего списка с именем 'РегистрНакопленияБД' я выбираю по строке 'ОперацииБюджетов'
					И у элемента с именем 'РесурсРегистраБД' я жду значения "Сумма" в течение 3 секунд
					И у элемента с именем 'ВидИтогаБД' я жду значения "Оборот" в течение 3 секунд	
					И из выпадающего списка с именем 'РесурсРегистраБД' я выбираю точное значение "Сумма исполнено"										
					Когда открылось окно "Источник данных (создание) *"
					И в таблице "ДеревоПолейБД" я разворачиваю текущую строку
					И в таблице "ДеревоПолейБД" я разворачиваю строку:
						| 'Поле'                      |
						| 'Аналитика статей бюджетов' |
					И в таблице "ДеревоПолейБД" я разворачиваю строку:
						| 'Поле'           |
						| 'Статья бюджета' |
					И в таблице "ДеревоПолейБД" я перехожу к строке:
						| 'Поле'                                     |
						| 'Справочник.СтатьиДвиженияДенежныхСредств' |
					И я выбираю пункт контекстного меню с именем 'КнопкаСопоставитьАналитики' на элементе формы с именем "ТаблицаСоответствия"
					Тогда таблица "ТаблицаСоответствия" стала равной:
						| 'Аналитика приемника'     | 'Способ заполнения' | 'Имя колонки'                                  | 'Вид аналитики' |
						| 'Аналитика 1: Статьи ДДС' | 'Поле источника'    | '[Аналитика статей бюджетов].[Статья бюджета]' | 'Статьи ДДС'    |																									
				Иначе
					И из выпадающего списка с именем 'РегистрНакопленияБД' я выбираю по строке 'ДвиженияДенежныхСредствУХ'
					И у элемента с именем 'РесурсРегистраБД' я жду значения "Сумма" в течение 3 секунд
					И у элемента с именем 'ВидИтогаБД' я жду значения "Оборот" в течение 3 секунд					
					Тогда таблица 'ТаблицаСоответствия' стала равной:
						| 'Аналитика приемника'     | 'Способ заполнения' | 'Имя колонки'                        | 'Вид аналитики' |
						| "Аналитика 1: Статьи ДДС" | 'Поле источника'    | '[Статья движения денежных средств]' | "Статьи ДДС"    |							
			* Заполняем отборы		
				И я перехожу к закладке с именем 'СтраницаОтборы'
				Если '$$ЭтоЕРПУХ$$' Тогда
					И в таблице "ДеревоПолейБД" я разворачиваю строку:
						| 'Поле'                |
						| 'Аналитика структуры' |
					И в таблице "ДеревоПолейБД" я перехожу к строке:
						| 'Поле'        |
						| 'Организация' |
					И я нажимаю на кнопку с именем 'ДобавитьЭлементУсловия'
					И в таблице "ДеревоПараметровОтбораБД" я перехожу к строке:
						| 'Поле'                                |
						| '[Аналитика структуры].[Организация]' |
					И в таблице "ДеревоПараметровОтбораБД" из выпадающего списка с именем "СпособВычисленияПараметра" я выбираю точное значение 'Организация отчета'
					И в таблице "ДеревоПараметровОтбораБД" я завершаю редактирование строки											
				Иначе
					И в таблице 'ДеревоПараметровОтбораБД' я перехожу к строке:
						| 'Отбор'         | 'Поле'         |
						| 'Проект отчета' | '[Аналитика1]' |
					И я нажимаю на кнопку с именем 'ДеревоПараметровОтбораБДУдалить'	
					И в таблице 'ДеревоПараметровОтбораБД' я перехожу к строке:
						| 'Отбор'           | 'Поле'         |
						| 'Сценарий отчета' | '[Аналитика2]' |
					И я нажимаю на кнопку с именем 'ДеревоПараметровОтбораБДУдалить'
					И в таблице 'ДеревоПараметровОтбораБД' я перехожу к строке:
						| 'Отбор'         | 'Поле'         |
						| "Период отчета" | '[Аналитика3]' |
					И я нажимаю на кнопку с именем 'ДеревоПараметровОтбораБДУдалить'	
				И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
				И я жду закрытия окна "Источник данных (создание) *" в течение 20 секунд

		* Сохраняем элемент		
			Тогда открылось окно "Источники данных"
			И в таблице 'Список' я выбираю текущую строку
			Тогда открылось окно "Конструктор отчета *"
			И я нажимаю на кнопку с именем 'ЗаписатьИСвернуть'

Сценарий: 05.04 Создание экземпляра отчета - "ВА - Заполнение из РН (без истории)" без записи 

	Если 'НЕ $$ЭтоPerform$$' Тогда

		И Я создаю экземпляр отчета для вида отчета "ВА - Заполнение из РН (без истории)" сценарий "ВА - Основной сценарий" период '01.01.2024' '31.03.2024' периодичность 'Месяц' организация "Меркурий ООО" проект "ВА - Основной проект" аналитики '' '' '' '' '' '' 
		
		* Документ должен быть пустой
			И табличный документ 'ПолеТабличногоДокументаМакет' равен:
				| "ВА - Заполнение из РН (без истории)" | ''               | ''                | ''             | ''      |
				| ''                                    | ''               | ''                | ''             | ''      |
				| ''                                    | "Январь 2024 г." | "Февраль 2024 г." | "Март 2024 г." | "ИТОГО" |
				| ''                                    | "Сумма"          | "Сумма"           | "Сумма"        | "Сумма" |
				| "Статьи ДДС"                          | '0'              | '0'               | '0'            | '0'     |

		* Рассчитываем значения показателей	
			Когда открылось окно '$ЗаголовокОкна$'
			И я нажимаю на кнопку с именем 'ФормаЗаполнитьПоУмолчанию'
			Тогда табличный документ 'ПолеТабличногоДокументаМакет' равен:
				| "ВА - Заполнение из РН (без истории)" | ''               | ''                | ''             | ''           |
				| ''                                    | ''               | ''                | ''             | ''           |
				| ''                                    | "Январь 2024 г." | "Февраль 2024 г." | "Март 2024 г." | "ИТОГО"      |
				| ''                                    | "Сумма"          | "Сумма"           | "Сумма"        | "Сумма"      |
				| "Статьи ДДС"                          | '3 120 000'      | '16 000 000'      | '0'            | '19 120 000' |
				| "Апгрейд программных продуктов "      | '0'              | '3 450 000'       | '0'            | '3 450 000'  |
				| "Внедрение программных продуктов "    | '2 340 000'      | '7 350 000'       | '0'            | '9 690 000'  |
				| "Реализация программных продуктов "   | '780 000'        | '5 200 000'       | '0'            | '5 980 000'  |

		* Закрываем без записи
			Когда открылось окно '$ЗаголовокОкна$'
			И Я закрываю окно '$ЗаголовокОкна$'
			Тогда открылось окно "1С:Предприятие"
			И я нажимаю на кнопку с именем 'Button1'

Сценарий: 05.05 Создание экземпляра отчета - "ВА - Заполнение из РН (без истории)" с записью 

	Если 'НЕ $$ЭтоPerform$$' Тогда

		И Я создаю экземпляр отчета для вида отчета "ВА - Заполнение из РН (без истории)" сценарий "ВА - Основной сценарий" период '01.01.2024' '31.03.2024' периодичность 'Месяц' организация "Меркурий ООО" проект "ВА - Основной проект" аналитики '' '' '' '' '' '' 

		* Документ должен быть пустой
			И табличный документ 'ПолеТабличногоДокументаМакет' равен:
				| "ВА - Заполнение из РН (без истории)" | ''               | ''                | ''             | ''      |
				| ''                                    | ''               | ''                | ''             | ''      |
				| ''                                    | "Январь 2024 г." | "Февраль 2024 г." | "Март 2024 г." | "ИТОГО" |
				| ''                                    | "Сумма"          | "Сумма"           | "Сумма"        | "Сумма" |
				| "Статьи ДДС"                          | '0'              | '0'               | '0'            | '0'     |

		* Рассчитываем значения показателей	
			Когда открылось окно '$ЗаголовокОкна$'
			И я нажимаю на кнопку с именем 'ФормаЗаполнитьПоУмолчанию'
			Тогда табличный документ 'ПолеТабличногоДокументаМакет' равен:
				| "ВА - Заполнение из РН (без истории)" | ''               | ''                | ''             | ''           |
				| ''                                    | ''               | ''                | ''             | ''           |
				| ''                                    | "Январь 2024 г." | "Февраль 2024 г." | "Март 2024 г." | "ИТОГО"      |
				| ''                                    | "Сумма"          | "Сумма"           | "Сумма"        | "Сумма"      |
				| "Статьи ДДС"                          | '3 120 000'      | '16 000 000'      | '0'            | '19 120 000' |
				| "Апгрейд программных продуктов "      | '0'              | '3 450 000'       | '0'            | '3 450 000'  |
				| "Внедрение программных продуктов "    | '2 340 000'      | '7 350 000'       | '0'            | '9 690 000'  |
				| "Реализация программных продуктов "   | '780 000'        | '5 200 000'       | '0'            | '5 980 000'  |

		* Записываем документ, проверяем движения
			Когда открылось окно '$ЗаголовокОкна$'
			И я нажимаю на кнопку с именем 'Записать'
			И я жду открытия формы '$ЗаголовокОкна$' в течение 30 секунд

		* Проверяем движения
			И Движения экземпляра отчета стали равны '3_Бюджетирование\Макеты\05\ВА_ЗаполнениеИзРН_Движения_1.mxl'
		
Сценарий: 05.06 Создаем формулу расчета с заполнением из РН по основной таблице

	Если 'НЕ $$ЭтоPerform$$' Тогда

		И Я открываю контруктор отчета с именем "ВА - Заполнение из РН (без истории)"
					
		* Вводим формулу расчета
			* Создаем новый элемент	
				Тогда открылось окно "Конструктор отчета"
				И я меняю значение переключателя с именем 'РежимРаботы' на "Формулы"
				И в табличном документе 'ПолеТабличногоДокументаМакет' я перехожу к ячейке 'R2C2'
				И в табличном документе 'ПолеТабличногоДокументаМакет' я делаю двойной клик на текущей ячейке
				И в поле с именем 'ПолеТекстовогоДокументаПроцедура' я ввожу текст ' '
				И я нажимаю на кнопку с именем 'ДобавитьОперанд1'
				Когда открылось окно "Источники данных"
				И я нажимаю на кнопку с именем 'ФормаСоздать'
			* Заполняем источник получения, проверяем заполнение полей				
				Когда открылось окно "Источник данных (создание)"
				И из выпадающего списка с именем 'СпособПолучения' я выбираю точное значение "Регистр накопления текущей ИБ"
				Если '$$ЭтоЕРПУХ$$' Тогда
					И из выпадающего списка с именем 'РегистрНакопленияБД' я выбираю по строке 'ОперацииБюджетов'
				Иначе
					И из выпадающего списка с именем 'РегистрНакопленияБД' я выбираю по строке 'ДвиженияДенежныхСредствУХ'
				И я устанавливаю флаг с именем 'ОсновнаяТаблицаРегистра'						
				И у элемента с именем 'РесурсРегистраБД' я жду значения "Сумма" в течение 10 секунд
				Тогда таблица 'ДеревоПолейБД' стала равной по шаблону:
					| 'Поле'                  |
					| 'Регистратор'           |
					| 'Измерения регистра(*)' |
					| 'Реквизиты регистра(*)' |
				Если '$$ЭтоЕРПУХ$$' Тогда
					И из выпадающего списка с именем 'РесурсРегистраБД' я выбираю точное значение "Сумма исполнено"										
					Когда открылось окно "Источник данных (создание) *"
					И в таблице "ДеревоПолейБД" я разворачиваю строку:
						| 'Поле'                   |
						| 'Измерения регистра(12)' |
					И в таблице "ДеревоПолейБД" я разворачиваю строку:
						| 'Поле'                      |
						| 'Аналитика статей бюджетов' |
					И в таблице "ДеревоПолейБД" я разворачиваю строку:
						| 'Поле'           |
						| 'Статья бюджета' |
					И в таблице "ДеревоПолейБД" я перехожу к строке:
						| 'Поле'                                     |
						| 'Справочник.СтатьиДвиженияДенежныхСредств' |
					И я выбираю пункт контекстного меню с именем 'КнопкаСопоставитьАналитики' на элементе формы с именем "ТаблицаСоответствия"
					Тогда таблица "ТаблицаСоответствия" стала равной:
						| 'Аналитика приемника'     | 'Способ заполнения' | 'Имя колонки'                                  | 'Вид аналитики' |
						| 'Аналитика 1: Статьи ДДС' | 'Поле источника'    | '[Аналитика статей бюджетов].[Статья бюджета]' | 'Статьи ДДС'    |
				Иначе
					Тогда таблица 'ТаблицаСоответствия' стала равной:
						| 'Аналитика приемника'     | 'Способ заполнения' | 'Имя колонки'                        | 'Вид аналитики' |
						| "Аналитика 1: Статьи ДДС" | 'Поле источника'    | '[Статья движения денежных средств]' | "Статьи ДДС"    |

			* Добавляем отборы
				И я перехожу к закладке с именем 'СтраницаОтборы'	
				Когда открылось окно "Источник данных (создание) *"
				И в таблице 'ДеревоПараметровОтбораБД' я перехожу к строке:
					| 'Отбор'                      | 'Поле'                      |
					| 'Дата начала периода отчета' | 'Дата начала отбора данных' |
				И в таблице 'ДеревоПараметровОтбораБД' из выпадающего списка с именем 'СпособВычисленияПараметра' я выбираю точное значение "Дата начала периода отчета со сдвигом"
				И в таблице 'ДеревоПараметровОтбораБД' в поле с именем 'УточнениеСпособаОпределения' я ввожу текст '-1'
				И в таблице 'ДеревоПараметровОтбораБД' я завершаю редактирование строки
				И в таблице 'ДеревоПараметровОтбораБД' я перехожу к строке:
					| 'Отбор'                     | 'Поле'                         |
					| 'Дата конца периода отчета' | 'Дата окончания отбора данных' |
				И в таблице 'ДеревоПараметровОтбораБД' из выпадающего списка с именем 'СпособВычисленияПараметра' я выбираю точное значение "Дата конца периода отчета со сдвигом"
				И в таблице 'ДеревоПараметровОтбораБД' в поле с именем 'УточнениеСпособаОпределения' я ввожу текст '-1'
				И в таблице 'ДеревоПараметровОтбораБД' я завершаю редактирование строки	
				Если '$$ЭтоЕРПУХ$$' Тогда
					* Добавляем поля отбора
						И в таблице "ДеревоПолейБД" я разворачиваю строку:
							| 'Поле'                |
							| 'Аналитика структуры' |
						И в таблице "ДеревоПолейБД" я перехожу к строке:
							| 'Поле'        |
							| 'Организация' |
						И я нажимаю на кнопку с именем 'ДобавитьЭлементУсловия'
						И в таблице "ДеревоПараметровОтбораБД" я перехожу к строке:
							| 'Поле'                                |
							| '[Аналитика структуры].[Организация]' |
						И в таблице "ДеревоПараметровОтбораБД" из выпадающего списка с именем "СпособВычисленияПараметра" я выбираю точное значение 'Организация отчета'
						И в таблице "ДеревоПараметровОтбораБД" я завершаю редактирование строки	

				Иначе	
					* Удаляем текущие отборы
						И в таблице 'ДеревоПараметровОтбораБД' я перехожу к строке:
							| 'Отбор'         | 'Поле'         |
							| 'Проект отчета' | '[Аналитика1]' |
						И я нажимаю на кнопку с именем 'ДеревоПараметровОтбораБДУдалить'
						И в таблице 'ДеревоПараметровОтбораБД' я перехожу к строке:
							| 'Отбор'           | 'Поле'         |
							| 'Сценарий отчета' | '[Аналитика2]' |
						И я нажимаю на кнопку с именем 'ДеревоПараметровОтбораБДУдалить'
						И в таблице 'ДеревоПараметровОтбораБД' я перехожу к строке:
							| 'Отбор'         | 'Поле'         |
							| "Период отчета" | '[Аналитика3]' |
						И я нажимаю на кнопку с именем 'ДеревоПараметровОтбораБДУдалить''			
				* Добавляем поля отбора
					Когда открылось окно "Источник данных (создание) *"
					И в таблице 'ДеревоПолейБД' я разворачиваю строку:
						| 'Поле'        |
						| 'Регистратор' |
					Если '$$ЭтоЕРПУХ$$' Тогда
						И в таблице 'ДеревоПолейБД' я перехожу к строке:
							| 'Поле'                                              |
							| 'Документ.ОтражениеФактическихДанныхБюджетирования' |
						И в таблице 'ДеревоПолейБД' я разворачиваю текущую строку	
					И в таблице 'ДеревоПолейБД' я разворачиваю строку:
						| 'Поле'       |
						| 'Контрагент' |
					И в таблице 'ДеревоПолейБД' я разворачиваю строку:
						| 'Поле'       |
						| 'Справочник.Контрагенты' |
					И я нажимаю на кнопку с именем 'ДобавитьЭлементУсловия'
					И в таблице 'ДеревоПолейБД' я перехожу к строке:
						| 'Поле'     |
						| 'Сценарий' |
					И я нажимаю на кнопку с именем 'ДобавитьЭлементУсловия'
				* Добавляем значения отбора
					Когда открылось окно "Источник данных (создание) *"													
					И в таблице 'ДеревоПараметровОтбораБД' я перехожу к строке:
						| 'Поле'                     |
						| '[Регистратор].[Сценарий]' |
					И в таблице 'ДеревоПараметровОтбораБД' я активизирую поле с именем 'СпособВычисленияПараметра'
					И в таблице 'ДеревоПараметровОтбораБД' из выпадающего списка с именем 'СпособВычисленияПараметра' я выбираю точное значение "Сценарий отчета"
					И в таблице 'ДеревоПараметровОтбораБД' я завершаю редактирование строки				
					И в таблице 'ДеревоПараметровОтбораБД' я перехожу к строке:
						| 'Поле'                       |
						| '[Регистратор].[Контрагент]' |
					И в таблице 'ДеревоПараметровОтбораБД' из выпадающего списка с именем 'СпособВычисленияПараметра' я выбираю точное значение "Фиксированное значение"
					И в таблице 'ДеревоПараметровОтбораБД' я нажимаю кнопку выбора у реквизита с именем 'УточнениеСпособаОпределения'
					Когда открылось окно "Контрагенты*"
					И Я закрываю окно "Контрагенты*"
					И в таблице 'ДеревоПараметровОтбораБД' из выпадающего списка с именем 'УточнениеСпособаОпределения' я выбираю по строке "ООО \"Ганимед\""
					И в таблице 'ДеревоПараметровОтбораБД' я завершаю редактирование строки
						
			* Записываем элемент
				Когда открылось окно "Источник данных (создание) *"
				И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
				И я жду закрытия окна "Источник данных (создание) *" в течение 20 секунд
		
		* Выбираем элемент в форме конструктура			
			Тогда открылось окно "Источники данных"
			И в таблице 'Список' я выбираю текущую строку
			Тогда открылось окно "Конструктор отчета *"
			И я нажимаю на кнопку с именем 'ЗаписатьИСвернуть'

Сценарий: 05.07 Настройка прав для пользователей

	Если 'НЕ $$ЭтоPerform$$' Тогда

		И Я добавляю право "Чтение, запись" для вида отчета "ВА - Заполнение из РН (без истории)" пользователя "Бюджетирование1" по всем организациям
		И я закрываю TestClient "УХ - Бюджетирование"
		И я подключаю TestClient "УХ - Бюджетирование" логин "Бюджетирование1" пароль ''			

Сценарий: 05.08 Создаем сводную таблицу

	Если 'НЕ $$ЭтоPerform$$' Тогда

		И Я нахожу в списке вид отчета с именем "ВА - Заполнение из РН (без истории)"

		* Создаем сводную таблицу			
			Когда открылось окно "Виды и бланки отчетов"
			И в таблице "Список" я перехожу к строке:
				| 'Наименование'                                          |
				| 'ВА - Заполнение из РН (без истории) (сводная таблица)' |
			И я нажимаю на кнопку с именем 'ПерейтиВРежимОтображенияДанных'
			И Открылась сводная таблица для вида отчета "ВА - Заполнение из РН (без истории)"
			И Я устанавливаю отборы сводной таблицы: дата начала '01.01.2024', дата конца '31.03.2024', валюта 'RUB', сценарий "ВА - Основной сценарий", организация "Меркурий ООО"
			И Я устанавливаю отбор сводной таблицы 'Проект' со значением "ВА - Основной проект"	
			Тогда табличный документ 'ПолеТабличногоДокументаМакет' равен:
				| 'ВА - Заполнение из РН (без истории) (сводная таблица)' | "Январь 2024 г." | "Февраль 2024 г." | "Март 2024 г." |
				| 'ВА - Заполнение из РН (без истории) (сводная таблица)' | "Сумма"          | "Сумма"           | "Сумма"        |
				| "Статьи ДДС"                                            | '3 120 000'      | '16 000 000'      | '0'            |
				| "Апгрейд программных продуктов"                         | '0'              | '3 450 000'       | '0'            |
				| "Внедрение программных продуктов"                       | '2 340 000'      | '7 350 000'       | '0'            |
				| "Реализация программных продуктов"                      | '780 000'        | '5 200 000'       | '0'            |
		
		* Рассчитываем по регламенту
			И Открылась сводная таблица для вида отчета "ВА - Заполнение из РН (без истории)"
			И я нажимаю на кнопку с именем 'ПересчитатьПоРегламенту'
			И я жду открытия формы '$ЗаголовокОкна$' в течение 30 секунд
			Тогда табличный документ 'ПолеТабличногоДокументаМакет' равен:
				| 'ВА - Заполнение из РН (без истории) (сводная таблица)' | "Январь 2024 г." | "Февраль 2024 г." | "Март 2024 г." |
				| 'ВА - Заполнение из РН (без истории) (сводная таблица)' | "Сумма"          | "Сумма"           | "Сумма"        |
				| "Статьи ДДС"                                            | '0'              | '3 120 000'       | '0'            |
				| "Внедрение программных продуктов"                       | '0'              | '2 340 000'       | '0'            |
				| "Реализация программных продуктов"                      | '0'              | '780 000'         | '0'            |

		* Отменим транзакцию
			И я нажимаю на кнопку с именем 'ОтменитьДействие'
			Тогда табличный документ 'ПолеТабличногоДокументаМакет' равен:
				| 'ВА - Заполнение из РН (без истории) (сводная таблица)' | "Январь 2024 г." | "Февраль 2024 г." | "Март 2024 г." |
				| 'ВА - Заполнение из РН (без истории) (сводная таблица)' | "Сумма"          | "Сумма"           | "Сумма"        |
				| "Статьи ДДС"                                            | '3 120 000'      | '16 000 000'      | '0'            |
				| "Апгрейд программных продуктов"                         | '0'              | '3 450 000'       | '0'            |
				| "Внедрение программных продуктов"                       | '2 340 000'      | '7 350 000'       | '0'            |
				| "Реализация программных продуктов"                      | '780 000'        | '5 200 000'       | '0'            |								

		* Рассчитываем по правилу
			Когда открылось окно '$ЗаголовокОкна$'
			И я нажимаю на кнопку с именем 'ПересчитатьПрочие'
			Тогда открылось окно "Выбор способа расчета показателей"
			И я нажимаю на кнопку с именем 'ФормаВыбрать'
			И я жду открытия формы '$ЗаголовокОкна$' в течение 30 секунд
			Тогда табличный документ 'ПолеТабличногоДокументаМакет' равен:
				| 'ВА - Заполнение из РН (без истории) (сводная таблица)' | "Январь 2024 г." | "Февраль 2024 г." | "Март 2024 г." |
				| 'ВА - Заполнение из РН (без истории) (сводная таблица)' | "Сумма"          | "Сумма"           | "Сумма"        |
				| "Статьи ДДС"                                            | '0'              | '3 120 000'       | '0'            |
				| "Внедрение программных продуктов"                       | '0'              | '2 340 000'       | '0'            |
				| "Реализация программных продуктов"                      | '0'              | '780 000'         | '0'            |

		* Сохраняем таблицу
			Когда открылось окно '$ЗаголовокОкна$'
			И Я закрываю окно '$ЗаголовокОкна$'
			Тогда открылось окно '1С:Предприятие'
			И я нажимаю на кнопку с именем 'Button0'

Сценарий: 05.09 Проверяем движения экземпляра отчета

	Если 'НЕ $$ЭтоPerform$$' Тогда

		И Я открываю первый экземпляр отчета для вида отчета "ВА - Заполнение из РН (без истории)"
		И Открылся экземпляр отчета для вида отчета "ВА - Заполнение из РН (без истории)" валюта 'RUB' организация "Меркурий ООО" сценарий "ВА - Основной сценарий" периодичность "Месяц" проект "ВА - Основной проект" аналитики '' '' '' '' '' '' 
		Тогда табличный документ 'ПолеТабличногоДокументаМакет' равен:
			| "ВА - Заполнение из РН (без истории)" | ''               | ''                | ''             | ''          |
			| ''                                    | ''               | ''                | ''             | ''          |
			| ''                                    | "Январь 2024 г." | "Февраль 2024 г." | "Март 2024 г." | "ИТОГО"     |
			| ''                                    | "Сумма"          | "Сумма"           | "Сумма"        | "Сумма"     |
			| "Статьи ДДС"                          | '0'              | '3 120 000'       | '0'            | '3 120 000' |
			| "Внедрение программных продуктов "    | '0'              | '2 340 000'       | '0'            | '2 340 000' |
			| "Реализация программных продуктов "   | '0'              | '780 000'         | '0'            | '780 000'   |

		* Проверяем, движения после сводной таблицы
			Когда открылось окно '$ЗаголовокОкна$'
			И Движения экземпляра отчета стали равны '3_Бюджетирование\Макеты\05\ВА_ЗаполнениеИзРН_Движения_2.mxl'

		* Рассчитываем документ
			Когда открылось окно '$ЗаголовокОкна$'
			И я нажимаю на кнопку с именем 'ФормаЗаполнитьПоУмолчанию'

		* Проверяем движения
			Когда открылось окно '$ЗаголовокОкна$'
			И я нажимаю на кнопку с именем 'ФормаДвиженияДокумента'
			Тогда открылось окно "1С:Предприятие"
			И я нажимаю на кнопку с именем 'Button1'
			Когда открылось окно '$ЗаголовокОкна$'
			И я нажимаю на кнопку с именем 'Записать'
			И я жду открытия формы '$ЗаголовокОкна$' в течение 30 секунд
			И Движения экземпляра отчета стали равны '3_Бюджетирование\Макеты\05\ВА_ЗаполнениеИзРН_Движения_2.mxl'
