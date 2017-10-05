case `hostname` in
    attila-Think*)
        # commands to execute
        # special variables, mostly for bioinformatics
        export PICARD="/opt/picard/current/picard.jar"
        export GATK="/opt/gatk/current/GenomeAnalysisTK.jar"
        export REFSEQ=$HOME/data/GRCh37/dna/hs37d5.fa
        export REFSEQ_DICT=$HOME/data/GRCh37/dna/hs37d5.dict
        export BWA_INDEX=$HOME/data/GRCh37/dna/bwa/hs37d5
        export BOWTIE2_INDEX=$HOME/data/GRCh37/dna/bowtie2/hs37d5
        ;;
#    attila-ThinkPad)
#        # commands to execute
#        eval "$(rbenv init -)"
#        # special variables, mostly for bioinformatics
#        export PICARD="/opt/picard/current/picard.jar"
#        export GATK="/opt/gatk/current/GenomeAnalysisTK.jar"
#        export REFSEQ=$HOME/data/GRCh37/dna/Homo_sapiens.GRCh37.dna.fa
#        export REFSEQ_DICT=$HOME/data/GRCh37/dna/Homo_sapiens.GRCh37.dna.dict
#        export BWA_INDEX=$HOME/data/GRCh37/dna/bwa/Homo_sapiens.GRCh37.dna
#        export BOWTIE2_INDEX=$HOME/data/GRCh37/dna/bowtie2/Homo_sapiens.GRCh37.dna
#        ;;
    minerva*)
        PATH="$PATH:/hpc/users/$USER/chess01c/local/bin:/hpc/users/$USER/chess01c/opt/bin"
        # commands to execute
        module load git vim/8.0
        #module load R
        #module unload openssl # revert the annoying hack meant to support new ssl despite Minerva's old linux kernel
        # special variables, mostly for bioinformatics
        export REFSEQ=/sc/orga/projects/chessa01c/refgenome/GRCh37/dna/Homo_sapiens.GRCh37.dna.fa
        export REFSEQ_DICT=/sc/orga/projects/chessa01c/refgenome/GRCh37/dna/Homo_sapiens.GRCh37.dna.dict
        export BWA_INDEX=/sc/orga/projects/chessa01c/refgenome/GRCh37/dna/bwa/Homo_sapiens.GRCh37.dna
        export MODULE_BWA=bwa
        #export MODULE_BWA=bwa/0.7.15
        export BOWTIE2_INDEX=/sc/orga/projects/chessa01c/refgenome/GRCh37/dna/bowtie2/Homo_sapiens.GRCh37.dna
        export MODULE_BOWTIE2=bowtie2
        #export MODULE_BOWTIE2=bowtie2/2.2.8
        export MODULE_SAMTOOLS=samtools
        export BSUB_STDOUT=/hpc/users/$USER/.bsub.stdout
        export BSUB_STDERR=/hpc/users/$USER/.bsub.stderr
        ;;
esac
