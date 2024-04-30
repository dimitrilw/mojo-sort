@always_inline
fn _partition[
    D: DType
](inout list: List[SIMD[D, 1]], low: Int, high: Int) -> Int:
    var pivot = list[high]
    var i = low - 1
    for j in range(low, high):
        if list[j] <= pivot:
            i += 1
            list[j], list[i] = list[i], list[j]
    list[i + 1], list[high] = list[high], list[i + 1]
    return i + 1


fn _quick_sort[
    D: DType
](inout list: List[SIMD[D, 1]], low: Int, high: Int):
    if low < high:
        var pi = _partition[D](list, low, high)
        _quick_sort[D](list, low, pi - 1)
        _quick_sort[D](list, pi + 1, high)


fn quick_sort[D: DType](inout list: List[SIMD[D, 1]]):
    _quick_sort[D](list, 0, len(list) - 1)


@always_inline
fn swap[D: CollectionElement](inout list: Pointer[D], a: Int, b: Int):
    var tmp = list[a]
    list.store(a, list[b])
    list.store(b, tmp)


@always_inline
fn _partition[
    D: CollectionElement, lt: fn (D, D) -> Bool
](inout list: Pointer[D], low: Int, high: Int) -> Int:
    var pivot = list[high]
    var i = low - 1
    for j in range(low, high):
        if lt(list[j], pivot):
            i += 1
            swap(list, i, j)

    swap(list, i + 1, high)
    return i + 1


fn _quick_sort[
    D: CollectionElement, lt: fn (D, D) -> Bool
](inout list: Pointer[D], low: Int, high: Int):
    if low < high:
        var pi = _partition[D, lt](list, low, high)
        _quick_sort[D, lt](list, low, pi - 1)
        _quick_sort[D, lt](list, pi + 1, high)


fn quick_sort[
    D: CollectionElement, lt: fn (D, D) -> Bool
](inout list: Pointer[D], length: Int):
    _quick_sort[D, lt](list, 0, length - 1)


fn quick_sort[
    D: CollectionElement, lt: fn (D, D) -> Bool
](inout list: ListLiteral[D]):
    _quick_sort[D, lt](list.data, 0, len(list) - 1)


fn quick_sort[
    D: CollectionElement, lt: fn (D, D) -> Bool
](inout list: List[D]):
    _quick_sort[D, lt](list.data, 0, len(list) - 1)
