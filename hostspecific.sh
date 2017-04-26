case `hostname` in
    attila-ThinkPad)
        # commands to execute
        eval "$(rbenv init -)"
        # special variables, mostly for bioinformatics
        export PICARD="/opt/picard/current/picard.jar"
        export GATK="/opt/gatk/current/GenomeAnalysisTK.jar"
        export BWA_INDEX=$HOME/data/GRCh37/dna/bwa/Homo_sapiens.GRCh37.75.dna.primary_assembly
        export BOWTIE2_INDEX=$HOME/GRCh37/dna/bowtie2/Homo_sapiens.GRCh37.75.dna.primary_assembly
        ;;
    minerva*)
    echo "I am $USER on `hostname`"
    # revert the annoying hack meant to support new ssl despite Minerva's old linux kernel
    module unload openssl

    module load R
    #module load R/3.2.2

    PATH="$PATH:/hpc/users/$USER/chess01c/local/bin:/hpc/users/$USER/chess01c/opt/bin"
    export BWA_INDEX=/sc/orga/projects/chessa01c/refgenome/GRCh37/dna/bwa/Homo_sapiens.GRCh37.75.dna.primary_assembly
    export BOWTIE2_INDEX=/sc/orga/projects/chessa01c/refgenome/GRCh37/dna/bowtie2/Homo_sapiens.GRCh37.75.dna.primary_assembly
    export BSUB_STDOUT=/hpc/users/$USER/.bsub.stdout
    export BSUB_STDERR=/hpc/users/$USER/.bsub.stderr
    export MODULE_BWA=bwa/0.7.15
    export MODULE_BOWTIE2=bowtie2/2.2.8
    ;;
esac
