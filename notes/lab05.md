# Lab 5: Mutability, Iterators

## insert_items

实现中用了 `list.index(x[, start[, end]])` 的列表方法，我想当然的认为返回的索引是从 start 开始，不过我错了，文档如下：

```python
list.index(x[, start[, end]])
```

可选参数 start 和 end 是切片符号，用于将搜索限制为列表的特定子序列。返回的索引是**相对于整个序列的开始计算的**，而不是 start 参数。
