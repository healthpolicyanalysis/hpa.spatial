# grouping works

    Code
      sa2_to_sa3_2011_mapped_grped_aggs
    Output
      # A tibble: 200 x 3
         sa3_code_2011  values grp  
         <chr>           <dbl> <chr>
       1 10104         -0.193  A    
       2 10202          0.775  A    
       3 10402         -0.268  A    
       4 10701          1.70   A    
       5 10801         -1.15   A    
       6 10805         -0.111  A    
       7 11001          0.0126 A    
       8 11003         -0.324  A    
       9 11103         -1.36   A    
      10 11303         -2.29   A    
      # i 190 more rows

# aggregating up SA's works

    Code
      sa2_to_sa3_2011_mapped_unit
    Output
      # A tibble: 200 x 2
         sa3_code_2011 values
         <chr>          <dbl>
       1 10101          0.896
       2 10103         -0.230
       3 10104          0.837
       4 10201         -1.75 
       5 10202          1.69 
       6 10302          0.865
       7 10304         -0.151
       8 10304         -1.45 
       9 10401          0.643
      10 10402          0.483
      # i 190 more rows

---

    Code
      sa2_to_sa3_2011_mapped_aggs
    Output
      # A tibble: 150 x 2
         sa3_code_2011 values
         <chr>          <dbl>
       1 10102         -1.69 
       2 10104         -1.77 
       3 10201         -1.19 
       4 10202          0.447
       5 10301         -1.45 
       6 10302          0.363
       7 10303         -0.275
       8 10304          1.14 
       9 10701         -0.365
      10 10704          0.658
      # i 140 more rows

# mapping across SAs and editions together works

    Code
      sa2_to_sa3_2011_to_2016_mapped_unit_ref_col
    Output
      # A tibble: 200 x 2
         sa3_code_2016 values
         <chr>          <dbl>
       1 10103          0.896
       2 10104         -0.230
       3 10105          0.837
       4 10201         -1.75 
       5 10202          1.69 
       6 10302          0.865
       7 10304         -0.151
       8 10304         -1.45 
       9 10401          0.643
      10 10402          0.483
      # i 190 more rows

---

    Code
      sa2_to_sa3_2011_to_2016_mapped_unit
    Output
      # A tibble: 200 x 2
         sa3_code_2016 values
         <chr>          <dbl>
       1 10102          0.896
       2 10104         -0.230
       3 10104          0.837
       4 10201         -1.75 
       5 10201          1.69 
       6 10201          0.865
       7 10202         -0.151
       8 10301         -1.45 
       9 10302          0.643
      10 10303          0.483
      # i 190 more rows

---

    Code
      sa2_to_sa3_2011_to_2016_mapped_aggs
    Output
      # A tibble: 154 x 2
         sa3_code_2016  values
         <chr>           <dbl>
       1 10102          0.760 
       2 10104         -1.50  
       3 10201         -5.24  
       4 10202         -0.942 
       5 10301         -1.10  
       6 10302         -0.0579
       7 10303         -1.63  
       8 10304         -1.09  
       9 10701          0.724 
      10 10704         -1.39  
      # i 144 more rows

# mapping data works

    Code
      sa2_2016_mapped_unit
    Output
      # A tibble: 2,214 x 2
         SA2_MAINCODE_2016  values
         <chr>               <dbl>
       1 101051539          1.37  
       2 101051540         -0.565 
       3 101061541          0.363 
       4 101061542          0.633 
       5 101061543          0.404 
       6 101061544         -0.106 
       7 101021007          1.51  
       8 101021008         -0.0947
       9 101021009          2.02  
      10 101021010         -0.0627
      # i 2,204 more rows

---

    Code
      sa2_2016_mapped_aggs
    Output
      # A tibble: 2,303 x 2
         SA2_MAINCODE_2016 values
         <chr>              <dbl>
       1 101021007             14
       2 101021008             22
       3 101021009             14
       4 101021010             20
       5 101021011             23
       6 101021012              9
       7 101031013             20
       8 101031014             18
       9 101031015             18
      10 101031016             16
      # i 2,293 more rows

---

    # A tibble: 5 x 2
      SA2_MAINCODE_2016 values
      <chr>              <dbl>
    1 107011545           4.82
    2 107011546           3.62
    3 107011547           1.57
    4 107041548           4.49
    5 107041549           5.51

---

    # A tibble: 5 x 2
      SA2_MAINCODE_2016 values
      <chr>              <dbl>
    1 107011545              5
    2 107011546              4
    3 107011547              2
    4 107041548              4
    5 107041549              6

