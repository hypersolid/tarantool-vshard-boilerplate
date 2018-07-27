# Quickstart

```
tarantoolctl rocks install https://raw.githubusercontent.com/tarantool/vshard/master/vshard-scm-1.rockspec
```

In three different consoles run:
```
tarantool -i router
tarantool -i storage_1_a
tarantool -i storage_2_a
```

# Some examples
In router shell:

```
tarantool> call(1, 'api.say_hello')
---
- hello from storage
...
```

```
tarantool> call(1, 'api.echo', 'my_custom_params', 1, 2, 3)
---
- [477, 'my_custom_params', 1, 2, 3]
...
```

```
tarantool> call(1, 'api.create_fruit', 1, 'apple')
---
- [477, 1, 'apple']
...

tarantool> call(2, 'api.create_fruit', 2, 'banana')
---
- [401, 2, 'banana']
...
```

```
tarantool> call(2, 'api.select_fruit', 2)
---
- [401, 2, 'banana']
...
```
