# DayZ-Mod-Template

# Русский
Шаблон для создания модов для DayZ Standalone.

## Примеры проектов:

> https://github.com/ghostiam-DayZ/InventoryDump \
импорт мода CF, сборка мода в разные пакеты(для сервера и клиента), и всё это с рабочим дебагером! (смотрите `mod.cfg` параметры `Additional*Mods`).

## Порядок действий для нового прокта

1) Склонировать(или скачать) репозиторий.
2) Открыть файл `mod.cfg` в текстовом редакторе.
3) Отредактировать параметры под себя.
4) Скачать если необходимо, [оффлайн карту](https://github.com/Arkensor/DayZCommunityOfflineMod) для локального теста и положить в папку с игрой.
5) Переименовать папки `Mod/Ghost/MyFirstMod` по формату из конфига `Mod/ВашПрефикс/НазваниеМода`.
6) Отредактировать файл `Mod/Ghost/MyFirstMod/config.cpp` под себя.
7) Запустить скрипт `ModInit.bat` который создаст все необходимые ссылки для работы мода.

## Инструменты
В папке `Tools` находятся скрипты, которые позволяют вам автоматизировать рутинные вещи, от удаления логов, до сборки вашего мода.

## Работа с Workbench

Чтобы открыть Workbench с модом, нужно запустить скрипт `Tools/StartWorkbench.bat`.\
Данные мода будут доступны в `SourceData/ВашПрефикс/НазваниеМода`, скрипты уже будут подгруженны в редактор скриптов(с рабочим дебагером).\
Так же, скрипт подгружает плагины для Workbench, которые доступны в меню `Plugins` или через шорткаты.\
Плагины с суффиксом "Production" предназначены для итогового тестирования мода, перед загрузкой в Workshop(необходимо сначала запустить BuildModProduction, а потом StartMPProduction).

# English
Template for creating mods for DayZ Standalone.

## Example projects: 

> https://github.com/ghostiam-DayZ/InventoryDump \
import CF mod, mod building into different packages (for server and client), and all this with a working debugger! (see `mod.cfg` for `Additional*Mods` options).

## Setup for a new project

1) Clone (or download) the repository.
2) Open the `mod.cfg` file in a text editor.
3) Edit the parameters.
4) Download, if necessary, [offline map](https://github.com/Arkensor/DayZCommunityOfflineMod) for a local test and put it in the game folder.
5) Rename the `Mod/Ghost/MyFirstMod` folders according to the format from the `Mod/YourPrefix/ModName` config.
6) Edit the file `Mod/Ghost/MyFirstMod/config.cpp`.
7) Run the script `ModInit.bat` which will create all the necessary links for the mod to work.

## Tools
The `Tools` folder contains scripts that allow you to automate routine things, from removing logs to building your mod.

## Working with the Workbench

To open the Workbench with a mod, you need to run the script `Tools/StartWorkbench.bat`. \
Mod data will be available in `SourceData/YourPrefix/ModName`, scripts will already be loaded into the script editor (with a working debugger). \
Also, the script loads plugins for the Workbench, which are available in the `Plugins` menu or via shortcuts. \
Plugins with the "Production" suffix are intended for final testing of the mod, before uploading it to the Workshop (you must first run BuildModProduction, and then StartMPProduction).
