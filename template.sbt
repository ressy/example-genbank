-- My own generic example, modified from one from the web interface
Submit-block ::= {
  contact {
    contact {
      name name {
        last "Last name of submitter",
        first "First name of submitter",
        middle "",
        initials "",
        suffix "",
        title ""
      },
      affil std {
        affil "Where you work",
        div "your department",
        city "City",
        sub "State",
        country "Country",
        street "123 Road Street",
        email "submitter@example.com",
        postal-code "12345"
      }
    }
  },
  cit {
    authors {
      names std {
        {
          name name {
            last "Last name of provider",
            first "First name of provider",
            middle "",
            initials "",
            suffix "",
            title ""
          }
        }
      },
      affil std {
        affil "Where data provider works",
        div "department",
        city "City",
        sub "State",
        country "Country",
        street "123 Road Street",
        email "provider@example.com",
        postal-code "12345"
      }
    }
  },
  subtype new
}
Seqdesc ::= pub {
  pub {
    gen {
      cit "unpublished",
      authors {
        names std {
          {
            name name {
              last "Last name of author",
              first "First name of author",
              middle "",
              initials "",
              suffix "",
              title ""
            }
          }
        }
      },
      title "Publication Title"
    }
  }
}
Seqdesc ::= user {
  type str "Submission",
  data {
    {
      label str "AdditionalComment",
      data str "ALT EMAIL:submitter@example.com"
    }
  }
}
Seqdesc ::= user {
  type str "Submission",
  data {
    {
      label str "AdditionalComment",
      data str "Submission Title:None"
    }
  }
}
