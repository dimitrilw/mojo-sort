from random import random_ui64, random_si64, random_float64
from memory.unsafe import bitcast
from my_utils import print_v
from time import now
# from algorithm.sort import sort
from quick_sort import quick_sort
from radix_sorting import radix_sort, radix_sort11, radix_sort13, radix_sort16
from selection_sort import selection_sort
from insertion_sort import insertion_sort
from count_sort import counting_sort
from tim_sort import tim_sort

fn random_vec[D: DType](size: Int, max: Int = 3000) -> List[SIMD[D, 1]]:
    var result = List[SIMD[D, 1]](size)
    for _ in range(size):
        @parameter
        if D == DType.int8 or D == DType.int16 or D == DType.int32 or D == DType.int64:
            result.append(random_si64(0, max).cast[D]())
        elif D == DType.float16 or D == DType.float32 or D == DType.float64:
            result.append(random_float64(0, max).cast[D]())
        else:
            result.append(random_ui64(0, max).cast[D]())
    return result

fn assert_sorted[D: DType](vector: List[SIMD[D, 1]]):
    for i in range(1, len(vector)):
        if vector[i] < vector[i - 1]:
            print(", 0")
            return
    print(", 1")

fn benchmark[D: DType, func: fn(inout List[SIMD[D, 1]]) -> None](
    name: StringLiteral, size: Int, max: Int = 3000
):
    var v = random_vec[D](size, max)
    var v1 = v
    var min_duration = Int64.MAX
    for _ in range(10):
        v1 = v
        var tik = now()
        func(v1)
        var tok = now()
        min_duration = min(min_duration, tok - tik)
    print(name, D, end="")
    print(",", size, ",", max, ",", min_duration, ",", min_duration // size, end="")
    assert_sorted[D](v1)

fn std_sort[D: DType](inout vector: List[SIMD[D, 1]]):
    sort[D](vector)

fn main():
    print("Operation, size, max_value, duration, avg duration, sorted")
    
    benchmark[DType.uint8, selection_sort[DType.uint8]]("Selection sort", 5)
    benchmark[DType.uint8, insertion_sort[DType.uint8]]("Insertion sort", 5)
    benchmark[DType.uint8, std_sort[DType.uint8]]("Std sort", 5)
    benchmark[DType.uint8, quick_sort[DType.uint8]]("Quick sort", 5)
    benchmark[DType.uint8, tim_sort[DType.uint8]]("Tim sort", 5)
    benchmark[DType.uint8, counting_sort[DType.uint8]]("Counting sort", 5)
    benchmark[DType.uint8, radix_sort[DType.uint8]]("Radix sort", 5)

    benchmark[DType.uint8, selection_sort[DType.uint8]]("Selection sort", 20)
    benchmark[DType.uint8, insertion_sort[DType.uint8]]("Insertion sort", 20)
    benchmark[DType.uint8, std_sort[DType.uint8]]("Std sort", 20)
    benchmark[DType.uint8, quick_sort[DType.uint8]]("Quick sort", 20)
    benchmark[DType.uint8, tim_sort[DType.uint8]]("Tim sort", 20)
    benchmark[DType.uint8, counting_sort[DType.uint8]]("Counting sort", 20)
    benchmark[DType.uint8, radix_sort[DType.uint8]]("Radix sort", 20)
    
    benchmark[DType.uint8, selection_sort[DType.uint8]]("Selection sort", 50)
    benchmark[DType.uint8, insertion_sort[DType.uint8]]("Insertion sort", 50)
    benchmark[DType.uint8, std_sort[DType.uint8]]("Std sort", 50)
    benchmark[DType.uint8, quick_sort[DType.uint8]]("Quick sort", 50)
    benchmark[DType.uint8, tim_sort[DType.uint8]]("Tim sort", 50)
    benchmark[DType.uint8, counting_sort[DType.uint8]]("Counting sort", 50)
    benchmark[DType.uint8, radix_sort[DType.uint8]]("Radix sort", 50)

    benchmark[DType.uint8, selection_sort[DType.uint8]]("Selection sort", 300)
    benchmark[DType.uint8, insertion_sort[DType.uint8]]("Insertion sort", 300)
    benchmark[DType.uint8, std_sort[DType.uint8]]("Std sort", 300)
    benchmark[DType.uint8, quick_sort[DType.uint8]]("Quick sort", 300)
    benchmark[DType.uint8, tim_sort[DType.uint8]]("Tim sort", 300)
    benchmark[DType.uint8, counting_sort[DType.uint8]]("Counting sort", 300)
    benchmark[DType.uint8, radix_sort[DType.uint8]]("Radix sort", 300)

    benchmark[DType.int8, selection_sort[DType.int8]]("Selection sort", 300)
    benchmark[DType.int8, insertion_sort[DType.int8]]("Insertion sort", 300)
    benchmark[DType.int8, std_sort[DType.int8]]("Std sort", 300)
    benchmark[DType.int8, quick_sort[DType.int8]]("Quick sort", 300)
    benchmark[DType.int8, tim_sort[DType.int8]]("Tim sort", 300)
    benchmark[DType.int8, radix_sort[DType.int8]]("Radix sort", 300)

    benchmark[DType.uint16, selection_sort[DType.uint16]]("Selection sort", 3000)
    benchmark[DType.uint16, insertion_sort[DType.uint16]]("Insertion sort", 3000)
    benchmark[DType.uint16, std_sort[DType.uint16]]("Std sort", 3000)
    benchmark[DType.uint16, quick_sort[DType.uint16]]("Quick sort", 3000)
    benchmark[DType.uint16, tim_sort[DType.uint16]]("Tim sort", 3000)
    benchmark[DType.uint16, counting_sort[DType.uint16]]("Counting sort", 3000)
    benchmark[DType.uint16, radix_sort[DType.uint16]]("Radix sort", 3000)

    benchmark[DType.int16, selection_sort[DType.int16]]("Selection sort", 3000)
    benchmark[DType.int16, insertion_sort[DType.int16]]("Insertion sort", 3000)
    benchmark[DType.int16, std_sort[DType.int16]]("Std sort", 3000)
    benchmark[DType.int16, quick_sort[DType.int16]]("Quick sort", 3000)
    benchmark[DType.int16, tim_sort[DType.int16]]("Tim sort", 3000)
    benchmark[DType.int16, radix_sort[DType.int16]]("Radix sort", 3000)

    benchmark[DType.float16, selection_sort[DType.float16]]("Selection sort", 3000)
    benchmark[DType.float16, insertion_sort[DType.float16]]("Insertion sort", 3000)
    benchmark[DType.float16, std_sort[DType.float16]]("Std sort", 3000)
    benchmark[DType.float16, quick_sort[DType.float16]]("Quick sort", 3000)
    benchmark[DType.float16, tim_sort[DType.float16]]("Tim sort", 3000)
    benchmark[DType.float16, radix_sort[DType.float16]]("Radix sort", 3000)

    benchmark[DType.uint32, std_sort[DType.uint32]]("Std sort", 300_000, 2_000_000_000)
    benchmark[DType.uint32, quick_sort[DType.uint32]]("Quick sort", 300_000, 2_000_000_000)
    benchmark[DType.uint32, tim_sort[DType.uint32]]("Tim sort", 300_000, 2_000_000_000)
    benchmark[DType.uint32, radix_sort[DType.uint32]]("Radix sort", 300_000, 2_000_000_000)
    benchmark[DType.uint32, radix_sort11[DType.uint32]]("Radix sort 11", 300_000, 2_000_000_000)

    benchmark[DType.int32, std_sort[DType.int32]]("Std sort", 300_000, 2_000_000_000)
    benchmark[DType.int32, quick_sort[DType.int32]]("Quick sort", 300_000, 2_000_000_000)
    benchmark[DType.int32, tim_sort[DType.int32]]("Tim sort", 300_000, 2_000_000_000)
    benchmark[DType.int32, radix_sort[DType.int32]]("Radix sort", 300_000, 2_000_000_000)
    benchmark[DType.int32, radix_sort11[DType.int32]]("Radix sort 11", 300_000, 2_000_000_000)

    benchmark[DType.float32, std_sort[DType.float32]]("Std sort", 5_000_000, 2_000_000_000)
    benchmark[DType.float32, quick_sort[DType.float32]]("Quick sort", 5_000_000, 2_000_000_000)
    benchmark[DType.float32, tim_sort[DType.float32]]("Tim sort", 5_000_000, 2_000_000_000)
    benchmark[DType.float32, radix_sort[DType.float32]]("Radix sort", 5_000_000, 2_000_000_000)
    benchmark[DType.float32, radix_sort11[DType.float32]]("Radix sort 11", 5_000_000, 2_000_000_000)

    benchmark[DType.uint64, std_sort[DType.uint64]]("Std sort", 3_000_000, 200_000_000_000)
    benchmark[DType.uint64, quick_sort[DType.uint64]]("Quick sort", 3_000_000, 200_000_000_000)
    benchmark[DType.uint64, tim_sort[DType.uint64]]("Tim sort", 3_000_000, 200_000_000_000)
    benchmark[DType.uint64, radix_sort[DType.uint64]]("Radix sort", 3_000_000, 200_000_000_000)
    benchmark[DType.uint64, radix_sort13[DType.uint64]]("Radix sort 13", 3_000_000, 200_000_000_000)

    benchmark[DType.int64, std_sort[DType.int64]]("Std sort", 3_000_000, 200_000_000_000)
    benchmark[DType.int64, quick_sort[DType.int64]]("Quick sort", 3_000_000, 200_000_000_000)
    benchmark[DType.int64, tim_sort[DType.int64]]("Tim sort", 3_000_000, 200_000_000_000)
    benchmark[DType.int64, radix_sort[DType.int64]]("Radix sort", 3_000_000, 200_000_000_000)
    benchmark[DType.int64, radix_sort13[DType.int64]]("Radix sort 13", 3_000_000, 200_000_000_000)

    benchmark[DType.float64, std_sort[DType.float64]]("Std sort", 3_000_000, 200_000_000_000)
    benchmark[DType.float64, quick_sort[DType.float64]]("Quick sort", 3_000_000, 200_000_000_000)
    benchmark[DType.float64, tim_sort[DType.float64]]("Tim sort", 3_000_000, 200_000_000_000)
    benchmark[DType.float64, radix_sort[DType.float64]]("Radix sort", 3_000_000, 200_000_000_000)
    benchmark[DType.float64, radix_sort13[DType.float64]]("Radix sort 13", 3_000_000, 200_000_000_000)
    benchmark[DType.float64, radix_sort16]("Radix sort 16", 3_000_000, 200_000_000_000)

    benchmark[DType.float64, std_sort[DType.float64]]("Std sort", 300, 200)
    benchmark[DType.float64, quick_sort[DType.float64]]("Quick sort", 300, 200)
    benchmark[DType.float64, tim_sort[DType.float64]]("Tim sort", 300, 200)
    benchmark[DType.float64, radix_sort[DType.float64]]("Radix sort", 300, 200)
    benchmark[DType.float64, radix_sort13[DType.float64]]("Radix sort 13", 300, 200)
    benchmark[DType.float64, radix_sort16]("Radix sort 16", 300, 200)


fn main2():
    for i in range(1000, 200_000, 1000):
        benchmark[DType.float32, radix_sort11[DType.float32]]("Radix sort 11", i, 2_000_000_000)
        benchmark[DType.float64, radix_sort13[DType.float64]]("Radix sort 13", i, 2_000_000_000)