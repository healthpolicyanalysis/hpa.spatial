# SA3s are adapted when adapted to be within LHNs

    Code
      sort(dplyr::pull(dplyr::filter(qld_new_sa3s, stringr::str_detect(sa3_code_2016,
        "-")), sa3_code_2016))
    Output
       [1] "30403-A" "30403-B" "30501-A" "30501-B" "30501-C" "30603-A" "30603-B"
       [8] "30603-C" "30701-A" "30701-B" "30804-A" "30804-B" "30805-A" "30805-B"
      [15] "30805-C" "31303-A" "31303-B" "31501-A" "31501-B" "31501-C" "31502-A"
      [22] "31502-B" "31502-C" "31503-A" "31503-B" "31503-C" "31701-A" "31701-B"
      [29] "31902-A" "31902-B" "31902-C"

