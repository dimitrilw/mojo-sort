from benchmark import run
from hash_utils import corpus1, corpus2, corpus3, corpus4, corpus5, corpus6, corpus7
from insertion_sort import insertion_sort
from string_compare import lt, lt2, lt3
from multi_key_quicksort import multi_key_quicksort
from quick_sort import quick_sort

fn in_sort[get_corpus: fn () -> UnsafeFixedVector[StringLiteral], lt:fn (StringLiteral, StringLiteral) -> Bool]():
    var corpus = get_corpus()
    insertion_sort[StringLiteral, lt](corpus)

fn mk_sort[get_corpus: fn () -> UnsafeFixedVector[StringLiteral]]():
    var corpus = get_corpus()
    multi_key_quicksort(corpus)

fn qk_sort[get_corpus: fn () -> UnsafeFixedVector[StringLiteral], lt:fn (StringLiteral, StringLiteral) -> Bool]():
    var corpus = get_corpus()
    quick_sort[StringLiteral, lt](corpus)



fn report_mean[f: fn()-> None](description: StringLiteral):
    let report1_mk = run[f]()
    print(description, report1_mk.mean["ns"]())

fn main():
    report_mean[in_sort[corpus1, lt]]("report1_i1")
    report_mean[in_sort[corpus1, lt2]]("report1_i2")
    report_mean[in_sort[corpus1, lt3]]("report1_i3")
    report_mean[qk_sort[corpus1, lt]]("report1_q1")
    report_mean[qk_sort[corpus1, lt2]]("report1_q2")
    report_mean[qk_sort[corpus1, lt3]]("report1_q3")
    report_mean[mk_sort[corpus1]]("report1_mk")

    report_mean[in_sort[corpus2, lt]]("report2_i1")
    report_mean[in_sort[corpus2, lt2]]("report2_i2")
    report_mean[in_sort[corpus2, lt3]]("report2_i3")
    report_mean[qk_sort[corpus2, lt]]("report2_q1")
    report_mean[qk_sort[corpus2, lt2]]("report2_q2")
    report_mean[qk_sort[corpus2, lt3]]("report2_q3")
    report_mean[mk_sort[corpus2]]("report2_mk")

    report_mean[in_sort[corpus3, lt]]("report3_i1")
    report_mean[in_sort[corpus3, lt2]]("report3_i2")
    report_mean[in_sort[corpus3, lt3]]("report3_i3")
    report_mean[qk_sort[corpus3, lt]]("report3_q1")
    report_mean[qk_sort[corpus3, lt2]]("report3_q2")
    report_mean[qk_sort[corpus3, lt3]]("report3_q3")
    report_mean[mk_sort[corpus3]]("report3_mk")

    report_mean[in_sort[corpus4, lt]]("report4_i1")
    report_mean[in_sort[corpus4, lt2]]("report4_i2")
    report_mean[in_sort[corpus4, lt3]]("report4_i3")
    report_mean[qk_sort[corpus4, lt]]("report4_q1")
    report_mean[qk_sort[corpus4, lt2]]("report4_q2")
    report_mean[qk_sort[corpus4, lt3]]("report4_q3")
    report_mean[mk_sort[corpus4]]("report4_mk")
    
    report_mean[in_sort[corpus5, lt]]("report5_i1")
    report_mean[in_sort[corpus5, lt2]]("report5_i2")
    report_mean[in_sort[corpus5, lt3]]("report5_i3")
    report_mean[qk_sort[corpus5, lt]]("report5_q1")
    report_mean[qk_sort[corpus5, lt2]]("report5_q2")
    report_mean[qk_sort[corpus5, lt3]]("report5_q3")
    report_mean[mk_sort[corpus5]]("report5_mk")

    report_mean[in_sort[corpus6, lt]]("report6_i1")
    report_mean[in_sort[corpus6, lt2]]("report6_i2")
    report_mean[in_sort[corpus6, lt3]]("report6_i3")
    report_mean[qk_sort[corpus6, lt]]("report6_q1")
    report_mean[qk_sort[corpus6, lt2]]("report6_q2")
    report_mean[qk_sort[corpus6, lt3]]("report6_q3")
    report_mean[mk_sort[corpus6]]("report6_mk")

    report_mean[in_sort[corpus7, lt]]("report7_i1")
    report_mean[in_sort[corpus7, lt2]]("report7_i2")
    report_mean[in_sort[corpus7, lt3]]("report7_i3")
    report_mean[qk_sort[corpus7, lt]]("report7_q1")
    report_mean[qk_sort[corpus7, lt2]]("report7_q2")
    report_mean[qk_sort[corpus7, lt3]]("report7_q3")
    report_mean[mk_sort[corpus7]]("report7_mk")
