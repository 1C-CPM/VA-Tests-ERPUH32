﻿#language: ru
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Функционал: 20. Тестирование подсистемы согласования

	Как Администратор я хочу
	Протестировать подсистему согласования 
	чтобы исключить ошибки при разработке   

Контекст:

	И я закрыл все окна клиентского приложения

Сценарий: 20.00 Определение типа приложения
	
	И я закрываю TestClient "УХ - Бюджетирование"
	И я подключаю TestClient "УХ - Бюджетирование" логин "Администратор" пароль ''
	Пусть Инициализация переменных

Сценарий: 20.01 Создание ролей

	* Создать роли и добавить их в матрицу адресации
		И Я создаю роль контактных лиц "ВА - Адресация по роли"
		И Я создаю роль контактных лиц "ВА - Роль расширенной адресации"

		И Я создаю элемент расширенной адресации "ВА - Расширенная адресация" роль "ВА - Роль расширенной адресации"

		И Я добавляю строку в матрицу адресации роль "ВА - Адресация по роли" пользователь "Бюджетирование2"
		И Я добавляю строку в матрицу адресации роль "ВА - Роль расширенной адресации" пользователь "Бюджетирование3"

	* Создать роль Суперпользователя
		И Я создаю роль контактных лиц "Суперпользователь"

		И В командном интерфейсе я выбираю "Общие справочники и настройки" "Общие настройки"
		Тогда открылось окно "Общие настройки*"
		И я нажимаю кнопку выбора у поля с именем 'РольСуперПользователь'
		И Я в списке "Роли контактных лиц" по полю "Наименование" ищу и выбираю элемент "Суперпользователь" "По точному совпадению"
		Тогда открылось окно "Общие настройки *"
		И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
		И я жду закрытия окна "Общие настройки *" в течение 20 секунд
		
		И Я добавляю строку в матрицу адресации роль "Суперпользователь" пользователь "Администратор"
		И Я добавляю строку в матрицу адресации роль "Суперпользователь" пользователь "Бюджетирование4"

Сценарий: 20.02 Настройка документа ИБ	

	И В командном интерфейсе я выбираю "Общие справочники и настройки" "Документы"
	
	Тогда открылось окно "Документы текущей информационной базы"
	И в таблице 'Список' я нажимаю на кнопку с именем 'СписокНайти'
	Тогда открылось окно "Найти"
	И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Документ"
	И я меняю значение переключателя с именем 'CompareType' на "По части строки"
	И в поле с именем 'Pattern' я ввожу текст "Экземпляр отчета"

	И я нажимаю на кнопку с именем 'Find'
	Тогда открылось окно "Документы текущей информационной базы"
	И я жду, что в таблице 'Список' количество строк будет "равно" 1 в течение 20 секунд
	И в таблице 'Список' я выбираю текущую строку

	Тогда открылось окно "Экземпляр отчета (Документ ИБ)"
	И я перехожу к закладке с именем 'ГруппаСогласование'
	И я устанавливаю флаг с именем 'РазделятьПоОрганизациям'
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
	И я жду закрытия окна "Экземпляр отчета (Документ ИБ) *" в течение 20 секунд
	Тогда открылось окно "Документы текущей информационной базы"
	И Я закрываю окно "Документы текущей информационной базы"

Сценарий: 20.03 Создание вида отчета

	* Создаем вид отчета
		И Я создаю вид отчета с именем "ВА - Согласование" и родителем "ВА - Группа отчетов"

	* Настраиваем структуру
		И я открываю контруктор отчета с именем "ВА - Согласование"
		И Я в конструкторе отчета добавляю строки
			| "Наименование" |
			| "Строка 1"     |
			| "Строка 2"     |
			| "Строка 3"     |
		И Я в конструкторе отчета добавляю колонки
			| "Наименование" |
			| "Количество"   |
			| "Цена"         |
			| "Сумма"        |

	* Настраиваем формулы
		И Я в конструкторе отчета для ячейки 'R2C4' задаю формулу произведение ячеек 'R2C2' 'R2C3'
		И Я в конструкторе отчета для ячейки 'R3C4' задаю формулу произведение ячеек 'R3C2' 'R3C3'
		И Я в конструкторе отчета для ячейки 'R4C4' задаю формулу произведение ячеек 'R4C2' 'R4C3'

	* Закрываем конструктор
		Когда открылось окно "Конструктор отчета"
		И Я закрываю окно "Конструктор отчета"
		
	* Создаем бланк
		И Я Для вида отчета "ВА - Согласование" создаю бланк по умолчанию	

