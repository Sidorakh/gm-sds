# gm-sds

A set of wrappers for GameMaker Studio 2's data structures, using the new structs available in version 2.3

Wrapped structures:
 - Stack
 - Queue
 - Priority Queue
 - Grid
 - List
 - Map
 - Iterators

## Type list

### Stack

```gml
var stack = new Stack();
stack.push("item-1");
stack.push("item-2");
show_debug_message(stack.size()); 	// outputs "2"
show_debug_message(stack.pop()); 	// outputs "item-2"
show_debug_message(stack.top());	// outputs "item-1"
stack.destroy();
```

| Member | Description |
|---|---|
| `Stack()` | Wrapped Stack constructor |
| `Stack.size()` | Returns the length of the Stack |
| `Stack.push(value)` | Push `value` to top of the Stack |
| `Stack.pop()` | Pop the item off the top of the Stack and returns it, returns `undefined` if no items are in the Stack |
| `Stack.top()` | Returns the item on the top of the Stack, or `undefined` if no items are in the Stack |
| `Stack.clear()` | Removes every item in the Stack |
| `Stack.destroy()` | Destroys the Stack |

### Queue
```gml
var queue = new Queue();
queue.push("item-1");
queue.push("item-2");
show_debug_message(queue.size());	// outputs "2"
show_debug_message(queue.pop()); 	// outputs "item-1"
show_debug_message(queue.top());	// outputs "item-2"
queue.destroy();
```

| Member | Description |
|---|---|
| `Queue()` | Wrapped Queue constructor |
| `Queue.size()` | Returns the length of the Queue |
| `Queue.push(value)` | Push `value` into the Queue |
| `Queue.pop()` | Removes the item at the front of the Queue and returns it, returns `undefined` if no items are in the Queue |
| `Queue.top()` | Returns the item at the front of the Queue, or `undefined` if no items are in the Queue |
| `Queue.clear()` | Removes every item in the Queue |
| `Queue.destroy()` | Destroys the Queue |

### Priority Queue
```gml
var priority = new Priority();
priority.add("item-1",100);
priority.add("item-2",200);
priority.add("item-3",300);
show_debug_message(priority.size());	// outputs "3";
show_debug_message(priority.get_max());	// outputs "item-3"
show_debug_message(priority.get_min());	// outputs "item-1"
priority.delete_min();
show_debug_message(priority.get_min());	// outputs "item-2";
priority.delete();
```
| Function | Description |
|---|---|
| `Priority()` | Wrapped Priority constructor |
| `Priority.size()` | Returns the length of the Priority Queue |
| `Priority.add(value,priority)` | Adds `value` into the Priority Queue with the specified `priority` |
| `Priority.get_max()` | Returns the value with highest priority in the Priority Queue |
| `Priority.get_min()` | Returns the value with the lowest priority in the Priority Queue |
| `Priority.delete_max()` | Returns the value with the highest priority and removes it from the Priority Queue |
| `Priority.delete_min()` | Returns the value with the lowest priority and removes it from the Priority Queue |
| `Priority.clear()` | Removes every item in the Priority Queue |
| `Priority.destroy()` | Destroys the Priority Queue |

----

### Grid
```gml
// TODO: code
```

| Function | Description |
|---|---|
| `Grid(width,height)` | Wrapped Grid constructor, creates a new Grid with passed in `width` and `height` |
| `Grid.width([new_width])` | Changes the Grid width if `new_width` is passed in, then returns the Grid width,  |
| `Grid.height([new_height])` | Changes the Grid height if `new_height` is passed in, then returns the Grid height |
| `Grid.resize(new_width,new_height)` | Resizes the grid to `new_width` and `new_height` |
| `Grid.shuffle()` | Shuffles the entries in the Grid |
| `Grid.sort(column,ascending)` | Sorts the entries in a Grid by a column, if `ascending` is true, in ascending order, otherwise, descending |
| `Grid.set(x,y,value)` | Set the value in the Grid at the position (`x,y`) |
| `Grid.get(x,y)` | Returns the value in the Grid at (`x,y`) |
| `Grid.get_max(x1,y1,x2,y2)` | Returns the maximum value in the Grid region defined by (`x1,y1,x2,y2`) |
| `Grid.get_min(x1,y1,x2,y2)` | Returns the minimum value in the Grid region defined by (`x1,y1,x2,y2`) |
| `Grid.get_mean(x1,y1,x2,y2)` | Returns the mean of all values in the Grid region defined by (`x1,y1,x2,y2`) |
| `Grid.get_sum(x1,y1,x2,y2)` | Returns the sum of all values in the Grid region defined by (`x1,y1,x2,y2`) |
| `Grid.get_max_disk(x,y,r)` | Returns the maximum value in the circular Grid region defined by (`x,y,r`) |
| `Grid.get_min_disk(x,y,r)` | Returns the minimum value in the circular Grid region defined by (`x,y,r`) |
| `Grid.get_mean_disk(x,y,r)` | Returns the mean of all values in the circular Grid region defined by (`x,y,r`) |
| `Grid.get_sum_disk(x,y,r)` | Returns the sum of all values in the circular Grid region defined by (`x,y,r`) |
| `Grid.filter(cb)` | Returns a new Grid containing only values that pass the `cb` function passed in. The `cb` function must take arguments in the order `value`,`x`,`y`,`grid`, and return `true` if the value passes, and `false` otherwise|
| `Grid.map(cb)` | Returns a new Grid with every entry passed through the `cb` function. The `cb` function must take arguments in the order `value`,`x`,`y`,`grid`, and return the new value |
| `Grid.foreach(cb)` | Runs the `cb` function on every value in the Grid. this function must take arguments in the order `value`,`x`,`y`,`grid`, and return `true` to break out of the foreach loop early |
| `Grid.clear()` | Clears every item in the Grid |
| `Grid.destroy()` | Destroys the Grid |

