/// @description Insert description here
// You can write your code in this editor

//var _x = json_parse_array(new List(),"[1,2,3,4,5,6,7,8,9],",1);//get_string("","\"\\\"abcdef\\\"\\nxxxx\\nyyyy\","),1);
//var _x = json_parse_object(new List(),@'{"a":"b","c":5,"d":[1,2,3,4,5,"44"]}',1);
//show_message(json_stringify(_x[0]));

function test(a,b,c){
    if (argument_count < 2) {
        b=3;
		c=4;
    }
    show_debug_message(string(a) + " - " + string(b) + " - " + string(c));
}
test(1);
test(3,5,8);

var _x = json_parse(@'{"a":"b","c":5,"d":[1,2,3,4,5,"44"]}');
//var _jstr = @'{"thiswas":"a triumph","making":["note","here",{"hard_to":{"thing":"my satisfaction","action":"overstate"},"done":true,"dead":false}]}';
//var _x = json_parse(_jstr);
show_message(json_stringify(_x));
_x.destroy();
//clipboard_set_text(json_stringify(_x));


//show_message(json_parse_number(-1,"2,",1));

//json_parse(@'{"this":"was a triumph","im":"making a note here","hude":["success"]}');
/*

var _new_map = new Map();

_new_map.set("other_key","efioufnweuiofn");

var _list = new List(1,2,3,4,5,6,7,8,9,0,"doqwndon332e\newfjf\n\n\nqjwdnqwon" + @'"\\',_new_map);

//show_message(json_stringify(_list));

var _map = new Map();
_map.set("x","weofnweuiofnweuinweuifn");
_map.set("y",13239874234321);
_map.set("z","ewonfowenf");
_map.set("list",_list);
clipboard_set_text(json_stringify(_map));
show_message(json_stringify(_map));

/*
queue = new Queue(1,2,3,4,5,6,7,8,9);

map = new Map();

map.set("x","ewfweopfniwefn");
map.set("y","jf8923465");
map.set("z",1112234242);

list = new List(32,4,5,6456,623534,8,763);

var _str = "";

var _map_iter = new Iterator(map);

while (_map_iter.next() != undefined) {
	_str += string(_map_iter.value()) + "\n";
}
show_message(_str);

_str = "";

var _list_iter = new Iterator(list);

while (_list_iter.next() != undefined) {
	_str += string(_list_iter.value()) + "\n";
}
show_message(_str);

_str = "";

while (queue.size()) {
	_str += string(queue.pop()) + "\n";	
}
show_message(_str);

list.foreach(function(c){
	show_message(c);
});