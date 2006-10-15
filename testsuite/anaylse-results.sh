#!/bin/sh


# case "$1" in
#     totals)
# 	totals ;;
#     *)
# 	exit ;;
# esac

total_fail=0;
total_pass=0;
total_xfail=0;
total_unresolved=0;

for dir in `find . -maxdepth 1 -type d | egrep -v ".libs|.deps" | grep "./"`; do
    nofail=`grep -c " FAILED: "   ${dir}/testrun.sum`
    nopass=`grep -c " PASSED: "   ${dir}/testrun.sum`
    noxfail=`grep -c " XFAILED: " ${dir}/testrun.sum`
    nounresolved=`grep -c " UNRESOLVED: " ${dir}/testrun.sum`
    echo -n "Test suite $dir had these results: "
    if test $nofail -gt 0; then
	echo -n " $nofail real failures"
	total_fail=`expr $total_fail + $nofail`
    fi
    if test $nopass -gt 0; then
	if test $nofail -gt 0; then
	    echo -n ", $nopass passes"
	else
	    echo -n "$nopass passes"
	fi
	total_pass=`expr $total_pass + $nopass`
    fi
    if test $noxfail -gt 0; then
	if test $nofail -gt 0 -o $nopass -gt 0; then
	    echo -n ", ${noxfail} expected failures"
	else
	    echo -n "${noxfail} expected failure"
	fi
	total_xfail=`expr $total_xfail + $noxfail`
    fi
    if test ${nounresolved} -gt 0; then
	if test $nofail -gt 0 -o $nopass -gt 0 -o $noxfail -gt 0; then
	    echo -n ", ${nounresolved} unresolved"
	else
	    echo -n "${nounresolved} unresolved"
	fi
	total_unresolved=`expr ${total_unresolved} + ${nounresolved}`
    fi
    echo
done

echo
echo "Test Result Totals:"
if test ${total_fail} -gt 0; then
    echo "	Total real failures: $total_fail"
fi
if test ${total_pass} -gt 0; then
    echo "	Total passes: $total_pass"
fi
if test ${total_unresolved} -gt 0; then
    echo "	Total unresolved: $total_unresolved"
fi
if test ${total_xfail} -gt 0; then
    echo "	Total expected failures: ${total_xfail}"
fi

#
# Look for regressions
#
