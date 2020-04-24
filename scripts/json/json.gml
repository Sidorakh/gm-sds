// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function json_stringify(struct){
	var _str = "";
	if (is_struct(struct)) {
		var _iter = new Iterator(struct);
		switch (struct.type) {
			case ds_type_list:
				_str += "[";
				while (_iter.next() != undefined) {
					if (_iter.key > 0) {
						_str += ",";
					}
					var v = _iter.value();
					if (is_struct(v)) {
						v = json_stringify(v);
					} else if (typeof(v)=="string") {
						v = "\"" + string_escape(v) + "\"";
					} else {
						v = string(v);	
					}
					_str += v;
				}
				_str += "]";
			break;
			case ds_type_map:
				_str += "{";
				while(_iter.next() != undefined) {
					var v = _iter.value();
					if (is_struct(v)) {
						v = json_stringify(v);
					} else if (typeof(v)=="string") {
						v = "\"" + string(v);
					} else {
						v = string(v);	
					}
					_str += "\"" + string(_iter.key) + "\":";
					_str += string(v);
					if (_iter.key != _iter.last()) {
						_str += ",";
					}
				}
				_str += "}";
			break;
		}
	}
	return _str;
}

function string_escape(str) {
	var _newstr = "";
	//var _buff = buffer_create(string_byte_length(str),buffer_grow,1);
	//buffer_write(_buff,buffer_string,_newstr);
	var i = 1, c="", o=0;
	while (i<string_length(str)) {
		c=string_char_at(str,i);
		i+=1;
		o = ord(c);
		switch (o) {
			case 8:			// backspace
				c = "\\b";
			break;
			case 9:		// \t
				c = "\\t";
			break;
			case 12:		// form feed
				c = "\\f";
			break;
			case 10:		// line feed
			show_message("\\n");
				c = "\\n";
			break;
			case 13:		// carriage return
				c = "\\r";
			break;
			case 34:	// double quote
				c = "\\"+"\"";
			break;
			case 92:	// backslash
				c = "\\\\"
			break;
		}
		_newstr += c;
	}
	return _newstr
}

function string_substring(str,first,last) {
	return string_copy(str,first,(last-first)-1);
}

function json_parse(json_string){
	var _list = new List();		// tracks all created data structures, allows for cleanup on fail
	try {
		var _res = json_parse_child(_list,json_string,
									json_next_char(json_string,1,global.JSON_MAP.get("space"),true));
		ds_list_destroy(_list.ds);
		delete(_list);
		return _res[0];
		
	} catch(e) {
		// delete each DS from _list - cleanup
		for (var i=0;i<_list.size();i++) {
			if (is_struct(_list.get(i))) {
				_list.get(i).destroy(true);	
			}
		}
		delete _list;
		// throw error up
		throw e;
	}
}

function json_parse_child(list,str,idx) {
	var c = string_char_at(str,idx);
	var f = global.JSON_MAP.get(c);
	//if (f != undefined) {
		
	//	return f(list,str,idx);	
	//} else {
	//	throw("JSON: Unexpected character " + string(c) + " at position " + string(idx));
	//}
	var a;
	if (idx == string_length(str)+1) {
		show_error(string(debug_get_callstack()),true);
	}
	switch (c) {
		case "\"":
			a = json_parse_string(list,str,idx);
		break;
		case "0":
		case "1":
		case "2":
		case "3":
		case "4":
		case "5":
		case "6":
		case "7":
		case "8":
		case "9":
		case "-":
			a = json_parse_number(list,str,idx);
		break;
		case "t":
		case "f":
		case "n":
			a = json_parse_literal(list,str,idx);
		break;
		case "{":
			a = json_parse_object(list,str,idx);
		break;
		case "[":
			a = json_parse_array(list,str,idx);
		break;
		default:
			throw("JSON: Unexpected character " + string(c) + " at position " + string(idx));
		
	}
	return a;
}

function json_next_char() {
	var str = argument[0];
	var index = argument[1];
	var set = argument[2];
	var negate = false;
	if (argument_count==4) {
		negate = true;
	}
	for (var i=index,l=string_length(str);i<=l;i++) {
		if (array_contains(set,string_char_at(str,i)) != negate) {
			return i;
		}
	}
	return l+1;
}

function array_contains(array,item) {
	for (var i=0;i<array_length(array);i++) {
		if (array[i] == item) return true;	
	}
	return false;
}

