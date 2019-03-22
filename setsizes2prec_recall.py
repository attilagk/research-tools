#!/usr/bin/env python3

import pandas as pd
import sys

def extend_w_prec_recall(fp):
    df = pd.read_csv(fp, index_col=0)
    df['precision'] = df['CV'] / df['C']
    df['recall'] = df['CV'] / df['V']
    df.to_csv(sys.stdout)
    return(df)

if __name__ == '__main__':
    extend_w_prec_recall(sys.stdin)
