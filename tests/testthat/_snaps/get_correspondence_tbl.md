# can get CG from absmapsdata

    Code
      df_sample
    Output
          SA2_MAINCODE_2011 SA2_MAINCODE_2016     ratio
      1           801051061         801051061 1.0000000
      2           304031095         304031095 1.0000000
      3           302021027         302021027 0.9999998
      4           306041165         306041165 1.0000000
      5           203021042         203021042 1.0000000
      6           509011231         509011231 1.0000000
      7           303051074         303051074 0.9999915
      8           309011229         309011229 1.0000000
      9           508041208         510011265 0.9999826
      10          117031338         117031338 1.0000000
      11          318021487         318021491 0.0001000
      12          108031161         108031161 1.0000000
      13          504011044         504011044 1.0000000
      14          211051283         211051283 1.0000000
      15          201021010         201021010 1.0000000
      16          308031209         308031209 1.0000000
      17          212041311         212041311 1.0000000
      18          214011370         214011370 1.0000000
      19          507011151         507011151 1.0000000
      20          202021029         202021029 1.0000000
      21          316011415         316011415 0.9999999
      22          210051249         210051246 0.0405963
      23          112031252         112031252 0.9998662
      24          309031240         309031240 1.0000000
      25          124011452         124011452 1.0000000
      26          309011224         309011224 0.9999999
      27          801091109         801091109 1.0000000
      28          114021287         114021287 1.0000000
      29          801051055         801051055 1.0000000
      30          308031218         308031218 1.0000000
      31          210011231         210011231 1.0000000
      32          213041358         213041358 1.0000000
      33          603031074         603031074 1.0000000
      34          309091266         309091541 0.5594004
      35          701021024         701021024 1.0000000
      36          316011414         316011414 1.0000000
      37          702011053         702011053 1.0000000
      38          206051132         206051132 1.0000000
      39          212051323         212051323 1.0000000
      40          203011034         203011034 1.0000000
      41          112031255         112031550 0.5775690
      42          106041129         106041129 1.0000000
      43          310031289         310031289 1.0000000
      44          215021398         215021398 1.0000000
      45          118021352         118021570 0.4177155
      46          215011388         215011388 1.0000000
      47          503011035         503011035 1.0000000
      48          204011058         204011058 1.0000000
      49          508061223         510031273 1.0000000
      50          125031481         125031481 1.0000000
      51          102011033         102011033 1.0000000
      52          801071079         801071079 1.0000000
      53          105031102         105031102 1.0000000
      54          901021002         901021002 1.0000000
      55          602011039         602011039 1.0000000
      56          309061250         309061250 0.9983246
      57          401051019         401051019 1.0000000
      58          103031075         103031075 1.0000000
      59          405041124         405041124 1.0000000
      60          314021390         314021390 1.0000000
      61          101031016         101031016 1.0000000
      62          310011275         310011275 1.0000000
      63          309061248         309041241 0.0001115
      64          213051364         213051464 0.1996861
      65          104011081         104011081 1.0000000
      66          505011083         505011083 1.0000000
      67          504011046         504011046 1.0000000
      68          212021296         212021454 0.5327243
      69          116011308         116011308 1.0000000
      70          319021503         319021503 0.9998116
      71          801041042         801041117 0.0555556
      72          107041146         107041146 1.0000000
      73          317011457         317011457 1.0000000
      74          105031099         105031099 1.0000000
      75          214011372         214011372 1.0000000
      76          801041042         801041120 0.5000000
      77          104021090         104021090 1.0000000
      78          301021010         301021527 0.9658210
      79          801041034         801041034 1.0000000
      80          206041125         206041125 1.0000000
      81          404031105         404031105 1.0000000
      82          509021242         509021242 1.0000000
      83          308031211         308031211 1.0000000
      84          319011501         319011501 1.0000000
      85          501031018         501031018 1.0000000
      86          121011402         121011402 1.0000000
      87          303021059         303021059 0.9999999
      88          128021533         128021533 1.0000000
      89          213011329         213011329 1.0000000
      90          315031412         315031412 1.0000000
      91          304011083         304011083 1.0000000
      92          403031065         403031065 1.0000000
      93          504031064         504031064 1.0000000
      94          115011295         115011559 0.7834300
      95          123031445         123031445 1.0000000
      96          317011445         317011445 1.0000000
      97          509011225         509011225 1.0000000
      98          207031163         207031163 1.0000000
      99          503011030         503011030 1.0000000
      100         307021181         307021181 0.9996948

---

    Code
      x
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

