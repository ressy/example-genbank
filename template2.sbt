-- example taken from tbl2asn readme
Submit-block ::= {
  contact {
    contact {
      name
        name {
          last "Darwin" ,
          first "Charles" ,
          initials "C.R." ,
          suffix "" } ,
      affil
        std {
          affil "Oxbridge University" ,
          div "Evolutionary Biology Department" ,
          city "Camford" ,
          country "United Kingdom" ,
          street "1859 Tennis Court Lane" ,
          email "darwin@beagle.edu.uk" ,
          phone "01 44 171-007-1212" ,
          postal-code "OX1 2BH" } } } ,
  cit {
    authors {
      names
        std {
          {
            name
              name {
                last "Darwin" ,
                first "Charles" ,
                initials "C.R." } } } ,
      affil
        std {
          affil "Oxbridge University" ,
          div "Evolutionary Biology Department" ,
          city "Camford" ,
          country "United Kingdom" ,
          street "1859 Tennis Court Lane" ,
          postal-code "OX1 2BH" } } ,
    date
      std {
        year 2003 ,
        month 2 ,
        day 28 } } ,
  subtype new  }
