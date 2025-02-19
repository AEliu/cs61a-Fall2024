# 匿名的递归函数 – Q7: Anonymous Factorial

## 问题

CS61A 2024 Fall 课程的 hw03 有这样一道题，Q7: [Anonymous Factorial](https://cs61a.org/hw/hw03/#q7-anonymous-factorial) ，要求用匿名的方式写递归函数计算阶乘，不能用 `def` 或赋值的方式来给函数命名，用一行代码实现这个功能，题目如下。

```python
from operator import sub, mul
 
def make_anonymous_factorial():
    """Return the value of an expression that computes factorial.
 
    >>> make_anonymous_factorial()(5)
    120
    >>> from construct_check import check
    >>> # ban any assignments or recursion
    >>> check(HW_SOURCE_FILE, 'make_anonymous_factorial',
    ...     ['Assign', 'AnnAssign', 'AugAssign', 'NamedExpr', 'FunctionDef', 'Recursion'])
    True
    """
    return 'YOUR_EXPRESSION_HERE'
```

## 课程作业的提示

题目给出了提示：

```python
>>> fact = lambda n: 1 if n == 1 else mul(n, fact(sub(n, 1)))
>>> fact(5)
120
```

其中 lambda 函数赋给 fact，而在这个函数体中再次调用 fact，「我用我自己」，实现递归函数。

## 返回函数的函数

根据题目，调用函数 `make_anonymous_factorial` 会返回一个新的函数，这个函数接收一个整数作为参数，计算这个参数的阶乘值。也就是说，函数 `make_anonymous_factorial` 的返回值也是一个函数，这个返回的函数以整数为参数。假设这个返回的函数是f，则函数内类似如下：

```python
return lamdba n: f
```

这里的 f 函数应该是什么？如果 n == 1，这里的 f 是一个返回 1 的函数，如果 n > 1，那么问题来了，如何递归的计算参数为 n – 1 的 f 函数？也可以认为是在 f 函数体体内再调用 f 函数？既然 f 是函数，不妨拓展一下，给它再加上一个参数，可以讲一个函数传递进去，形如 f(function, n)，这时我们可以观察前述题目给出的提示，fact 是一个函数，同样也进入了自己的体内，那么，我们就直接将 f 函数传递给自己，`f(f, n)`，在函数体中调用函数，类似为：

```python
f(f, n):
    return n * f(f, n - 1)
```

用匿名函数表示：

```python
lambda f, n: n * f(f, n - 1)
```

考虑 base case, n 为 1 函数返回 1，我们此时可以得到这个 `lambda` 函数，有两个参数，一个是 n，这是需要计算阶乘的值，一个是 f，这是这个函数本身：

```python
lambda f, n: 1 if n == 1 else n * f(f, n - 1)
```

## Currying，多参数转化成单参数函数

但是现在还有问题：一个问题是此函数有两个参数，而调用函数 `make_anonymous_factorial` 后，其返回的函数只有一个参数，另一个问题是，这个匿名函数的一个参数是这个函数本身，但是它没有名字来进行传递。配套教材介绍了 [Currying](https://www.composingprograms.com/pages/16-higher-order-functions.html#currying) 这个东西，可以将一个有多参数的函数转换成单参数函数的函数链，如下面介绍的例子

```python
>>> def curried_pow(x):
        def h(y):
            return pow(x, y)
        return h
>>> curried_pow(2)(3)
8
```

如果用 lambda 函数表示，上面示例可以表示如下：

```python
lambda x: lambda y: x ** y
```

可以看到运行结果：

```python
>>> (lambda x: lambda y: x ** y)(2)
<function __main__.<lambda>.<locals>.<lambda>(y)>
>>> (lambda x: lambda y: x ** y)(2)(3)
8
```

我们仿照上面的程序来写一下，此时返回函数中将f作为一个参数：

```python
def inner_fact(f):
    def fun(n):
        return f(f, n)
    return fun

return inner_fact(f)
```

`inner_fact` 改造成 lambda 函数：

```python
lambda f : lambda n: f(f, n)
```

将其放在 `()` 里，作为一个整体的函数来调用，其参数为上述的函数： `lambda f, n: 1 if n == 1 else n * f(f, n - 1)`。

```python
(lambda f : lambda n: f(f, n))(lambda f, n: 1 if n == 1 else n * f(f, n - 1))
```

此时，这是一个以 `n` 为参数的函数，来实现递归。

## 完整实现

```python
from operator import sub, mul
 
def make_anonymous_factorial():
    """Return the value of an expression that computes factorial.
 
    >>> make_anonymous_factorial()(5)
    120
    >>> from construct_check import check
    >>> # ban any assignments or recursion
    >>> check(HW_SOURCE_FILE, 'make_anonymous_factorial',
    ...     ['Assign', 'AnnAssign', 'AugAssign', 'NamedExpr', 'FunctionDef', 'Recursion'])
    True
    """
    return (lambda f: lambda n: f(f, n))(lambda f, n: \
                                         1 
                                         if n == 1 
                                         else mul(n, f(f, sub(n, 1))))
```

## 计算斐波那契数列

我们还可以利用这个原理来计算[斐波那契数列](https://zh.wikipedia.org/wiki/%E6%96%90%E6%B3%A2%E9%82%A3%E5%A5%91%E6%95%B0)

普通递归实现如下：

```python
def fib(n):
    """
    >>> fib(5)
    5
    >>> fib(12)
    144
    >>> fib(1)
    1
    """
    if n == 0 or n == 1:
        return n
    return fib(n - 1) + fib(n - 2)
```

类似的改成匿名函数的递归实现：

```python
def make_anonymous_fib():
    """Return the value of an expression that computes Fibonacci.
    >>> make_anonymous_fib()(5)
    5
    >>> make_anonymous_fib()(12)
    144
    """
    return (lambda f: lambda n: f(f, n)) (lambda f, n: n if n == 1 or n == 0 else f(f, n - 1) + f(f, n - 2))
```
