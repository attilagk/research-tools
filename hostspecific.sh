case `hostname` in
    attila-Think*)
        # commands to execute
        # special variables, mostly for bioinformatics
        export PICARD="/opt/picard/current/picard.jar"
        export GATK="/opt/gatk/current/GenomeAnalysisTK.jar"
        export GATK_BUNDLE="/big/data/GATK-bundle"
        refseq_dir="$HOME/data/refgenome/GRCh37/dna"
        dbsnp_dir="$HOME/data/dbsnp/human_9606"
        export REFSEQ=$refseq_dir/hs37d5.fa
        export REFSEQ_DICT=$refseq_dir/hs37d5.dict
        export DBSNP_ALL=$dbsnp_dir/00-All.vcf.gz
        export BWA_INDEX=$refseq_dir/bwa/hs37d5
        export BOWTIE2_INDEX=$HOME/data/refgenome/GRCh37/dna/bowtie2/hs37d5
        # Sentieon related stuff has been removed because our license is valid only on Ada
        alias lofreq="/opt/lofreq_star/current/lofreq"
        ;;
    ada)
        export PICARD="/opt/picard/current/picard.jar"
        export GATK="/opt/gatk/current/GenomeAnalysisTK.jar"
        export GATK_BUNDLE="/projects/shared/GATK-bundle"
        refseq_dir=/projects/shared/refgenome/GRCh37/dna
        dbsnp_dir=/projects/shared/dbsnp/human_9606
        export REFSEQ=$refseq_dir/hs37d5.fa
        export REFSEQ_DICT=$refseq_dir/hs37d5.dict
        export DBSNP_ALL=$dbsnp_dir/00-All.vcf.gz
        export BWA_INDEX=$refseq_dir/bwa/hs37d5
        export SENTIEON_LOG_FILE="$HOME/tools/sentieon.log"
        export SENTIEON_LICENSE_FILE="/opt/sentieon-genomics/license/Mount_Sinai_School_of_Medicine-Chess_Lab_cluster.lic"
        export SENTIEON_LICENSE=ada.1470mad.mssm.edu:8990
        export SENTIEON_INSTALL_DIR=/opt/sentieon-genomics/current/
        alias sentieon="/opt/sentieon-genomics/current/bin/sentieon"
        alias lofreq="/opt/lofreq_star/current/lofreq"
        ;;
    minerva*)
        PATH="$PATH:/hpc/users/$USER/chess01c/local/bin:/hpc/users/$USER/chess01c/opt/bin"
        # commands to execute
        module load git vim/8.0
        #module load R
        #module unload openssl # revert the annoying hack meant to support new ssl despite Minerva's old linux kernel
        # special variables, mostly for bioinformatics
        refseq_dir=/sc/orga/projects/chessa01c/refgenome/GRCh37/dna
        export REFSEQ=$refseq_dir/Homo_sapiens.GRCh37.dna.fa
        export REFSEQ_DICT=$refseq_dir/Homo_sapiens.GRCh37.dna.dict
        export BWA_INDEX=$refseq_dir/bwa/Homo_sapiens.GRCh37.dna
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
