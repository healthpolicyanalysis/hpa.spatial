# can get CG from absmapsdata

    Code
      df_sample
    Output
          sa2_maincode_2011 sa2_maincode_2016 ratio
      1           801051061         801051061  1.00
      2           304031095         304031095  1.00
      3           302021027         302021027  1.00
      4           306041165         306041165  1.00
      5           203021042         203021042  1.00
      6           509011231         509011231  1.00
      7           303051074         303051074  1.00
      8           309011229         309011229  1.00
      9           508041208         510011265  1.00
      10          117031338         117031338  1.00
      11          318021487         318021491  0.00
      12          108031161         108031161  1.00
      13          504011044         504011044  1.00
      14          211051283         211051283  1.00
      15          201021010         201021010  1.00
      16          308031209         308031209  1.00
      17          212041311         212041311  1.00
      18          214011370         214011370  1.00
      19          507011151         507011151  1.00
      20          202021029         202021029  1.00
      21          316011415         316011415  1.00
      22          210051249         210051246  0.04
      23          112031252         112031252  1.00
      24          309031240         309031240  1.00
      25          124011452         124011452  1.00
      26          309011224         309011224  1.00
      27          801091109         801091109  1.00
      28          114021287         114021287  1.00
      29          801051055         801051055  1.00
      30          308031218         308031218  1.00
      31          210011231         210011231  1.00
      32          213041358         213041358  1.00
      33          603031074         603031074  1.00
      34          309091266         309091541  0.56
      35          701021024         701021024  1.00
      36          316011414         316011414  1.00
      37          702011053         702011053  1.00
      38          206051132         206051132  1.00
      39          212051323         212051323  1.00
      40          203011034         203011034  1.00
      41          112031255         112031550  0.58
      42          106041129         106041129  1.00
      43          310031289         310031289  1.00
      44          215021398         215021398  1.00
      45          118021352         118021570  0.42
      46          215011388         215011388  1.00
      47          503011035         503011035  1.00
      48          204011058         204011058  1.00
      49          508061223         510031273  1.00
      50          125031481         125031481  1.00
      51          102011033         102011033  1.00
      52          801071079         801071079  1.00
      53          105031102         105031102  1.00
      54          901021002         901021002  1.00
      55          602011039         602011039  1.00
      56          309061250         309061250  1.00
      57          401051019         401051019  1.00
      58          103031075         103031075  1.00
      59          405041124         405041124  1.00
      60          314021390         314021390  1.00
      61          101031016         101031016  1.00
      62          310011275         310011275  1.00
      63          309061248         309041241  0.00
      64          213051364         213051464  0.20
      65          104011081         104011081  1.00
      66          505011083         505011083  1.00
      67          504011046         504011046  1.00
      68          212021296         212021454  0.53
      69          116011308         116011308  1.00
      70          319021503         319021503  1.00
      71          801041042         801041117  0.06
      72          107041146         107041146  1.00
      73          317011457         317011457  1.00
      74          105031099         105031099  1.00
      75          214011372         214011372  1.00
      76          801041042         801041120  0.50
      77          104021090         104021090  1.00
      78          301021010         301021527  0.97
      79          801041034         801041034  1.00
      80          206041125         206041125  1.00
      81          404031105         404031105  1.00
      82          509021242         509021242  1.00
      83          308031211         308031211  1.00
      84          319011501         319011501  1.00
      85          501031018         501031018  1.00
      86          121011402         121011402  1.00
      87          303021059         303021059  1.00
      88          128021533         128021533  1.00
      89          213011329         213011329  1.00
      90          315031412         315031412  1.00
      91          304011083         304011083  1.00
      92          403031065         403031065  1.00
      93          504031064         504031064  1.00
      94          115011295         115011559  0.78
      95          123031445         123031445  1.00
      96          317011445         317011445  1.00
      97          509011225         509011225  1.00
      98          207031163         207031163  1.00
      99          503011030         503011030  1.00
      100         307021181         307021181  1.00

---

    Code
      x
    Output
      # A tibble: 2,426 x 3
         sa2_maincode_2011 sa2_maincode_2016 ratio
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

# can get CG using input polygons rather than areas/years and using a custom CG

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

