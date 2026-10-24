extends Node

## Emitted after the game changes to another language.
signal changed

## The languages the game speaks, in the order the language key goes through
## them.
const LOCALES: Array[String] = ["pt_BR", "en"]
const SETTINGS_PATH := "user://settings.cfg"


## Uses the language chosen last time. The first time, Godot has already
## picked the device's language, or English when the game does not speak it.
func _ready() -> void:
	var settings := ConfigFile.new()
	if settings.load(SETTINGS_PATH) == OK:
		var saved: String = settings.get_value("game", "language", "")
		if saved in LOCALES:
			TranslationServer.set_locale(saved)


## The language in use, as one of `LOCALES`.
func current() -> String:
	var locale := TranslationServer.get_locale()
	for known in LOCALES:
		if TranslationServer.compare_locales(locale, known) >= 5:
			return known
	return "en"


## Changes the language and remembers it for the next time.
func choose(locale: String) -> void:
	if locale == current():
		return
	TranslationServer.set_locale(locale)
	var settings := ConfigFile.new()
	settings.load(SETTINGS_PATH)
	settings.set_value("game", "language", locale)
	settings.save(SETTINGS_PATH)
	changed.emit()


## Goes to the next language in `LOCALES`.
func choose_next() -> void:
	choose(LOCALES[(LOCALES.find(current()) + 1) % LOCALES.size()])
