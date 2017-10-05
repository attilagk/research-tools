#! /usr/bin/env bash

# Fetch, check, and prepare for bwa and bowtie2 the human genome's GRCh37 or
# GRCh38 assembly.  Unless the FASTA file 'refseqname' already exists,
# the current (latest) release is fetched from ENSEMBL's public ftp
# site; downloaded fasta files are checked using checksums; only fasta files
# for single chromosomes are fetched; these are concatenated into a single
# output fasta in karyotypic order (1,...,22, X, Y, MT); the output fasta is
# indexed and a dictionary is created both with samtools and picard tools,
# such that the default .dict file is symlinked to the samtools dictionary;
# finally, an aligner index is built both for bwa and bowtie2.

usage="usage: `basename $0` outdir grch37|grch38 [refseqname]"
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
echo $0 $@ > README_generator_cmd
baseurl=ftp://ftp.ensembl.org/pub
case $assembly in
    *38)
        assembly=GRCh38
        current_README="$baseurl/current_README"
        srcdir="$baseurl/current_fasta/homo_sapiens/dna/"
        ;;
    *37)
        assembly=GRCh37
        current_README="$baseurl/grch37/current/README"
        srcdir="$baseurl/grch37/current/fasta/homo_sapiens/dna/"
        ;;
esac

# unless specified as argument $3, auto-generate name for reference FASTA
refseqname="${3:-Homo_sapiens.$assembly.dna.fa}"

if test ! -e $refseqname; then
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
    done > $refseqname
    f="Homo_sapiens."$assembly".dna.nonchromosomal.fa.gz"
    test -e $f || fetch $f || { echo $errormsg >&2; exit 1; }
    zcat $f >> $refseqname && rm $f
    rm CHECKSUMS
fi

# create index
faix="$refseqname.fai"
test -e $faix || samtools faidx $refseqname

# dictionary file; make one by samtools and another one by picard tools
bn_refseqname="`basename $refseqname .fa`"
fadict="$bn_refseqname.dict"
samtools_dict="`basename $refseqname .fa`-samtools.dict"
picard_dict="`basename $refseqname .fa`-picard.dict"
if test ! -e $fadict; then
    samtools dict -a $assembly -s "Homo sapiens" -o $samtools_dict $refseqname
    java -jar $PICARD CreateSequenceDictionary O=$picard_dict R=$refseqname \
        GENOME_ASSEMBLY=$assembly SPECIES="Homo sapiens" 
    # create a symlink to one of the two dictionaries
    ln -s $samtools_dict $fadict
fi

# bwa index
if test ! -d bwa; then
    which bwa > /dev/null && mkdir bwa && cd bwa
    bwa index -p $bn_refseqname ../$refseqname
    cd ..
fi

# bowtie2 index
if test ! -d bowtie2; then
    which bowtie2 > /dev/null && mkdir bowtie2 && cd bowtie2
    bowtie2-build --threads 1 ../$refseqname $bn_refseqname
    cd ..
fi