Сценарий: 20.04 Создание экземпляра отчета

	И Я создаю экземпляр отчета для вида отчета "ВА - Согласование" сценарий "ВА - Основной сценарий" период '01.01.2024' '31.03.2024' периодичность "Месяц" организация "Меркурий ООО" проект '' аналитики '' '' '' '' '' ''

	И Я ввожу значение '3,00000' в ячейку 'R6C2'
	И Я ввожу значение '4,00000' в ячейку 'R7C2'
	И Я ввожу значение '5,00000' в ячейку 'R8C2'
	И Я ввожу значение '100,00000' в ячейку 'R6C3'
	И Я ввожу значение '200,00000' в ячейку 'R7C3'
	И Я ввожу значение '300,00000' в ячейку 'R8C3'

	Когда открылось окно '$ЗаголовокОкна$'
	И я нажимаю на кнопку с именем 'ЗаписатьИЗакрыть'
	И я жду закрытия окна '$ЗаголовокОкна$' в течение 20 секунд

Сценарий: 20.05 Создание шаблона процесса согласования

	* Проверить наличие группы шаблонов
		И В командном интерфейсе я выбираю "Процессы и согласование" "Шаблоны процессов"
		Тогда открылось окно "Шаблоны универсальных процессов"
		И Я в списке "Шаблоны универсальных процессов" по полю "Наименование" ищу элемент "ВА - Группа процесса согласования" "По точному совпадению"
		Если в таблице 'Список' количество строк "=" 0 Тогда
			И я нажимаю на кнопку с именем 'ФормаОтменитьПоиск'
			И я нажимаю на кнопку с именем 'ФормаСоздатьГруппу'
			Тогда открылось окно "Шаблоны универсальных процессов (создание группы)"
			И в поле с именем 'Наименование' я ввожу текст "ВА - Группа процесса согласования"
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна "Шаблоны универсальных процессов (создание группы) *" в течение 20 секунд

	* Удаляем существующие шаблоны
		Тогда открылось окно "Шаблоны универсальных процессов"
		И Я в списке "Шаблоны универсальных процессов" по полю "Наименование" ищу элемент "ВА - Шаблон процесса согласования" "По точному совпадению"
		И пока в таблице 'Список' количество строк ">" 0 Тогда
			И в таблице 'Список' я выбираю текущую строку
			Тогда открылось окно "Редактирование этапов процесса: ВА - Шаблон процесса согласования"
			И я нажимаю на кнопку с именем 'ФормаОткрытьСвойстваПроцесса'
			Тогда открылось окно "ВА - Шаблон процесса согласования (Шаблон универсального процесса)"
			И Я запоминаю значение выражения '"ВА - (удалить) " + StrReplace(Новый УникальныйИдентификатор, "-", "")' в переменную 'UID_Description'
			И в поле с именем 'Наименование' я ввожу значение переменной 'UID_Description'
			И я нажимаю на кнопку с именем 'ФормаЗаписать'
			Тогда открылось окно "$UID_Description$ (Шаблон универсального процесса)"
			И я нажимаю на кнопку с именем 'ФормаУстановитьПометкуУдаления'
			Тогда открылось окно "1С:Предприятие"
			И я нажимаю на кнопку с именем 'Button0'
			Тогда открылось окно "$UID_Description$ (Шаблон универсального процесса)"
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна "$UID_Description$ (Шаблон универсального процесса)" в течение 20 секунд
			Тогда открылось окно "Редактирование этапов процесса: ВА - Шаблон процесса согласования"
			И Я закрываю окно "Редактирование этапов процесса: ВА - Шаблон процесса согласования"

	* Создаем шаблон
		Тогда открылось окно "Шаблоны универсальных процессов"
		И я нажимаю на кнопку с именем 'ФормаСоздать'
		Тогда открылось окно "Шаблон универсального процесса (создание)"
		И в поле с именем 'Наименование' я ввожу текст "ВА - Шаблон процесса согласования"
		И из выпадающего списка с именем 'Родитель' я выбираю по строке "ВА - Группа процесса согласования"
		И из выпадающего списка с именем 'НазначениеПроцесса' я выбираю точное значение "Маршрут согласования"
		И из выпадающего списка с именем 'ИмяСправочника' я выбираю точное значение "Документ текущей ИБ"
		И я нажимаю кнопку выбора у поля с именем 'ТипОбъектаСогласования'
		И Я в списке "Документы ИБ" по полю "Документ" ищу и выбираю элемент "Экземпляр отчета" "По части строки"
		Тогда открылось окно "Шаблон универсального процесса (создание) *"
		И я нажимаю на кнопку с именем 'ФормаЗаписать'
		Тогда открылось окно "Редактирование этапов процесса: ВА - Шаблон процесса согласования"

	* Настраиваем схему процесса		
		И Я добавляю этап согласования с наименованием "Этап согласования 1" способ адресации "Пользователь" пользователь "Бюджетирование1" роль '' расширенная адресация ''
		И Я добавляю этап согласования с наименованием "Этап согласования 2" способ адресации "Роль" пользователь "Бюджетирование2" роль "ВА - Адресация по роли" расширенная адресация ''
		И Я добавляю этап согласования с наименованием "Этап согласования 3" способ адресации "Расширенная адресация" пользователь "Бюджетирование3" роль '' расширенная адресация "ВА - Расширенная адресация"
		И Я добавляю этап согласования с наименованием "Этап согласования 4" способ адресации "Пользователь" пользователь "Бюджетирование4" роль '' расширенная адресация ''
		И Я добавляю этап согласования с наименованием "Этап согласования 5" способ адресации "Роль" пользователь "Бюджетирование2" роль "ВА - Адресация по роли" расширенная адресация ''
		И Я добавляю этап согласования с наименованием "Этап согласования 6" способ адресации "Расширенная адресация" пользователь "Бюджетирование3" роль '' расширенная адресация "ВА - Расширенная адресация"
		И Я добавляю этап согласования с наименованием "Этап согласования 7" способ адресации "Пользователь" пользователь "Бюджетирование4" роль '' расширенная адресация ''
		И Я добавляю этап согласования с наименованием "Этап согласования 8" способ адресации "Пользователь" пользователь "Бюджетирование1" роль '' расширенная адресация ''
		И Я добавляю этап согласования с наименованием "Этап согласования 9" способ адресации "Пользователь" пользователь "Бюджетирование1" роль '' расширенная адресация ''

		И в табличном документе 'ТабличноеПолеВозможныхЭтапов' я перехожу к ячейке 'Автоутверждение'
		И я нажимаю на кнопку с именем 'ДобавитьВыбранныйЭтап'
		Тогда открылось окно "Автоматическое утверждение документа (Этап универсального процесса)"
		И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
		И я жду закрытия окна "Автоматическое утверждение документа (Этап универсального процесса)" в течение 20 секунд
		
		И в табличном документе 'ТабличноеПолеВозможныхЭтапов' я перехожу к ячейке 'УсловныйПереход'
		И я нажимаю на кнопку с именем 'ДобавитьВыбранныйЭтап'
		Тогда открылось окно "Переход по условию (Этап универсального процесса)"
		И в поле с именем 'Наименование' я ввожу текст "Переход по условию 1"
		И я нажимаю на кнопку с именем 'ДеревоОтборовДобавитьИсточникДанных'
		Тогда открылось окно "Источник данных (создание)"
		И в поле с именем 'Наименование' я ввожу текст "Источник 1"
		И я нажимаю кнопку выбора у поля с именем 'ВидОтчетаОтбор'

		И Я в списке "Виды отчетов" по полю "Наименование" ищу элемент "ВА - Согласование" "По точному совпадению"
		И в таблице 'Список' количество строк 'равно' 1
		И в таблице 'Список' я выбираю текущую строку

		Тогда открылось окно "Источник данных (создание) *"
		И я нажимаю кнопку выбора у поля с именем 'ПоказательОтбор'
		Тогда открылось окно "Показатели отчетов"
		И я меняю значение переключателя с именем 'РежимВыбораПоказателя' на "Макет структуры"				
		И в табличном документе 'ТабДокВыборПоказателя' я перехожу к ячейке "СТРК3_Сумма"
		И я нажимаю на кнопку с именем 'ФормаВыбратьЭлементы'
		Тогда открылось окно "Источник данных (создание) *"
		И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
		И я жду закрытия окна "Источник данных (создание) *" в течение 20 секунд
		Тогда открылось окно "Переход по условию (Этап универсального процесса) *"
		И я нажимаю на кнопку с именем 'ТабличноеПолеПереходаДобавитьУсловие'
		И в таблице 'ДеревоОтборов' я разворачиваю строку:
			| "Элемент"    |
			| "Источник 1" |
		И в таблице 'ДеревоОтборов' я перехожу к строке:
			| "Элемент"                    |
			| "Показатель: Строка 3 сумма" |
		Когда открылось окно "Переход по условию (Этап универсального процесса) *"
		И я нажимаю на кнопку с именем 'ДеревоОтборовКонтекстноеМенюПеренестиЭлементУсловия'
		Когда открылось окно "Переход по условию (Этап универсального процесса) *"
		И в таблице 'ТабличноеПолеПерехода' я активизирую поле с именем 'ТабличноеПолеПереходаЗначение'
		И в таблице 'ТабличноеПолеПерехода' я выбираю текущую строку
		И в таблице 'ТабличноеПолеПерехода' из выпадающего списка с именем 'ТабличноеПолеПереходаЗначение' я выбираю точное значение "Равно"
		И в таблице 'ТабличноеПолеПерехода' я активизирую поле с именем 'ТабличноеПолеПереходаЗначениеОтбора'
		И в таблице 'ТабличноеПолеПерехода' в поле с именем 'ТабличноеПолеПереходаЗначениеОтбора' я ввожу текст '1536,7852'
		И в таблице 'ТабличноеПолеПерехода' я завершаю редактирование строки
		Когда открылось окно "Переход по условию (Этап универсального процесса) *"
		И в таблице 'ТабличноеПолеПерехода' я перехожу к строке:
			| "Действие" |
			| "Тогда"    |
		И в таблице 'ТабличноеПолеПерехода' я активизирую поле с именем 'ТабличноеПолеПереходаОтображениеДействияТекст'
		И я нажимаю на кнопку с именем 'ТабличноеПолеПереходаДобавитьДействие'
		И в таблице 'ТабличноеПолеПерехода' я активизирую поле с именем 'ТабличноеПолеПереходаЗначение'
		И в таблице 'ТабличноеПолеПерехода' я выбираю текущую строку
		
		И Я в списке "Этапы универсальных процессов" по полю "Наименование" ищу элемент "Этап согласования 2" "По точному совпадению"
		И в таблице 'Список' количество строк 'равно' 1
		И в таблице 'Список' я выбираю текущую строку

		Тогда открылось окно "Переход по условию (Этап универсального процесса) *"
		И в таблице 'ТабличноеПолеПерехода' я завершаю редактирование строки		
		Когда открылось окно "Переход по условию (Этап универсального процесса) *"
		И в таблице 'ТабличноеПолеПерехода' я перехожу к строке:
			| "Действие" |
			| "Иначе"    |
		И в таблице 'ТабличноеПолеПерехода' я активизирую поле с именем 'ТабличноеПолеПереходаОтображениеДействияТекст'
		И я нажимаю на кнопку с именем 'ТабличноеПолеПереходаДобавитьДействие'
		И в таблице 'ТабличноеПолеПерехода' я активизирую поле с именем 'ТабличноеПолеПереходаЗначение'
		И в таблице 'ТабличноеПолеПерехода' я выбираю текущую строку
		
		И Я в списке "Этапы универсальных процессов" по полю "Наименование" ищу элемент "Этап согласования 5" "По точному совпадению"
		И в таблице 'Список' количество строк 'равно' 1
		И в таблице 'Список' я выбираю текущую строку

		Тогда открылось окно "Переход по условию (Этап универсального процесса) *"
		И в таблице 'ТабличноеПолеПерехода' я завершаю редактирование строки
		И я нажимаю на кнопку с именем 'ФормаЗаписать'
		Тогда открылось окно "Переход по условию (Этап универсального процесса)"
		И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
		И я жду закрытия окна "Переход по условию (Этап универсального процесса)" в течение 20 секунд
		
		И Я добавляю связь этапа "Этап согласования 1" с этапом "Этап согласования 9"
		И Я добавляю связь этапа "Этап согласования 9" с этапом "Этап согласования 8"
		И Я добавляю связь этапа "Этап согласования 8" с этапом "Переход по условию 1"
		И Я добавляю связь этапа "Этап согласования 2" с этапом "Этап согласования 3"
		И Я добавляю связь этапа "Этап согласования 3" с этапом "Этап согласования 4"
		И Я добавляю связь этапа "Этап согласования 4" с этапом "Автоматическое утверждение документа"
		И Я добавляю связь этапа "Этап согласования 5" с этапом "Этап согласования 6"
		И Я добавляю связь этапа "Этап согласования 6" с этапом "Этап согласования 7"
		И Я добавляю связь этапа "Этап согласования 7" с этапом "Автоматическое утверждение документа"

		И Я закрываю окно "Редактирование этапов процесса: ВА - Шаблон процесса согласования"
		Тогда открылось окно "ВА - Шаблон процесса согласования (Шаблон универсального процесса)"
		И в таблице 'ПараметрыПроцесса' я активизирую поле с именем 'ПараметрыПроцессаЗначениеПоУмолчанию'
		И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
		И я жду закрытия окна "ВА - Шаблон процесса согласования (Шаблон универсального процесса)" в течение 20 секунд