function json_parse_string(list,str,i) {
	var _res = "";
	var j = i+1;
	var k = j;
	var l = string_length(str);
	
	//while (j<=l) {
	for (var j=i+1;j<=l;j++) {
		var c = string_char_at(str,j);
		var o = ord(c);
		if (o < 32) { // control character?!
			throw("JSON: Unexpected control character in string @ pos " + string(j));
		} else if (o==92) {	// escaped characters -> \ 
			_res += string_substring(str,k,j+1);
			j+=1;
			c = string_char_at(str,j);
			if (c == "u") {	// unicode char
				// 
			} else {
				if (global.JSON_ESCAPE_LOOKUP[? c] == undefined) {
					throw("JSON: Invalid escape sequence in string");
				}
				_res += global.JSON_ESCAPE_LOOKUP[? c];
			}
			k = j+1;
		} else if (o==34) {	// quote/end of string
			_res += string_substring(str,k,j+2);
			return [_res,j+1];
		}
		//j+=1;
	}
	throw("JSON: Unclosed string");
}
function json_parse_number(list,str,i) {
	var p = json_next_char(str,i,global.JSON_MAP.get("delim"));
	try {
		var s = string_substring(str,i,p+1);
		var n = real(s);
		return [n,p];
	} catch (e) {
		throw("JSON: Error in JSON at position " + string(p) + ": Malformed number")
	}
}
function json_parse_literal(list,str,i) {
	var p = json_next_char(str,i,global.JSON_MAP.get("delim"));
	var word = string_substring(str,i,p+1);
	if (array_contains(global.JSON_MAP.get("literal"),word)) {
		return [word=="true" ? true : false,p];
	} else {
		throw("JSON: Unexpected token " + string_char_at(str,p) + " position " + string(p));	
	}
}
function json_parse_array(list,str,i) {
	var new_list = new List();
	list.add(new_list);
	var l = string_length(str);
	i+=1;
	while (true) {
		i = json_next_char(str,i,global.JSON_MAP.get("space"),true);
		show_debug_message(string_char_at(str,i));
		// Check for end of array
		if (string_char_at(str,i)=="]") {
			i+=1;
			break;
		}
		// Read token
		var a = json_parse_child(list,str,i);
		new_list.add(a[0]);
		// Next token
		i = a[1];
		i = json_next_char(str,i,global.JSON_MAP.get("space"),true);
		var c = string_char_at(str,i);
		i+=1;
		if (c == "]") break;
		if (c != ",") throw("JSON: Expected ',' or ']' at position " + string(i));
	}
	return [new_list,i];
}
// https://github.com/rxi/json.lua/blob/master/json.lua#L307
function json_parse_object(list,str,i) {
	var new_map = new Map();
	i += 1;
	while (true) {
		var key, val;
		i = json_next_char(str,i,global.JSON_MAP.get("space"),true);
		// Check for end of object
		if (string_char_at(str,i)=="}") {
			i+=1;
			break;
		}
		// Get key
		if (string_char_at(str,i) != "\"") {
			throw("JSON: \" expected at position " + string(i));
		}
		var a = json_parse_child(list,str,i);
		key = a[0];
		i = a[1];
		// Read : delimiter
		if (string_char_at(str,i) != ":") {
			throw("JSON: : expected at position " + string(i));
		}
		i = json_next_char(str,i+1,global.JSON_MAP.get("space"),true);
		// Read value
		a = json_parse_child(list,str,i);
		val = a[0];
		i = a[1];
		new_map.set(string_copy(key,1,string_length(key)-1),val);
		// Next token
		i = json_next_char(str,i,global.JSON_MAP.get("space"),true);
		var c = string_char_at(str,i);
		i += 1;
		if (c == "}") break;
		if (c != ",") throw("JSON: Unexpected token at " + string(i-1) + " (" + string_char_at(str,i-1) + "): " +  string_substring(str,i-10,i+10));
	}
	return [new_map,i];
}

global.JSON_MAP = new Map();
var _map = global.JSON_MAP;

// string
_map.set("\"",json_parse_string);

// numbers
_map.set("0",json_parse_number);
_map.set("1",json_parse_number);
_map.set("2",json_parse_number);
_map.set("3",json_parse_number);
_map.set("4",json_parse_number);
_map.set("5",json_parse_number);
_map.set("6",json_parse_number);
_map.set("7",json_parse_number);
_map.set("8",json_parse_number);
_map.set("9",json_parse_number);
_map.set("-",json_parse_number);

// true/false/null
_map.set("t",json_parse_literal);
_map.set("f",json_parse_literal);
_map.set("n",json_parse_literal);

// arrays/objects
_map.set("[",json_parse_array);
_map.set("{",json_parse_object);

// Control chararcters
_map.set("space",[" ","\t","\r","\n"]);
_map.set("delim",[" ","\t","\r","\n","]","}",","]);
_map.set("escape",["\\","/",@'"',"b","f","n","r","t","u"]);
_map.set("literal",["true","false","null"]);

global.JSON_ESCAPE_LOOKUP = ds_map_create();
var _map = global.JSON_ESCAPE_LOOKUP;

_map[? "\\"] = "\\";
_map[? "\\"] = "\\";
_map[? "\""] = "\"";
_map[? "\""] = "\"";
_map[? "\b"] = "b";
_map[? "b"] = "\b";
_map[? "f"] = "\f";
_map[? "\f"] = "f";
_map[? "\n"] = "n";
_map[? "n"] = "\n";
_map[? "\r"] = "r";
_map[? "r"] = "\r";
_map[? "\t"] = "t";
_map[? "t"] = "\t";
