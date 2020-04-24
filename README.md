# gm-sds

A set of wrappers for GameMaker Studio 2's data structures, using the new structs available in version 2.3

Wrapped structures:
 - Stack
 - Queue
 - Priority Queue
 - Grid
 - List
 - Map

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

| Function | Description |
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

| Function | Description |
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
..WIP

###

## Helpers

Also includes two functions, `json_parse` and `json_stringify` to handle JSON parsing

