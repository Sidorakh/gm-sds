// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function Stack() constructor {
	type = ds_type_stack;
	ds = ds_stack_create();
	destroy = function() {
		if (ds==undefined) {
			show_error("Stack does not exist: \n" + debug_get_callstack(),false);
		} else {
			ds_stack_destroy(ds);
		}
		ds = undefined;
	};
    top = function() { return ds_stack_top(ds); };
    pop = function() { return ds_stack_pop(ds); };
    push = function(val) { ds_stack_push(ds,val); };
    size = function() { return ds_stack_size(ds); };
	if (argument_count > 0) {
		for (var i=0;i<argument_count;i++) {
			push(argument[i]);
		}
	}
}

function Queue() constructor {
    type = ds_type_queue;
    ds = ds_queue_create();
    destroy = function() {
		if (ds == undefined) {
			show_error("Queue does not exist: " + debug_get_callstack(),false);
		} else {
			ds_queue_destroy(ds);
		}
		ds = undefined;
	};
    top = function() { return ds_queue_head(ds); };
    pop = function() { return ds_queue_dequeue(ds); };
    push = function(val) { ds_queue_enqueue(ds,val); };
    size = function() { return ds_queue_size(ds); };
	if (argument_count > 0) {
		for (var i=0;i<argument_count;i++) {
			push(argument[i]);
		}
	}
}


function PriorityQueue() constructor {
    type = ds_type_priority;
    ds = ds_priority_create();
    destroy = function() {
		if (ds == undefined) {
			show_error("Priority Queue does not exist: " + debug_get_callstack(),false);
		} else {
			ds_priority_destroy(ds);
		}
		ds = undefined;
	};
    clear = function() { ds_priority_clear(ds); };
    size = function() { return ds_priority_size(ds); };
    add = function(val,priority) { ds_priority_add(ds,val,priority); }; 
    get_min = function() { return ds_priority_find_min(ds); };
    get_max = function() { return ds_priority_find_max(ds); };
    delete_min = function() { return ds_priority_delete_min(ds); };
    delete_max = function() { return ds_priority_delete_max(ds); };
}

