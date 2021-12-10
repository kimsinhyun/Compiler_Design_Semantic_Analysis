#!/bin/bash

#
# Writer: Woohyun Lee
# Note: this script must be run from the CSI4014_Assignment_4 (Top level) directory, otherwise the
# hardcoded paths won't work!
#
TOPDIR=`pwd`
tst=$TOPDIR/MiniC/SemanticAnalysis/tst/base/testcases
sol=$TOPDIR/MiniC/SemanticAnalysis/tst/base/solutions
ans=$TOPDIR/MiniC/SemanticAnalysis/tst/base/answer
report=$ans/report.txt
all=0
ok=0
classpath=$TOPDIR/build/classes/main
minic=$TOPDIR/build/libs/MiniC-SemAnalysis.jar


mkdir -p $ans
echo "SemanticAnalysis Test Report" > $report
echo "generated "`date` >> $report
#
# Run testcases:
#
TMP_ANS=__tmp_ans
TMP_SOL=__tmp_sol
echo "Testing the SemanticAnalysis..."
for file in $tst/c*.mc
do
     all=$(( $all + 1 ))
     f=`basename $file`
     java -jar $minic $file > $ans/$f.sol
     grep -oE "ERROR: #[0-9]+" $ans/$f.sol > $TMP_ANS
     grep -oE "ERROR: #[0-9]+" $sol/$f.sol > $TMP_SOL
     # cat $TMP_SOL
     diff -u --ignore-all-space --ignore-blank-lines $TMP_ANS $TMP_SOL > $ans/diff_$f
     if [ "$?" -eq 1 ]
     then
                echo -n "-"
                echo "$f failed" >> $report
     else
                echo -n "+"
                echo "$f succeeded" >> $report
                rm -rf $ans/diff_$f $ans/$f.sol
                ok=$(( $ok + 1 ))
     fi
     rm -f $TMP_SOL $TMP_ANS
done
echo
echo "Testing finished, pls. consult the test report in ${report}"
echo "$ok out of $all testcases succeeded."