Сценарий: 20.06 Настройка матрицы полномочий
	
	И В командном интерфейсе я выбираю "Процессы и согласование" "Матрица полномочий"
	Тогда открылось окно "Матрица полномочий"
	И я нажимаю кнопку выбора у поля с именем 'ВидДокументаОтбор'
	И Я в списке "Документы ИБ" по полю "Документ" ищу и выбираю элемент "Экземпляр отчета" "По части строки"
	Тогда открылось окно "Матрица полномочий"
	И я нажимаю кнопку выбора у поля с именем 'ВерсияРегламента'
	И Я в списке "Регламенты подготовки отчетности" по полю "Наименование" ищу и выбираю элемент "ВА - Основной регламент" "По точному совпадению"
	
	Когда открылось окно "Матрица полномочий"
	И я перехожу к закладке с именем 'ГруппаСписок'

	* Удаляем существующие записи
		И в таблице 'РегистрПолномочий' я нажимаю на кнопку с именем 'РегистрПолномочийНастройкаСписка'	
		Тогда открылось окно "Настройка списка"
		И я удаляю все строки таблицы 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0Отбор'
		И в таблице 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0Отбор' я нажимаю на кнопку с именем 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0ОтборДобавитьЭлементОтбора'
		И в таблице 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0Отбор' я перехожу к последней строке
		И в таблице 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0Отбор' из выпадающего списка с именем 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0ОтборЛевоеЗначение' я выбираю точное значение "Шаблон документа БД"
		И в таблице 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0Отбор' я активизирую поле с именем 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0ОтборВидСравнения'
		И в таблице 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0Отбор' из выпадающего списка с именем 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0ОтборВидСравнения' я выбираю точное значение "Равно"
		И в таблице 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0Отбор' я нажимаю кнопку выбора у реквизита с именем 'КомпоновщикНастроекПользовательскиеНастройкиЭлемент0ОтборПравоеЗначение'
		Тогда открылось окно "Выбор типа данных"
		И в таблице "" я перехожу к строке:
			| ''             |
			| "Виды отчетов" |
		И в таблице "" я выбираю текущую строку
		И Я в списке "Виды отчетов" по полю "Наименование" ищу и выбираю элемент "ВА - Согласование" "По точному совпадению"
		И я нажимаю на кнопку с именем 'ФормаЗакончитьРедактирование'

		И Пока в таблице 'РегистрПолномочий' количество строк ">" 0 Тогда
			Когда открылось окно "Матрица полномочий"
			И в таблице 'РегистрПолномочий' я нажимаю на кнопку с именем 'РегистрПолномочийУдалить'
			Тогда открылось окно "1С:Предприятие"
			И я нажимаю на кнопку с именем 'Button0'

		Когда открылось окно "Матрица полномочий"
		И в таблице 'РегистрПолномочий' я нажимаю на кнопку с именем 'РегистрПолномочийНастройкаСписка'
		И Я снимаю все отборы в форме списка
			
	* Создаем новый элемент
		И в таблице 'РегистрПолномочий' я нажимаю на кнопку с именем 'РегистрПолномочийСоздать'
		Тогда открылось окно "Регистр матрицы полномочий (создание)"
		И я нажимаю кнопку выбора у поля с именем 'ШаблонДокументаБД'
		Тогда открылось окно "Выбор типа данных"
		И в таблице "" я перехожу к строке:
			| ''             |
			| "Виды отчетов" |
		И в таблице "" я выбираю текущую строку
		И Я в списке "Виды отчетов" по полю "Наименование" ищу и выбираю элемент "ВА - Согласование" "По точному совпадению"
		
		Тогда открылось окно "Регистр матрицы полномочий (создание) *"
		И я нажимаю кнопку выбора у поля с именем 'Организация'
		И Я выбираю организацию "Меркурий ООО"

		Тогда открылось окно "Регистр матрицы полномочий (создание) *"
		И я нажимаю кнопку выбора у поля с именем 'Согласование'
		Тогда открылось окно "Выбор типа данных"
		И в таблице "" я перехожу к строке:
			| ''                               |
			| "Шаблон универсального процесса" |
		И в таблице "" я выбираю текущую строку
		И Я в списке "Шаблоны универсальных процессов" по полю "Наименование" ищу и выбираю элемент "ВА - Шаблон процесса согласования" "По точному совпадению"

		Тогда открылось окно "Регистр матрицы полномочий (создание) *"
		И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
		И я жду закрытия окна "Регистр матрицы полномочий (создание) *" в течение 20 секунд	

