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
        PATH="$PATH:/hpc/users/$USER/chess01c/local/bin:/hpc/users/$USER/chess01c/opt/bin"
        # commands to execute
        module load R git vim/8.0
        module unload openssl # no effect; revert the annoying hack meant to support new ssl despite Minerva's old linux kernel
        # special variables, mostly for bioinformatics
        export BWA_INDEX=/sc/orga/projects/chessa01c/refgenome/GRCh37/dna/bwa/Homo_sapiens.GRCh37.75.dna.primary_assembly
        export MODULE_BWA=bwa#/0.7.15
        export BOWTIE2_INDEX=/sc/orga/projects/chessa01c/refgenome/GRCh37/dna/bowtie2/Homo_sapiens.GRCh37.75.dna.primary_assembly
        export MODULE_BOWTIE2=bowtie2#/2.2.8
        export BSUB_STDOUT=/hpc/users/$USER/.bsub.stdout
        export BSUB_STDERR=/hpc/users/$USER/.bsub.stderr
        ;;
esac
