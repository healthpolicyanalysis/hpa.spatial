# can get CG from absmapsdata

    Code
      tbl
    Output
      # A tibble: 2,426 x 3
         SA2_MAINCODE_2011 SA2_MAINCODE_2016 ratio
         <chr>             <chr>             <dbl>
       1 101011001         101051539             1
       2 101011002         101051540             1
       3 101011003         101061541             1
       4 101011004         101061542             1
       5 101011005         101061543             1
       6 101011006         101061544             1
       7 101021007         101021007             1
       8 101021008         101021008             1
       9 101021009         101021009             1
      10 101021010         101021010             1
      # i 2,416 more rows

# can get CG via make_correspondence_tbl() and retrieve faster a second time

    Code
      res$tbl
    Output
      # A tibble: 2,238 x 3
      # Groups:   sa2_code_2011 [2,165]
         sa2_code_2011 LHN_Name                ratio
         <chr>         <chr>                   <dbl>
       1 101011001     Southern NSW         1       
       2 101011002     South Western Sydney 0.000436
       3 101011002     Southern NSW         1.00    
       4 101011003     Southern NSW         1       
       5 101011004     Murrumbidgee         0.0447  
       6 101011004     Southern NSW         0.955   
       7 101011005     Murrumbidgee         1       
       8 101011006     Murrumbidgee         1       
       9 101021007     Southern NSW         1       
      10 101021008     Southern NSW         1       
      # i 2,228 more rows