Сценарий: 20.07 Сохранение настроек формы списка экземпляров отчетов	

	* Откроем экземпляры отчетов
		И В командном интерфейсе я выбираю "Бюджетирование, отчетность и анализ" "Экземпляры отчетов"
		Тогда открылось окно "Экземпляры отчетов"
		Тогда я устанавливаю флаг с именем 'ОтображатьСтандартныеОтборы'
		И в таблице 'Отбор' я нажимаю на кнопку с именем 'ОтборСнятьФлажки'

	* Установим фильтры
		И я перехожу к закладке с именем 'Стандартные'

		И в таблице 'Отбор' я перехожу к строке:
			| "Вид сравнения" | "Использование" | "ПОЛЕ"        | "Режим отображения" |
			| "Равно"         | "Нет"           | "Организация" | "Быстрый доступ"    |
		И в таблице 'Отбор' из выпадающего списка с именем 'ОтборПравоеЗначение' я выбираю по строке "Меркурий ООО"
		
		И в таблице 'Отбор' я перехожу к строке:
			| "Вид сравнения" | "Использование" | "ПОЛЕ"          | "Режим отображения" |
			| "Равно"         | "Нет"           | "Период отчета" | "Быстрый доступ"    |
		И в таблице 'Отбор' я нажимаю кнопку выбора у реквизита с именем 'ОтборПравоеЗначение'
		И Я в списке "Периоды" по полю "Наименование" ищу и выбираю элемент "Январь 2024 г." "По началу строки"
	
		Тогда открылось окно "Экземпляры отчетов"
		И в таблице 'Отбор' я перехожу к строке:
			| "Вид сравнения" | "Использование" | "ПОЛЕ"     | "Режим отображения" |
			| "Равно"         | "Нет"           | "Сценарий" | "Быстрый доступ"    |
		И в таблице 'Отбор' из выпадающего списка с именем 'ОтборПравоеЗначение' я выбираю по строке "ВА - Основной сценарий"
		
		И в таблице 'Отбор' я перехожу к строке:
			| "Вид сравнения" | "Использование" | "ПОЛЕ"       | "Режим отображения" |
			| "Равно"         | "Нет"           | "Вид отчета" | "Быстрый доступ"    |
		И в таблице 'Отбор' из выпадающего списка с именем 'ОтборПравоеЗначение' я выбираю по строке "ВА - Согласование"

	* Сохраним настройку
		Когда открылось окно "Экземпляры отчетов"
		И я нажимаю на кнопку с именем 'СохранитьНастройкуКак'	
		И Я в списке "Сохраненные настройки" по полю "Наименование" ищу элемент "ВА - Согласование - Меркурий ООО" "По точному совпадению"
		И Пока в таблице 'Список' количество строк 'больше' 0 Тогда
			И Я запоминаю значение выражения '"Удалить_" + СтрЗаменить(Новый УникальныйИдентификатор, "-", "")' в переменную 'УИД'
			И я выбираю пункт контекстного меню с именем 'СписокКонтекстноеМенюИзменить' на элементе формы с именем 'Список'
			Тогда открылось окно "ВА - Согласование - Меркурий ООО (Вариант настройки)"
			И в поле с именем 'Наименование' я ввожу значение переменной 'УИД'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна "ВА - Ручной ввод по всем аналитикам - Венера ООО *" в течение 20 секунд
			
	Тогда открылось окно "Сохраненные настройки"
	И в поле с именем 'Наименование' я ввожу текст "ВА - Согласование - Меркурий ООО"
	И я нажимаю на кнопку с именем 'ФормаСохранитьВариант'

	Когда открылось окно "Экземпляры отчетов"
	И я нажимаю на кнопку открытия поля с именем 'СохраненнаяНастройка'

	* Настраиваем пользователей
		Когда открылось окно "ВА - Согласование - Меркурий ООО (Вариант настройки)"
		И в таблице 'Пользователи' я нажимаю на кнопку с именем 'ПользователиДобавить'
		И в таблице 'Пользователи' я нажимаю кнопку выбора у реквизита с именем 'ПользователиПользователь'
		Тогда открылось окно "Выбор типа данных"
		И в таблице "" я перехожу к строке:
			| ''                     |
			| "Группа пользователей" |
		И в таблице "" я выбираю текущую строку
		И Я в списке "Выбор группы пользователей" по полю "Наименование" ищу и выбираю элемент "ВА - Бюджетирование" "По точному совпадению"
		Тогда открылось окно "ВА - Согласование - Меркурий ООО (Вариант настройки) *"
		И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
		И я жду закрытия окна "ВА - Согласование - Меркурий ООО (Вариант настройки) *" в течение 20 секунд				

