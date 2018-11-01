URL_ROOT = "ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/converters/by_program/tbl2asn"
URL_BIN = "linux64.tbl2asn.gz"
URL_DOC = "DOCUMENTATION/tbl2asn.txt"

all: example/example.sqn example2/example2.sqn
	diff $^

tbl2asn:
	wget $(URL_ROOT)/$(URL_BIN) -O - | gunzip > $@
	chmod +x $@

tbl2asn.txt:
	wget $(URL_ROOT)/$(URL_DOC) -O $@

clean:
	rm -f tbl2asn.txt tbl2asn \
		example/example.sqn example/example.gbf \
		example/example.val example/errorsummary.val \
		example2/example2.tbl \
		example2/example2.sqn example2/example2.gbf \
		example2/example2.val example2/errorsummary2.val \
		example2/example2.fsa

# The program, and three files (sbt, fsa, tbl), are needed.
# -V runs checks and creates more files.
# Their example.tbl text is actually a bit garbled and has spaces where it
# should have tabs.  It seems to work out the same either way, though.  I set
# theirs aside as "example_raw.tbl" and made "example.tbl" a version that
# actually matches the documentation.
example/example.sqn: tbl2asn template.sbt example/example.fsa example/example.tbl
	./tbl2asn -t template.sbt -p example -V vb

# Make the example table a nice simple square TSV grid instead of the weird
# jagged file they describe.  Will this still work as expected?
example2/example2.tbl: example/example.tbl
	awk  -v FS='\t' < $^ 'IFS=OFS=FS{print $$1,$$2,$$3,$$4,$$5}' > $@

# Use the same seq data for the second example too
example2/example2.fsa: example/example.fsa
	ln -s ../$^ $@

# Now make the second sqn.  Should be the same as the first!
example2/example2.sqn: tbl2asn template.sbt example2/example2.fsa example2/example2.tbl
	./tbl2asn -t template.sbt -p example2 -V vb
