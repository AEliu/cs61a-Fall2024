# 单词转换 minimum mewtations

## 函数原型

```python
minimum_mewtations(typed, source, limit):
    """A diff function for autocorrect that computes the edit distance from TYPED to SOURCE.
    This function takes in a string TYPED, a string SOURCE, and a number LIMIT.

    Arguments:
        typed: a starting word
        source: a string representing a desired goal word
        limit: a number representing an upper bound on the number of edits

    >>> big_limit = 10
    >>> minimum_mewtations("cats", "scat", big_limit)       # cats -> scats -> scat
    2
    >>> minimum_mewtations("purng", "purring", big_limit)   # purng -> purrng -> purring
    2
    >>> minimum_mewtations("ckiteus", "kittens", big_limit) # ckiteus -> kiteus -> kitteus -> kittens
    3
    """
    assert False, 'Remove this line'
    if ___________: # Base cases should go here, you may add more base cases as needed.
        # BEGIN
        "*** YOUR CODE HERE ***"
        # END
    # Recursive cases should go below here
    if ___________: # Feel free to remove or add additional cases
        # BEGIN
        "*** YOUR CODE HERE ***"
        # END
    else:
        add = ... # Fill in these lines
        remove = ...
        substitute = ...
        # BEGIN
        "*** YOUR CODE HERE ***"
        # END
```

## 基础情况

考虑了三种情况：

1. typed 与 source 相同，直接返回 0 ，不需要转化
2. typed 与 source 不同，说明这两者也不同时为 `''`，如果此时 limit 为 0 ，后面不再求解，直接返回 1
3. typed 或 source 是对方的子字符串，此时直接通过 add 或 remove 可以遗漏或多余的部分即可转化

## 递归情况

从 typed 到 source 的转化有三种方式，增加、移除或替换，对应上面的 add remove substitute，对应这三种情况，分别处理如下：

- `add` : 相当于 typed 转换成 source 除去首字母后的单词
- `remove` : 相当于去首字母后的 typed 单词转换成 source
- `add` : 相当于 typed 和 source 分别除去首字母后的单词进行转换

最后，取这三种方式的最小值：

```python
    # Base cases
    if typed == source: 
        return 0
    if limit == 0:
        return 1
    if typed in source or source in typed: 
        return abs(len(typed) - len(source)) if abs(len(typed) - len(source)) <= limit else limit + 1
    
    # Recursive cases should go below here
    if source[0] == typed[0]: 
        return minimum_mewtations(typed[1:], source[1:], limit)
    else:
        add = 1 + minimum_mewtations(typed, source[1:], limit - 1) 
        remove = 1 + minimum_mewtations(typed[1:], source, limit - 1)
        substitute = 1 + minimum_mewtations(typed[1:], source[1:], limit - 1)

        return min(add, remove, substitute)
```

## 还有个问题？

如果两个字母可以互换，这样怎么来求解呢？