# can get a custom CG via make_correspondence_tbl()

    Code
      df_sample
    Output
           sa2_code_2011                            LHN_Name        ratio
      1        101011001                        Southern NSW 1.0000000000
      2        101011002                South Western Sydney 0.0004360782
      3        101011002                        Southern NSW 0.9995639218
      4        101011003                        Southern NSW 1.0000000000
      5        101011004                        Southern NSW 0.9553085836
      6        101011004                        Murrumbidgee 0.0446914164
      7        101011005                        Murrumbidgee 1.0000000000
      8        101011006                        Murrumbidgee 1.0000000000
      9        101021007                        Southern NSW 1.0000000000
      10       101021008                        Southern NSW 1.0000000000
      11       101021009                        Southern NSW 1.0000000000
      12       101021010                        Southern NSW 1.0000000000
      13       101021011                        Southern NSW 1.0000000000
      14       101021012                        Southern NSW 1.0000000000
      15       101031013                        Southern NSW 1.0000000000
      16       101031014                        Southern NSW 1.0000000000
      17       101031015                        Southern NSW 1.0000000000
      18       101031016                        Southern NSW 1.0000000000
      19       101041017                        Southern NSW 1.0000000000
      20       101041018                        Southern NSW 1.0000000000
      21       101041019                        Southern NSW 1.0000000000
      22       101041020                        Southern NSW 1.0000000000
      23       101041021                        Southern NSW 1.0000000000
      24       101041022                        Southern NSW 1.0000000000
      25       101041023                        Southern NSW 1.0000000000
      26       101041024                        Southern NSW 0.9436058103
      27       101041024                Illawarra Shoalhaven 0.0563941897
      28       101041025                        Southern NSW 1.0000000000
      29       101041026                        Southern NSW 1.0000000000
      30       101041027                        Southern NSW 1.0000000000
      31       102011028                 Central Coast (NSW) 1.0000000000
      32       102011029                 Central Coast (NSW) 1.0000000000
      33       102011030                 Central Coast (NSW) 1.0000000000
      34       102011031                 Central Coast (NSW) 1.0000000000
      35       102011032                 Central Coast (NSW) 1.0000000000
      36       102011033                 Central Coast (NSW) 1.0000000000
      37       102011034                 Central Coast (NSW) 1.0000000000
      38       102011035                 Central Coast (NSW) 1.0000000000
      39       102011036                 Central Coast (NSW) 1.0000000000
      40       102011037                 Central Coast (NSW) 1.0000000000
      41       102011038                 Central Coast (NSW) 1.0000000000
      42       102011039                 Central Coast (NSW) 1.0000000000
      43       102011040                 Central Coast (NSW) 1.0000000000
      44       102011041                 Central Coast (NSW) 1.0000000000
      45       102011042                 Central Coast (NSW) 1.0000000000
      46       102011043                 Central Coast (NSW) 1.0000000000
      47       102021044                 Central Coast (NSW) 1.0000000000
      48       102021045                 Central Coast (NSW) 1.0000000000
      49       102021046                 Central Coast (NSW) 1.0000000000
      50       102021047                 Central Coast (NSW) 1.0000000000
      51       102021048                 Central Coast (NSW) 1.0000000000
      52       102021049                 Central Coast (NSW) 1.0000000000
      53       102021050                 Central Coast (NSW) 1.0000000000
      54       102021051                 Central Coast (NSW) 1.0000000000
      55       102021052                 Central Coast (NSW) 1.0000000000
      56       102021053                 Central Coast (NSW) 1.0000000000
      57       102021054                 Central Coast (NSW) 1.0000000000
      58       102021055                 Central Coast (NSW) 1.0000000000
      59       102021056                 Central Coast (NSW) 1.0000000000
      60       102021057                 Central Coast (NSW) 1.0000000000
      61       103011058                         Western NSW 1.0000000000
      62       103011059                         Western NSW 1.0000000000
      63       103011060                         Western NSW 0.9985521934
      64       103011060               Nepean Blue Mountains 0.0014478066
      65       103011061                         Western NSW 1.0000000000
      66       103021062                         Western NSW 0.7189307488
      67       103021062                        Murrumbidgee 0.2810692512
      68       103021063                         Western NSW 1.0000000000
      69       103021064                         Western NSW 1.0000000000
      70       103021065                         Western NSW 1.0000000000
      71       103021066                         Western NSW 1.0000000000
      72       103021067                         Western NSW 1.0000000000
      73       103021068                         Western NSW 1.0000000000
      74       103021069                        Murrumbidgee 1.0000000000
      75       103031070               Nepean Blue Mountains 1.0000000000
      76       103031071                         Western NSW 0.0003562945
      77       103031071               Nepean Blue Mountains 0.9996437055
      78       103031072                         Western NSW 1.0000000000
      79       103031073               Nepean Blue Mountains 0.0011802892
      80       103031073                         Western NSW 0.9988197108
      81       103031074                         Western NSW 0.9997284331
      82       103031074                  Hunter New England 0.0002715669
      83       103031075               Nepean Blue Mountains 0.9500000000
      84       103031075                  Hunter New England 0.0500000000
      85       103041076                         Western NSW 1.0000000000
      86       103041077                         Western NSW 1.0000000000
      87       103041078                         Western NSW 1.0000000000
      88       103041079                         Western NSW 1.0000000000
      89       104011080                        Northern NSW 1.0000000000
      90       104011081                        Northern NSW 1.0000000000
      91       104011082                        Northern NSW 1.0000000000
      92       104021083               Mid North Coast (NSW) 1.0000000000
      93       104021084               Mid North Coast (NSW) 1.0000000000
      94       104021085               Mid North Coast (NSW) 1.0000000000
      95       104021086               Mid North Coast (NSW) 1.0000000000
      96       104021087                        Northern NSW 0.1376856436
      97       104021087               Mid North Coast (NSW) 0.8623143564
      98       104021088               Mid North Coast (NSW) 1.0000000000
      99       104021089               Mid North Coast (NSW) 1.0000000000
      100      104021090               Mid North Coast (NSW) 1.0000000000
      101      104021091               Mid North Coast (NSW) 1.0000000000
      102      105011092                         Western NSW 1.0000000000
      103      105011093                         Western NSW 1.0000000000
      104      105011094                         Western NSW 1.0000000000
      105      105011095                         Western NSW 1.0000000000
      106      105011096                         Western NSW 1.0000000000
      107      105021097                        Far West NSW 1.0000000000
      108      105021098                        Far West NSW 1.0000000000
      109      105031099                         Western NSW 1.0000000000
      110      105031100                         Western NSW 1.0000000000
      111      105031101                         Western NSW 1.0000000000
      112      105031102                         Western NSW 1.0000000000
      113      105031103                         Western NSW 1.0000000000
      114      105031104                         Western NSW 1.0000000000
      115      105031105                         Western NSW 1.0000000000
      116      105031106                         Western NSW 1.0000000000
      117      106011107                  Hunter New England 1.0000000000
      118      106011108                  Hunter New England 1.0000000000
      119      106011109                  Hunter New England 1.0000000000
      120      106011110                  Hunter New England 1.0000000000
      121      106011111                  Hunter New England 1.0000000000
      122      106011112                  Hunter New England 1.0000000000
      123      106011113                  Hunter New England 1.0000000000
      124      106021114                  Hunter New England 1.0000000000
      125      106021115                  Hunter New England 1.0000000000
      126      106021116                  Hunter New England 1.0000000000
      127      106021117                  Hunter New England 1.0000000000
      128      106021118                  Hunter New England 1.0000000000
      129      106031119                  Hunter New England 1.0000000000
      130      106031120                  Hunter New England 1.0000000000
      131      106031121                  Hunter New England 1.0000000000
      132      106031122                  Hunter New England 1.0000000000
      133      106031123                  Hunter New England 1.0000000000
      134      106031124                  Hunter New England 1.0000000000
      135      106031125                  Hunter New England 1.0000000000
      136      106041126                  Hunter New England 1.0000000000
      137      106041127                  Hunter New England 1.0000000000
      138      106041128                  Hunter New England 1.0000000000
      139      106041129                  Hunter New England 1.0000000000
      140      107011130                Illawarra Shoalhaven 1.0000000000
      141      107011131                Illawarra Shoalhaven 1.0000000000
      142      107011132                Illawarra Shoalhaven 1.0000000000
      143      107011133                Illawarra Shoalhaven 1.0000000000
      144      107011134                Illawarra Shoalhaven 1.0000000000
      145      107021135                Illawarra Shoalhaven 0.5000000000
      146      107021135                South Western Sydney 0.5000000000
      147      107031136                Illawarra Shoalhaven 1.0000000000
      148      107031137                Illawarra Shoalhaven 1.0000000000
      149      107031138                Illawarra Shoalhaven 1.0000000000
      150      107031139                Illawarra Shoalhaven 1.0000000000
      151      107031140                Illawarra Shoalhaven 1.0000000000
      152      107031141                Illawarra Shoalhaven 1.0000000000
      153      107031142                Illawarra Shoalhaven 1.0000000000
      154      107031143                Illawarra Shoalhaven 1.0000000000
      155      107041144                Illawarra Shoalhaven 1.0000000000
      156      107041145                Illawarra Shoalhaven 1.0000000000
      157      107041146                Illawarra Shoalhaven 1.0000000000
      158      107041147                Illawarra Shoalhaven 0.9981345331
      159      107041147                South Western Sydney 0.0018654669
      160      107041148                Illawarra Shoalhaven 1.0000000000
      161      107041149                Illawarra Shoalhaven 1.0000000000
      162      107041150                Illawarra Shoalhaven 1.0000000000
      163      108011151                  Hunter New England 1.0000000000
      164      108011152                  Hunter New England 1.0000000000
      165      108011153                  Hunter New England 1.0000000000
      166      108011154                  Hunter New England 1.0000000000
      167      108021155               Mid North Coast (NSW) 1.0000000000
      168      108021156                  Hunter New England 0.0065380154
      169      108021156               Mid North Coast (NSW) 0.9934619846
      170      108021157               Mid North Coast (NSW) 1.0000000000
      171      108021158               Mid North Coast (NSW) 1.0000000000
      172      108021159               Mid North Coast (NSW) 1.0000000000
      173      108021160               Mid North Coast (NSW) 1.0000000000
      174      108031161                South Eastern Sydney 1.0000000000
      175      108041162               Mid North Coast (NSW) 1.0000000000
      176      108041163               Mid North Coast (NSW) 1.0000000000
      177      108041164               Mid North Coast (NSW) 1.0000000000
      178      108041165               Mid North Coast (NSW) 0.9970048671
      179      108041165                  Hunter New England 0.0029951329
      180      108041166               Mid North Coast (NSW) 1.0000000000
      181      108051167                  Hunter New England 1.0000000000
      182      108051168                  Hunter New England 1.0000000000
      183      108051169                  Hunter New England 1.0000000000
      184      108051170                  Hunter New England 1.0000000000
      185      108051171                  Hunter New England 1.0000000000
      186      109011172                        Murrumbidgee 1.0000000000
      187      109011173                        Murrumbidgee 1.0000000000
      188      109011174                        Murrumbidgee 1.0000000000
      189      109011175                        Murrumbidgee 1.0000000000
      190      109011176                        Murrumbidgee 1.0000000000
      191      109021177                        Murrumbidgee 1.0000000000
      192      109021178                        Far West NSW 1.0000000000
      193      109021179                        Murrumbidgee 0.1381668947
      194      109021179                        Far West NSW 0.8618331053
      195      109031180                        Murrumbidgee 1.0000000000
      196      109031181                        Murrumbidgee 1.0000000000
      197      109031182                        Murrumbidgee 1.0000000000
      198      109031183                        Murrumbidgee 1.0000000000
      199      109031184                        Murrumbidgee 1.0000000000
      200      109031185                        Murrumbidgee 1.0000000000
      201      110011186                  Hunter New England 1.0000000000
      202      110011187                  Hunter New England 1.0000000000
      203      110011188                  Hunter New England 1.0000000000
      204      110011189                  Hunter New England 1.0000000000
      205      110021190                  Hunter New England 1.0000000000
      206      110021191                  Hunter New England 1.0000000000
      207      110021192                  Hunter New England 1.0000000000
      208      110021193                  Hunter New England 1.0000000000
      209      110021194                        Northern NSW 0.0689604685
      210      110021194                  Hunter New England 0.9310395315
      211      110031195                  Hunter New England 1.0000000000
      212      110031196                  Hunter New England 1.0000000000
      213      110031197                  Hunter New England 1.0000000000
      214      110031198                  Hunter New England 1.0000000000
      215      110041199                  Hunter New England 1.0000000000
      216      110041200                  Hunter New England 1.0000000000
      217      110041201                  Hunter New England 1.0000000000
      218      110041202                  Hunter New England 1.0000000000
      219      110041203                  Hunter New England 1.0000000000
      220      110041204                  Hunter New England 1.0000000000
      221      110041205                  Hunter New England 1.0000000000
      222      111011206                  Hunter New England 1.0000000000
      223      111011207                  Hunter New England 1.0000000000
      224      111011208                  Hunter New England 1.0000000000
      225      111011209                  Hunter New England 1.0000000000
      226      111011210                  Hunter New England 1.0000000000
      227      111011211                  Hunter New England 1.0000000000
      228      111011212                  Hunter New England 0.9382932865
      229      111011212                 Central Coast (NSW) 0.0617067135
      230      111011213                  Hunter New England 1.0000000000
      231      111011214                  Hunter New England 1.0000000000
      232      111021215                  Hunter New England 1.0000000000
      233      111021216                  Hunter New England 1.0000000000
      234      111021217                  Hunter New England 1.0000000000
      235      111021218                  Hunter New England 1.0000000000
      236      111021219                  Hunter New England 1.0000000000
      237      111021220                  Hunter New England 1.0000000000
      238      111021221                  Hunter New England 1.0000000000
      239      111031222                  Hunter New England 1.0000000000
      240      111031223                  Hunter New England 1.0000000000
      241      111031224                  Hunter New England 1.0000000000
      242      111031225                  Hunter New England 1.0000000000
      243      111031226                  Hunter New England 1.0000000000
      244      111031227                  Hunter New England 1.0000000000
      245      111031228                  Hunter New England 1.0000000000
      246      111031229                  Hunter New England 1.0000000000
      247      111031230                  Hunter New England 1.0000000000
      248      111031231                  Hunter New England 1.0000000000
      249      111031232                  Hunter New England 1.0000000000
      250      111031233                  Hunter New England 1.0000000000
      251      111031234                  Hunter New England 1.0000000000
      252      111031235                  Hunter New England 1.0000000000
      253      112011236                        Northern NSW 1.0000000000
      254      112011237                        Northern NSW 1.0000000000
      255      112011238                        Northern NSW 1.0000000000
      256      112011239                        Northern NSW 1.0000000000
      257      112011240                        Northern NSW 1.0000000000
      258      112011241                        Northern NSW 1.0000000000
      259      112011242                        Northern NSW 1.0000000000
      260      112011243                        Northern NSW 1.0000000000
      261      112021244                        Northern NSW 1.0000000000
      262      112021245                        Northern NSW 1.0000000000
      263      112021246                        Northern NSW 1.0000000000
      264      112021247                        Northern NSW 1.0000000000
      265      112021248                        Northern NSW 1.0000000000
      266      112021249                        Northern NSW 1.0000000000
      267      112031250                        Northern NSW 1.0000000000
      268      112031251                        Northern NSW 1.0000000000
      269      112031252                        Northern NSW 1.0000000000
      270      112031253                        Northern NSW 1.0000000000
      271      112031254                        Northern NSW 1.0000000000
      272      112031255                        Northern NSW 1.0000000000
      273      113011256                        Murrumbidgee 1.0000000000
      274      113011257                        Murrumbidgee 1.0000000000
      275      113011258                        Murrumbidgee 1.0000000000
      276      113011259                        Murrumbidgee 1.0000000000
      277      113021260                        Murrumbidgee 1.0000000000
      278      113021261                        Murrumbidgee 1.0000000000
      279      113021262                        Murrumbidgee 1.0000000000
      280      113031263                        Murrumbidgee 1.0000000000
      281      113031264                        Murrumbidgee 1.0000000000
      282      113031265                        Murrumbidgee 1.0000000000
      283      113031266                        Murrumbidgee 1.0000000000
      284      113031267                        Murrumbidgee 1.0000000000
      285      113031268                        Murrumbidgee 1.0000000000
      286      113031269                        Murrumbidgee 1.0000000000
      287      113031270                        Murrumbidgee 1.0000000000
      288      113031271                        Murrumbidgee 1.0000000000
      289      114011272                Illawarra Shoalhaven 0.9996845426
      290      114011272                South Western Sydney 0.0003154574
      291      114011273                Illawarra Shoalhaven 1.0000000000
      292      114011274                Illawarra Shoalhaven 1.0000000000
      293      114011275                Illawarra Shoalhaven 1.0000000000
      294      114011276                Illawarra Shoalhaven 1.0000000000
      295      114011277                Illawarra Shoalhaven 1.0000000000
      296      114011278                Illawarra Shoalhaven 1.0000000000
      297      114011279                Illawarra Shoalhaven 1.0000000000
      298      114011280                Illawarra Shoalhaven 1.0000000000
      299      114011281                Illawarra Shoalhaven 1.0000000000
      300      114011282                Illawarra Shoalhaven 1.0000000000
      301      114011283                Illawarra Shoalhaven 1.0000000000
      302      114021284                South Western Sydney 1.0000000000
      303      114021285                South Western Sydney 1.0000000000
      304      114021286                South Western Sydney 1.0000000000
      305      114021287                South Western Sydney 1.0000000000
      306      114021288                Illawarra Shoalhaven 0.0241621200
      307      114021288                South Western Sydney 0.9758378800
      308      114021289                South Western Sydney 1.0000000000
      309      115011290                      Western Sydney 1.0000000000
      310      115011291                      Western Sydney 1.0000000000
      311      115011292                      Western Sydney 1.0000000000
      312      115011293                     Northern Sydney 1.0000000000
      313      115011294                      Western Sydney 0.9406940063
      314      115011294                     Northern Sydney 0.0593059937
      315      115011295                      Western Sydney 1.0000000000
      316      115011296                      Western Sydney 1.0000000000
      317      115021297                      Western Sydney 0.6621476989
      318      115021297                     Northern Sydney 0.3356671423
      319      115021297               Nepean Blue Mountains 0.0021851588
      320      115021298                     Northern Sydney 1.0000000000
      321      115031299               Nepean Blue Mountains 1.0000000000
      322      115031300               Nepean Blue Mountains 1.0000000000
      323      115041301               Nepean Blue Mountains 0.9328231293
      324      115041301                      Western Sydney 0.0671768707
      325      115041302                      Western Sydney 1.0000000000
      326      116011303                      Western Sydney 1.0000000000
      327      116011304                      Western Sydney 1.0000000000
      328      116011305                      Western Sydney 1.0000000000
      329      116011306                      Western Sydney 1.0000000000
      330      116011307                      Western Sydney 1.0000000000
      331      116011308                      Western Sydney 1.0000000000
      332      116021309                      Western Sydney 1.0000000000
      333      116021310                      Western Sydney 1.0000000000
      334      116021311                      Western Sydney 1.0000000000
      335      116021312                      Western Sydney 1.0000000000
      336      116031313                      Western Sydney 1.0000000000
      337      116031314                      Western Sydney 1.0000000000
      338      116031315                      Western Sydney 1.0000000000
      339      116031316                      Western Sydney 1.0000000000
      340      116031317                      Western Sydney 1.0000000000
      341      116031318                      Western Sydney 1.0000000000
      342      116031319                      Western Sydney 1.0000000000
      343      117011320                South Eastern Sydney 1.0000000000
      344      117011321                South Eastern Sydney 1.0000000000
      345      117011322                South Eastern Sydney 1.0000000000
      346      117011323                South Eastern Sydney 1.0000000000
      347      117011324                South Eastern Sydney 1.0000000000
      348      117011325                South Eastern Sydney 1.0000000000
      349      117021326                              Sydney 1.0000000000
      350      117021327                              Sydney 1.0000000000
      351      117021328                              Sydney 1.0000000000
      352      117031329                South Eastern Sydney 1.0000000000
      353      117031330                              Sydney 1.0000000000
      354      117031331                              Sydney 1.0000000000
      355      117031332                              Sydney 1.0000000000
      356      117031333                South Eastern Sydney 1.0000000000
      357      117031334                South Eastern Sydney 0.0220650496
      358      117031334                              Sydney 0.9779349504
      359      117031335                              Sydney 1.0000000000
      360      117031336                South Eastern Sydney 0.9997531474
      361      117031336                              Sydney 0.0002468526
      362      117031337                South Eastern Sydney 0.9983622070
      363      117031337                              Sydney 0.0016377930
      364      117031338                              Sydney 1.0000000000
      365      118011339                South Eastern Sydney 1.0000000000
      366      118011340                South Eastern Sydney 1.0000000000
      367      118011341                South Eastern Sydney 1.0000000000
      368      118011342                South Eastern Sydney 1.0000000000
      369      118011343                South Eastern Sydney 1.0000000000
      370      118011344                South Eastern Sydney 1.0000000000
      371      118011345                South Eastern Sydney 1.0000000000
      372      118011346                South Eastern Sydney 1.0000000000
      373      118011347                South Eastern Sydney 1.0000000000
      374      118021348                South Eastern Sydney 1.0000000000
      375      118021349                South Eastern Sydney 1.0000000000
      376      118021350                South Eastern Sydney 1.0000000000
      377      118021351                South Eastern Sydney 1.0000000000
      378      118021352                South Eastern Sydney 1.0000000000
      379      119011353                South Western Sydney 1.0000000000
      380      119011354                South Western Sydney 1.0000000000
      381      119011355                              Sydney 0.0725652451
      382      119011355                South Western Sydney 0.9274347549
      383      119011356                South Western Sydney 1.0000000000
      384      119011357                South Western Sydney 0.9454454275
      385      119011357                              Sydney 0.0545545725
      386      119011358                South Western Sydney 1.0000000000
      387      119011359                South Western Sydney 1.0000000000
      388      119011360                South Western Sydney 1.0000000000
      389      119011361                South Western Sydney 1.0000000000
      390      119021362                              Sydney 1.0000000000
      391      119021363                              Sydney 1.0000000000
      392      119021364                              Sydney 1.0000000000
      393      119021365                              Sydney 1.0000000000
      394      119021366                              Sydney 0.6101074671
      395      119021366                South Western Sydney 0.3898925329
      396      119021367                              Sydney 1.0000000000
      397      119031368                South Eastern Sydney 1.0000000000
      398      119031369                South Eastern Sydney 1.0000000000
      399      119031370                South Eastern Sydney 0.7666496834
      400      119031370                              Sydney 0.2333503166
      401      119031371                South Eastern Sydney 1.0000000000
      402      119031372                South Eastern Sydney 1.0000000000
      403      119031373                              Sydney 0.5002510880
      404      119031373                South Eastern Sydney 0.4997489120
      405      119031374                South Eastern Sydney 1.0000000000
      406      119041375                South Eastern Sydney 1.0000000000
      407      119041376                South Eastern Sydney 1.0000000000
      408      119041377                South Eastern Sydney 1.0000000000
      409      119041378                South Eastern Sydney 1.0000000000
      410      119041379                South Eastern Sydney 1.0000000000
      411      119041380                South Eastern Sydney 1.0000000000
      412      119041381                South Eastern Sydney 1.0000000000
      413      119041382                South Eastern Sydney 1.0000000000
      414      120011383                              Sydney 1.0000000000
      415      120011384                              Sydney 1.0000000000
      416      120011385                              Sydney 1.0000000000
      417      120011386                              Sydney 1.0000000000
      418      120021387                              Sydney 1.0000000000
      419      120021388                              Sydney 1.0000000000
      420      120021389                              Sydney 1.0000000000
      421      120031390                              Sydney 1.0000000000
      422      120031391                              Sydney 1.0000000000
      423      120031392                              Sydney 1.0000000000
      424      120031393                              Sydney 1.0000000000
      425      120031394                              Sydney 1.0000000000
      426      120031395                              Sydney 1.0000000000
      427      120031396                              Sydney 1.0000000000
      428      120031397                              Sydney 1.0000000000
      429      121011398                     Northern Sydney 1.0000000000
      430      121011399                     Northern Sydney 1.0000000000
      431      121011400                     Northern Sydney 1.0000000000
      432      121011401                     Northern Sydney 1.0000000000
      433      121011402                     Northern Sydney 1.0000000000
      434      121021403                     Northern Sydney 1.0000000000
      435      121021404                     Northern Sydney 1.0000000000
      436      121021405                     Northern Sydney 1.0000000000
      437      121021406                     Northern Sydney 1.0000000000
      438      121031407                     Northern Sydney 1.0000000000
      439      121031408                     Northern Sydney 1.0000000000
      440      121031409                     Northern Sydney 1.0000000000
      441      121031410                     Northern Sydney 1.0000000000
      442      121031411                     Northern Sydney 1.0000000000
      443      121031412                     Northern Sydney 1.0000000000
      444      121041413                     Northern Sydney 1.0000000000
      445      121041414                     Northern Sydney 1.0000000000
      446      121041415                     Northern Sydney 1.0000000000
      447      121041416                     Northern Sydney 1.0000000000
      448      121041417                     Northern Sydney 1.0000000000
      449      122011418                     Northern Sydney 1.0000000000
      450      122011419                     Northern Sydney 1.0000000000
      451      122021420                     Northern Sydney 1.0000000000
      452      122021421                     Northern Sydney 1.0000000000
      453      122021422                     Northern Sydney 1.0000000000
      454      122021423                     Northern Sydney 1.0000000000
      455      122031424                     Northern Sydney 1.0000000000
      456      122031425                     Northern Sydney 1.0000000000
      457      122031426                     Northern Sydney 1.0000000000
      458      122031427                     Northern Sydney 1.0000000000
      459      122031428                     Northern Sydney 1.0000000000
      460      122031429                     Northern Sydney 1.0000000000
      461      122031430                     Northern Sydney 1.0000000000
      462      122031431                     Northern Sydney 1.0000000000
      463      122031432                     Northern Sydney 1.0000000000
      464      123011433                South Western Sydney 1.0000000000
      465      123011434                South Western Sydney 1.0000000000
      466      123011435                South Western Sydney 1.0000000000
      467      123021436                South Western Sydney 1.0000000000
      468      123021437                South Western Sydney 1.0000000000
      469      123021438                South Western Sydney 1.0000000000
      470      123021439                South Western Sydney 1.0000000000
      471      123021440                South Western Sydney 1.0000000000
      472      123021441                South Western Sydney 1.0000000000
      473      123021442                South Western Sydney 1.0000000000
      474      123021443                South Western Sydney 1.0000000000
      475      123021444                South Western Sydney 1.0000000000
      476      123031445                South Western Sydney 1.0000000000
      477      123031446                South Western Sydney 1.0000000000
      478      123031447                South Western Sydney 1.0000000000
      479      123031448                South Western Sydney 1.0000000000
      480      124011449               Nepean Blue Mountains 1.0000000000
      481      124011450               Nepean Blue Mountains 1.0000000000
      482      124011451               Nepean Blue Mountains 1.0000000000
      483      124011452               Nepean Blue Mountains 1.0000000000
      484      124011453               Nepean Blue Mountains 1.0000000000
      485      124011454               Nepean Blue Mountains 1.0000000000
      486      124011455               Nepean Blue Mountains 1.0000000000
      487      124021456                South Western Sydney 1.0000000000
      488      124031457               Nepean Blue Mountains 1.0000000000
      489      124031458               Nepean Blue Mountains 1.0000000000
      490      124031459               Nepean Blue Mountains 1.0000000000
      491      124031460               Nepean Blue Mountains 1.0000000000
      492      124031461               Nepean Blue Mountains 1.0000000000
      493      124031462               Nepean Blue Mountains 1.0000000000
      494      124031463               Nepean Blue Mountains 0.9322979859
      495      124031463                South Western Sydney 0.0677020141
      496      124031464               Nepean Blue Mountains 1.0000000000
      497      124031465                South Western Sydney 1.0000000000
      498      124041466               Nepean Blue Mountains 1.0000000000
      499      124041467               Nepean Blue Mountains 1.0000000000
      500      124041468               Nepean Blue Mountains 1.0000000000
      501      124051469               Nepean Blue Mountains 1.0000000000
      502      124051470               Nepean Blue Mountains 1.0000000000
      503      124051471               Nepean Blue Mountains 1.0000000000
      504      125011472                      Western Sydney 1.0000000000
      505      125011473                      Western Sydney 1.0000000000
      506      125011474                      Western Sydney 0.9779615902
      507      125011474                South Western Sydney 0.0220384098
      508      125011475                      Western Sydney 1.0000000000
      509      125021476                     Northern Sydney 0.2605126541
      510      125021476                      Western Sydney 0.7394873459
      511      125021477                      Western Sydney 1.0000000000
      512      125021478                      Western Sydney 1.0000000000
      513      125031479                South Western Sydney 1.0000000000
      514      125031480                South Western Sydney 0.9901015228
      515      125031480                      Western Sydney 0.0098984772
      516      125031481                      Western Sydney 1.0000000000
      517      125031482                      Western Sydney 1.0000000000
      518      125031483                      Western Sydney 1.0000000000
      519      125031484                      Western Sydney 1.0000000000
      520      125031485                      Western Sydney 1.0000000000
      521      125031486                      Western Sydney 1.0000000000
      522      125031487                      Western Sydney 1.0000000000
      523      125041488                      Western Sydney 1.0000000000
      524      125041489                      Western Sydney 1.0000000000
      525      125041490                      Western Sydney 1.0000000000
      526      125041491                      Western Sydney 1.0000000000
      527      125041492                      Western Sydney 1.0000000000
      528      125041493                      Western Sydney 1.0000000000
      529      125041494                      Western Sydney 1.0000000000
      530      126011495                     Northern Sydney 0.7139575651
      531      126011495                      Western Sydney 0.2860424349
      532      126011496                     Northern Sydney 1.0000000000
      533      126021497                      Western Sydney 0.1559473745
      534      126021497                     Northern Sydney 0.8440526255
      535      126021498                     Northern Sydney 1.0000000000
      536      126021499                     Northern Sydney 1.0000000000
      537      126021500                     Northern Sydney 1.0000000000
      538      126021501                     Northern Sydney 1.0000000000
      539      126021502                     Northern Sydney 1.0000000000
      540      126021503                     Northern Sydney 1.0000000000
      541      127011504                South Western Sydney 1.0000000000
      542      127011505                South Western Sydney 1.0000000000
      543      127011506                South Western Sydney 1.0000000000
      544      127011507                South Western Sydney 1.0000000000
      545      127011508                South Western Sydney 1.0000000000
      546      127021509                South Western Sydney 1.0000000000
      547      127021510                South Western Sydney 1.0000000000
      548      127021511                South Western Sydney 1.0000000000
      549      127021512                South Western Sydney 1.0000000000
      550      127021513                South Western Sydney 1.0000000000
      551      127021514                South Western Sydney 1.0000000000
      552      127021515                South Western Sydney 1.0000000000
      553      127021516                South Western Sydney 1.0000000000
      554      127021517                South Western Sydney 1.0000000000
      555      127021518               Nepean Blue Mountains 0.3972286374
      556      127021518                South Western Sydney 0.6027713626
      557      127021519                South Western Sydney 1.0000000000
      558      127021520                South Western Sydney 1.0000000000
      559      127021521                South Western Sydney 1.0000000000
      560      127031522                South Western Sydney 1.0000000000
      561      127031523                South Western Sydney 1.0000000000
      562      127031524                South Western Sydney 0.9716650899
      563      127031524                South Eastern Sydney 0.0283349101
      564      127031525                South Western Sydney 1.0000000000
      565      127031526                South Western Sydney 1.0000000000
      566      128011527                South Eastern Sydney 1.0000000000
      567      128011528                South Eastern Sydney 1.0000000000
      568      128011529                South Eastern Sydney 1.0000000000
      569      128011530                South Eastern Sydney 1.0000000000
      570      128011531                South Eastern Sydney 1.0000000000
      571      128021532                South Eastern Sydney 1.0000000000
      572      128021533                South Eastern Sydney 1.0000000000
      573      128021534                South Eastern Sydney 1.0000000000
      574      128021535                South Eastern Sydney 1.0000000000
      575      128021536                South Eastern Sydney 1.0000000000
      576      128021537                South Eastern Sydney 1.0000000000
      577      128021538                South Eastern Sydney 1.0000000000
      578      201011001                   Central Highlands 1.0000000000
      579      201011002                   Central Highlands 1.0000000000
      580      201011003                   Central Highlands 1.0000000000
      581      201011004                   Central Highlands 1.0000000000
      582      201011005                   Central Highlands 1.0000000000
      583      201011006                   Central Highlands 1.0000000000
      584      201011007                   Central Highlands 1.0000000000
      585      201011008                   Central Highlands 1.0000000000
      586      201021009                   Central Highlands 1.0000000000
      587      201021010                   Central Highlands 1.0000000000
      588      201021011                   Central Highlands 1.0000000000
      589      201021012                   Central Highlands 1.0000000000
      590      201031013                   Central Highlands 1.0000000000
      591      201031014                   Central Highlands 1.0000000000
      592      201031015                   Central Highlands 1.0000000000
      593      201031016                              Loddon 1.0000000000
      594      201031017                              Loddon 1.0000000000
      595      202011018                              Loddon 1.0000000000
      596      202011019                              Loddon 1.0000000000
      597      202011020                              Loddon 1.0000000000
      598      202011021                              Loddon 1.0000000000
      599      202011022                              Loddon 1.0000000000
      600      202011023                              Loddon 1.0000000000
      601      202011024                              Loddon 1.0000000000
      602      202011025                              Loddon 1.0000000000
      603      202021026                              Loddon 1.0000000000
      604      202021027                              Loddon 1.0000000000
      605      202021028                              Loddon 1.0000000000
      606      202021029                              Loddon 1.0000000000
      607      202021030                              Loddon 1.0000000000
      608      202021031                              Loddon 1.0000000000
      609      202031032                              Loddon 1.0000000000
      610      202031033                              Loddon 1.0000000000
      611      203011034                   Central Highlands 1.0000000000
      612      203011035                   Central Highlands 1.0000000000
      613      203011036                              Barwon 1.0000000000
      614      203021037                              Barwon 1.0000000000
      615      203021038                              Barwon 1.0000000000
      616      203021039                              Barwon 1.0000000000
      617      203021040                              Barwon 1.0000000000
      618      203021041                              Barwon 1.0000000000
      619      203021042                              Barwon 1.0000000000
      620      203021043                              Barwon 1.0000000000
      621      203021044                              Barwon 1.0000000000
      622      203021045                              Barwon 1.0000000000
      623      203021046                              Barwon 1.0000000000
      624      203021047                              Barwon 1.0000000000
      625      203031048                              Barwon 1.0000000000
      626      203031049                              Barwon 1.0000000000
      627      203031050                              Barwon 1.0000000000
      628      203031051                              Barwon 1.0000000000
      629      203031052                              Barwon 1.0000000000
      630      203031053                              Barwon 1.0000000000
      631      204011054                            Goulburn 1.0000000000
      632      204011055                            Goulburn 1.0000000000
      633      204011056                            Goulburn 1.0000000000
      634      204011057                        Ovens Murray 0.9991463530
      635      204011057                            Goulburn 0.0008536470
      636      204011058                            Goulburn 1.0000000000
      637      204011059                            Goulburn 1.0000000000
      638      204011060                            Goulburn 1.0000000000
      639      204011061             Outer Eastern Melbourne 1.0000000000
      640      204011062                            Goulburn 1.0000000000
      641      204021063                        Ovens Murray 1.0000000000
      642      204021064                            Goulburn 0.0192155830
      643      204021064                        Ovens Murray 0.9807844170
      644      204021065                        Ovens Murray 1.0000000000
      645      204021066                        Ovens Murray 1.0000000000
      646      204021067                        Ovens Murray 1.0000000000
      647      204031068                        Ovens Murray 1.0000000000
      648      204031069                        Ovens Murray 1.0000000000
      649      204031070                        Ovens Murray 1.0000000000
      650      204031071                        Ovens Murray 1.0000000000
      651      204031072                        Ovens Murray 1.0000000000
      652      204031073                        Ovens Murray 1.0000000000
      653      204031074                        Ovens Murray 1.0000000000
      654      204031075                        Ovens Murray 1.0000000000
      655      205011076                     Inner Gippsland 1.0000000000
      656      205011077                     Inner Gippsland 1.0000000000
      657      205011078                     Inner Gippsland 1.0000000000
      658      205011079                     Inner Gippsland 1.0000000000
      659      205021080                     Outer Gippsland 1.0000000000
      660      205021081                     Outer Gippsland 1.0000000000
      661      205021082                     Outer Gippsland 1.0000000000
      662      205021083                     Outer Gippsland 1.0000000000
      663      205021084                     Outer Gippsland 1.0000000000
      664      205021085                     Outer Gippsland 1.0000000000
      665      205021086                     Outer Gippsland 1.0000000000
      666      205031087                     Inner Gippsland 1.0000000000
      667      205031088                   Bayside Peninsula 1.0000000000
      668      205031089                     Inner Gippsland 1.0000000000
      669      205031090                     Inner Gippsland 1.0000000000
      670      205031091                     Inner Gippsland 1.0000000000
      671      205031092                     Inner Gippsland 1.0000000000
      672      205031093                     Inner Gippsland 1.0000000000
      673      205041094                     Inner Gippsland 1.0000000000
      674      205041095                     Inner Gippsland 1.0000000000
      675      205041096                     Inner Gippsland 1.0000000000
      676      205041097                     Inner Gippsland 1.0000000000
      677      205041098                     Inner Gippsland 1.0000000000
      678      205051099                     Outer Gippsland 1.0000000000
      679      205051100                     Outer Gippsland 1.0000000000
      680      205051101                     Outer Gippsland 1.0000000000
      681      205051102                     Outer Gippsland 1.0000000000
      682      205051103                     Outer Gippsland 1.0000000000
      683      205051104                     Outer Gippsland 1.0000000000
      684      206011105                       Hume Moreland 1.0000000000
      685      206011106                       Hume Moreland 1.0000000000
      686      206011107                       Hume Moreland 1.0000000000
      687      206011108                       Hume Moreland 0.9992459091
      688      206011108             North Eastern Melbourne 0.0007540909
      689      206011109                       Hume Moreland 1.0000000000
      690      206021110             North Eastern Melbourne 1.0000000000
      691      206021111             North Eastern Melbourne 1.0000000000
      692      206021112             North Eastern Melbourne 1.0000000000
      693      206031113                   Western Melbourne 1.0000000000
      694      206031114                       Hume Moreland 0.0040996643
      695      206031114                   Western Melbourne 0.9959003357
      696      206031115                   Western Melbourne 1.0000000000
      697      206031116                   Western Melbourne 1.0000000000
      698      206041117                   Western Melbourne 1.0000000000
      699      206041118                   Western Melbourne 1.0000000000
      700      206041119                   Western Melbourne 1.0000000000
      701      206041120                   Western Melbourne 1.0000000000
      702      206041121                   Western Melbourne 1.0000000000
      703      206041122                   Western Melbourne 1.0000000000
      704      206041123                   Western Melbourne 1.0000000000
      705      206041124                   Western Melbourne 1.0000000000
      706      206041125                   Western Melbourne 0.9890584065
      707      206041125                   Bayside Peninsula 0.0109415935
      708      206041126                   Western Melbourne 1.0000000000
      709      206041127                   Western Melbourne 1.0000000000
      710      206051128                   Bayside Peninsula 1.0000000000
      711      206051129                   Bayside Peninsula 1.0000000000
      712      206051130                   Bayside Peninsula 1.0000000000
      713      206051131                   Western Melbourne 0.0069541029
      714      206051131                   Bayside Peninsula 0.9930458971
      715      206051132                   Bayside Peninsula 1.0000000000
      716      206051133                   Bayside Peninsula 1.0000000000
      717      206051134                   Bayside Peninsula 1.0000000000
      718      206061135                   Bayside Peninsula 1.0000000000
      719      206061136                   Bayside Peninsula 1.0000000000
      720      206061137                   Bayside Peninsula 1.0000000000
      721      206061138                   Bayside Peninsula 1.0000000000
      722      206071139             North Eastern Melbourne 1.0000000000
      723      206071140             North Eastern Melbourne 1.0000000000
      724      206071141             North Eastern Melbourne 1.0000000000
      725      206071142             North Eastern Melbourne 1.0000000000
      726      206071143             North Eastern Melbourne 0.9260676087
      727      206071143                       Hume Moreland 0.0739323913
      728      206071144             North Eastern Melbourne 1.0000000000
      729      206071145             North Eastern Melbourne 1.0000000000
      730      207011146             Inner Eastern Melbourne 1.0000000000
      731      207011147             Inner Eastern Melbourne 1.0000000000
      732      207011148             Inner Eastern Melbourne 1.0000000000
      733      207011149             Inner Eastern Melbourne 1.0000000000
      734      207011150             Inner Eastern Melbourne 1.0000000000
      735      207011151             Inner Eastern Melbourne 1.0000000000
      736      207011152             Inner Eastern Melbourne 1.0000000000
      737      207011153             Inner Eastern Melbourne 1.0000000000
      738      207011154             Inner Eastern Melbourne 1.0000000000
      739      207011155             Inner Eastern Melbourne 1.0000000000
      740      207021156             Inner Eastern Melbourne 1.0000000000
      741      207021157             Inner Eastern Melbourne 1.0000000000
      742      207021158             Inner Eastern Melbourne 1.0000000000
      743      207021159             Inner Eastern Melbourne 1.0000000000
      744      207021160             Inner Eastern Melbourne 1.0000000000
      745      207031161             Inner Eastern Melbourne 1.0000000000
      746      207031162             Inner Eastern Melbourne 1.0000000000
      747      207031163             Inner Eastern Melbourne 1.0000000000
      748      207031164             Inner Eastern Melbourne 1.0000000000
      749      207031165             Inner Eastern Melbourne 1.0000000000
      750      207031166             Inner Eastern Melbourne 1.0000000000
      751      207031167             Inner Eastern Melbourne 1.0000000000
      752      208011168                   Bayside Peninsula 1.0000000000
      753      208011169                   Bayside Peninsula 1.0000000000
      754      208011170                   Bayside Peninsula 1.0000000000
      755      208011171                   Bayside Peninsula 1.0000000000
      756      208011172                   Bayside Peninsula 1.0000000000
      757      208011173                   Bayside Peninsula 1.0000000000
      758      208021174                   Bayside Peninsula 1.0000000000
      759      208021175                   Bayside Peninsula 1.0000000000
      760      208021176                   Bayside Peninsula 1.0000000000
      761      208021177                   Bayside Peninsula 1.0000000000
      762      208021178                   Bayside Peninsula 1.0000000000
      763      208021179                   Bayside Peninsula 1.0000000000
      764      208021180             Inner Eastern Melbourne 1.0000000000
      765      208021181                   Bayside Peninsula 1.0000000000
      766      208021182                   Bayside Peninsula 1.0000000000
      767      208031183                   Bayside Peninsula 1.0000000000
      768      208031184                   Bayside Peninsula 1.0000000000
      769      208031185                   Bayside Peninsula 1.0000000000
      770      208031186                   Bayside Peninsula 1.0000000000
      771      208031187                   Bayside Peninsula 1.0000000000
      772      208031188                   Bayside Peninsula 1.0000000000
      773      208031189                   Bayside Peninsula 1.0000000000
      774      208031190                   Bayside Peninsula 1.0000000000
      775      208031191                   Bayside Peninsula 1.0000000000
      776      208031192                   Bayside Peninsula 1.0000000000
      777      208031193                   Bayside Peninsula 1.0000000000
      778      208041194                   Bayside Peninsula 1.0000000000
      779      208041195                   Bayside Peninsula 1.0000000000
      780      209011196             North Eastern Melbourne 1.0000000000
      781      209011197             North Eastern Melbourne 1.0000000000
      782      209011198             North Eastern Melbourne 1.0000000000
      783      209011199             North Eastern Melbourne 1.0000000000
      784      209011200             North Eastern Melbourne 1.0000000000
      785      209011201             North Eastern Melbourne 1.0000000000
      786      209011202             North Eastern Melbourne 1.0000000000
      787      209011203             North Eastern Melbourne 1.0000000000
      788      209011204             North Eastern Melbourne 1.0000000000
      789      209021205             North Eastern Melbourne 1.0000000000
      790      209021206             North Eastern Melbourne 1.0000000000
      791      209021207             North Eastern Melbourne 1.0000000000
      792      209021208             North Eastern Melbourne 1.0000000000
      793      209031209             North Eastern Melbourne 1.0000000000
      794      209031210             North Eastern Melbourne 1.0000000000
      795      209031211                            Goulburn 1.0000000000
      796      209031212             North Eastern Melbourne 1.0000000000
      797      209031213             North Eastern Melbourne 1.0000000000
      798      209031214             North Eastern Melbourne 1.0000000000
      799      209031215             North Eastern Melbourne 1.0000000000
      800      209041216             North Eastern Melbourne 1.0000000000
      801      209041217             North Eastern Melbourne 1.0000000000
      802      209041218             North Eastern Melbourne 1.0000000000
      803      209041219             North Eastern Melbourne 1.0000000000
      804      209041220             North Eastern Melbourne 1.0000000000
      805      209041221             North Eastern Melbourne 1.0000000000
      806      209041222             North Eastern Melbourne 1.0000000000
      807      209041223             North Eastern Melbourne 1.0000000000
      808      209041224                            Goulburn 1.0000000000
      809      209041225             North Eastern Melbourne 1.0000000000
      810      210011226                   Western Melbourne 1.0000000000
      811      210011227                   Western Melbourne 1.0000000000
      812      210011228                     Brimbank Melton 0.9994154098
      813      210011228                       Hume Moreland 0.0005845902
      814      210011229                   Western Melbourne 1.0000000000
      815      210011230                   Western Melbourne 1.0000000000
      816      210011231                   Western Melbourne 1.0000000000
      817      210021232                              Loddon 1.0000000000
      818      210021233                              Loddon 1.0000000000
      819      210021234                              Loddon 1.0000000000
      820      210021235                              Loddon 1.0000000000
      821      210031236                       Hume Moreland 1.0000000000
      822      210031237                       Hume Moreland 1.0000000000
      823      210031238                       Hume Moreland 1.0000000000
      824      210031239                       Hume Moreland 1.0000000000
      825      210041240                       Hume Moreland 1.0000000000
      826      210041241                     Brimbank Melton 0.1670113589
      827      210041241                       Hume Moreland 0.8329886411
      828      210051242                       Hume Moreland 1.0000000000
      829      210051243                       Hume Moreland 1.0000000000
      830      210051244                       Hume Moreland 1.0000000000
      831      210051245                       Hume Moreland 1.0000000000
      832      210051246                       Hume Moreland 1.0000000000
      833      210051247                       Hume Moreland 1.0000000000
      834      210051248                       Hume Moreland 1.0000000000
      835      210051249                       Hume Moreland 1.0000000000
      836      210051250                       Hume Moreland 1.0000000000
      837      211011251             Outer Eastern Melbourne 1.0000000000
      838      211011252             Outer Eastern Melbourne 1.0000000000
      839      211011253             Outer Eastern Melbourne 1.0000000000
      840      211011254             Outer Eastern Melbourne 1.0000000000
      841      211011255             Outer Eastern Melbourne 1.0000000000
      842      211011256             Outer Eastern Melbourne 1.0000000000
      843      211011257             Outer Eastern Melbourne 1.0000000000
      844      211011258             Outer Eastern Melbourne 1.0000000000
      845      211011259             Outer Eastern Melbourne 1.0000000000
      846      211011260             Outer Eastern Melbourne 1.0000000000
      847      211021261             Inner Eastern Melbourne 1.0000000000
      848      211021262             Inner Eastern Melbourne 0.9617063492
      849      211021262             Outer Eastern Melbourne 0.0382936508
      850      211031263             Outer Eastern Melbourne 1.0000000000
      851      211031264             Outer Eastern Melbourne 1.0000000000
      852      211031265             Outer Eastern Melbourne 1.0000000000
      853      211031266             Outer Eastern Melbourne 1.0000000000
      854      211031267             Outer Eastern Melbourne 1.0000000000
      855      211031268             Outer Eastern Melbourne 1.0000000000
      856      211041269             Inner Eastern Melbourne 1.0000000000
      857      211041270             Inner Eastern Melbourne 1.0000000000
      858      211041271             Inner Eastern Melbourne 1.0000000000
      859      211041272             Outer Eastern Melbourne 0.0423251589
      860      211041272             Inner Eastern Melbourne 0.9576748411
      861      211041273             Inner Eastern Melbourne 1.0000000000
      862      211051274             Outer Eastern Melbourne 0.9823141487
      863      211051274                  Southern Melbourne 0.0176858513
      864      211051275             Outer Eastern Melbourne 1.0000000000
      865      211051276             Outer Eastern Melbourne 1.0000000000
      866      211051277             Outer Eastern Melbourne 1.0000000000
      867      211051278             Outer Eastern Melbourne 1.0000000000
      868      211051279             Outer Eastern Melbourne 1.0000000000
      869      211051280             Outer Eastern Melbourne 1.0000000000
      870      211051281             Outer Eastern Melbourne 1.0000000000
      871      211051282             Outer Eastern Melbourne 1.0000000000
      872      211051283             Outer Eastern Melbourne 1.0000000000
      873      211051284             Outer Eastern Melbourne 1.0000000000
      874      211051285             Outer Eastern Melbourne 1.0000000000
      875      211051286             Outer Eastern Melbourne 1.0000000000
      876      212011287                  Southern Melbourne 1.0000000000
      877      212011288                  Southern Melbourne 1.0000000000
      878      212011289             Outer Eastern Melbourne 0.0176540030
      879      212011289                  Southern Melbourne 0.9823459970
      880      212011290                  Southern Melbourne 1.0000000000
      881      212011291                  Southern Melbourne 1.0000000000
      882      212011292                  Southern Melbourne 1.0000000000
      883      212021293                  Southern Melbourne 1.0000000000
      884      212021294                  Southern Melbourne 1.0000000000
      885      212021295                  Southern Melbourne 1.0000000000
      886      212021296                  Southern Melbourne 1.0000000000
      887      212021297                  Southern Melbourne 1.0000000000
      888      212021298                  Southern Melbourne 1.0000000000
      889      212021299                  Southern Melbourne 1.0000000000
      890      212031300                  Southern Melbourne 1.0000000000
      891      212031301                  Southern Melbourne 1.0000000000
      892      212031302                  Southern Melbourne 1.0000000000
      893      212031303                  Southern Melbourne 1.0000000000
      894      212031304                  Southern Melbourne 1.0000000000
      895      212031305                  Southern Melbourne 1.0000000000
      896      212031306                  Southern Melbourne 1.0000000000
      897      212031307                  Southern Melbourne 1.0000000000
      898      212031308                  Southern Melbourne 1.0000000000
      899      212041309                   Bayside Peninsula 1.0000000000
      900      212041310                   Bayside Peninsula 1.0000000000
      901      212041311                  Southern Melbourne 1.0000000000
      902      212041312                  Southern Melbourne 1.0000000000
      903      212041313                   Bayside Peninsula 1.0000000000
      904      212041314                  Southern Melbourne 1.0000000000
      905      212041315                  Southern Melbourne 1.0000000000
      906      212041316                  Southern Melbourne 1.0000000000
      907      212041317                  Southern Melbourne 1.0000000000
      908      212041318                  Southern Melbourne 1.0000000000
      909      212051319             Inner Eastern Melbourne 1.0000000000
      910      212051320             Inner Eastern Melbourne 1.0000000000
      911      212051321             Inner Eastern Melbourne 1.0000000000
      912      212051322             Inner Eastern Melbourne 1.0000000000
      913      212051323             Inner Eastern Melbourne 1.0000000000
      914      212051324             Inner Eastern Melbourne 1.0000000000
      915      212051325             Inner Eastern Melbourne 1.0000000000
      916      212051326             Inner Eastern Melbourne 1.0000000000
      917      212051327             Inner Eastern Melbourne 1.0000000000
      918      213011328                     Brimbank Melton 1.0000000000
      919      213011329                     Brimbank Melton 1.0000000000
      920      213011330                     Brimbank Melton 1.0000000000
      921      213011331                     Brimbank Melton 1.0000000000
      922      213011332                     Brimbank Melton 1.0000000000
      923      213011333                     Brimbank Melton 1.0000000000
      924      213011334                     Brimbank Melton 1.0000000000
      925      213011335                     Brimbank Melton 1.0000000000
      926      213011336                     Brimbank Melton 1.0000000000
      927      213011337                     Brimbank Melton 1.0000000000
      928      213011338                     Brimbank Melton 1.0000000000
      929      213011339                     Brimbank Melton 1.0000000000
      930      213011340                     Brimbank Melton 1.0000000000
      931      213021341                   Western Melbourne 1.0000000000
      932      213021342                   Western Melbourne 1.0000000000
      933      213021343                   Western Melbourne 1.0000000000
      934      213021344                   Western Melbourne 1.0000000000
      935      213021345                   Western Melbourne 1.0000000000
      936      213021346                   Western Melbourne 1.0000000000
      937      213031347                   Western Melbourne 1.0000000000
      938      213031348                   Western Melbourne 1.0000000000
      939      213031349                   Western Melbourne 1.0000000000
      940      213031350                   Western Melbourne 1.0000000000
      941      213031351                   Western Melbourne 1.0000000000
      942      213031352                   Western Melbourne 1.0000000000
      943      213041353                   Central Highlands 1.0000000000
      944      213041354                     Brimbank Melton 1.0000000000
      945      213041355                     Brimbank Melton 1.0000000000
      946      213041356                     Brimbank Melton 1.0000000000
      947      213041357                     Brimbank Melton 1.0000000000
      948      213041358                     Brimbank Melton 1.0000000000
      949      213041359                     Brimbank Melton 1.0000000000
      950      213041360                     Brimbank Melton 1.0000000000
      951      213051361                   Western Melbourne 1.0000000000
      952      213051362                   Western Melbourne 1.0000000000
      953      213051363                   Western Melbourne 1.0000000000
      954      213051364                   Western Melbourne 1.0000000000
      955      213051365                   Western Melbourne 1.0000000000
      956      213051366                   Western Melbourne 1.0000000000
      957      213051367                   Western Melbourne 1.0000000000
      958      213051368                   Western Melbourne 1.0000000000
      959      213051369                   Western Melbourne 1.0000000000
      960      214011370                   Bayside Peninsula 1.0000000000
      961      214011371                   Bayside Peninsula 1.0000000000
      962      214011372                   Bayside Peninsula 1.0000000000
      963      214011373                   Bayside Peninsula 1.0000000000
      964      214011374                   Bayside Peninsula 1.0000000000
      965      214011375                   Bayside Peninsula 1.0000000000
      966      214011376                   Bayside Peninsula 1.0000000000
      967      214021377                   Bayside Peninsula 1.0000000000
      968      214021378                   Bayside Peninsula 1.0000000000
      969      214021379                   Bayside Peninsula 1.0000000000
      970      214021380                   Bayside Peninsula 1.0000000000
      971      214021381                   Bayside Peninsula 1.0000000000
      972      214021382                   Bayside Peninsula 1.0000000000
      973      214021383                   Bayside Peninsula 1.0000000000
      974      214021384                   Bayside Peninsula 1.0000000000
      975      214021385                   Bayside Peninsula 1.0000000000
      976      215011386                   Central Highlands 1.0000000000
      977      215011387                   Central Highlands 1.0000000000
      978      215011388                  Wimmera South West 1.0000000000
      979      215011389                  Wimmera South West 1.0000000000
      980      215011390                  Wimmera South West 1.0000000000
      981      215011391                  Wimmera South West 1.0000000000
      982      215011392                  Wimmera South West 1.0000000000
      983      215011393                  Wimmera South West 1.0000000000
      984      215011394                  Wimmera South West 1.0000000000
      985      215021395                              Mallee 1.0000000000
      986      215021396                              Mallee 1.0000000000
      987      215021397                              Mallee 1.0000000000
      988      215021398                              Mallee 1.0000000000
      989      215021399                              Mallee 1.0000000000
      990      215031400                              Mallee 1.0000000000
      991      215031401                              Mallee 1.0000000000
      992      215031402                              Mallee 1.0000000000
      993      215031403                              Mallee 1.0000000000
      994      215031404                              Mallee 1.0000000000
      995      215031405                              Mallee 1.0000000000
      996      216011406                              Loddon 1.0000000000
      997      216011407                            Goulburn 0.0141882184
      998      216011407                              Loddon 0.9858117816
      999      216011408                              Loddon 1.0000000000
      1000     216011409                              Loddon 1.0000000000
      1001     216011410                              Loddon 1.0000000000
      1002     216021411                            Goulburn 1.0000000000
      1003     216021412                            Goulburn 1.0000000000
      1004     216021413                            Goulburn 1.0000000000
      1005     216021414                            Goulburn 1.0000000000
      1006     216031415                            Goulburn 1.0000000000
      1007     216031416                            Goulburn 1.0000000000
      1008     216031417                            Goulburn 1.0000000000
      1009     216031418                            Goulburn 1.0000000000
      1010     216031419                            Goulburn 1.0000000000
      1011     217011420                  Wimmera South West 1.0000000000
      1012     217011421                  Wimmera South West 1.0000000000
      1013     217011422                  Wimmera South West 1.0000000000
      1014     217011423                  Wimmera South West 1.0000000000
      1015     217021424                  Wimmera South West 1.0000000000
      1016     217021425                              Barwon 1.0000000000
      1017     217021426                              Barwon 1.0000000000
      1018     217021427                  Wimmera South West 1.0000000000
      1019     217021428                  Wimmera South West 1.0000000000
      1020     217021429                  Wimmera South West 1.0000000000
      1021     217021430                  Wimmera South West 1.0000000000
      1022     217021431                              Barwon 1.0000000000
      1023     217021432                  Wimmera South West 1.0000000000
      1024     217021433                  Wimmera South West 1.0000000000
      1025     301011001                   Metro South (Qld) 1.0000000000
      1026     301011002                   Metro South (Qld) 1.0000000000
      1027     301011003                   Metro South (Qld) 1.0000000000
      1028     301011004                   Metro South (Qld) 1.0000000000
      1029     301011005                   Metro South (Qld) 1.0000000000
      1030     301011006                   Metro South (Qld) 1.0000000000
      1031     301021007                   Metro South (Qld) 1.0000000000
      1032     301021008                   Metro South (Qld) 1.0000000000
      1033     301021009                   Metro South (Qld) 1.0000000000
      1034     301021010                   Metro South (Qld) 1.0000000000
      1035     301021011                   Metro South (Qld) 1.0000000000
      1036     301021012                   Metro South (Qld) 1.0000000000
      1037     301021013                   Metro South (Qld) 1.0000000000
      1038     301031014                   Metro South (Qld) 1.0000000000
      1039     301031015                   Metro South (Qld) 1.0000000000
      1040     301031016                   Metro South (Qld) 1.0000000000
      1041     301031017                   Metro South (Qld) 1.0000000000
      1042     301031018                   Metro South (Qld) 1.0000000000
      1043     301031019                   Metro South (Qld) 1.0000000000
      1044     301031020                   Metro South (Qld) 1.0000000000
      1045     301031021                   Metro South (Qld) 1.0000000000
      1046     302011022                   Metro North (Qld) 1.0000000000
      1047     302011023                   Metro North (Qld) 1.0000000000
      1048     302011024                   Metro North (Qld) 1.0000000000
      1049     302011025                   Metro North (Qld) 1.0000000000
      1050     302011026                   Metro North (Qld) 1.0000000000
      1051     302021027                   Metro North (Qld) 1.0000000000
      1052     302021028                   Metro North (Qld) 1.0000000000
      1053     302021029                   Metro North (Qld) 1.0000000000
      1054     302021030                   Metro North (Qld) 1.0000000000
      1055     302021031                   Metro North (Qld) 1.0000000000
      1056     302021032                   Metro North (Qld) 1.0000000000
      1057     302021033                   Metro North (Qld) 1.0000000000
      1058     302021034                   Metro North (Qld) 1.0000000000
      1059     302031035                   Metro North (Qld) 1.0000000000
      1060     302031036                   Metro North (Qld) 1.0000000000
      1061     302031037                   Metro North (Qld) 1.0000000000
      1062     302031038                   Metro North (Qld) 1.0000000000
      1063     302031039                   Metro North (Qld) 1.0000000000
      1064     302031040                   Metro North (Qld) 1.0000000000
      1065     302041041                   Metro North (Qld) 1.0000000000
      1066     302041042                   Metro North (Qld) 1.0000000000
      1067     302041043                   Metro North (Qld) 1.0000000000
      1068     302041044                   Metro North (Qld) 1.0000000000
      1069     302041045                   Metro North (Qld) 1.0000000000
      1070     302041046                   Metro North (Qld) 1.0000000000
      1071     303011047                   Metro South (Qld) 1.0000000000
      1072     303011048                   Metro South (Qld) 1.0000000000
      1073     303011049                   Metro South (Qld) 1.0000000000
      1074     303011050                   Metro South (Qld) 1.0000000000
      1075     303011051                   Metro South (Qld) 1.0000000000
      1076     303021052                   Metro South (Qld) 1.0000000000
      1077     303021053                   Metro South (Qld) 1.0000000000
      1078     303021054                   Metro South (Qld) 1.0000000000
      1079     303021055                   Metro South (Qld) 1.0000000000
      1080     303021056                   Metro South (Qld) 1.0000000000
      1081     303021057                   Metro South (Qld) 1.0000000000
      1082     303021058                   Metro South (Qld) 1.0000000000
      1083     303021059                   Metro South (Qld) 1.0000000000
      1084     303031060                   Metro South (Qld) 1.0000000000
      1085     303031061                   Metro South (Qld) 1.0000000000
      1086     303031062                   Metro South (Qld) 1.0000000000
      1087     303031063                   Metro South (Qld) 1.0000000000
      1088     303031064                   Metro South (Qld) 1.0000000000
      1089     303031065                   Metro South (Qld) 1.0000000000
      1090     303031066                   Metro South (Qld) 1.0000000000
      1091     303041067                   Metro South (Qld) 1.0000000000
      1092     303041068                   Metro South (Qld) 1.0000000000
      1093     303041069                   Metro South (Qld) 1.0000000000
      1094     303041070                   Metro South (Qld) 1.0000000000
      1095     303041071                   Metro South (Qld) 1.0000000000
      1096     303051072                   Metro South (Qld) 1.0000000000
      1097     303051073                   Metro South (Qld) 1.0000000000
      1098     303051074                   Metro South (Qld) 1.0000000000
      1099     303051075                   Metro South (Qld) 1.0000000000
      1100     303051076                   Metro South (Qld) 1.0000000000
      1101     303061077                   Metro South (Qld) 1.0000000000
      1102     303061078                   Metro South (Qld) 1.0000000000
      1103     303061079                   Metro South (Qld) 1.0000000000
      1104     303061080                   Metro South (Qld) 1.0000000000
      1105     304011081                   Metro South (Qld) 1.0000000000
      1106     304011082                   Metro South (Qld) 1.0000000000
      1107     304011083                   Metro South (Qld) 1.0000000000
      1108     304011084                   Metro South (Qld) 1.0000000000
      1109     304011085                   Metro South (Qld) 1.0000000000
      1110     304021086                   Metro North (Qld) 1.0000000000
      1111     304021087                   Metro North (Qld) 1.0000000000
      1112     304021088                   Metro North (Qld) 1.0000000000
      1113     304021089                   Metro North (Qld) 1.0000000000
      1114     304021090                   Metro North (Qld) 1.0000000000
      1115     304021091                   Metro North (Qld) 1.0000000000
      1116     304031092                   Metro South (Qld) 1.0000000000
      1117     304031093                   Metro South (Qld) 1.0000000000
      1118     304031094                   Metro North (Qld) 1.0000000000
      1119     304031095                   Metro South (Qld) 1.0000000000
      1120     304031096                   Metro North (Qld) 1.0000000000
      1121     304031097                   Metro North (Qld) 1.0000000000
      1122     304041098                   Metro North (Qld) 1.0000000000
      1123     304041099                   Metro North (Qld) 1.0000000000
      1124     304041100                   Metro North (Qld) 1.0000000000
      1125     304041101                   Metro North (Qld) 1.0000000000
      1126     304041102                   Metro North (Qld) 1.0000000000
      1127     304041103                   Metro North (Qld) 1.0000000000
      1128     304041104                   Metro North (Qld) 1.0000000000
      1129     305011105                   Metro North (Qld) 1.0000000000
      1130     305011106                   Metro North (Qld) 1.0000000000
      1131     305011107                   Metro South (Qld) 1.0000000000
      1132     305011108                   Metro South (Qld) 1.0000000000
      1133     305011109                   Metro North (Qld) 1.0000000000
      1134     305011110                   Metro South (Qld) 1.0000000000
      1135     305011111                   Metro North (Qld) 1.0000000000
      1136     305011112                   Metro South (Qld) 1.0000000000
      1137     305021113                   Metro South (Qld) 1.0000000000
      1138     305021114                   Metro South (Qld) 1.0000000000
      1139     305021115                   Metro South (Qld) 1.0000000000
      1140     305021116                   Metro South (Qld) 1.0000000000
      1141     305021117                   Metro South (Qld) 1.0000000000
      1142     305021118                   Metro South (Qld) 1.0000000000
      1143     305031119                   Metro North (Qld) 1.0000000000
      1144     305031120                   Metro North (Qld) 1.0000000000
      1145     305031121                   Metro North (Qld) 1.0000000000
      1146     305031122                   Metro North (Qld) 1.0000000000
      1147     305031123                   Metro North (Qld) 1.0000000000
      1148     305031124                   Metro North (Qld) 1.0000000000
      1149     305031125                   Metro North (Qld) 1.0000000000
      1150     305031126                   Metro North (Qld) 1.0000000000
      1151     305031127                   Metro North (Qld) 1.0000000000
      1152     305031128                   Metro North (Qld) 1.0000000000
      1153     305031129                   Metro North (Qld) 1.0000000000
      1154     305031130                   Metro North (Qld) 1.0000000000
      1155     305031131                   Metro North (Qld) 1.0000000000
      1156     305041132                   Metro North (Qld) 1.0000000000
      1157     305041133                   Metro North (Qld) 1.0000000000
      1158     305041134                   Metro North (Qld) 1.0000000000
      1159     305041135                   Metro North (Qld) 1.0000000000
      1160     305041136                   Metro North (Qld) 1.0000000000
      1161     305041137                   Metro North (Qld) 1.0000000000
      1162     306011138               Cairns and Hinterland 1.0000000000
      1163     306011139               Cairns and Hinterland 1.0000000000
      1164     306011140               Cairns and Hinterland 1.0000000000
      1165     306011141               Cairns and Hinterland 1.0000000000
      1166     306011142               Cairns and Hinterland 1.0000000000
      1167     306011143               Cairns and Hinterland 1.0000000000
      1168     306021144               Cairns and Hinterland 1.0000000000
      1169     306021145               Cairns and Hinterland 1.0000000000
      1170     306021146               Cairns and Hinterland 1.0000000000
      1171     306021147               Cairns and Hinterland 1.0000000000
      1172     306021148               Cairns and Hinterland 1.0000000000
      1173     306021149               Cairns and Hinterland 1.0000000000
      1174     306021150               Cairns and Hinterland 1.0000000000
      1175     306021151               Cairns and Hinterland 1.0000000000
      1176     306021152               Cairns and Hinterland 1.0000000000
      1177     306021153               Cairns and Hinterland 1.0000000000
      1178     306021154               Cairns and Hinterland 1.0000000000
      1179     306021155               Cairns and Hinterland 1.0000000000
      1180     306021156               Cairns and Hinterland 1.0000000000
      1181     306021157               Cairns and Hinterland 1.0000000000
      1182     306031158               Cairns and Hinterland 1.0000000000
      1183     306031159               Cairns and Hinterland 1.0000000000
      1184     306031160               Cairns and Hinterland 1.0000000000
      1185     306031161               Cairns and Hinterland 0.8218145491
      1186     306031161                          Townsville 0.1781854509
      1187     306031162               Cairns and Hinterland 1.0000000000
      1188     306031163               Cairns and Hinterland 1.0000000000
      1189     306041164               Cairns and Hinterland 1.0000000000
      1190     306041165               Cairns and Hinterland 1.0000000000
      1191     306051166               Cairns and Hinterland 1.0000000000
      1192     306051167               Cairns and Hinterland 1.0000000000
      1193     306051168               Cairns and Hinterland 1.0000000000
      1194     306051169               Cairns and Hinterland 1.0000000000
      1195     306051170               Cairns and Hinterland 1.0000000000
      1196     307011171                    South West (Qld) 1.0000000000
      1197     307011172                       Darling Downs 1.0000000000
      1198     307011173                       Darling Downs 1.0000000000
      1199     307011174                       Darling Downs 1.0000000000
      1200     307011175                       Darling Downs 1.0000000000
      1201     307011176                    South West (Qld) 1.0000000000
      1202     307011177                    South West (Qld) 1.0000000000
      1203     307011178                       Darling Downs 1.0000000000
      1204     307021179                       Darling Downs 1.0000000000
      1205     307021180                       Darling Downs 1.0000000000
      1206     307021181                       Darling Downs 1.0000000000
      1207     307021182                       Darling Downs 1.0000000000
      1208     307021183                       Darling Downs 1.0000000000
      1209     307031184                       Darling Downs 1.0000000000
      1210     307031185                       Darling Downs 1.0000000000
      1211     307031186                       Darling Downs 1.0000000000
      1212     307031187                       Darling Downs 1.0000000000
      1213     307031188                       Darling Downs 1.0000000000
      1214     307031189                       Darling Downs 1.0000000000
      1215     308011190                  Central Queensland 1.0000000000
      1216     308011191                  Central Queensland 1.0000000000
      1217     308011192                  Central Queensland 1.0000000000
      1218     308021193                            Wide Bay 1.0000000000
      1219     308021194                  Central Queensland 0.8927028870
      1220     308021194                       Darling Downs 0.1072971130
      1221     308021195                  Central Queensland 1.0000000000
      1222     308021196                  Central Queensland 1.0000000000
      1223     308021197                  Central Queensland 1.0000000000
      1224     308021198                  Central Queensland 1.0000000000
      1225     308021199                  Central Queensland 1.0000000000
      1226     308021200                  Central Queensland 1.0000000000
      1227     308021201                  Central Queensland 1.0000000000
      1228     308021202                  Central Queensland 1.0000000000
      1229     308021203                  Central Queensland 1.0000000000
      1230     308021204                  Central Queensland 1.0000000000
      1231     308031205                  Central Queensland 1.0000000000
      1232     308031206                  Central Queensland 1.0000000000
      1233     308031207                  Central Queensland 1.0000000000
      1234     308031208                  Central Queensland 1.0000000000
      1235     308031209                  Central Queensland 1.0000000000
      1236     308031210                  Central Queensland 1.0000000000
      1237     308031211                  Central Queensland 1.0000000000
      1238     308031212                  Central Queensland 1.0000000000
      1239     308031213                  Central Queensland 1.0000000000
      1240     308031214                  Central Queensland 1.0000000000
      1241     308031215                  Central Queensland 1.0000000000
      1242     308031216                  Central Queensland 1.0000000000
      1243     308031217                  Central Queensland 1.0000000000
      1244     308031218                  Central Queensland 1.0000000000
      1245     308031219                  Central Queensland 1.0000000000
      1246     308031220                  Central Queensland 1.0000000000
      1247     308031221                  Central Queensland 1.0000000000
      1248     308031222                  Central Queensland 1.0000000000
      1249     308031223                  Central Queensland 1.0000000000
      1250     309011224                          Gold Coast 1.0000000000
      1251     309011225                          Gold Coast 1.0000000000
      1252     309011226                          Gold Coast 1.0000000000
      1253     309011227                          Gold Coast 1.0000000000
      1254     309011228                          Gold Coast 1.0000000000
      1255     309011229                          Gold Coast 1.0000000000
      1256     309021230                          Gold Coast 1.0000000000
      1257     309021231                          Gold Coast 1.0000000000
      1258     309021232                          Gold Coast 1.0000000000
      1259     309021233                          Gold Coast 1.0000000000
      1260     309021234                          Gold Coast 1.0000000000
      1261     309031235                          Gold Coast 1.0000000000
      1262     309031236                          Gold Coast 1.0000000000
      1263     309031237                          Gold Coast 1.0000000000
      1264     309031238                          Gold Coast 1.0000000000
      1265     309031239                          Gold Coast 1.0000000000
      1266     309031240                          Gold Coast 1.0000000000
      1267     309041241                          Gold Coast 1.0000000000
      1268     309041242                          Gold Coast 0.9932595701
      1269     309041242                   Metro South (Qld) 0.0067404299
      1270     309051243                          Gold Coast 1.0000000000
      1271     309051244                          Gold Coast 1.0000000000
      1272     309051245                          Gold Coast 1.0000000000
      1273     309061246                          Gold Coast 1.0000000000
      1274     309061247                          Gold Coast 1.0000000000
      1275     309061248                          Gold Coast 1.0000000000
      1276     309061249                          Gold Coast 1.0000000000
      1277     309061250                          Gold Coast 1.0000000000
      1278     309071251                          Gold Coast 1.0000000000
      1279     309071252                          Gold Coast 1.0000000000
      1280     309071253                          Gold Coast 1.0000000000
      1281     309071254                          Gold Coast 1.0000000000
      1282     309071255                          Gold Coast 1.0000000000
      1283     309071256                          Gold Coast 1.0000000000
      1284     309071257                          Gold Coast 1.0000000000
      1285     309071258                          Gold Coast 1.0000000000
      1286     309081259                          Gold Coast 1.0000000000
      1287     309081260                          Gold Coast 1.0000000000
      1288     309081261                          Gold Coast 1.0000000000
      1289     309081262                          Gold Coast 1.0000000000
      1290     309091263                          Gold Coast 1.0000000000
      1291     309091264                          Gold Coast 1.0000000000
      1292     309091265                          Gold Coast 1.0000000000
      1293     309091266                          Gold Coast 1.0000000000
      1294     309101267                          Gold Coast 1.0000000000
      1295     309101268                          Gold Coast 1.0000000000
      1296     309101269                          Gold Coast 1.0000000000
      1297     309101270                          Gold Coast 1.0000000000
      1298     310011271                   Metro South (Qld) 1.0000000000
      1299     310011272                   Metro South (Qld) 1.0000000000
      1300     310011273                   Metro South (Qld) 1.0000000000
      1301     310011274                   Metro South (Qld) 1.0000000000
      1302     310011275                   Metro South (Qld) 1.0000000000
      1303     310011276                   Metro South (Qld) 1.0000000000
      1304     310021277                        West Moreton 0.9974538511
      1305     310021277                   Metro South (Qld) 0.0025461489
      1306     310021278                        West Moreton 1.0000000000
      1307     310021279                        West Moreton 1.0000000000
      1308     310021280                        West Moreton 1.0000000000
      1309     310021281                        West Moreton 1.0000000000
      1310     310021282                        West Moreton 1.0000000000
      1311     310031283                        West Moreton 1.0000000000
      1312     310031284                        West Moreton 1.0000000000
      1313     310031285                        West Moreton 1.0000000000
      1314     310031286                        West Moreton 1.0000000000
      1315     310031287                        West Moreton 1.0000000000
      1316     310031288                        West Moreton 1.0000000000
      1317     310031289                        West Moreton 1.0000000000
      1318     310031290                        West Moreton 1.0000000000
      1319     310031291                        West Moreton 1.0000000000
      1320     310031292                        West Moreton 1.0000000000
      1321     310031293                        West Moreton 1.0000000000
      1322     310031294                        West Moreton 1.0000000000
      1323     310031295                        West Moreton 1.0000000000
      1324     310041296                        West Moreton 1.0000000000
      1325     310041297                        West Moreton 1.0000000000
      1326     310041298                        West Moreton 1.0000000000
      1327     310041299                        West Moreton 1.0000000000
      1328     310041300                        West Moreton 1.0000000000
      1329     310041301                        West Moreton 1.0000000000
      1330     310041302                        West Moreton 1.0000000000
      1331     310041303                        West Moreton 1.0000000000
      1332     310041304                        West Moreton 1.0000000000
      1333     311011305                          Gold Coast 0.0009558924
      1334     311011305                   Metro South (Qld) 0.9990441076
      1335     311021306                   Metro South (Qld) 1.0000000000
      1336     311021307                   Metro South (Qld) 1.0000000000
      1337     311021308                   Metro South (Qld) 1.0000000000
      1338     311021309                   Metro South (Qld) 1.0000000000
      1339     311021310                   Metro South (Qld) 1.0000000000
      1340     311031311                   Metro South (Qld) 1.0000000000
      1341     311031312                   Metro South (Qld) 1.0000000000
      1342     311031313                   Metro South (Qld) 1.0000000000
      1343     311031314                   Metro South (Qld) 1.0000000000
      1344     311031315                   Metro South (Qld) 1.0000000000
      1345     311031316                   Metro South (Qld) 1.0000000000
      1346     311031317                   Metro South (Qld) 1.0000000000
      1347     311031318                   Metro South (Qld) 1.0000000000
      1348     311031319                   Metro South (Qld) 1.0000000000
      1349     311041320                   Metro South (Qld) 1.0000000000
      1350     311041321                   Metro South (Qld) 1.0000000000
      1351     311041322                   Metro South (Qld) 1.0000000000
      1352     311051323                   Metro South (Qld) 1.0000000000
      1353     311051324                   Metro South (Qld) 1.0000000000
      1354     311051325                   Metro South (Qld) 1.0000000000
      1355     311051326                   Metro South (Qld) 1.0000000000
      1356     311051327                   Metro South (Qld) 1.0000000000
      1357     311051328                   Metro South (Qld) 1.0000000000
      1358     311061329                   Metro South (Qld) 1.0000000000
      1359     311061330                   Metro South (Qld) 1.0000000000
      1360     311061331                   Metro South (Qld) 1.0000000000
      1361     311061332                   Metro South (Qld) 1.0000000000
      1362     311061333                   Metro South (Qld) 1.0000000000
      1363     311061334                   Metro South (Qld) 1.0000000000
      1364     311061335                   Metro South (Qld) 1.0000000000
      1365     311061336                   Metro South (Qld) 1.0000000000
      1366     312011337                              Mackay 1.0000000000
      1367     312011338                              Mackay 1.0000000000
      1368     312011339                              Mackay 1.0000000000
      1369     312011340                              Mackay 1.0000000000
      1370     312011341                              Mackay 1.0000000000
      1371     312021342                              Mackay 1.0000000000
      1372     312021343                              Mackay 1.0000000000
      1373     312021344                              Mackay 1.0000000000
      1374     312021345                              Mackay 1.0000000000
      1375     312021346                              Mackay 1.0000000000
      1376     312021347                              Mackay 1.0000000000
      1377     312021348                              Mackay 1.0000000000
      1378     312021349                              Mackay 1.0000000000
      1379     312021350                              Mackay 1.0000000000
      1380     312021351                              Mackay 1.0000000000
      1381     312021352                              Mackay 1.0000000000
      1382     312021353                              Mackay 1.0000000000
      1383     312021354                              Mackay 1.0000000000
      1384     312021355                              Mackay 1.0000000000
      1385     312021356                              Mackay 1.0000000000
      1386     312021357                              Mackay 1.0000000000
      1387     312021358                              Mackay 1.0000000000
      1388     312031359                              Mackay 1.0000000000
      1389     312031360                              Mackay 1.0000000000
      1390     312031361                              Mackay 1.0000000000
      1391     313011362                   Metro North (Qld) 1.0000000000
      1392     313011363                   Metro North (Qld) 1.0000000000
      1393     313021364                   Metro North (Qld) 1.0000000000
      1394     313021365                   Metro North (Qld) 1.0000000000
      1395     313021366                   Metro North (Qld) 1.0000000000
      1396     313021367                   Metro North (Qld) 1.0000000000
      1397     313021368                   Metro North (Qld) 1.0000000000
      1398     313021369                   Metro North (Qld) 1.0000000000
      1399     313031370                   Metro North (Qld) 0.8606939410
      1400     313031370                        West Moreton 0.1393060590
      1401     313031371                   Metro North (Qld) 1.0000000000
      1402     313041372                   Metro North (Qld) 1.0000000000
      1403     313041373                   Metro North (Qld) 1.0000000000
      1404     313041374                   Metro North (Qld) 1.0000000000
      1405     313041375                   Metro North (Qld) 1.0000000000
      1406     313041376                   Metro North (Qld) 1.0000000000
      1407     313051377                   Metro North (Qld) 1.0000000000
      1408     313051378                   Metro North (Qld) 1.0000000000
      1409     313051379                   Metro North (Qld) 1.0000000000
      1410     313051380                   Metro North (Qld) 1.0000000000
      1411     313051381                   Metro North (Qld) 1.0000000000
      1412     314011382                   Metro North (Qld) 1.0000000000
      1413     314011383                   Metro North (Qld) 1.0000000000
      1414     314011384                   Metro North (Qld) 1.0000000000
      1415     314011385                   Metro North (Qld) 1.0000000000
      1416     314011386                   Metro North (Qld) 1.0000000000
      1417     314011387                   Metro North (Qld) 1.0000000000
      1418     314021388                   Metro North (Qld) 1.0000000000
      1419     314021389                   Metro North (Qld) 1.0000000000
      1420     314021390                   Metro North (Qld) 1.0000000000
      1421     314031391                   Metro North (Qld) 1.0000000000
      1422     314031392                   Metro North (Qld) 1.0000000000
      1423     314031393                   Metro North (Qld) 1.0000000000
      1424     314031394                   Metro North (Qld) 1.0000000000
      1425     315011395                     Torres and Cape 1.0000000000
      1426     315011396               Cairns and Hinterland 0.0103119361
      1427     315011396                     Torres and Cape 0.9896880639
      1428     315011397               Cairns and Hinterland 1.0000000000
      1429     315011398                     Torres and Cape 1.0000000000
      1430     315011399                     Torres and Cape 1.0000000000
      1431     315011400               Cairns and Hinterland 1.0000000000
      1432     315011401                     Torres and Cape 1.0000000000
      1433     315011402                     Torres and Cape 1.0000000000
      1434     315011403                     Torres and Cape 1.0000000000
      1435     315021404                    North West (Qld) 1.0000000000
      1436     315021405                    North West (Qld) 1.0000000000
      1437     315021406                    North West (Qld) 1.0000000000
      1438     315021407                          Townsville 0.7290926703
      1439     315021407                    North West (Qld) 0.2709073297
      1440     315031408                  Central West (Qld) 1.0000000000
      1441     315031409                    South West (Qld) 1.0000000000
      1442     315031410                    North West (Qld) 0.0292887029
      1443     315031410                  Central West (Qld) 0.9707112971
      1444     315031411                    South West (Qld) 1.0000000000
      1445     315031412                  Central West (Qld) 1.0000000000
      1446     316011413                      Sunshine Coast 1.0000000000
      1447     316011414                      Sunshine Coast 1.0000000000
      1448     316011415                      Sunshine Coast 1.0000000000
      1449     316011416                      Sunshine Coast 1.0000000000
      1450     316021417                      Sunshine Coast 1.0000000000
      1451     316021418                      Sunshine Coast 1.0000000000
      1452     316021419                      Sunshine Coast 1.0000000000
      1453     316021420                      Sunshine Coast 1.0000000000
      1454     316021421                      Sunshine Coast 1.0000000000
      1455     316021422                      Sunshine Coast 1.0000000000
      1456     316021423                      Sunshine Coast 1.0000000000
      1457     316021424                      Sunshine Coast 1.0000000000
      1458     316031425                      Sunshine Coast 1.0000000000
      1459     316031426                      Sunshine Coast 1.0000000000
      1460     316031427                      Sunshine Coast 1.0000000000
      1461     316031428                      Sunshine Coast 1.0000000000
      1462     316041429                      Sunshine Coast 1.0000000000
      1463     316041430                      Sunshine Coast 1.0000000000
      1464     316041431                      Sunshine Coast 1.0000000000
      1465     316041432                      Sunshine Coast 1.0000000000
      1466     316041433                      Sunshine Coast 1.0000000000
      1467     316051434                      Sunshine Coast 1.0000000000
      1468     316051435                      Sunshine Coast 1.0000000000
      1469     316051436                      Sunshine Coast 1.0000000000
      1470     316051437                      Sunshine Coast 1.0000000000
      1471     316051438                      Sunshine Coast 1.0000000000
      1472     316061439                      Sunshine Coast 1.0000000000
      1473     316061440                      Sunshine Coast 1.0000000000
      1474     316061441                      Sunshine Coast 1.0000000000
      1475     316061442                      Sunshine Coast 1.0000000000
      1476     316061443                      Sunshine Coast 1.0000000000
      1477     316061444                      Sunshine Coast 1.0000000000
      1478     317011445                       Darling Downs 1.0000000000
      1479     317011446                       Darling Downs 1.0000000000
      1480     317011447                       Darling Downs 1.0000000000
      1481     317011448                        West Moreton 1.0000000000
      1482     317011449                       Darling Downs 1.0000000000
      1483     317011450                       Darling Downs 1.0000000000
      1484     317011451                        West Moreton 1.0000000000
      1485     317011452                       Darling Downs 1.0000000000
      1486     317011453                       Darling Downs 1.0000000000
      1487     317011454                       Darling Downs 1.0000000000
      1488     317011455                       Darling Downs 1.0000000000
      1489     317011456                       Darling Downs 1.0000000000
      1490     317011457                       Darling Downs 1.0000000000
      1491     317011458                       Darling Downs 1.0000000000
      1492     317011459                       Darling Downs 1.0000000000
      1493     318011460                          Townsville 1.0000000000
      1494     318011461                          Townsville 1.0000000000
      1495     318011462                          Townsville 1.0000000000
      1496     318011463                          Townsville 1.0000000000
      1497     318011464                          Townsville 1.0000000000
      1498     318011465                          Townsville 1.0000000000
      1499     318011466                          Townsville 1.0000000000
      1500     318021467                          Townsville 1.0000000000
      1501     318021468                          Townsville 1.0000000000
      1502     318021469                          Townsville 1.0000000000
      1503     318021470                          Townsville 1.0000000000
      1504     318021471                          Townsville 1.0000000000
      1505     318021472                          Townsville 1.0000000000
      1506     318021473                          Townsville 1.0000000000
      1507     318021474                          Townsville 1.0000000000
      1508     318021475                          Townsville 1.0000000000
      1509     318021476                          Townsville 1.0000000000
      1510     318021477                          Townsville 1.0000000000
      1511     318021478                          Townsville 1.0000000000
      1512     318021479                          Townsville 1.0000000000
      1513     318021480                          Townsville 1.0000000000
      1514     318021481                          Townsville 1.0000000000
      1515     318021482                          Townsville 1.0000000000
      1516     318021483                          Townsville 1.0000000000
      1517     318021484                          Townsville 1.0000000000
      1518     318021485                          Townsville 1.0000000000
      1519     318021486                          Townsville 1.0000000000
      1520     318021487                          Townsville 1.0000000000
      1521     318021488                          Townsville 1.0000000000
      1522     318021489                          Townsville 1.0000000000
      1523     318021490                          Townsville 1.0000000000
      1524     318021491                          Townsville 1.0000000000
      1525     319011492                            Wide Bay 1.0000000000
      1526     319011493                            Wide Bay 1.0000000000
      1527     319011494                            Wide Bay 1.0000000000
      1528     319011495                            Wide Bay 1.0000000000
      1529     319011496                            Wide Bay 1.0000000000
      1530     319011497                            Wide Bay 1.0000000000
      1531     319011498                            Wide Bay 1.0000000000
      1532     319011499                            Wide Bay 1.0000000000
      1533     319011500                            Wide Bay 1.0000000000
      1534     319011501                            Wide Bay 1.0000000000
      1535     319011502                            Wide Bay 1.0000000000
      1536     319021503                            Wide Bay 1.0000000000
      1537     319021504                            Wide Bay 1.0000000000
      1538     319021505                       Darling Downs 1.0000000000
      1539     319021506                       Darling Downs 0.9989523311
      1540     319021506                      Sunshine Coast 0.0010476689
      1541     319021507                       Darling Downs 1.0000000000
      1542     319021508                            Wide Bay 1.0000000000
      1543     319021509                       Darling Downs 1.0000000000
      1544     319021510                            Wide Bay 1.0000000000
      1545     319031511                      Sunshine Coast 1.0000000000
      1546     319031512                      Sunshine Coast 1.0000000000
      1547     319031513                      Sunshine Coast 1.0000000000
      1548     319031514                            Wide Bay 0.0002457727
      1549     319031514                      Sunshine Coast 0.9997542273
      1550     319031515                      Sunshine Coast 1.0000000000
      1551     319041516                            Wide Bay 1.0000000000
      1552     319041517                            Wide Bay 1.0000000000
      1553     319041518                            Wide Bay 1.0000000000
      1554     319041519                            Wide Bay 1.0000000000
      1555     319041520                            Wide Bay 1.0000000000
      1556     319041521                            Wide Bay 1.0000000000
      1557     319051522                            Wide Bay 1.0000000000
      1558     319051523                            Wide Bay 1.0000000000
      1559     319051524                            Wide Bay 1.0000000000
      1560     319051525                            Wide Bay 0.9899212598
      1561     319051525                      Sunshine Coast 0.0100787402
      1562     319051526                            Wide Bay 1.0000000000
      1563     401011001                    Central Adelaide 1.0000000000
      1564     401011002                    Central Adelaide 1.0000000000
      1565     401021003              Barossa Hills Fleurieu 1.0000000000
      1566     401021004              Barossa Hills Fleurieu 1.0000000000
      1567     401021005              Barossa Hills Fleurieu 1.0000000000
      1568     401021006              Barossa Hills Fleurieu 1.0000000000
      1569     401021007              Barossa Hills Fleurieu 1.0000000000
      1570     401021008              Barossa Hills Fleurieu 1.0000000000
      1571     401021009              Barossa Hills Fleurieu 1.0000000000
      1572     401021010              Barossa Hills Fleurieu 1.0000000000
      1573     401031011                    Central Adelaide 1.0000000000
      1574     401031012                    Central Adelaide 1.0000000000
      1575     401031013                    Central Adelaide 1.0000000000
      1576     401041014                    Central Adelaide 1.0000000000
      1577     401041015                    Central Adelaide 1.0000000000
      1578     401041016                    Central Adelaide 1.0000000000
      1579     401051017                    Central Adelaide 1.0000000000
      1580     401051018                    Central Adelaide 1.0000000000
      1581     401051019                    Central Adelaide 1.0000000000
      1582     401061020                    Central Adelaide 1.0000000000
      1583     401061021                    Central Adelaide 1.0000000000
      1584     401061022                    Central Adelaide 1.0000000000
      1585     401071023                    Central Adelaide 1.0000000000
      1586     401071024                    Central Adelaide 1.0000000000
      1587     402011025              Barossa Hills Fleurieu 1.0000000000
      1588     402011026              Barossa Hills Fleurieu 1.0000000000
      1589     402011027              Barossa Hills Fleurieu 1.0000000000
      1590     402021028                   Northern Adelaide 1.0000000000
      1591     402021029                   Northern Adelaide 1.0000000000
      1592     402021030                   Northern Adelaide 1.0000000000
      1593     402021031                   Northern Adelaide 1.0000000000
      1594     402021032                   Northern Adelaide 1.0000000000
      1595     402021033                   Northern Adelaide 1.0000000000
      1596     402021034                   Northern Adelaide 1.0000000000
      1597     402021035                   Northern Adelaide 1.0000000000
      1598     402031036                   Northern Adelaide 1.0000000000
      1599     402031037                   Northern Adelaide 1.0000000000
      1600     402031038                   Northern Adelaide 1.0000000000
      1601     402041039                   Northern Adelaide 1.0000000000
      1602     402041040                   Northern Adelaide 1.0000000000
      1603     402041041                   Northern Adelaide 1.0000000000
      1604     402041042                   Northern Adelaide 1.0000000000
      1605     402041043                   Northern Adelaide 1.0000000000
      1606     402041044                   Northern Adelaide 1.0000000000
      1607     402041045                   Northern Adelaide 1.0000000000
      1608     402041046                   Northern Adelaide 1.0000000000
      1609     402041047                   Northern Adelaide 1.0000000000
      1610     402041048                   Northern Adelaide 1.0000000000
      1611     402051049                   Northern Adelaide 1.0000000000
      1612     402051050                   Northern Adelaide 1.0000000000
      1613     402051051                   Northern Adelaide 1.0000000000
      1614     402051052                   Northern Adelaide 1.0000000000
      1615     402051053                   Northern Adelaide 1.0000000000
      1616     402051054                   Northern Adelaide 1.0000000000
      1617     402051055                   Northern Adelaide 1.0000000000
      1618     403011056                   Southern Adelaide 1.0000000000
      1619     403011057                   Southern Adelaide 1.0000000000
      1620     403021058                   Southern Adelaide 1.0000000000
      1621     403021059                   Southern Adelaide 1.0000000000
      1622     403021060                   Southern Adelaide 1.0000000000
      1623     403021061                   Southern Adelaide 1.0000000000
      1624     403021062                   Southern Adelaide 1.0000000000
      1625     403021063                   Southern Adelaide 1.0000000000
      1626     403021064                   Southern Adelaide 1.0000000000
      1627     403031065                   Southern Adelaide 1.0000000000
      1628     403031066                   Southern Adelaide 1.0000000000
      1629     403031067                   Southern Adelaide 1.0000000000
      1630     403031068                   Southern Adelaide 1.0000000000
      1631     403031069                   Southern Adelaide 1.0000000000
      1632     403031070                   Southern Adelaide 1.0000000000
      1633     403041071                   Southern Adelaide 1.0000000000
      1634     403041072                   Southern Adelaide 1.0000000000
      1635     403041073                   Southern Adelaide 1.0000000000
      1636     403041074                   Southern Adelaide 1.0000000000
      1637     403041075                   Southern Adelaide 1.0000000000
      1638     403041076                   Southern Adelaide 1.0000000000
      1639     403041077                   Southern Adelaide 1.0000000000
      1640     403041078                   Southern Adelaide 1.0000000000
      1641     403041079                   Southern Adelaide 1.0000000000
      1642     403041080                   Southern Adelaide 1.0000000000
      1643     403041081                   Southern Adelaide 1.0000000000
      1644     403041082                   Southern Adelaide 1.0000000000
      1645     403041083                   Southern Adelaide 1.0000000000
      1646     403041084                   Southern Adelaide 1.0000000000
      1647     403041085                   Southern Adelaide 1.0000000000
      1648     403041086                   Southern Adelaide 1.0000000000
      1649     403041087                   Southern Adelaide 1.0000000000
      1650     403041088                   Southern Adelaide 1.0000000000
      1651     403041089                   Southern Adelaide 1.0000000000
      1652     404011090                    Central Adelaide 1.0000000000
      1653     404011091                    Central Adelaide 1.0000000000
      1654     404011092                    Central Adelaide 1.0000000000
      1655     404011093                    Central Adelaide 1.0000000000
      1656     404011094                    Central Adelaide 1.0000000000
      1657     404011095                    Central Adelaide 1.0000000000
      1658     404011096                    Central Adelaide 1.0000000000
      1659     404011097                    Central Adelaide 1.0000000000
      1660     404021098                    Central Adelaide 1.0000000000
      1661     404021099                    Central Adelaide 1.0000000000
      1662     404021100                    Central Adelaide 1.0000000000
      1663     404021101                    Central Adelaide 1.0000000000
      1664     404021102                    Central Adelaide 1.0000000000
      1665     404021103                    Central Adelaide 1.0000000000
      1666     404031104                    Central Adelaide 1.0000000000
      1667     404031105                    Central Adelaide 1.0000000000
      1668     404031106                    Central Adelaide 1.0000000000
      1669     404031107                    Central Adelaide 1.0000000000
      1670     404031108                    Central Adelaide 1.0000000000
      1671     404031109                    Central Adelaide 1.0000000000
      1672     405011110              Barossa Hills Fleurieu 1.0000000000
      1673     405011111              Barossa Hills Fleurieu 1.0000000000
      1674     405011112              Barossa Hills Fleurieu 1.0000000000
      1675     405011113              Barossa Hills Fleurieu 1.0000000000
      1676     405011114              Barossa Hills Fleurieu 1.0000000000
      1677     405011115              Barossa Hills Fleurieu 1.0000000000
      1678     405021116                  Yorke and Northern 1.0000000000
      1679     405021117                  Yorke and Northern 1.0000000000
      1680     405021118              Barossa Hills Fleurieu 0.4224074528
      1681     405021118                  Yorke and Northern 0.5775925472
      1682     405021119                  Yorke and Northern 1.0000000000
      1683     405031120                  Yorke and Northern 1.0000000000
      1684     405031121                  Yorke and Northern 1.0000000000
      1685     405031122                  Yorke and Northern 1.0000000000
      1686     405031123                  Yorke and Northern 1.0000000000
      1687     405041124                  Yorke and Northern 1.0000000000
      1688     405041125                  Yorke and Northern 1.0000000000
      1689     405041126                  Yorke and Northern 1.0000000000
      1690     405041127                  Yorke and Northern 1.0000000000
      1691     405041128                  Yorke and Northern 1.0000000000
      1692     406011129                  Eyre and Far North 1.0000000000
      1693     406011130                  Eyre and Far North 1.0000000000
      1694     406011131                  Eyre and Far North 0.9772944551
      1695     406011131            Flinders and Upper North 0.0227055449
      1696     406011132                  Eyre and Far North 1.0000000000
      1697     406011133                  Eyre and Far North 1.0000000000
      1698     406011134                  Eyre and Far North 1.0000000000
      1699     406011135                  Eyre and Far North 1.0000000000
      1700     406011136            Flinders and Upper North 1.0000000000
      1701     406011137            Flinders and Upper North 1.0000000000
      1702     406021138                  Eyre and Far North 1.0000000000
      1703     406021139                  Eyre and Far North 1.0000000000
      1704     406021140                  Eyre and Far North 0.0184586987
      1705     406021140            Flinders and Upper North 0.9815413013
      1706     406021141                  Yorke and Northern 0.1114948199
      1707     406021141            Flinders and Upper North 0.6482486433
      1708     406021141                  Eyre and Far North 0.2195362605
      1709     406021141            Riverland Mallee Coorong 0.0207202763
      1710     406021142            Flinders and Upper North 1.0000000000
      1711     406021143            Flinders and Upper North 1.0000000000
      1712     407011144              Barossa Hills Fleurieu 1.0000000000
      1713     407011145              Barossa Hills Fleurieu 1.0000000000
      1714     407011146              Barossa Hills Fleurieu 1.0000000000
      1715     407011147              Barossa Hills Fleurieu 1.0000000000
      1716     407011148              Barossa Hills Fleurieu 1.0000000000
      1717     407011149              Barossa Hills Fleurieu 1.0000000000
      1718     407021150                     Limestone Coast 1.0000000000
      1719     407021151                     Limestone Coast 1.0000000000
      1720     407021152                     Limestone Coast 1.0000000000
      1721     407021153                     Limestone Coast 1.0000000000
      1722     407021154                     Limestone Coast 1.0000000000
      1723     407021155                     Limestone Coast 1.0000000000
      1724     407021156                     Limestone Coast 1.0000000000
      1725     407021157                     Limestone Coast 1.0000000000
      1726     407021158                     Limestone Coast 1.0000000000
      1727     407031159            Riverland Mallee Coorong 1.0000000000
      1728     407031160            Riverland Mallee Coorong 1.0000000000
      1729     407031161            Riverland Mallee Coorong 1.0000000000
      1730     407031162            Riverland Mallee Coorong 1.0000000000
      1731     407031163            Riverland Mallee Coorong 1.0000000000
      1732     407031164              Barossa Hills Fleurieu 0.2573673870
      1733     407031164            Riverland Mallee Coorong 0.7426326130
      1734     407031165            Riverland Mallee Coorong 1.0000000000
      1735     407031166            Riverland Mallee Coorong 1.0000000000
      1736     407031167            Riverland Mallee Coorong 1.0000000000
      1737     407031168            Riverland Mallee Coorong 1.0000000000
      1738     407031169            Riverland Mallee Coorong 1.0000000000
      1739     407031170              Barossa Hills Fleurieu 0.1088989442
      1740     407031170            Riverland Mallee Coorong 0.8911010558
      1741     501011001                               WACHS 1.0000000000
      1742     501011002                               WACHS 1.0000000000
      1743     501011003                               WACHS 1.0000000000
      1744     501011004                               WACHS 1.0000000000
      1745     501021005                               WACHS 1.0000000000
      1746     501021006                               WACHS 1.0000000000
      1747     501021007                               WACHS 1.0000000000
      1748     501021008                               WACHS 1.0000000000
      1749     501021009                               WACHS 1.0000000000
      1750     501021010                               WACHS 1.0000000000
      1751     501021011                               WACHS 1.0000000000
      1752     501021012                               WACHS 1.0000000000
      1753     501021013                               WACHS 1.0000000000
      1754     501021014                               WACHS 1.0000000000
      1755     501021015                               WACHS 1.0000000000
      1756     501021016                         South Metro 1.0000000000
      1757     501031017                               WACHS 1.0000000000
      1758     501031018                               WACHS 1.0000000000
      1759     501031019                               WACHS 1.0000000000
      1760     501031020                               WACHS 1.0000000000
      1761     502011021                         South Metro 1.0000000000
      1762     502011022                         South Metro 1.0000000000
      1763     502011023                         South Metro 1.0000000000
      1764     502011024                         South Metro 1.0000000000
      1765     502011025                         South Metro 1.0000000000
      1766     502011026                         South Metro 1.0000000000
      1767     502011027                         South Metro 1.0000000000
      1768     502011028                         South Metro 1.0000000000
      1769     502011029                         South Metro 1.0000000000
      1770     503011030                         North Metro 1.0000000000
      1771     503011031                         North Metro 1.0000000000
      1772     503011032                         North Metro 1.0000000000
      1773     503011033                         North Metro 1.0000000000
      1774     503011034                         North Metro 1.0000000000
      1775     503011035                         North Metro 1.0000000000
      1776     503011036                         North Metro 1.0000000000
      1777     503021037                         North Metro 1.0000000000
      1778     503021038                         North Metro 1.0000000000
      1779     503021039                          East Metro 1.0000000000
      1780     503021040                         North Metro 1.0000000000
      1781     503021041                          East Metro 1.0000000000
      1782     503021042                         North Metro 1.0000000000
      1783     503021043                         North Metro 1.0000000000
      1784     504011044                          East Metro 1.0000000000
      1785     504011045                          East Metro 1.0000000000
      1786     504011046                          East Metro 1.0000000000
      1787     504011047                          East Metro 1.0000000000
      1788     504011048                         North Metro 1.0000000000
      1789     504021049                          East Metro 1.0000000000
      1790     504021050                          East Metro 1.0000000000
      1791     504021051                          East Metro 1.0000000000
      1792     504021052                          East Metro 1.0000000000
      1793     504021053                          East Metro 1.0000000000
      1794     504021054                          East Metro 1.0000000000
      1795     504031055                          East Metro 1.0000000000
      1796     504031056                         North Metro 1.0000000000
      1797     504031057                          East Metro 1.0000000000
      1798     504031058                          East Metro 1.0000000000
      1799     504031059                          East Metro 1.0000000000
      1800     504031060                          East Metro 1.0000000000
      1801     504031061                          East Metro 1.0000000000
      1802     504031062                          East Metro 1.0000000000
      1803     504031063                         North Metro 1.0000000000
      1804     504031064                          East Metro 1.0000000000
      1805     504031065                          East Metro 1.0000000000
      1806     504031066                          East Metro 1.0000000000
      1807     504031067                          East Metro 1.0000000000
      1808     504031068                          East Metro 1.0000000000
      1809     504031069                          East Metro 1.0000000000
      1810     505011070                         North Metro 1.0000000000
      1811     505011071                         North Metro 1.0000000000
      1812     505011072                         North Metro 1.0000000000
      1813     505011073                         North Metro 1.0000000000
      1814     505011074                         North Metro 1.0000000000
      1815     505011075                         North Metro 1.0000000000
      1816     505011076                         North Metro 1.0000000000
      1817     505011077                         North Metro 1.0000000000
      1818     505011078                         North Metro 1.0000000000
      1819     505011079                         North Metro 1.0000000000
      1820     505011080                         North Metro 1.0000000000
      1821     505011081                         North Metro 1.0000000000
      1822     505011082                         North Metro 1.0000000000
      1823     505011083                         North Metro 1.0000000000
      1824     505021084                         North Metro 1.0000000000
      1825     505021085                         North Metro 1.0000000000
      1826     505021086                         North Metro 1.0000000000
      1827     505021087                         North Metro 1.0000000000
      1828     505021088                         North Metro 1.0000000000
      1829     505021089                         North Metro 1.0000000000
      1830     505021090                         North Metro 1.0000000000
      1831     505021091                         North Metro 1.0000000000
      1832     505021092                         North Metro 1.0000000000
      1833     505021093                         North Metro 1.0000000000
      1834     505021094                         North Metro 1.0000000000
      1835     505021095                         North Metro 1.0000000000
      1836     505021096                         North Metro 1.0000000000
      1837     505021097                         North Metro 1.0000000000
      1838     505031098                         North Metro 1.0000000000
      1839     505031099                         North Metro 1.0000000000
      1840     505031100                         North Metro 1.0000000000
      1841     505031101                         North Metro 1.0000000000
      1842     505031102                         North Metro 1.0000000000
      1843     505031103                         North Metro 1.0000000000
      1844     505031104                         North Metro 1.0000000000
      1845     505031105                         North Metro 1.0000000000
      1846     505031106                         North Metro 1.0000000000
      1847     505031107                         North Metro 1.0000000000
      1848     505031108                         North Metro 1.0000000000
      1849     505031109                         North Metro 1.0000000000
      1850     506011110                          East Metro 1.0000000000
      1851     506011111                          East Metro 1.0000000000
      1852     506011112                          East Metro 1.0000000000
      1853     506011113                          East Metro 1.0000000000
      1854     506011114                          East Metro 1.0000000000
      1855     506011115                          East Metro 1.0000000000
      1856     506011116                          East Metro 1.0000000000
      1857     506011117                          East Metro 1.0000000000
      1858     506021118                          East Metro 1.0000000000
      1859     506021119                          East Metro 1.0000000000
      1860     506021120                          East Metro 1.0000000000
      1861     506021121                          East Metro 1.0000000000
      1862     506021122                          East Metro 1.0000000000
      1863     506021123                          East Metro 1.0000000000
      1864     506031124                          East Metro 1.0000000000
      1865     506031125                         South Metro 1.0000000000
      1866     506031126                         South Metro 1.0000000000
      1867     506031127                          East Metro 1.0000000000
      1868     506031128                         South Metro 1.0000000000
      1869     506031129                         South Metro 1.0000000000
      1870     506031130                          East Metro 1.0000000000
      1871     506031131                         South Metro 1.0000000000
      1872     506041132                          East Metro 1.0000000000
      1873     506041133                         South Metro 1.0000000000
      1874     506041134                          East Metro 1.0000000000
      1875     506041135                          East Metro 1.0000000000
      1876     506041136                          East Metro 1.0000000000
      1877     506041137                          East Metro 1.0000000000
      1878     506051138                          East Metro 1.0000000000
      1879     506051139                          East Metro 1.0000000000
      1880     506051140                          East Metro 1.0000000000
      1881     506051141                          East Metro 1.0000000000
      1882     506061142                          East Metro 1.0000000000
      1883     506061143                          East Metro 1.0000000000
      1884     506061144                          East Metro 1.0000000000
      1885     506071145                         South Metro 1.0000000000
      1886     506071146                         South Metro 1.0000000000
      1887     506071147                          East Metro 1.0000000000
      1888     507011148                         South Metro 1.0000000000
      1889     507011149                         South Metro 1.0000000000
      1890     507011150                         South Metro 1.0000000000
      1891     507011151                         South Metro 1.0000000000
      1892     507011152                         South Metro 1.0000000000
      1893     507011153                         South Metro 1.0000000000
      1894     507011154                         South Metro 1.0000000000
      1895     507011155                         South Metro 1.0000000000
      1896     507011156                         South Metro 1.0000000000
      1897     507011157                         South Metro 1.0000000000
      1898     507011158                         South Metro 1.0000000000
      1899     507011159                         South Metro 1.0000000000
      1900     507011160                         South Metro 1.0000000000
      1901     507011161                         South Metro 1.0000000000
      1902     507011162                         South Metro 1.0000000000
      1903     507011163                         South Metro 1.0000000000
      1904     507021164                         South Metro 1.0000000000
      1905     507021165                         South Metro 1.0000000000
      1906     507021166                         South Metro 1.0000000000
      1907     507021167                         South Metro 1.0000000000
      1908     507031168                         South Metro 1.0000000000
      1909     507031169                         South Metro 1.0000000000
      1910     507031170                         South Metro 1.0000000000
      1911     507031171                         South Metro 1.0000000000
      1912     507031172                         South Metro 1.0000000000
      1913     507031173                         South Metro 1.0000000000
      1914     507031174                         South Metro 1.0000000000
      1915     507041175                         South Metro 1.0000000000
      1916     507041176                         South Metro 1.0000000000
      1917     507041177                         South Metro 1.0000000000
      1918     507041178                         South Metro 1.0000000000
      1919     507041179                         South Metro 1.0000000000
      1920     507041180                         South Metro 1.0000000000
      1921     507041181                         South Metro 1.0000000000
      1922     507041182                         South Metro 1.0000000000
      1923     507041183                         South Metro 1.0000000000
      1924     507041184                         South Metro 1.0000000000
      1925     507051185                         South Metro 1.0000000000
      1926     507051186                         South Metro 1.0000000000
      1927     507051187                         South Metro 1.0000000000
      1928     507051188                         South Metro 1.0000000000
      1929     507051189                         South Metro 1.0000000000
      1930     507051190                         South Metro 1.0000000000
      1931     507051191                         South Metro 1.0000000000
      1932     507051192                         South Metro 1.0000000000
      1933     507051193                         South Metro 1.0000000000
      1934     508011194                               WACHS 1.0000000000
      1935     508011195                               WACHS 1.0000000000
      1936     508021196                               WACHS 1.0000000000
      1937     508021197                               WACHS 1.0000000000
      1938     508031198                               WACHS 1.0000000000
      1939     508031199                               WACHS 1.0000000000
      1940     508031200                               WACHS 1.0000000000
      1941     508031201                               WACHS 1.0000000000
      1942     508031202                               WACHS 1.0000000000
      1943     508031203                               WACHS 1.0000000000
      1944     508031204                               WACHS 1.0000000000
      1945     508041205                               WACHS 1.0000000000
      1946     508041206                               WACHS 1.0000000000
      1947     508041207                               WACHS 1.0000000000
      1948     508041208                               WACHS 1.0000000000
      1949     508041209                               WACHS 1.0000000000
      1950     508051210                               WACHS 1.0000000000
      1951     508051211                               WACHS 1.0000000000
      1952     508051212                               WACHS 1.0000000000
      1953     508051213                               WACHS 1.0000000000
      1954     508051214                               WACHS 1.0000000000
      1955     508051215                               WACHS 1.0000000000
      1956     508051216                               WACHS 1.0000000000
      1957     508051217                               WACHS 1.0000000000
      1958     508061218                               WACHS 1.0000000000
      1959     508061219                               WACHS 1.0000000000
      1960     508061220                               WACHS 1.0000000000
      1961     508061221                               WACHS 1.0000000000
      1962     508061222                               WACHS 1.0000000000
      1963     508061223                               WACHS 1.0000000000
      1964     508061224                               WACHS 1.0000000000
      1965     509011225                               WACHS 1.0000000000
      1966     509011226                               WACHS 1.0000000000
      1967     509011227                               WACHS 1.0000000000
      1968     509011228                               WACHS 1.0000000000
      1969     509011229                               WACHS 1.0000000000
      1970     509011230                               WACHS 1.0000000000
      1971     509011231                               WACHS 1.0000000000
      1972     509011232                               WACHS 1.0000000000
      1973     509011233                               WACHS 1.0000000000
      1974     509011234                               WACHS 1.0000000000
      1975     509011235                               WACHS 1.0000000000
      1976     509021236                               WACHS 1.0000000000
      1977     509021237                               WACHS 1.0000000000
      1978     509021238                               WACHS 1.0000000000
      1979     509021239                               WACHS 1.0000000000
      1980     509021240                               WACHS 1.0000000000
      1981     509021241                               WACHS 1.0000000000
      1982     509021242                               WACHS 1.0000000000
      1983     509021243                               WACHS 1.0000000000
      1984     509021244                               WACHS 1.0000000000
      1985     509021245                               WACHS 1.0000000000
      1986     509031246                               WACHS 1.0000000000
      1987     509031247                               WACHS 1.0000000000
      1988     509031248                               WACHS 0.7211864407
      1989     509031248                         South Metro 0.2788135593
      1990     509031249                               WACHS 1.0000000000
      1991     509031250                               WACHS 1.0000000000
      1992     601011001            Tasmanian Health Service 1.0000000000
      1993     601011002            Tasmanian Health Service 1.0000000000
      1994     601011003            Tasmanian Health Service 1.0000000000
      1995     601021004            Tasmanian Health Service 1.0000000000
      1996     601021005            Tasmanian Health Service 1.0000000000
      1997     601021006            Tasmanian Health Service 1.0000000000
      1998     601021007            Tasmanian Health Service 1.0000000000
      1999     601021008            Tasmanian Health Service 1.0000000000
      2000     601021009            Tasmanian Health Service 1.0000000000
      2001     601021010            Tasmanian Health Service 1.0000000000
      2002     601021011            Tasmanian Health Service 1.0000000000
      2003     601021012            Tasmanian Health Service 1.0000000000
      2004     601031013            Tasmanian Health Service 1.0000000000
      2005     601031014            Tasmanian Health Service 1.0000000000
      2006     601031015            Tasmanian Health Service 1.0000000000
      2007     601031016            Tasmanian Health Service 1.0000000000
      2008     601031017            Tasmanian Health Service 1.0000000000
      2009     601031018            Tasmanian Health Service 1.0000000000
      2010     601031019            Tasmanian Health Service 1.0000000000
      2011     601031020            Tasmanian Health Service 1.0000000000
      2012     601031021            Tasmanian Health Service 1.0000000000
      2013     601041022            Tasmanian Health Service 1.0000000000
      2014     601041023            Tasmanian Health Service 1.0000000000
      2015     601041024            Tasmanian Health Service 1.0000000000
      2016     601041025            Tasmanian Health Service 1.0000000000
      2017     601041026            Tasmanian Health Service 1.0000000000
      2018     601051027            Tasmanian Health Service 1.0000000000
      2019     601051028            Tasmanian Health Service 1.0000000000
      2020     601051029            Tasmanian Health Service 1.0000000000
      2021     601051030            Tasmanian Health Service 1.0000000000
      2022     601051031            Tasmanian Health Service 1.0000000000
      2023     601051032            Tasmanian Health Service 1.0000000000
      2024     601051033            Tasmanian Health Service 1.0000000000
      2025     601061034            Tasmanian Health Service 1.0000000000
      2026     601061035            Tasmanian Health Service 1.0000000000
      2027     602011036            Tasmanian Health Service 1.0000000000
      2028     602011037            Tasmanian Health Service 1.0000000000
      2029     602011038            Tasmanian Health Service 1.0000000000
      2030     602011039            Tasmanian Health Service 1.0000000000
      2031     602011040            Tasmanian Health Service 1.0000000000
      2032     602011041            Tasmanian Health Service 1.0000000000
      2033     602011042            Tasmanian Health Service 1.0000000000
      2034     602011043            Tasmanian Health Service 1.0000000000
      2035     602011044            Tasmanian Health Service 1.0000000000
      2036     602011045            Tasmanian Health Service 1.0000000000
      2037     602011046            Tasmanian Health Service 1.0000000000
      2038     602011047            Tasmanian Health Service 1.0000000000
      2039     602011048            Tasmanian Health Service 1.0000000000
      2040     602011049            Tasmanian Health Service 1.0000000000
      2041     602011050            Tasmanian Health Service 1.0000000000
      2042     602011051            Tasmanian Health Service 1.0000000000
      2043     602011052            Tasmanian Health Service 1.0000000000
      2044     602021053            Tasmanian Health Service 1.0000000000
      2045     602021054            Tasmanian Health Service 1.0000000000
      2046     602021055            Tasmanian Health Service 1.0000000000
      2047     602021056            Tasmanian Health Service 1.0000000000
      2048     602021057            Tasmanian Health Service 1.0000000000
      2049     602031058            Tasmanian Health Service 1.0000000000
      2050     602031059            Tasmanian Health Service 1.0000000000
      2051     602031060            Tasmanian Health Service 1.0000000000
      2052     602031061            Tasmanian Health Service 1.0000000000
      2053     602031062            Tasmanian Health Service 1.0000000000
      2054     602031063            Tasmanian Health Service 1.0000000000
      2055     602031064            Tasmanian Health Service 1.0000000000
      2056     603011065            Tasmanian Health Service 1.0000000000
      2057     603011066            Tasmanian Health Service 1.0000000000
      2058     603011067            Tasmanian Health Service 1.0000000000
      2059     603011068            Tasmanian Health Service 1.0000000000
      2060     603021069            Tasmanian Health Service 1.0000000000
      2061     603021070            Tasmanian Health Service 1.0000000000
      2062     603021071            Tasmanian Health Service 1.0000000000
      2063     603021072            Tasmanian Health Service 1.0000000000
      2064     603031073            Tasmanian Health Service 1.0000000000
      2065     603031074            Tasmanian Health Service 1.0000000000
      2066     604011075            Tasmanian Health Service 1.0000000000
      2067     604011076            Tasmanian Health Service 1.0000000000
      2068     604011077            Tasmanian Health Service 1.0000000000
      2069     604011078            Tasmanian Health Service 1.0000000000
      2070     604011079            Tasmanian Health Service 1.0000000000
      2071     604011080            Tasmanian Health Service 1.0000000000
      2072     604011081            Tasmanian Health Service 1.0000000000
      2073     604011082            Tasmanian Health Service 1.0000000000
      2074     604011083            Tasmanian Health Service 1.0000000000
      2075     604011084            Tasmanian Health Service 1.0000000000
      2076     604021085            Tasmanian Health Service 1.0000000000
      2077     604021086            Tasmanian Health Service 1.0000000000
      2078     604021087            Tasmanian Health Service 1.0000000000
      2079     604021088            Tasmanian Health Service 1.0000000000
      2080     604021089            Tasmanian Health Service 1.0000000000
      2081     604021090            Tasmanian Health Service 1.0000000000
      2082     604021091            Tasmanian Health Service 1.0000000000
      2083     604021092            Tasmanian Health Service 1.0000000000
      2084     604031093            Tasmanian Health Service 1.0000000000
      2085     604031094            Tasmanian Health Service 1.0000000000
      2086     604031095            Tasmanian Health Service 1.0000000000
      2087     604031096            Tasmanian Health Service 1.0000000000
      2088     604031097            Tasmanian Health Service 1.0000000000
      2089     604031098            Tasmanian Health Service 1.0000000000
      2090     701011001 NT Regional Health Services (NTRHS) 1.0000000000
      2091     701011002 NT Regional Health Services (NTRHS) 1.0000000000
      2092     701011003 NT Regional Health Services (NTRHS) 1.0000000000
      2093     701011004 NT Regional Health Services (NTRHS) 1.0000000000
      2094     701011005 NT Regional Health Services (NTRHS) 1.0000000000
      2095     701011006 NT Regional Health Services (NTRHS) 1.0000000000
      2096     701011007 NT Regional Health Services (NTRHS) 1.0000000000
      2097     701011008 NT Regional Health Services (NTRHS) 1.0000000000
      2098     701011009 NT Regional Health Services (NTRHS) 1.0000000000
      2099     701021010 NT Regional Health Services (NTRHS) 1.0000000000
      2100     701021011 NT Regional Health Services (NTRHS) 1.0000000000
      2101     701021012 NT Regional Health Services (NTRHS) 1.0000000000
      2102     701021013 NT Regional Health Services (NTRHS) 1.0000000000
      2103     701021014 NT Regional Health Services (NTRHS) 1.0000000000
      2104     701021015 NT Regional Health Services (NTRHS) 1.0000000000
      2105     701021016 NT Regional Health Services (NTRHS) 1.0000000000
      2106     701021017 NT Regional Health Services (NTRHS) 1.0000000000
      2107     701021018 NT Regional Health Services (NTRHS) 1.0000000000
      2108     701021019 NT Regional Health Services (NTRHS) 1.0000000000
      2109     701021020 NT Regional Health Services (NTRHS) 1.0000000000
      2110     701021021 NT Regional Health Services (NTRHS) 1.0000000000
      2111     701021022 NT Regional Health Services (NTRHS) 1.0000000000
      2112     701021023 NT Regional Health Services (NTRHS) 1.0000000000
      2113     701021024 NT Regional Health Services (NTRHS) 1.0000000000
      2114     701021025 NT Regional Health Services (NTRHS) 1.0000000000
      2115     701021026 NT Regional Health Services (NTRHS) 1.0000000000
      2116     701021027 NT Regional Health Services (NTRHS) 1.0000000000
      2117     701021028 NT Regional Health Services (NTRHS) 1.0000000000
      2118     701021029 NT Regional Health Services (NTRHS) 1.0000000000
      2119     701021030 NT Regional Health Services (NTRHS) 1.0000000000
      2120     701031031 NT Regional Health Services (NTRHS) 1.0000000000
      2121     701031032 NT Regional Health Services (NTRHS) 1.0000000000
      2122     701031033 NT Regional Health Services (NTRHS) 1.0000000000
      2123     701031034 NT Regional Health Services (NTRHS) 1.0000000000
      2124     701031035 NT Regional Health Services (NTRHS) 1.0000000000
      2125     701041036 NT Regional Health Services (NTRHS) 1.0000000000
      2126     701041037 NT Regional Health Services (NTRHS) 1.0000000000
      2127     701041038 NT Regional Health Services (NTRHS) 1.0000000000
      2128     701041039 NT Regional Health Services (NTRHS) 1.0000000000
      2129     701041040 NT Regional Health Services (NTRHS) 1.0000000000
      2130     701041041 NT Regional Health Services (NTRHS) 1.0000000000
      2131     701041042 NT Regional Health Services (NTRHS) 1.0000000000
      2132     701041043 NT Regional Health Services (NTRHS) 1.0000000000
      2133     701041044 NT Regional Health Services (NTRHS) 1.0000000000
      2134     702011045 NT Regional Health Services (NTRHS) 1.0000000000
      2135     702011046 NT Regional Health Services (NTRHS) 1.0000000000
      2136     702011047 NT Regional Health Services (NTRHS) 1.0000000000
      2137     702011048 NT Regional Health Services (NTRHS) 1.0000000000
      2138     702011049 NT Regional Health Services (NTRHS) 1.0000000000
      2139     702011050 NT Regional Health Services (NTRHS) 1.0000000000
      2140     702011051 NT Regional Health Services (NTRHS) 1.0000000000
      2141     702011052 NT Regional Health Services (NTRHS) 1.0000000000
      2142     702011053 NT Regional Health Services (NTRHS) 1.0000000000
      2143     702011054 NT Regional Health Services (NTRHS) 1.0000000000
      2144     702021055 NT Regional Health Services (NTRHS) 1.0000000000
      2145     702021056 NT Regional Health Services (NTRHS) 1.0000000000
      2146     702031057 NT Regional Health Services (NTRHS) 1.0000000000
      2147     702031058 NT Regional Health Services (NTRHS) 1.0000000000
      2148     702031059 NT Regional Health Services (NTRHS) 1.0000000000
      2149     702031060 NT Regional Health Services (NTRHS) 1.0000000000
      2150     702031061 NT Regional Health Services (NTRHS) 1.0000000000
      2151     702041062 NT Regional Health Services (NTRHS) 1.0000000000
      2152     702041063 NT Regional Health Services (NTRHS) 1.0000000000
      2153     702041064 NT Regional Health Services (NTRHS) 1.0000000000
      2154     702051065 NT Regional Health Services (NTRHS) 1.0000000000
      2155     702051066 NT Regional Health Services (NTRHS) 1.0000000000
      2156     702051067 NT Regional Health Services (NTRHS) 1.0000000000
      2157     702051068 NT Regional Health Services (NTRHS) 1.0000000000
      2158     801011001        Australian Capital Territory 1.0000000000
      2159     801011002        Australian Capital Territory 1.0000000000
      2160     801011003        Australian Capital Territory 1.0000000000
      2161     801011004        Australian Capital Territory 1.0000000000
      2162     801011005        Australian Capital Territory 1.0000000000
      2163     801011006        Australian Capital Territory 1.0000000000
      2164     801011007        Australian Capital Territory 1.0000000000
      2165     801011008        Australian Capital Territory 1.0000000000
      2166     801011009        Australian Capital Territory 1.0000000000
      2167     801011010        Australian Capital Territory 1.0000000000
      2168     801011011        Australian Capital Territory 1.0000000000
      2169     801011012        Australian Capital Territory 1.0000000000
      2170     801011013        Australian Capital Territory 1.0000000000
      2171     801011014        Australian Capital Territory 1.0000000000
      2172     801011015        Australian Capital Territory 1.0000000000
      2173     801011016        Australian Capital Territory 1.0000000000
      2174     801011017        Australian Capital Territory 1.0000000000
      2175     801011018        Australian Capital Territory 1.0000000000
      2176     801011019        Australian Capital Territory 1.0000000000
      2177     801011020        Australian Capital Territory 1.0000000000
      2178     801011021        Australian Capital Territory 1.0000000000
      2179     801011022        Australian Capital Territory 1.0000000000
      2180     801011023        Australian Capital Territory 1.0000000000
      2181     801011024        Australian Capital Territory 1.0000000000
      2182     801011025        Australian Capital Territory 1.0000000000
      2183     801011026        Australian Capital Territory 1.0000000000
      2184     801021027        Australian Capital Territory 1.0000000000
      2185     801021028        Australian Capital Territory 1.0000000000
      2186     801021029        Australian Capital Territory 1.0000000000
      2187     801031030        Australian Capital Territory 1.0000000000
      2188     801031031        Australian Capital Territory 1.0000000000
      2189     801031032        Australian Capital Territory 1.0000000000
      2190     801031033        Australian Capital Territory 1.0000000000
      2191     801041034        Australian Capital Territory 1.0000000000
      2192     801041035        Australian Capital Territory 1.0000000000
      2193     801041036        Australian Capital Territory 1.0000000000
      2194     801041037        Australian Capital Territory 1.0000000000
      2195     801041038        Australian Capital Territory 1.0000000000
      2196     801041039        Australian Capital Territory 1.0000000000
      2197     801041040        Australian Capital Territory 1.0000000000
      2198     801041041        Australian Capital Territory 1.0000000000
      2199     801041042        Australian Capital Territory 1.0000000000
      2200     801041043        Australian Capital Territory 1.0000000000
      2201     801041044        Australian Capital Territory 1.0000000000
      2202     801041045        Australian Capital Territory 1.0000000000
      2203     801041046        Australian Capital Territory 1.0000000000
      2204     801041047        Australian Capital Territory 1.0000000000
      2205     801041048        Australian Capital Territory 1.0000000000
      2206     801051049        Australian Capital Territory 1.0000000000
      2207     801051050        Australian Capital Territory 1.0000000000
      2208     801051051        Australian Capital Territory 1.0000000000
      2209     801051052        Australian Capital Territory 1.0000000000
      2210     801051053        Australian Capital Territory 1.0000000000
      2211     801051054        Australian Capital Territory 1.0000000000
      2212     801051055        Australian Capital Territory 1.0000000000
      2213     801051056        Australian Capital Territory 1.0000000000
      2214     801051057        Australian Capital Territory 1.0000000000
      2215     801051058        Australian Capital Territory 1.0000000000
      2216     801051059        Australian Capital Territory 1.0000000000
      2217     801051060        Australian Capital Territory 1.0000000000
      2218     801051061        Australian Capital Territory 1.0000000000
      2219     801061062        Australian Capital Territory 1.0000000000
      2220     801061063        Australian Capital Territory 1.0000000000
      2221     801061064        Australian Capital Territory 1.0000000000
      2222     801061065        Australian Capital Territory 1.0000000000
      2223     801061066        Australian Capital Territory 1.0000000000
      2224     801061067        Australian Capital Territory 1.0000000000
      2225     801061068        Australian Capital Territory 1.0000000000
      2226     801061069        Australian Capital Territory 1.0000000000
      2227     801061070        Australian Capital Territory 1.0000000000
      2228     801071071        Australian Capital Territory 1.0000000000
      2229     801071072        Australian Capital Territory 1.0000000000
      2230     801071073        Australian Capital Territory 1.0000000000
      2231     801071074        Australian Capital Territory 1.0000000000
      2232     801071075        Australian Capital Territory 1.0000000000
      2233     801071076        Australian Capital Territory 1.0000000000
      2234     801071077        Australian Capital Territory 1.0000000000
      2235     801071078        Australian Capital Territory 1.0000000000
      2236     801071079        Australian Capital Territory 1.0000000000
      2237     801071080        Australian Capital Territory 1.0000000000
      2238     801071081        Australian Capital Territory 1.0000000000
      2239     801071082        Australian Capital Territory 1.0000000000
      2240     801071083        Australian Capital Territory 1.0000000000
      2241     801071084        Australian Capital Territory 1.0000000000
      2242     801071085        Australian Capital Territory 1.0000000000
      2243     801071086        Australian Capital Territory 1.0000000000
      2244     801071087        Australian Capital Territory 1.0000000000
      2245     801071088        Australian Capital Territory 1.0000000000
      2246     801071089        Australian Capital Territory 1.0000000000
      2247     801071090        Australian Capital Territory 1.0000000000
      2248     801081091        Australian Capital Territory 1.0000000000
      2249     801081092        Australian Capital Territory 1.0000000000
      2250     801081093        Australian Capital Territory 1.0000000000
      2251     801081094        Australian Capital Territory 1.0000000000
      2252     801081095        Australian Capital Territory 1.0000000000
      2253     801081096        Australian Capital Territory 1.0000000000
      2254     801081097        Australian Capital Territory 1.0000000000
      2255     801081098        Australian Capital Territory 1.0000000000
      2256     801091099        Australian Capital Territory 1.0000000000
      2257     801091100        Australian Capital Territory 1.0000000000
      2258     801091101        Australian Capital Territory 1.0000000000
      2259     801091102        Australian Capital Territory 1.0000000000
      2260     801091103        Australian Capital Territory 1.0000000000
      2261     801091104        Australian Capital Territory 1.0000000000
      2262     801091105        Australian Capital Territory 1.0000000000
      2263     801091106        Australian Capital Territory 1.0000000000
      2264     801091107        Australian Capital Territory 1.0000000000
      2265     801091108        Australian Capital Territory 1.0000000000
      2266     801091109        Australian Capital Territory 1.0000000000
      2267     801091110        Australian Capital Territory 1.0000000000
      2268     901011001                                <NA> 1.0000000000
      2269     901021002                                <NA> 1.0000000000
      2270     901031003                                <NA> 1.0000000000

