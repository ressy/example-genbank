# GenBank Submissions

My notes on preparing a GenBank submission with annotations on Linux using
[tbl2asn] for file handling.

**As of September 2019 BankIt/the submission portal seem to handle bulk uploads
for multiple submission types with varying features and metadata FASTA and TSV
(via the same odd features table format below) and that seems to be less hassle
than the tbl2asn method here.**  I'd recommend that approach where possible.

## Overview

Aside from the template, match the names of the different files so that only
the extension differs, and store in one folder.  If everything is in one place
it'd just be:

    ./tbl2asn -t template.sbt -p .

And then you have the .sqn output file for the submission.  They recommend
`-V v` for validation and you can get a for-your-information GenBank flatfile
version with `-V b`, so this might be better:

    ./tbl2asn -t template.sbt -p . -V vb

Running `make` in this repository will try to create an `example.sqn` and
associated validation and flatfile outputs using the Sc 16 information from the
[tbl2asn] page and the linked [Table Example].  The example tbl file
given is a bit garbled up in its tabs and spaces but it doesn't actually seem
to matter to tbl2sqn.

The `example.gbf` flatfile will start off something like:

    LOCUS       Sc_16                    543 bp    DNA     linear   PLN 01-NOV-2018
    DEFINITION  Saccharomyces cerevisiae.
    ACCESSION
    VERSION
    KEYWORDS    .
    SOURCE      Saccharomyces cerevisiae (baker's yeast)
    ...

What you actually submit is the .sqn file.
[The tbl2asn quickstart section](https://www.ncbi.nlm.nih.gov/books/NBK53709/#gbankquickstart.Submission_using_tbl2asn)
of the [GenBank Submissions Handbook]
gives an email address or links to upload forms:
[regular](https://www.ncbi.nlm.nih.gov/LargeDirSubs/dir_submit.cgi)
on an old-school CGI page, or
[genome upload](https://submit.ncbi.nlm.nih.gov/subs/genome/)
on the recent Submisison Portal system like for SRA.  If I had to guess I
expect they'll absorb more of this into the Submission Portal system
(...someday).

## Input Files Needed

### Template (sbt)

The template file has information about the submitter, sequence provider, and
publication.  Always required.

The [GenBank Online Submission] is *not* to be used for most GenBank submissions
("Submit only ribosomal RNA (rRNA), rRNA-ITS or Influenza sequences here"),
even though the [GenBank Submission Template] on the same server *is* used for
generating templates used by tbl2asn.  That page looks a lot like the other
NCBI submission pages I've seen, but instead of continuing through a whole
interactive process it just provides a `template.sbt` file.  (The template is
in [Abstract Syntax Notation One].)

### Sequence (fsa)

The sequence file provides the sequence data in FASTA format with some
specific requirements for the definition line.  Always required.

FASTA definition:
 * SeqID must match the regex `[-_.:*#.A-Za-z0-9]+`
 * [Modifiers] encapsulated in square brackets as `[modifier=text]`, organism
   required (or given in tbl2asn command) and the rest optional

For more information on modifiers, see
[here](https://www.ncbi.nlm.nih.gov/Sequin/sequin.hlp.html#ModifiersPage).
Note that Country must match
[this list](https://www.ncbi.nlm.nih.gov/genbank/collab/country/),
and some of the other modifiers have a controlled format or vocabulary.

### Feature Table (tbl)

The feature table is a tab-separated text file with a somewhat weird layout.
The instructions describe it as having varying numbers of fields (i.e., tab
characters) on different lines.  In my testing tbl2asn generates identical
output when every line contains four tabs for the five possible fields, just
leaving blanks as needed, so thankfully it seems to work using TSV
spreadsheets.  `make example2/example2.sqn` will create an output file using
this modified input tbl file, which should be identical to the output using the
original tbl file.

Required if annotations are submitted (but the handbook elsewhere says "you
must provide some type of annotation", so, always required?)

Rows:

 1. SeqID: This should be the same SeqID as on the first line of the sequence
    file, but with "Feature " between the ">" and the SeqID.  So for the
    example copied here, the feature table should start ">Feature Sc_16" whereas
    the FASTA starts with ">Sc_16". (1 column)
 2. Feature: Defines a feature with Start, Stop, Feature, Modifier, Modifier
    cells (5 columns).
    1. Start: Integer position of start of feature, or "<1" for beyond the
       given sequence at the 5' end.)
    2. Stop:  Integer position of end of feature.  For beyond on the 3' end,
       use ">N" where N is the last position.  Putting a lower Start than Stop
       implies the feature is on the complementary strand.
    3. Feature: keyword for the feature type.  See the [GenBank Features
       Reference]) for the type of feature, like "CDS" for a coding sequence.
    4. **Modifier**?
    5. **Modifier Value**?
 3. Interval: Additional Start and Stop positions for the most recent Feature.
    For example maybe there are multiple ranges for coding sequence.  (2
    columns)
 4. Modifier: Modifier information for the most recent Feature.  Three empty
    cells, then Modifier and Modifier Value.  For example, "product" and the
    description of the product of the coding regions.  (5 columns)

[Example Table and GenBank Record](https://www.ncbi.nlm.nih.gov/Sequin/table.html)

### Quality Scores (qvl)

Optional.

### Source Table (src)

Optional.

### Protein Sequence (pep)

Optional.

## Tips and Tricks

 * `tbl2asn -E T` will enable a recursive search within the directory given
   with `-p`.  It still expects .fsa files with correspondingly-named .tbl
   files, though.
 * `tbl2asn -a s` will, in contrast to the recursive option for separate files,
   allow multiple separate entries within a single .fsa/.tbl pair.
 * Before submitting, check the .val files and the discrepancy report if `-Z
   file.txt` was given.  Nothing shows up on the standard error stream when
   running the program even if major problems are logged to these text files!
 * To get `/organlle="mitochondrion"` in the eventual GBF flat file, use
   `[location=mitochondrion]` (or presumably whatever other location/organelle
   you're using) as source modifier and tbl2asn will create the expected GBF
   preview.

[GenBank Submissions Handbook]: https://www.ncbi.nlm.nih.gov/books/NBK53709
[GenBank Online Submission]: https://submit.ncbi.nlm.nih.gov/subs/genbank/
[GenBank Submission Template]: https://submit.ncbi.nlm.nih.gov/genbank/template/submission/
[Modifiers]: https://www.ncbi.nlm.nih.gov/Sequin/modifiers.html
[GenBank Features Reference]: http://www.insdc.org/documents/feature_table.html#7.2
[Example GenBank Record]: https://www.ncbi.nlm.nih.gov/Sitemap/samplerecord.html
[tbl2asn]: https://www.ncbi.nlm.nih.gov/genbank/tbl2asn2/
[Table Example]: https://www.ncbi.nlm.nih.gov/Sequin/table.html
[Abstract Syntax Notation One]: https://en.wikipedia.org/wiki/Abstract_Syntax_Notation_One
[tbl2asn source]: https://www.ncbi.nlm.nih.gov/IEB/ToolBox/C_DOC/lxr/source/demo/tbl2asn.c
