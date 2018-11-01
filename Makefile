URL_ROOT = "ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/converters/by_program/tbl2asn"
URL_BIN = "linux64.tbl2asn.gz"
URL_DOC = "DOCUMENTATION/tbl2asn.txt"

all: tbl2asn tbl2asn.txt

tbl2asn:
	wget $(URL_ROOT)/$(URL_BIN) -O - | gunzip > $@
	chmod +x $@

tbl2asn.txt:
	wget $(URL_ROOT)/$(URL_DOC) -O $@

clean:
	rm -f tbl2asn.txt linux64.tbl2asn