Сценарий: 20.08 Настройка прав для пользователей

	И Я добавляю право "Чтение, запись" для вида отчета "ВА - Согласование" пользователя "Бюджетирование1" по всем организациям
	И Я добавляю право "Чтение, запись" для вида отчета "ВА - Согласование" пользователя "Бюджетирование2" по всем организациям
	И Я добавляю право "Чтение, запись" для вида отчета "ВА - Согласование" пользователя "Бюджетирование3" по всем организациям
	И Я добавляю право "Чтение, запись" для вида отчета "ВА - Согласование" пользователя "Бюджетирование4" по всем организациям

Сценарий: 20.09 Согласование по пользователеми

	* Согласование 1 (часть 1)
		И я закрываю TestClient "УХ - Бюджетирование"
		И я подключаю TestClient "УХ - Бюджетирование" логин "Бюджетирование1" пароль ''

		И Я открываю экземпляр отчета по сохраненной настройке "ВА - Согласование - Меркурий ООО"
		И Открылся экземпляр отчета для вида отчета "ВА - Согласование" валюта 'RUB' организация "Меркурий ООО" сценарий "ВА - Основной сценарий" периодичность "Месяц" проект '' аналитики '' '' '' '' '' ''

		И я нажимаю на кнопку с именем 'ПринятьКСогласованию'
		
		Тогда открылось окно '$ЗаголовокОкна$'
		И я нажимаю на кнопку с именем 'СогласоватьДокумент'
		Тогда открылось окно "Согласование"
		И я нажимаю на кнопку с именем 'СогласоватьОтчет'

	* Добавим заместителя
		И Для пользователя 'Бюджетирование1' я добавляю заместителя 'Бюджетирование3'
		
	* Согласование3 (заместитель)
		И я закрываю TestClient "УХ - Бюджетирование"
		И я подключаю TestClient "УХ - Бюджетирование" логин "Бюджетирование3" пароль ''

		И Я открываю экземпляр отчета по сохраненной настройке "ВА - Согласование - Меркурий ООО"
		И Открылся экземпляр отчета для вида отчета "ВА - Согласование" валюта 'RUB' организация "Меркурий ООО" сценарий "ВА - Основной сценарий" периодичность "Месяц" проект '' аналитики '' '' '' '' '' ''
		
		И я нажимаю на кнопку с именем 'СогласоватьДокумент'
		Тогда открылось окно "Согласование"
		И я нажимаю на кнопку с именем 'СогласоватьОтчет'

	* Согласование 1 (часть 2)
		И я закрываю TestClient "УХ - Бюджетирование"
		И я подключаю TestClient "УХ - Бюджетирование" логин "Бюджетирование1" пароль ''

		И Я открываю экземпляр отчета по сохраненной настройке "ВА - Согласование - Меркурий ООО"
		И Открылся экземпляр отчета для вида отчета "ВА - Согласование" валюта 'RUB' организация "Меркурий ООО" сценарий "ВА - Основной сценарий" периодичность "Месяц" проект '' аналитики '' '' '' '' '' ''
		
		И я нажимаю на кнопку с именем 'СогласоватьДокумент'
		Тогда открылось окно 'Согласование'
		И я нажимаю на кнопку с именем 'ДобавитьСогласующих'
		Тогда открылось окно "Дополнительное согласование"
		И я нажимаю на кнопку с именем 'ФормаДобавитьСогласующих'
		
		И Я в списке "Выбор пользователя" по полю "Полное имя" ищу элемент 'Бюджетирование2' "По точному совпадению"
		И в таблице 'ПользователиСписок' количество строк 'равно' 1
		И в таблице 'ПользователиСписок' я выбираю текущую строку

		Тогда открылось окно "Дополнительное согласование"
		И я нажимаю на кнопку с именем 'ФормаЗакрыть'
		Тогда открылось окно "Согласование"
		И я нажимаю на кнопку с именем 'СогласоватьОтчет'
		Тогда открылось окно '$ЗаголовокОкна$'
		И я нажимаю на кнопку с именем 'МаршрутСогласования'
		И Я закрываю окно "Согласование: Экземпляр отчета *"

		И Я закрываю окно '$ЗаголовокОкна$'
		Тогда открылось окно "Экземпляры отчетов"
		И Я закрываю окно "Экземпляры отчетов"
		
	* Согласование 2
		И я закрываю TestClient "УХ - Бюджетирование"
		И я подключаю TestClient "УХ - Бюджетирование" логин "Бюджетирование2" пароль ''

		И Я открываю экземпляр отчета по сохраненной настройке "ВА - Согласование - Меркурий ООО"
		И Открылся экземпляр отчета для вида отчета "ВА - Согласование" валюта 'RUB' организация "Меркурий ООО" сценарий "ВА - Основной сценарий" периодичность "Месяц" проект '' аналитики '' '' '' '' '' ''
	
		И я нажимаю на кнопку с именем 'СогласоватьДокумент'
		Тогда открылось окно "Согласование"
		И я нажимаю на кнопку с именем 'СогласоватьОтчет'

		И я нажимаю на кнопку с именем 'СогласоватьДокумент'
		Тогда открылось окно "Согласование"
		И я нажимаю на кнопку с именем 'СогласоватьОтчет'

	* Согласование 3
		И я закрываю TestClient "УХ - Бюджетирование"
		И я подключаю TestClient "УХ - Бюджетирование" логин "Бюджетирование3" пароль ''

		И Я открываю экземпляр отчета по сохраненной настройке "ВА - Согласование - Меркурий ООО"
		И Открылся экземпляр отчета для вида отчета "ВА - Согласование" валюта 'RUB' организация "Меркурий ООО" сценарий "ВА - Основной сценарий" периодичность "Месяц" проект '' аналитики '' '' '' '' '' ''
		
		И я нажимаю на кнопку с именем 'СогласоватьДокумент'
		Тогда открылось окно "Согласование"
		И я нажимаю на кнопку с именем 'СогласоватьОтчет'

	* Согласование 4
		И я закрываю TestClient "УХ - Бюджетирование"
		И я подключаю TestClient "УХ - Бюджетирование" логин "Бюджетирование4" пароль ''

		И Я открываю экземпляр отчета по сохраненной настройке "ВА - Согласование - Меркурий ООО"
		И Открылся экземпляр отчета для вида отчета "ВА - Согласование" валюта 'RUB' организация "Меркурий ООО" сценарий "ВА - Основной сценарий" периодичность "Месяц" проект '' аналитики '' '' '' '' '' ''
		
		И я нажимаю на кнопку с именем 'СогласоватьДокумент'
		Тогда открылось окно "Согласование"
		И я нажимаю на кнопку с именем 'СогласоватьОтчет'

		Тогда открылось окно '$ЗаголовокОкна$'
		И я нажимаю на кнопку с именем 'ОтменитьСогласование'
		Если открылось окно "Причина отмены согласования" Тогда
			И я нажимаю на кнопку с именем 'OK'

	* История согласования
		Тогда открылось окно '$ЗаголовокОкна$'
		И я нажимаю на кнопку с именем 'ИсторияСогласования'
		И табличный документ 'Результат' равен макету "3_Бюджетирование\Макеты\20\ВА_ТестированиеСогласованияИстория_Меркурий.mxl" по шаблону			