function Grid(_width, _height) constructor {
	type = ds_type_grid;
	ds = ds_grid_create(_width, _height);
	destroy = function() {
		if (ds == undefined) {
			show_error("Grid does not exist: " + debug_get_callstack(),false);
		} else {
			ds_grid_destroy(ds);
		}
		ds = undefined;
	}
	__width = _width;
	__height = _height;
	width = function() {
		if (argument_count == 1) {
			resize(argument[0],__height);
		}
		return __width;
	}
	height = function() {
		if (argument_count == 1) {
			resize(__width,argument[0]);
		}
		return __height;
	}
	resize = function(_w,_h) {
		__width = _w;
		__height = _h;
		ds_grid_resize(ds,_w,_h);
	}
    clear  = function() {
		var _v = argument_count == 1 ? argument[0] : 0;
		ds_grid_clear(ds,_v);
	};
    shuffle = function() { ds_grid_shuffle(ds); };
    sort = function(column,ascending) { ds_grid_sort(ds,column,ascending); };
    set = function(x,y,v) { ds[# x,y] = v; };
    get = function(x,y) { return ds[# x,y]; };
    get_max = function(x1,y1,x2,y2) { return ds_grid_get_max(ds,x1,y1,x2,y2); };
    get_min = function(x1,y1,x2,y2) { return ds_grid_get_min(ds,x1,y1,x2,y2); };
    get_mean = function(x1,y1,x2,y2) { return ds_grid_get_mean(ds,x1,y1,x2,y2); };
    get_sum = function(x1,y1,x2,y2) { return ds_grid_get_sum(ds,x1,y1,x2,y2); };
    get_max_disk = function(x,y,r) { return ds_grid_get_disk_max(ds,x,y,r); };
    get_min_disk = function(x,y,r) { return ds_grid_get_disk_min(ds,x,y,r); };
    get_mean_disk = function(x,y,r) { return ds_grid_get_disk_mean(ds,x,y,r); };
    get_sum_disk = function(x,y,r) { return ds_grid_get_disk_sum(ds,x,y,r); };
	
	filter = function (cb) {
		var _nds = new Grid(__width,__height);
		for (var _x=0;_x<__width;_x++) {
			for (var _y=0;_y<__width;_y++) {
				if (cb(ds[# _x,_y],_x,_y,self)) {
					_nds.set(_x,_y,ds[# _x,_y]);
				} else {
					_nds.set(_x,_y,undefined);
				}
			}
		}
		return _nds;
	};
	
	map = function(cb){
		var _nds = new Grid(__width,__height);
		for (var _x=0;_x<__width;_x++) {
			for (var _y=0;_y<__width;_y++) {
				_nds.set(_x,_y,cb(ds[# x,y],_x,_y,self));
			}
		}
		return _nds;
	};
	
	foreach = function(cb) {
		var _br = false;
		for (var _x=0;_x<__width;_x++) {
			for (var _y=0;_y<__width;_y++) {
				if (cb(ds[# _x,_y],_x,_y,self) == false) {
					_br = true;
					break;
				}
			}
			if (_br) {
				break;	
			}
		}
	};
	
}

function List() constructor {
	type = ds_type_list;
	ds = ds_list_create();
	destroy = function(shallow) {
		if (shallow == undefined) {
			shallow = false;	
		}
		if (ds == undefined) {
			show_error("List does not exist: " + debug_get_callstack(),false);
		} else {
			if (shallow != false) {
				var _iter = new Iterator(self);
				while (_iter.next() != undefined) {
					var _item = _iter.value();
					if (is_struct(_item)) {
						switch (instanceof(_item)) {
							case "List":
							case "Map":
							case "Grid":
							case "Queue":
							case "Priority":
							case "Stack":
								_item.destroy();
							break;
						}
					}
				}
			}
			ds_list_destroy(ds);
		}
		ds = undefined;
	}
    get = function(i) { return ds[| i]};
    set = function(i,v) { ds[| i] = v; };
    add = function(v) { ds_list_add(ds,v); };
    insert = function(i, v) { ds_list_insert(ds, i, v); };
    shuffle = function() { ds_list_shuffle(ds); };
    sort = function(ascending) { ds_list_sort(ds,ascending); };
    size = function() { return ds_list_size(ds); };
    mark_list = function(i) { ds_list_mark_as_list(ds, i); };
    mark_map = function(i) { ds_list_mark_as_map(ds,i); };
	remove = function(i) { ds_list_delete(ds,i) };
	
	foreach = function(cb) {
		for (var i=0,s=size();i<s;i++) {
			if (cb(ds[| i],i,self) == true) {
				break;	
			}
		}
	}
	
	map = function(cb,remove) {
		if (remove == undefined) {
			remove = false;	
		}
		var _nds = new List();
		for (var i=0,s=size();i<s;i++) {
			_nds.add(cb(ds[| i], i, self));
		}
		if (remove) {
			self.destroy(true);
		}
		return _nds;
	}
	
	filter = function(cb,remove) {
		if (remove == undefined) {
			remove = false;	
		}
		var _nds = List();
		for (var i=0,s=size();i<s;i++) {
			if (cb(ds[| i],i,self) == true) {
				_nds.add(ds[| i]);	
			}
		}
		if (remove) {
			self.destroy(true);	
		}
	}
	
	if (argument_count > 0) {
		for (var i=0;i<argument_count;i++) {
			add(argument[i]);	
		}
	}
}

function Map() constructor {
	type = ds_type_map;
	ds = ds_map_create();
	destroy = function(shallow) {
		if (shallow = undefined) {
			shallow = false;	
		}
		if (ds == undefined) {
			show_error("Map does not exist: " + debug_get_callstack(),false);
		} else {
			if (shallow != false) {
				var _iter = new Iterator(self);
				while (_iter.next() != undefined) {
					var _item = _iter.value();
					if (is_struct(_item)) {
						switch (instanceof(_item)) {
							case "List":
							case "Map":
							case "Grid":
							case "Queue":
							case "Priority":
							case "Stack":
								_item.destroy();
							break;
						}
					}
				}
			}
			ds_map_destroy(ds);
		}
		ds = undefined;
	}
	get = function(key) { return ds[? key]; };
	set = function(key,val) { ds[? key] = val; };
	clear = function() { ds_map_clear(ds); };
	remove = function(key) { ds_map_delete(ds,key); };
	size = function() { return ds_map_size(ds); };
	
	foreach = function() {
		var _k = ds_map_find_first(ds);
		while (_k != undefined) {
			if (cb(ds[? _k], _k, ds) == true) {
				break;
			}
			k = ds_map_find_next(ds,_k);
		}
	};
	map = function(cb,remove) {
		if (remove == undefined) {
			remove = false;	
		}
		var _k = ds_map_find_first(ds);
		var _nds = Map();
		while (_k != undefined) {
			_nds.set(_k,cb(ds[? _k], _k, self));
			k = ds_map_find_next(ds,_k);
		}
		if (remove) {
			self.destroy();	
		}
		return _nds;
	}
	filter = function(cb) {
		var _k = ds_map_find_first(ds);
		var _nds = new Map();
		while (_k != undefined) {
			if (cb(ds[? _k],_k,self)) {
				_nds[? _k] = ds[? _k];
			}
		}
		return _nds;
	}
}


function Iterator(bds) constructor {
	ds = bds;
	type = ds.type;
	key = undefined;
	next = undefined;
	value = undefined;
	last = function() {
		if (type == ds_type_list) {
			return ds.size()-1;
		} else if (type == ds_type_map) {
			return ds_map_find_last(ds.ds);
		}
	}
	_next_list = function() {
		if (key==undefined) {
			key = 0;
			return key;
		}
		if (key+1 < ds_list_size(ds.ds)) {
			return ++key;
		} else {
			return undefined;	
		}
	}
	_next_map = function() {
        if (key == undefined) {
            key = ds_map_find_first(ds.ds);
        } else {
            key = ds_map_find_next(ds.ds,key);
        }
        return key;
	}
    _value_list = function() {
        return ds.ds[| key];
    };
    _value_map = function() {
        return ds.ds[? key];
    };
	if (type == ds_type_list) {
		key = undefined;
		next = _next_list;
		value = _value_list;
	} else if (type == ds_type_map) {
		key = undefined;
		next = _next_map;
		value = _value_map;
	}
}