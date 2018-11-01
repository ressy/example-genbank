# GenBank Submissions

My notes on doing a GenBank submission using tbl2asn for file handling.  A lot
of the documentation still refers to Sequin and BankIt, but tbl2asn seems the
preferred way now.

Aside from the template, match the names of the different files so that only
the extension differs, and store in one folder.

## Template (sbt)

The template file has information about the submitter, sequence provider, and
publication.  Always required.

The [GenBank Online Submission] is *not* to be used for most GenBank submissions
("Submit only ribosomal RNA (rRNA), rRNA-ITS or Influenza sequences here"),
even though the [GenBank Submission Template] on the same server *is* used for
generating templates used by tbl2asn.  That page looks a lot like the other
NCBI submission pages I've seen, but instead of continuing through a whole
interactive process it just provides a `template.sbt` file.  (The template is
in [Abstrace Syntax Notation One].)

## Sequence (fsa)

The sequence file provides the sequence data in FASTA format with some
specific requirements for the definition line.  Always required.

FASTA definition:
 * SeqID must be `[-_.:*#.A-Za-z0-9]+`
 * [Modifiers] encapsulated in square brackets as `[modifier=text]`, organism
   required (or given in tbl2asn command) and the rest optional

## Feature Table (tbl)

The feature table is a tab-separated text file with a somewhat weird layout
(compatible with TSV, just with empty cells, I think?  **verify this**  The
row-by-row description implies the file should be "jagged", but possibly it'll
accept square too).  Required if annotations are submitted (but the handbook
elsewhere says "you must provide some type of annotation", so, always
required?)

Rows:

 1. SeqID: This should be the same SeqID as on the first line of the sequence
    file. (1 column?)
 2. Feature: Defines a feature with Start, Stop, Feature, Modifier, Modifier
    cells (5 columns).
    1. Start: Integer position of start of feature, or "<1" for beyond the
       given sequence at the 5' end.)
    2. Stop:  Integer position of end of feature.  I think there's a notation
       for beyond on the 3' end but I can't find the example for that.  Putting
       a lower Start than Stop implies the feature is on the complementary
       strand.
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

## Quality Scores (qvl)

Optional.

## Source Table (src)

Optional.

## Protein Sequence (pep)

Optional.

[GenBank Online Submission]: https://submit.ncbi.nlm.nih.gov/subs/genbank/
[GenBank Submission Template]: https://submit.ncbi.nlm.nih.gov/genbank/template/submission/
[Modifiers]: https://www.ncbi.nlm.nih.gov/Sequin/modifiers.html
[GenBank Features Reference]: http://www.insdc.org/documents/feature_table.html#7.2
[Example GenBank Record]: https://www.ncbi.nlm.nih.gov/Sitemap/samplerecord.html
[GenBank Submissions Handbook]: https://www.ncbi.nlm.nih.gov/books/NBK53709
[What is tbl2asn]: https://www.ncbi.nlm.nih.gov/genbank/tbl2asn2/
[Abstract Syntax Notation One]: https://en.wikipedia.org/wiki/Abstract_Syntax_Notation_One
