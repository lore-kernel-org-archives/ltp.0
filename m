From: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
Date: Sat, 17 Dec 2016 13:56:17 -0500
Subject: [LTP] On the performance of lcov...
Message-ID: <11e74d02-aec3-04c2-a001-39966d8d3430@giref.ulaval.ca>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

We are running gcov+lcov analysis each night for our software.  It does 
a really great job to help us manage our nightly tests database (~1100 
runs) and to discover unused lines of code! :)

However running lcov+genthml is really time consuming (longer than the 
tests or even compiling the code) and I would like to know if there is a 
way to make lcov+genthml go a little faster...

Here is the timings for a complete analysis and html generation:

===========================
  660s (1866 .gcno files):  lcov --rc lcov_branch_coverage=1 --capture 
--initial -d $obj/dev -d $obj2/dev -o init.info

2113s (1662 .gcda files): lcov --rc lcov_branch_coverage=1 --capture -d 
$obj/dev -d $obj2/dev -o cov.info

3112s: lcov --rc lcov_branch_coverage=1 --remove init.info "/usr*" 
"/opt*" "/pmi/Indus*" -o init.info && lcov --rc lcov_branch_coverage=1 
--remove cov.info   "/usr*" "/opt*" "/pmi/Indus*" -o cov.info
...
Deleted 255 files
Writing data to cov.info
Summary coverage rate:
   lines......: 69.4% (357216 of 515067 lines)
   functions..: 64.1% (61500 of 95942 functions)
   branches...: 32.1% (717338 of 2232711 branches)

2227s:  lcov --rc lcov_branch_coverage=1 -a init.info -a cov.info -o 
total.info
...
Combining tracefiles.
Reading tracefile init.info
Reading tracefile cov.info
Writing data to total.info
Summary coverage rate:
   lines......: 64.5% (357216 of 553958 lines)
   functions..: 60.3% (61500 of 102006 functions)
   branches...: 32.1% (717338 of 2232711 branches)

1391s:  genhtml  --show-details --legend --branch-coverage 
--demangle-cpp -o $$pref_html/coverage_dev total.info
Reading data file total.info
Found 2854 entries.
...
===========================

total time: 9503s => 2h38m

We would like to understand if we are doing something wrong... or if 
someone is aware of this performance "problem" or willing to optimize 
lcov/genthml code itself?

anyway, thanks for this great tool! :)

Eric