---

    Code
      x
    Output
      # A tibble: 2,270 x 3
      # Groups:   sa2_code_2011 [2,196]
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
      # i 2,260 more rows

# can get CG using input polygons rather than areas/years

    Code
      df_sample
    Output
          sa3_code_2016                            LHN_Name        ratio
      1           10102                        Southern NSW 1.000000e+00
      2           10103                        Southern NSW 1.000000e+00
      3           10104                Illawarra Shoalhaven 2.588675e-03
      4           10104                        Southern NSW 9.974113e-01
      5           10105                        Southern NSW 9.998431e-01
      6           10105                South Western Sydney 1.569161e-04
      7           10106                        Southern NSW 4.956321e-01
      8           10106                        Murrumbidgee 5.043679e-01
      9           10201                 Central Coast (NSW) 1.000000e+00
      10          10202                 Central Coast (NSW) 1.000000e+00
      11          10301               Nepean Blue Mountains 2.033058e-04
      12          10301                         Western NSW 9.997967e-01
      13          10302                        Murrumbidgee 1.338340e-01
      14          10302                         Western NSW 8.661660e-01
      15          10303                  Hunter New England 6.277201e-05
      16          10303                         Western NSW 5.650109e-01
      17          10303               Nepean Blue Mountains 4.349263e-01
      18          10304                         Western NSW 1.000000e+00
      19          10401                        Northern NSW 1.000000e+00
      20          10402                        Northern NSW 4.814923e-03
      21          10402               Mid North Coast (NSW) 9.951851e-01
      22          10501                         Western NSW 1.000000e+00
      23          10502                        Far West NSW 1.000000e+00
      24          10503                         Western NSW 1.000000e+00
      25          10601                  Hunter New England 1.000000e+00
      26          10602                  Hunter New England 1.000000e+00
      27          10603                  Hunter New England 1.000000e+00
      28          10604                  Hunter New England 1.000000e+00
      29          10701                Illawarra Shoalhaven 1.000000e+00
      30          10702                Illawarra Shoalhaven 5.000000e-01
      31          10702                South Western Sydney 5.000000e-01
      32          10703                Illawarra Shoalhaven 1.000000e+00
      33          10704                South Western Sydney 1.263067e-04
      34          10704                Illawarra Shoalhaven 9.998737e-01
      35          10801                  Hunter New England 1.000000e+00
      36          10802               Mid North Coast (NSW) 9.987896e-01
      37          10802                  Hunter New England 1.210441e-03
      38          10803                South Eastern Sydney 1.000000e+00
      39          10804               Mid North Coast (NSW) 9.998159e-01
      40          10804                  Hunter New England 1.840583e-04
      41          10805                  Hunter New England 1.000000e+00
      42          10901                        Murrumbidgee 1.000000e+00
      43          10902                        Murrumbidgee 2.616586e-01
      44          10902                        Far West NSW 7.383414e-01
      45          10903                        Murrumbidgee 1.000000e+00
      46          11001                  Hunter New England 1.000000e+00
      47          11002                        Northern NSW 1.217589e-02
      48          11002                  Hunter New England 9.878241e-01
      49          11003                  Hunter New England 1.000000e+00
      50          11004                  Hunter New England 1.000000e+00
      51          11101                  Hunter New England 9.938787e-01
      52          11101                 Central Coast (NSW) 6.121318e-03
      53          11102                  Hunter New England 1.000000e+00
      54          11103                  Hunter New England 1.000000e+00
      55          11201                        Northern NSW 1.000000e+00
      56          11202                        Northern NSW 1.000000e+00
      57          11203                        Northern NSW 1.000000e+00
      58          11301                        Murrumbidgee 1.000000e+00
      59          11302                        Murrumbidgee 1.000000e+00
      60          11303                        Murrumbidgee 1.000000e+00
      61          11401                Illawarra Shoalhaven 9.999723e-01
      62          11401                South Western Sydney 2.772054e-05
      63          11402                South Western Sydney 9.982367e-01
      64          11402                Illawarra Shoalhaven 1.763301e-03
      65          11501                      Western Sydney 8.371088e-01
      66          11501                     Northern Sydney 1.628912e-01
      67          11502                      Western Sydney 5.330461e-01
      68          11502                     Northern Sydney 4.651948e-01
      69          11502               Nepean Blue Mountains 1.759110e-03
      70          11503               Nepean Blue Mountains 1.000000e+00
      71          11504               Nepean Blue Mountains 1.935734e-01
      72          11504                      Western Sydney 8.064266e-01
      73          11601                      Western Sydney 1.000000e+00
      74          11602                      Western Sydney 1.000000e+00
      75          11603                      Western Sydney 1.000000e+00
      76          11701                South Eastern Sydney 1.000000e+00
      77          11702                              Sydney 1.000000e+00
      78          11703                South Eastern Sydney 3.349065e-01
      79          11703                              Sydney 6.650935e-01
      80          11801                South Eastern Sydney 1.000000e+00
      81          11802                South Eastern Sydney 1.000000e+00
      82          11901                              Sydney 8.786856e-03
      83          11901                South Western Sydney 9.912131e-01
      84          11902                South Western Sydney 5.964470e-02
      85          11902                              Sydney 9.403553e-01
      86          11903                              Sydney 6.976320e-02
      87          11903                South Eastern Sydney 9.302368e-01
      88          11904                South Eastern Sydney 1.000000e+00
      89          12001                              Sydney 1.000000e+00
      90          12002                              Sydney 1.000000e+00
      91          12003                              Sydney 1.000000e+00
      92          12101                     Northern Sydney 1.000000e+00
      93          12102                     Northern Sydney 1.000000e+00
      94          12103                     Northern Sydney 1.000000e+00
      95          12104                     Northern Sydney 1.000000e+00
      96          12201                     Northern Sydney 1.000000e+00
      97          12202                     Northern Sydney 1.000000e+00
      98          12203                     Northern Sydney 1.000000e+00
      99          12301                South Western Sydney 1.000000e+00
      100         12302                South Western Sydney 1.000000e+00
      101         12303                South Western Sydney 1.000000e+00
      102         12401               Nepean Blue Mountains 1.000000e+00
      103         12402                South Western Sydney 1.000000e+00
      104         12403               Nepean Blue Mountains 9.571342e-01
      105         12403                South Western Sydney 4.286576e-02
      106         12404               Nepean Blue Mountains 1.000000e+00
      107         12405               Nepean Blue Mountains 1.000000e+00
      108         12501                      Western Sydney 9.925491e-01
      109         12501                South Western Sydney 7.450916e-03
      110         12502                      Western Sydney 8.913826e-01
      111         12502                     Northern Sydney 1.086174e-01
      112         12503                      Western Sydney 7.774624e-01
      113         12503                South Western Sydney 2.225376e-01
      114         12504                      Western Sydney 1.000000e+00
      115         12601                      Western Sydney 1.728206e-01
      116         12601                     Northern Sydney 8.271794e-01
      117         12602                     Northern Sydney 9.725189e-01
      118         12602                      Western Sydney 2.748108e-02
      119         12701                South Western Sydney 1.000000e+00
      120         12702               Nepean Blue Mountains 8.816444e-03
      121         12702                South Western Sydney 9.911836e-01
      122         12703                South Western Sydney 9.955822e-01
      123         12703                South Eastern Sydney 4.417763e-03
      124         12801                South Eastern Sydney 1.000000e+00
      125         12802                South Eastern Sydney 1.000000e+00
      126         20101                   Central Highlands 1.000000e+00
      127         20102                   Central Highlands 1.000000e+00
      128         20103                   Central Highlands 4.897510e-01
      129         20103                              Loddon 5.102490e-01
      130         20201                              Loddon 1.000000e+00
      131         20202                              Loddon 1.000000e+00
      132         20203                              Loddon 1.000000e+00
      133         20301                              Barwon 2.943478e-01
      134         20301                   Central Highlands 7.056522e-01
      135         20302                              Barwon 1.000000e+00
      136         20303                              Barwon 1.000000e+00
      137         20401                            Goulburn 8.205914e-01
      138         20401                        Ovens Murray 1.753796e-01
      139         20401             Outer Eastern Melbourne 4.029036e-03
      140         20402                            Goulburn 1.504751e-03
      141         20402                        Ovens Murray 9.984952e-01
      142         20403                        Ovens Murray 1.000000e+00
      143         20501                     Inner Gippsland 1.000000e+00
      144         20502                     Outer Gippsland 1.000000e+00
      145         20503                   Bayside Peninsula 1.930664e-03
      146         20503                     Inner Gippsland 9.980693e-01
      147         20504                     Inner Gippsland 1.000000e+00
      148         20505                     Outer Gippsland 1.000000e+00
      149         20601             North Eastern Melbourne 2.227990e-04
      150         20601                       Hume Moreland 9.997772e-01
      151         20602             North Eastern Melbourne 1.000000e+00
      152         20603                   Western Melbourne 1.000000e+00
      153         20604                   Western Melbourne 1.000000e+00
      154         20605                   Bayside Peninsula 9.998530e-01
      155         20605                   Western Melbourne 1.470257e-04
      156         20606                   Bayside Peninsula 1.000000e+00
      157         20607                       Hume Moreland 1.038582e-02
      158         20607             North Eastern Melbourne 9.896142e-01
      159         20701             Inner Eastern Melbourne 1.000000e+00
      160         20702             Inner Eastern Melbourne 1.000000e+00
      161         20703             Inner Eastern Melbourne 1.000000e+00
      162         20801                   Bayside Peninsula 1.000000e+00
      163         20802                   Bayside Peninsula 9.518351e-01
      164         20802             Inner Eastern Melbourne 4.816492e-02
      165         20803                   Bayside Peninsula 1.000000e+00
      166         20804                   Bayside Peninsula 1.000000e+00
      167         20901             North Eastern Melbourne 1.000000e+00
      168         20902             North Eastern Melbourne 1.000000e+00
      169         20903                            Goulburn 6.257361e-02
      170         20903             North Eastern Melbourne 9.374264e-01
      171         20904                            Goulburn 8.973881e-02
      172         20904             North Eastern Melbourne 9.102612e-01
      173         21001                       Hume Moreland 8.107275e-05
      174         21001                     Brimbank Melton 1.386020e-01
      175         21001                   Western Melbourne 8.613169e-01
      176         21002                              Loddon 1.000000e+00
      177         21003                       Hume Moreland 1.000000e+00
      178         21004                       Hume Moreland 8.835445e-01
      179         21004                     Brimbank Melton 1.164555e-01
      180         21005                       Hume Moreland 1.000000e+00
      181         21101             Outer Eastern Melbourne 1.000000e+00
      182         21102             Outer Eastern Melbourne 1.465285e-02
      183         21102             Inner Eastern Melbourne 9.853472e-01
      184         21103             Outer Eastern Melbourne 1.000000e+00
      185         21104             Outer Eastern Melbourne 7.395769e-03
      186         21104             Inner Eastern Melbourne 9.926042e-01
      187         21105             Outer Eastern Melbourne 9.988604e-01
      188         21105                  Southern Melbourne 1.139619e-03
      189         21201                  Southern Melbourne 9.972212e-01
      190         21201             Outer Eastern Melbourne 2.778787e-03
      191         21202                  Southern Melbourne 1.000000e+00
      192         21203                  Southern Melbourne 1.000000e+00
      193         21204                  Southern Melbourne 8.172674e-01
      194         21204                   Bayside Peninsula 1.827326e-01
      195         21205             Inner Eastern Melbourne 1.000000e+00
      196         21301                     Brimbank Melton 1.000000e+00
      197         21302                   Western Melbourne 1.000000e+00
      198         21303                   Western Melbourne 1.000000e+00
      199         21304                   Central Highlands 1.244188e-01
      200         21304                     Brimbank Melton 8.755812e-01
      201         21305                   Western Melbourne 1.000000e+00
      202         21401                   Bayside Peninsula 1.000000e+00
      203         21402                   Bayside Peninsula 1.000000e+00
      204         21501                   Central Highlands 1.938635e-01
      205         21501                  Wimmera South West 8.061365e-01
      206         21502                              Mallee 1.000000e+00
      207         21503                              Mallee 1.000000e+00
      208         21601                              Loddon 9.959326e-01
      209         21601                            Goulburn 4.067448e-03
      210         21602                            Goulburn 1.000000e+00
      211         21603                            Goulburn 1.000000e+00
      212         21701                  Wimmera South West 1.000000e+00
      213         21703                              Barwon 5.823377e-01
      214         21703                  Wimmera South West 4.176623e-01
      215         21704                  Wimmera South West 1.000000e+00
      216         30101                   Metro South (Qld) 1.000000e+00
      217         30102                   Metro South (Qld) 1.000000e+00
      218         30103                   Metro South (Qld) 1.000000e+00
      219         30201                   Metro North (Qld) 1.000000e+00
      220         30202                   Metro North (Qld) 1.000000e+00
      221         30203                   Metro North (Qld) 1.000000e+00
      222         30204                   Metro North (Qld) 1.000000e+00
      223         30301                   Metro South (Qld) 1.000000e+00
      224         30302                   Metro South (Qld) 1.000000e+00
      225         30303                   Metro South (Qld) 1.000000e+00
      226         30304                   Metro South (Qld) 1.000000e+00
      227         30305                   Metro South (Qld) 1.000000e+00
      228         30306                   Metro South (Qld) 1.000000e+00
      229         30401                   Metro South (Qld) 1.000000e+00
      230         30402                   Metro North (Qld) 1.000000e+00
      231         30403                   Metro South (Qld) 3.612109e-01
      232         30403                   Metro North (Qld) 6.387891e-01
      233         30404                   Metro North (Qld) 1.000000e+00
      234         30501                   Metro North (Qld) 4.851334e-01
      235         30501                   Metro South (Qld) 5.148666e-01
      236         30502                   Metro South (Qld) 1.000000e+00
      237         30503                   Metro North (Qld) 1.000000e+00
      238         30504                   Metro North (Qld) 1.000000e+00
      239         30601               Cairns and Hinterland 1.000000e+00
      240         30602               Cairns and Hinterland 1.000000e+00
      241         30603               Cairns and Hinterland 9.445120e-01
      242         30603                          Townsville 5.548799e-02
      243         30604               Cairns and Hinterland 1.000000e+00
      244         30605               Cairns and Hinterland 1.000000e+00
      245         30701                    South West (Qld) 3.874151e-01
      246         30701                       Darling Downs 6.125849e-01
      247         30702                       Darling Downs 1.000000e+00
      248         30703                       Darling Downs 1.000000e+00
      249         30801                  Central Queensland 1.000000e+00
      250         30803                  Central Queensland 1.000000e+00
      251         30804                       Darling Downs 6.507203e-02
      252         30804                  Central Queensland 9.349280e-01
      253         30805                  Central Queensland 8.931568e-01
      254         30805                            Wide Bay 1.068432e-01
      255         30901                          Gold Coast 1.000000e+00
      256         30902                          Gold Coast 1.000000e+00
      257         30903                          Gold Coast 1.000000e+00
      258         30904                          Gold Coast 9.947279e-01
      259         30904                   Metro South (Qld) 5.272058e-03
      260         30905                          Gold Coast 1.000000e+00
      261         30906                          Gold Coast 1.000000e+00
      262         30907                          Gold Coast 1.000000e+00
      263         30908                          Gold Coast 1.000000e+00
      264         30909                          Gold Coast 1.000000e+00
      265         30910                          Gold Coast 1.000000e+00
      266         31001                   Metro South (Qld) 1.000000e+00
      267         31002                   Metro South (Qld) 4.759214e-04
      268         31002                        West Moreton 9.995241e-01
      269         31003                        West Moreton 1.000000e+00
      270         31004                        West Moreton 1.000000e+00
      271         31101                          Gold Coast 9.558924e-04
      272         31101                   Metro South (Qld) 9.990441e-01
      273         31102                   Metro South (Qld) 1.000000e+00
      274         31103                   Metro South (Qld) 1.000000e+00
      275         31104                   Metro South (Qld) 1.000000e+00
      276         31105                   Metro South (Qld) 1.000000e+00
      277         31106                   Metro South (Qld) 1.000000e+00
      278         31201                              Mackay 1.000000e+00
      279         31202                              Mackay 1.000000e+00
      280         31203                              Mackay 1.000000e+00
      281         31301                   Metro North (Qld) 1.000000e+00
      282         31302                   Metro North (Qld) 1.000000e+00
      283         31303                        West Moreton 5.425210e-02
      284         31303                   Metro North (Qld) 9.457479e-01
      285         31304                   Metro North (Qld) 1.000000e+00
      286         31305                   Metro North (Qld) 9.950441e-01
      287         31305                   Metro South (Qld) 4.955852e-03
      288         31401                   Metro North (Qld) 1.000000e+00
      289         31402                   Metro North (Qld) 1.000000e+00
      290         31403                   Metro North (Qld) 1.000000e+00
      291         31501                     Torres and Cape 7.738739e-01
      292         31501               Cairns and Hinterland 2.261261e-01
      293         31502                    North West (Qld) 9.256038e-01
      294         31502                          Townsville 7.439623e-02
      295         31503                    South West (Qld) 3.884586e-01
      296         31503                  Central West (Qld) 6.078728e-01
      297         31503                    North West (Qld) 3.668549e-03
      298         31601                      Sunshine Coast 1.000000e+00
      299         31602                      Sunshine Coast 1.000000e+00
      300         31603                      Sunshine Coast 1.000000e+00
      301         31605                      Sunshine Coast 1.000000e+00
      302         31606                      Sunshine Coast 1.000000e+00
      303         31607                      Sunshine Coast 1.000000e+00
      304         31608                      Sunshine Coast 1.000000e+00
      305         31701                        West Moreton 1.228998e-01
      306         31701                       Darling Downs 8.771002e-01
      307         31801                          Townsville 1.000000e+00
      308         31802                          Townsville 1.000000e+00
      309         31901                            Wide Bay 1.000000e+00
      310         31902                      Sunshine Coast 2.013490e-04
      311         31902                            Wide Bay 3.117689e-01
      312         31902                       Darling Downs 6.880298e-01
      313         31903                      Sunshine Coast 9.999060e-01
      314         31903                            Wide Bay 9.403976e-05
      315         31904                            Wide Bay 1.000000e+00
      316         31905                            Wide Bay 9.979840e-01
      317         31905                      Sunshine Coast 2.015960e-03
      318         40101                    Central Adelaide 1.000000e+00
      319         40102              Barossa Hills Fleurieu 1.000000e+00
      320         40103                    Central Adelaide 1.000000e+00
      321         40104                    Central Adelaide 1.000000e+00
      322         40105                    Central Adelaide 1.000000e+00
      323         40106                    Central Adelaide 1.000000e+00
      324         40107                    Central Adelaide 1.000000e+00
      325         40201              Barossa Hills Fleurieu 1.000000e+00
      326         40202                   Northern Adelaide 1.000000e+00
      327         40203                   Northern Adelaide 1.000000e+00
      328         40204                   Northern Adelaide 1.000000e+00
      329         40205                   Northern Adelaide 1.000000e+00
      330         40301                   Southern Adelaide 1.000000e+00
      331         40302                   Southern Adelaide 1.000000e+00
      332         40303                   Southern Adelaide 1.000000e+00
      333         40304                   Southern Adelaide 1.000000e+00
      334         40401                    Central Adelaide 1.000000e+00
      335         40402                    Central Adelaide 1.000000e+00
      336         40403                    Central Adelaide 1.000000e+00
      337         40501              Barossa Hills Fleurieu 1.000000e+00
      338         40502              Barossa Hills Fleurieu 7.591646e-02
      339         40502                  Yorke and Northern 9.240835e-01
      340         40503                  Yorke and Northern 1.000000e+00
      341         40504                  Yorke and Northern 1.000000e+00
      342         40601                  Eyre and Far North 6.278019e-01
      343         40601            Flinders and Upper North 3.721981e-01
      344         40602                  Eyre and Far North 1.702735e-01
      345         40602            Flinders and Upper North 8.196689e-01
      346         40602            Riverland Mallee Coorong 1.213165e-03
      347         40602                  Yorke and Northern 8.844363e-03
      348         40701              Barossa Hills Fleurieu 1.000000e+00
      349         40702                     Limestone Coast 1.000000e+00
      350         40703              Barossa Hills Fleurieu 3.401027e-02
      351         40703            Riverland Mallee Coorong 9.659897e-01
      352         50101                               WACHS 1.000000e+00
      353         50102                               WACHS 9.607781e-01
      354         50102                         South Metro 3.922189e-02
      355         50103                               WACHS 1.000000e+00
      356         50201                         South Metro 1.000000e+00
      357         50301                         North Metro 1.000000e+00
      358         50302                          East Metro 4.720793e-01
      359         50302                         North Metro 5.279207e-01
      360         50401                          East Metro 9.053769e-01
      361         50401                         North Metro 9.462310e-02
      362         50402                          East Metro 1.000000e+00
      363         50403                          East Metro 8.748515e-01
      364         50403                         North Metro 1.251485e-01
      365         50501                         North Metro 1.000000e+00
      366         50502                         North Metro 1.000000e+00
      367         50503                         North Metro 1.000000e+00
      368         50601                          East Metro 1.000000e+00
      369         50602                          East Metro 1.000000e+00
      370         50603                          East Metro 4.164077e-01
      371         50603                         South Metro 5.835923e-01
      372         50604                          East Metro 8.071207e-01
      373         50604                         South Metro 1.928793e-01
      374         50605                          East Metro 1.000000e+00
      375         50606                          East Metro 1.000000e+00
      376         50607                         South Metro 6.042391e-01
      377         50607                          East Metro 3.957609e-01
      378         50701                         South Metro 1.000000e+00
      379         50702                         South Metro 1.000000e+00
      380         50703                         South Metro 1.000000e+00
      381         50704                         South Metro 1.000000e+00
      382         50705                         South Metro 1.000000e+00
      383         50901                               WACHS 1.000000e+00
      384         50902                               WACHS 1.000000e+00
      385         50903                               WACHS 9.660299e-01
      386         50903                         South Metro 3.397006e-02
      387         51001                               WACHS 1.000000e+00
      388         51002                               WACHS 1.000000e+00
      389         51003                               WACHS 1.000000e+00
      390         51101                               WACHS 1.000000e+00
      391         51102                               WACHS 1.000000e+00
      392         51103                               WACHS 1.000000e+00
      393         51104                               WACHS 1.000000e+00
      394         60101            Tasmanian Health Service 1.000000e+00
      395         60102            Tasmanian Health Service 1.000000e+00
      396         60103            Tasmanian Health Service 1.000000e+00
      397         60104            Tasmanian Health Service 1.000000e+00
      398         60105            Tasmanian Health Service 1.000000e+00
      399         60106            Tasmanian Health Service 1.000000e+00
      400         60201            Tasmanian Health Service 1.000000e+00
      401         60202            Tasmanian Health Service 1.000000e+00
      402         60203            Tasmanian Health Service 1.000000e+00
      403         60301            Tasmanian Health Service 1.000000e+00
      404         60302            Tasmanian Health Service 1.000000e+00
      405         60303            Tasmanian Health Service 1.000000e+00
      406         60401            Tasmanian Health Service 1.000000e+00
      407         60402            Tasmanian Health Service 1.000000e+00
      408         60403            Tasmanian Health Service 1.000000e+00
      409         70101 NT Regional Health Services (NTRHS) 1.000000e+00
      410         70102 NT Regional Health Services (NTRHS) 1.000000e+00
      411         70103 NT Regional Health Services (NTRHS) 1.000000e+00
      412         70104 NT Regional Health Services (NTRHS) 1.000000e+00
      413         70201 NT Regional Health Services (NTRHS) 1.000000e+00
      414         70202 NT Regional Health Services (NTRHS) 1.000000e+00
      415         70203 NT Regional Health Services (NTRHS) 1.000000e+00
      416         70204 NT Regional Health Services (NTRHS) 1.000000e+00
      417         70205 NT Regional Health Services (NTRHS) 1.000000e+00
      418         80101        Australian Capital Territory 1.000000e+00
      419         80103        Australian Capital Territory 1.000000e+00
      420         80104        Australian Capital Territory 1.000000e+00
      421         80105        Australian Capital Territory 1.000000e+00
      422         80106        Australian Capital Territory 1.000000e+00
      423         80107        Australian Capital Territory 1.000000e+00
      424         80108        Australian Capital Territory 1.000000e+00
      425         80109        Australian Capital Territory 1.000000e+00
      426         80110        Australian Capital Territory 1.000000e+00
      427         80111        Australian Capital Territory 1.000000e+00
      428         90101                                <NA> 1.000000e+00
      429         90102                                <NA> 1.000000e+00
      430         90103                                <NA> 1.000000e+00
      431         90104                                <NA> 1.000000e+00

