URL_ROOT = "ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/converters/by_program/tbl2asn"
URL_BIN = "linux64.tbl2asn.gz"
URL_DOC = "DOCUMENTATION/tbl2asn.txt"

# The program, and three files, are needed:
example.sqn: tbl2asn template.sbt example.fsa example.tbl
	./tbl2asn -t template.sbt -p .

tbl2asn:
	wget $(URL_ROOT)/$(URL_BIN) -O - | gunzip > $@
	chmod +x $@

tbl2asn.txt:
	wget $(URL_ROOT)/$(URL_DOC) -O $@

clean:
	rm -f tbl2asn.txt tbl2asn example.sqn
