# test mapping is similar to published correspondence tables

    Code
      tbl_test
    Output
      # A tibble: 555 x 3
      # Groups:   sa2_code_2016 [528]
         sa2_code_2016 sa2_code_2021 ratio
         <chr>         <chr>         <dbl>
       1 301011001     301011001         1
       2 301011002     301011002         1
       3 301011003     301011003         1
       4 301011004     301011004         1
       5 301011005     301011005         1
       6 301011006     301011006         1
       7 301021007     301021007         1
       8 301021008     301021008         1
       9 301021009     301021009         1
      10 301021011     301021011         1
      # i 545 more rows

---

    Code
      sa2_to_lhn_tbl
    Output
      # A tibble: 2,521 x 3
      # Groups:   sa2_code_2021 [2,454]
         sa2_code_2021 LHN_Name     ratio
         <chr>         <chr>        <dbl>
       1 101021007     Southern NSW     1
       2 101021008     Southern NSW     1
       3 101021009     Southern NSW     1
       4 101021010     Southern NSW     1
       5 101021012     Southern NSW     1
       6 101021610     Southern NSW     1
       7 101021611     Southern NSW     1
       8 101031013     Southern NSW     1
       9 101031014     Southern NSW     1
      10 101031015     Southern NSW     1
      # i 2,511 more rows

