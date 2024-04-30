from memory.anypointer import AnyPointer

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

# TODO: uncomment this block & implement the ListLiteral type
# currently, it fails because ListLiteral does not have a data attribute
# fn quick_sort[
#     D: CollectionElement, lt: fn (D, D) -> Bool
# ](inout list_literal: ListLiteral[D]):
#     _quick_sort[D, lt](list_literal.data, 0, len(list) - 1)


fn quick_sort[
    D: CollectionElement, lt: fn (D, D) -> Bool
](inout list: List[D]):
    # TODO: fix this
    # It fails because there is no matching function signature for _quick_sort.
    # This function signature is:
    #     _q_s[
    #         CollectionElement,
    #         fn (CollectionElement, CollectionElement) -> Bool,
    #     ](
    #         AnyPointer[CollectionElement], ## <- this is the mismatch
    #         Int,
    #         Int,
    #     )
    # stdlib source shows that List.data returns an AnyPointer[T]
    # ref: https://github.com/modularml/mojo/blob/432b2c1c966b8f2d9866d0b5257ab603aacd62d1/stdlib/src/collections/list.mojo#L82
    # However, the _q_s function signature expects a Pointer[T] instead of an AnyPointer[T]
    # and when I try to import AnyPointer (via `from memory.anypointer import AnyPointer`),
    # then I get:
    #     unable to locate module 'anypointer'
    _quick_sort[D, lt](list.data, 0, len(list) - 1)