---

    Code
      x
    Output
      # A tibble: 431 x 3
      # Groups:   sa3_code_2016 [340]
         sa3_code_2016 LHN_Name                ratio
         <chr>         <chr>                   <dbl>
       1 10102         Southern NSW         1       
       2 10103         Southern NSW         1       
       3 10104         Illawarra Shoalhaven 0.00259 
       4 10104         Southern NSW         0.997   
       5 10105         South Western Sydney 0.000157
       6 10105         Southern NSW         1.00    
       7 10106         Murrumbidgee         0.504   
       8 10106         Southern NSW         0.496   
       9 10201         Central Coast (NSW)  1       
      10 10202         Central Coast (NSW)  1       
      # i 421 more rows

# correspondence table is complete - all non-NA SA2 mappings are other territories

    Code
      df_sample
    Output
        sa2_code_2021 LHN_Name ratio
      1     901011001     <NA>     1
      2     901021002     <NA>     1
      3     901031003     <NA>     1
      4     901041004     <NA>     1

---

    Code
      x
    Output
      # A tibble: 4 x 3
      # Groups:   sa2_code_2021 [4]
        sa2_code_2021 LHN_Name ratio
        <chr>         <chr>    <dbl>
      1 901011001     <NA>         1
      2 901021002     <NA>         1
      3 901031003     <NA>         1
      4 901041004     <NA>         1

