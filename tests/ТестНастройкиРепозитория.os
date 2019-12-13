#Использовать asserts
#Использовать logos
#Использовать tempfiles
#Использовать "../src"

Перем юТест;
Перем Лог;
Перем МенеджерВременныхФайлов;

// Основная точка входа
Функция ПолучитьСписокТестов(ЮнитТестирование) Экспорт
	
	юТест = ЮнитТестирование;
	
	ВсеТесты = Новый Массив;
	
	ВсеТесты.Добавить("Тест_ИспользованиеГлобальныхНастроек");
	ВсеТесты.Добавить("Тест_ИспользованиеЛокальныхНастроек");
	ВсеТесты.Добавить("Тест_ОтключенныеНастройки");
	ВсеТесты.Добавить("Тест_ОтключенныеНастройкиИПереопределенныеГлобальныеСценарии");
	
	Возврат ВсеТесты;
	
КонецФункции


Процедура ПередЗапускомТеста() Экспорт
	
	МенеджерПриложения.Инициализировать(ПараметрыПриложения);

	ВремТестер = Новый Тестер;
	Лог = Логирование.ПолучитьЛог(ВремТестер.ИмяЛога());

	ВключитьПоказОтладки();
	
	МенеджерВременныхФайлов = Новый МенеджерВременныхФайлов;
	
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	
	МенеджерВременныхФайлов.Удалить();
	МенеджерВременныхФайлов = Неопределено;
	
КонецПроцедуры

Процедура Тест_ИспользованиеГлобальныхНастроек() Экспорт
	
	НастройкиПрекоммит = ЗагрузитьНастройкиИзФикстуры("v8configБезНастроекПрекоммит.json");
	
	Ожидаем.Что(НастройкиПрекоммит, "Не удалось загрузить настройки").Заполнено();
	
КонецПроцедуры

Процедура Тест_ИспользованиеЛокальныхНастроек() Экспорт

	НастройкиПрекоммит = ЗагрузитьНастройкиИзФикстуры("v8config.json");
	
	Ожидаем.Что(НастройкиПрекоммит, "Не удалось загрузить настройки").Заполнено();
	
	ОжидаемыеСценарии = Новый Массив();
	ОжидаемыеСценарии.Добавить("УдалениеДублейМетаданных.os");
	ОжидаемыеСценарии.Добавить("УдалениеЛишнихКонцевыхПробелов.os");
	ОжидаемыеСценарии.Добавить("УдалениеЛишнихПустыхСтрок.os");
	
	ПроверитьОжидаемыеСценарии(НастройкиПрекоммит["ГлобальныеСценарии"], ОжидаемыеСценарии);
		
КонецПроцедуры

Процедура Тест_ОтключенныеНастройки() Экспорт

	НастройкиПрекоммит = ЗагрузитьНастройкиИзФикстуры("v8configОтключенныеСценарии.json");
	
	Ожидаем.Что(НастройкиПрекоммит, "Не удалось загрузить настройки").Заполнено();
	
	ОжидаемыеСценарии = Новый Массив();
    ОжидаемыеСценарии.Добавить("ДобавлениеПробеловПередКлючевымиСловами.os");
    ОжидаемыеСценарии.Добавить("ЗапретИспользованияПерейти.os");
    ОжидаемыеСценарии.Добавить("ИсправлениеНеКаноническогоНаписания.os");
    ОжидаемыеСценарии.Добавить("КорректировкаXMLФорм.os");
    ОжидаемыеСценарии.Добавить("ОтключениеПолнотекстовогоПоиска.os");
    ОжидаемыеСценарии.Добавить("ПроверкаДублейПроцедурИФункций.os");
    ОжидаемыеСценарии.Добавить("ПроверкаКорректностиОбластей.os");
    ОжидаемыеСценарии.Добавить("РазборОбычныхФормНаИсходники.os");
    ОжидаемыеСценарии.Добавить("РазборОтчетовОбработокРасширений.os");
    ОжидаемыеСценарии.Добавить("СинхронизацияОбъектовМетаданныхИФайлов.os");
	ОжидаемыеСценарии.Добавить("СортировкаДереваМетаданных.os");
	
	ИменаЗагружаемыхСценариев = МенеджерНастроек.ИменаЗагружаемыхСценариев();

	ПроверитьОжидаемыеСценарии(ИменаЗагружаемыхСценариев, ОжидаемыеСценарии);

	ИменаЗагружаемыхСценариев = МенеджерНастроек.ИменаЗагружаемыхСценариев("Несуществующий проект");

	ПроверитьОжидаемыеСценарии(ИменаЗагружаемыхСценариев, ОжидаемыеСценарии);

