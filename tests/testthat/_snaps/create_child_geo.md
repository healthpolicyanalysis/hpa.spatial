# SA3s are adapted when adapted to be within LHNs

    Code
      sort(dplyr::pull(dplyr::filter(qld_new_sa3s, stringr::str_detect(sa3_code_2016,
        "-")), sa3_code_2016))
    Output
       [1] "30403-A" "30403-B" "30501-A" "30501-B" "30603-A" "30603-B" "30701-A"
       [8] "30701-B" "30804-A" "30804-B" "30805-A" "30805-B" "31303-A" "31303-B"
      [15] "31501-A" "31501-B" "31502-A" "31502-B" "31503-A" "31503-B" "31503-C"
      [22] "31701-A" "31701-B" "31902-A" "31902-B" "31902-C"

# child remains unchanged when it should

    Code
      dplyr::filter(test, stringr::str_detect(sa2_code_2021, "306031161"))
    Output
      Simple feature collection with 2 features and 2 fields
      Geometry type: MULTIPOLYGON
      Dimension:     XY
      Bounding box:  xmin: 145.5726 ymin: -18.53331 xmax: 146.3587 ymax: -17.71358
      Geodetic CRS:  GDA2020
        sa2_code_2021              LHN_Name                       geometry
      1   306031161-A Cairns and Hinterland MULTIPOLYGON (((146.1989 -1...
      2   306031161-B            Townsville MULTIPOLYGON (((146.3296 -1...