### List

```gml
// TODO: code
```
| Member | Description |
|--|--|
|`List([...values])`| Wrapped List constructor, creates a new List with passed in values (or empty if none are passed in) |
| `List.add(value)` | Adds `value` to the end of the List |
| `List.set(index,value)` | Sets the item at position `index` in the List to `value` |
| `List.get(index)` | Gets the item at position `index` in the List |
| `List.insert(index,value)` | Inserts `value` at `index` in the List |
| `List.sort(cb)` | If `cb` is not passed in, the list is sorted in ascendign order. Otherwise, `cb` is a comparison function, defined as `function(a,b)`. If `b` is larger than `a`, `1` should be returned, if they are equal, `0` should be returned, and if `a` is greater than `b`, `-1` should be returned. |
| `List.size()` | Returns the list size |
| `List.remove(index)` | Removes the value at position `index` within the list |
| `List.filter(cb)` | Returns a new List containing only values that pass the `cb` function. The `cb` function must take arguments in the order `value`,`i`,`list`, and return `true` if the value passes, and `false` otherwise |
| `List.map(cb)` | Returns a new List with every value passed through the `cb` function. The `cb` function must take arguments in the order `value`,`i`,`list`, and return the new value |
| `List.foreach(cb)` | Runs the `cb` function on every value in the List. This function must take arguments in the order `value`,`i`,`list`, and return `true` to break out of the foreach loop early |
| `List.clear()` | Removes every item in the List |
| `List.destroy()` | Destroys the list, along with any nested List and Map structures |


### Map

| Member | Description |
|--|--|
| `Map()` | Wrapped Map constructor |
| `Map.set(key,value)` | Sets the value in the Map at `key` to `value` |
| `Map.get(key)` | Gets the value in the Map at `key` |
| `Map.remove(key)` | Removes the entry in Map at `key` |
| `Map.size()` | Returns the number of entries in the Map |
| `Map.filter(cb)` | Returns a new Map containing only values that pass the `cb` function. The `cb` function must take arguments in the order `value`,`key`,`Map`, and return `true` if the value passes, and `false` otherwise |
| `Map.map(cb)` | Returns a new Map with every value passed through the `cb` function. The `cb` function must take arguments in the order `value`,`key`,`map`, and return the new value |
| `Map.foreach(cb)` | Runs the `cb` function on every value in the Map. This function must take arguments in the order `value`,`key`,`map`, and return `true` to break out of the foreach loop early |
| `Map.clear()` | Removes every entry in the Map |
| `Map.destroy()` | Destroys the Map |


### Iterators

You can also create iterators for use with Maps and Lists

```gml
var _map = new Map();

_map.set("x","ewfweopfniwefn");
_map.set("y","jf8923465");
_map.set("z",1112234242);

var _list = new List(32,4,5,6456,623534,8,763);

var _str = "";

var _map_iter = new Iterator(_map);

while (_map_iter.next() != undefined) {
	_str += string(_map_iter.key) + " - " + string(_map_iter.value()) + "\n";
}

var _list_iter = new Iterator(_list);

while (_list_iter.next() !- undefined) {
	_str += string(_list_iter.value()) + "\n";
}

show_message(_str);

_list.destroy();
_map.destroy();
```

| Member | Description |
|--|--|
| `Iterator(map/list)` | Create  a new Iterator over the passed in Struct (must be a wrapped Map or wrapped List |
| `Iterator.key` | If in a Map iterator, this contains the current key. if in a List iterator, it contains the current index |
| `Iterator.next()` | Moves the pointer to the next key. Returns `undefined` if each key or index has been returned |
| `Iterator.value()` | Returns the current value in the iterator |
| `Iterator.last() ` | Contains the last key or index in an iterator |

## Helpers

Two helper functions are included to help parse JSON strings
| Function | Description |
|--|--|
| `json_parse(json_string)` | Attempts to parse the `json_string`, throws an error if unsuccessful, returns a Map or List if successful (depending on the JSON string) |
| `json_stringify(sds_list/sds_map)` | Converts a List or Map structure into a JSON string, including any nested SDS structures |



----
Notes: 
 - When nesting lists and maps, try not to mix these structures with the built in counterpartes, this can lead to memory leaks if you don't manage the built in structures properly. 
 - `json_parse` throws an error on failure, you can catch it in a `try..catch` block (also new in 2.3). On failure, it should clean up any structures it has created. 
 - The JSON parse function is likely imperfect, so, be aware of this when using it. There may be some edge cases that weren't covered properly