КонецПроцедуры

Процедура Тест_ОтключенныеНастройкиИПереопределенныеГлобальныеСценарии() Экспорт

	НастройкиПрекоммит = ЗагрузитьНастройкиИзФикстуры("v8configОтключенныеСценарииПереопреденыГлобальные.json");
	
	Ожидаем.Что(НастройкиПрекоммит, "Не удалось загрузить настройки").Заполнено();
	
	ОжидаемыеСценарии = Новый Массив();
    ОжидаемыеСценарии.Добавить("РазборОбычныхФормНаИсходники.os");
    ОжидаемыеСценарии.Добавить("РазборОтчетовОбработокРасширений.os");
    ОжидаемыеСценарии.Добавить("СинхронизацияОбъектовМетаданныхИФайлов.os");
	ОжидаемыеСценарии.Добавить("СортировкаДереваМетаданных.os");
	
	ИменаЗагружаемыхСценариев = МенеджерНастроек.ИменаЗагружаемыхСценариев();

	ПроверитьОжидаемыеСценарии(ИменаЗагружаемыхСценариев, ОжидаемыеСценарии);

	ИменаЗагружаемыхСценариев = МенеджерНастроек.ИменаЗагружаемыхСценариев("Несуществующий проект");

	ПроверитьОжидаемыеСценарии(ИменаЗагружаемыхСценариев, ОжидаемыеСценарии);

КонецПроцедуры

#Область Служебные

Процедура ПроверитьОжидаемыеСценарии(ГлобальныеСценарии, ОжидаемыеСценарии)

	Ожидаем.Что(ГлобальныеСценарии, "Нет глобальных сценариев").Заполнено();
	
	Ожидаем.Что(ГлобальныеСценарии.Количество(), "Не корректный список сценариев").Равно(ОжидаемыеСценарии.Количество());
	
	Для каждого ИмяСценария Из ОжидаемыеСценарии Цикл
	
		Ожидаем.Что(ГлобальныеСценарии, "Не содержит нужные сценарии").Содержит(ИмяСценария)
		
	КонецЦикла;
		
КонецПроцедуры

Процедура ВключитьПоказОтладки()
	Лог.УстановитьУровень(УровниЛога.Отладка);
КонецПроцедуры

Процедура ВыключитьПоказОтладки()
	Лог.УстановитьУровень(УровниЛога.Информация);
КонецПроцедуры

Функция ЗагрузитьНастройкиИзФикстуры(ИмяФикстуры)

	КаталогРепозитория = СоздатьТестовыйКаталог(ИмяФикстуры);
	
	Настройки = МенеджерНастроек.НастройкиРепозитория(КаталогРепозитория);
	
	Возврат Настройки.НастройкиПриложения(МенеджерНастроек.КлючНастройкиPrecommit());

КонецФункции

Функция СоздатьТестовыйКаталог(ИмяФикстуры)
	
	Каталог = МенеджерВременныхФайлов.СоздатьКаталог();
	
	КаталогФикстур = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "Настройки");
	Фикстура = ОбъединитьПути(КаталогФикстур, ИмяФикстуры);
	
	КопироватьФайл(Фикстура, ОбъединитьПути(Каталог, "v8config.json"));
	
	Возврат Каталог;

КонецФункции

#КонецОбласти