# mapping across SAs and editions together works

    Code
      sa2_to_sa3_2011_to_2016_mapped_unit_ref_col
    Output
      # A tibble: 200 x 2
         sa3_code_2016  values
         <chr>           <dbl>
       1 10103          0.349 
       2 10104          1.63  
       3 10105          0.0885
       4 10201          1.24  
       5 10202         -1.64  
       6 10302          1.45  
       7 10304         -0.691 
       8 10304         -0.276 
       9 10401         -1.11  
      10 10402          0.134 
      # i 190 more rows

---

    Code
      sa2_to_sa3_2011_to_2016_mapped_unit
    Output
      # A tibble: 200 x 2
         sa3_code_2016  values
         <chr>           <dbl>
       1 10102          1.73  
       2 10104          0.456 
       3 10202         -0.570 
       4 10501         -1.11  
       5 10502          0.905 
       6 10503          0.328 
       7 10601          1.08  
       8 10602         -0.0603
       9 10604         -0.244 
      10 10604          2.24  
      # i 190 more rows

---

    Code
      sa2_to_sa3_2011_to_2016_mapped_aggs
    Output
      # A tibble: 147 x 2
         sa3_code_2016  values
         <chr>           <dbl>
       1 10104         -0.238 
       2 10106          0.950 
       3 10202         -1.49  
       4 10303          1.35  
       5 10401         -0.154 
       6 10402          0.119 
       7 10503         -0.0717
       8 10601          2.69  
       9 10602          1.83  
      10 10603         -0.512 
      # i 137 more rows

