#! /usr/bin/env bash

# Print the nth read of a fastq.gz file

usage="`basename $0` readnum path/to/fastq.gz"

readn=$1
fastq=$2

readn_1=$(( $readn - 1 ))

if ! test $# -eq 2; then
echo Exactly two arguments were expected, $# given.  Exiting...; exit 1
fi

function get_lnum() {
readnum=$1
offset=$2 #1 for read start and 4 for read end
val=$(( $(( $(($readnum - 1)) * 4 )) + $offset ))
echo $val
return $val
}

zcat $fastq | sed -n " \
# the n - 1'th read
$(get_lnum $readn_1 1) i\
read $readn_1
$(get_lnum $readn_1 1),$(get_lnum $readn_1 4) p; \
# the nth read
$(get_lnum $readn 1) i\
read $readn
$(get_lnum $readn 1),$(get_lnum $readn 4) p; \
$(get_lnum $readn 4) q"
