extends Node

var _current := 0
var _word_set := {}


func _ready():
	print("[GLOBAL] Ready")
	_word_set_load()
	if _word_set.empty():
		var words := []
		var word1 := { "expected": "hello", "actual": "" }
		var word2 := { "expected": "world", "actual": "" }
		words.push_back(word1)
		words.push_back(word2)
		_word_set.words = words


func check_point():
	_word_set_save()


func _load_json(name):
	var json = _load_content(name)
	return JSON.parse(json).result


func _save_json(name, data):
	var json = JSON.print(data, "  ")
	_save_content(name, json)

	
func _load_content(name):
	var file = File.new()
	if !file.file_exists(name):
		return "{}";
	file.open(name, File.READ)
	var content = file.get_as_text()
	file.close()
	return content


func _save_content(name, content):
	var file = File.new()
	file.open(name, File.WRITE)
	file.store_string(content)
	file.close()


func _word_set_load():
	_word_set = _load_json("user://words1.json")


func _word_set_save():
	_save_json("user://words1.json", _word_set)


func get_words():
	return _word_set.words


func get_current_index():
	return _current


func get_current():
	return _word_set.words[_current].expected


func get_current_input():
	return _word_set.words[_current].actual


func set_current_input(input):
	_word_set.words[_current].actual = input
	check_point()


func set_word(index, text):
	_word_set.words[index].expected = text
	check_point()


func add_word(text):
	var word := {}
	word.expected = text
	word.actual = ""
	_word_set.words.push_back(word)
	check_point()


func delete_word(index):
	_word_set.words.remove(index)
	check_point()


func get_correct_count():
	var count := 0
	for i in range(0, _word_set.words.size()):
		if _word_set.words[i].expected == _word_set.words[i].actual:
			count += 1
	return count


func clear_expected():
	for i in range(0, _word_set.words.size()):
		_word_set.words[i].actual = ""
	_current = 0
	check_point()

func dec_current():
	if _current > 0:
		_current -= 1


func inc_current():
	if _current < (_word_set.words.size() - 1):
		_current += 1


func words_size():
	return _word_set.words.size()

