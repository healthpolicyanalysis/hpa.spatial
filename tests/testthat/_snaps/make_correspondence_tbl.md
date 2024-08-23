# test mapping works for non-standard geographies

    Code
      df_sample
    Output
        sa3_code_2016          LHN_Name ratio
      1         30401 Metro South (Qld)  1.00
      2         30404 Metro North (Qld)  1.00
      3         30403 Metro South (Qld)  0.36
      4         30403 Metro North (Qld)  0.64
      5         30402 Metro North (Qld)  1.00

---

    Code
      x
    Output
      # A tibble: 5 x 3
        sa3_code_2016 LHN_Name          ratio
        <chr>         <chr>             <dbl>
      1 30401         Metro South (Qld)  1   
      2 30402         Metro North (Qld)  1   
      3 30403         Metro North (Qld)  0.64
      4 30403         Metro South (Qld)  0.36
      5 30404         Metro North (Qld)  1   

