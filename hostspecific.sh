case `hostname` in
    attila-ThinkPad)
        # commands to execute
        eval "$(rbenv init -)"
        # general variables
        export VISUAL=${VISUAL:-vi}
        export EDITOR=${EDITOR:-${VISUAL}}
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
        ;;
esac
