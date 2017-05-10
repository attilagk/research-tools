#! /usr/bin/env bash

usage="usage: `basename $0` outdir [grch37|grch38]"
if test $# -eq 0; then
    echo $usage >&2; exit 1
fi

# function to fetch and check a fasta file
fetch () {
    # subfunction to compare the calculated checksum to the expected one
    mychecksum () {
        f=$1
        sedexp="{s/^\([[:digit:]]\+\)\s.*$/\1/; p}" 
        expected_sum=$(sed -ne "/\<${f}\>/ $sedexp" CHECKSUMS)
        calculated_sum=$(sum $f | sed -ne "$sedexp")
        test $expected_sum = $calculated_sum
    }
    f=$1
    wget "$srcdir/$f" && mychecksum $f
}


# determine assembly (GRCh37 or GRCh38) from argument and set some variables
outdir=$1
cd $outdir || exit 1
assembly=$2
baseurl=ftp://ftp.ensembl.org/pub
case $assembly in
    *38)
        assembly=GRCh38
        current_README="$baseurl/current_README"
        srcdir="$baseurl/current_fasta/homo_sapiens/dna/"
        ;;
    *)
        assembly=GRCh37
        current_README="$baseurl/grch37/current/README"
        srcdir="$baseurl/grch37/current/fasta/homo_sapiens/dna/"
        ;;
esac

outfa="Homo_sapiens.$assembly.dna.fa"
if test ! -e $outfa; then
    # get info on current release of assembly
    test -e current_release_README || wget $current_README -O current_release_README
    # get checksums and info on various fasta sequence files
    for f in CHECKSUMS README; do
        test -e $f || wget "$srcdir/$f"
    done
    # fetch and concatenate chromosomes in karyotypic order
    #set Y MT
    set {1..22} X Y MT
    for chr; do
        f="Homo_sapiens.$assembly.dna.chromosome.$chr.fa.gz"
        errormsg="`basename $0`: couldn't fetch $f from $srcdir; exiting" 
        test -e $f || fetch $f || { echo $errormsg >&2; exit 1; }
        zcat $f && rm $f
    done > $outfa
fi

faix="$outfa.fai"
test -e $faix || samtools faidx $outfa

# dictionary file; make one by samtools and another one by picard tools
fadict="`basename $outfa .fa`.dict"
samtools_dict="`basename $outfa .fa`-samtools.dict"
picard_dict="`basename $outfa .fa`-picard.dict"
if test ! -e $fadict; then
    samtools dict -a $assembly -s "Homo sapiens" -o $samtools_dict $outfa
    java -jar $PICARD CreateSequenceDictionary O=$picard_dict R=$outfa \
        GENOME_ASSEMBLY=$assembly SPECIES="Homo sapiens" 
    # create a symlink to one of the two dictionaries
    ln -s $samtools_dict $fadict
fi
