From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Aug 2021 11:08:37 +0200
Subject: [LTP] [PATCH 1/1] utils: Remove kernbench-0.42
Message-ID: <20210831090837.30245-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Quote homepage [1]:

kernbench is a CPU throughput benchmark. It is designed to compare
kernels on the same machine, or to compare hardware. It runs a kernel
compile at various numbers of concurrent jobs: 1/2 number of CPUs,
optimal (default is 4xnumber of CPUs), and maximal job count. Optionally
it can also run single threaded. It then prints out a number of useful
statistics for the average of each group of runs.

Implementation: simple shell script.

Reasons:
1) We don't use this benchmark tool.
2) It's an outdated version. Latest version 0.50 (released 2009) is
available from SF [1] and from the author website [2].

[1] http://freshmeat.sourceforge.net/projects/kernbench
[2] http://ck.kolivas.org/apps/kernbench/

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 utils/benchmark/kernbench-0.42/Makefile  |  29 ---
 utils/benchmark/kernbench-0.42/README    |  81 --------
 utils/benchmark/kernbench-0.42/kernbench | 233 -----------------------
 3 files changed, 343 deletions(-)
 delete mode 100644 utils/benchmark/kernbench-0.42/Makefile
 delete mode 100644 utils/benchmark/kernbench-0.42/README
 delete mode 100644 utils/benchmark/kernbench-0.42/kernbench

diff --git a/utils/benchmark/kernbench-0.42/Makefile b/utils/benchmark/kernbench-0.42/Makefile
deleted file mode 100644
index 0beb525ff..000000000
--- a/utils/benchmark/kernbench-0.42/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    utils/benchmarks/kernbench Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, November 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= kernbench
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/utils/benchmark/kernbench-0.42/README b/utils/benchmark/kernbench-0.42/README
deleted file mode 100644
index 6293fd5e7..000000000
--- a/utils/benchmark/kernbench-0.42/README
+++ /dev/null
@@ -1,81 +0,0 @@
-Kernbench v0.42
-
-
-What is this?
-
-This is a cpu throughput benchmark originally devised and used by Martin J.
-Bligh. It is designed to compare kernels on the same machine, or to compare
-hardware. To compare hardware you need to be running the same architecture
-machines (eg i386), the same userspace binaries and run kernbench on the same
-kernel source tree.
-
-It runs a kernel at various numbers of concurrent jobs: 1/2 number of cpus,
-optimal (default is 4xnumber of cpus) and maximal job count. Optionally it can
-also run single threaded. It then prints out a number of useful statistics
-for the average of each group of runs and logs them to kernbench.log
-
-You need more than 2Gb of ram for this to be a true throughput benchmark or
-else you will get swapstorms.
-
-Ideally it should be run in single user mode on a non-journalled filesystem.
-To compare results it should always be run in the same kernel tree.
-
-
-How do I use it?
-
-You need a kernel tree (any 2.6 will do) and the applications 'time', 'awk',
-'date' and 'yes' installed. 'time' is different to the builtin time used by
-BASH and has more information desired for this benchmark.
-
-Simply cd into the kernel tree directory and type
-
-/path/to/kernbench
-
-
-Options
-
-kernbench [-n runs] [-o jobs] [-s] [-H] [-O] [-M] [-h] [-v]
-n : number of times to perform benchmark (default 5)
-o : number of jobs for optimal run (default 4 * cpu)
-s : perform single threaded runs (default don't)
-H : don't perform half load runs (default do)
-O : don't perform optimal load runs (default do)
-M : don't perform maximal load runs (default do)
-f : fast run
-h : print this help
-v : print version number
-
-
-Changelog:
-v0.42 Fixed incorrect counting of cpus (thanks Flynn Marquardt)
-	Changed -j to at least 4GB ram.
-
-v0.41 Fixed make oldconfig
-
-v0.40 Made all runs use the oldconfig if it exists. Changed to only do one
-	warmup run before all the benchmarks. Added logging to kernbench.log
-	Cleaned up the code substantially to reuse code where possible.
-	Added standard deviation statistics courtesy of Peter Williams
-
-v0.30 Added fast run option which bypasses caching, warmup and tree
-	preparation and drops number of runs to 3. Modified half loads to
-	detect -j2 and change to -j3. Added syncs. Improved warnings and
-	messages.
-
-v0.20 Change to average of runs, add options to choose which runs to perform
-	remove single threaded run from defaults, do warmup run, lots more
-	sanity checks, drop meaningless runs, add a few warnings, remove fudge
-	factor from no. of jobs.
-
-v0.11 First public release
-
-
-Thanks: M. Bligh for ideas. Others for help with magic incantations to get
-	BASH to work.
-
-
-Con Kolivas <kernbench@kolivas.org>
-Mon Jun 18 18:59:24 2007
-
-License:
-GPL of course. Read COPYING included in this tarball.
diff --git a/utils/benchmark/kernbench-0.42/kernbench b/utils/benchmark/kernbench-0.42/kernbench
deleted file mode 100644
index 2d5817bed..000000000
--- a/utils/benchmark/kernbench-0.42/kernbench
+++ /dev/null
@@ -1,233 +0,0 @@
-#!/bin/bash
-# kernbench by Con Kolivas <kernbench@kolivas.org>
-# based on a benchmark by Martin J. Bligh
-trap 'echo "ABORTING";exit' 1 2 15
-
-VERSION=0.42
-
-num_runs=5
-single_runs=0
-half_runs=1
-opti_runs=1
-max_runs=1
-fast_run=0
-
-while getopts vsHOMn:o:hf i
-do
-	case $i in
-		 h) 	echo "kernbench v$VERSION by Con Kolivas <kernbench@kolivas.org>"
-				echo "Usage:"
-				echo "kernbench [-n runs] [-o jobs] [-s] [-H] [-O] [-M] [-h] [-v]"
-				echo "n : number of times to perform benchmark (default 5)"
-				echo "o : number of jobs for optimal run (default 4 * cpu)"
-				echo "s : perform single threaded runs (default don't)"
-				echo "H : don't perform half load runs (default do)"
-				echo "O : don't perform optimal load runs (default do)"
-				echo "M : don't perform maximal load runs (default do)"
-				echo "f : fast run"
-				echo "h : print this help"
-				echo "v : print version number"
-				exit ;;
-		 v) echo "kernbench Version $VERSION by Con Kolivas <kernbench@kolivas.org>" ; exit ;;
-		 n) nruns=$OPTARG ;;
-		 o) optijobs=$OPTARG ;;
-		 s) single_runs=1 ;;
-		 H) half_runs=0 ;;
-		 O) opti_runs=0 ;;
-		 M) max_runs=0 ;;
-		 f) fast_run=1 ;;
-	esac
-done
-
-if [[ ! -f include/linux/kernel.h ]] ; then
-	echo "No kernel source found; exiting"
-	exit
-fi
-
-for i in time awk yes date
-do
-	iname=`which $i`
-	if [[ ! -a $iname ]] ; then
-		echo "$i not found in path, please install it; exiting"
-		exit
-	fi
-done
-
-time=`which time`
-
-if [[ $nruns -gt 0 ]] ; then
-	num_runs=$nruns
-elif [[ $fast_run -eq 1 ]]; then
-	echo "Dropping to 3 runs for fast run"
-	num_runs=3
-fi
-
-if (($num_runs < 1)) ; then
-	echo "Nothing to do; exiting"
-	exit
-fi
-
-if (($num_runs > 10)) ; then
-	echo "Are you crazy? trimming number of runs to 10"
-	num_runs=10
-fi
-
-if [[ ! -d /proc ]] ; then
-	echo "Can't find proc filesystem; exiting"
-	exit
-fi
-
-mem=`awk '/MemTotal/ {print $2}' /proc/meminfo`
-if [[ $mem -lt 4000000 && $max_runs -gt 0 ]] ; then
-	echo Less than 4Gb ram detected!
-	echo Maximal loads will not measure cpu throughput and may cause a swapstorm!
-	echo If you did not plan this, -M flag is recommended to bypass maximal load.
-fi
-
-(( single_runs *= $num_runs ))
-(( half_runs *= $num_runs ))
-(( opti_runs *= $num_runs ))
-(( max_runs *= $num_runs ))
-
-cpus=`grep -c ^processor /proc/cpuinfo`
-echo $cpus cpus found
-echo Cleaning source tree...
-make clean > /dev/null 2>&1
-
-if [[ $fast_run -eq 0 ]] ; then
-	echo Caching kernel source in ram...
-	for i in `find -type f`
-	do
-		cat $i > /dev/null
-	done
-fi
-
-if [[ ! -f .config ]] ; then
-	echo No old config found, using defconfig
-	echo Making mrproper
-	make mrproper > /dev/null 2>&1
-	echo Making defconfig...
-	make defconfig > /dev/null 2>&1
-else
-	echo Making oldconfig...
-	yes "" | make oldconfig > /dev/null 2>&1
-fi
-
-halfjobs=$(( $cpus / 2 ))
-optijobs=${optijobs:=$(( $cpus * 4 ))}
-
-if [[ $halfjobs -lt 2 ]] ; then
-	echo "Half load is no greater than single; disabling"
-	half_runs=0
-elif [[ $halfjobs -eq 2 ]] ; then
-	echo "Half load is 2 jobs, changing to 3 as a kernel compile won't guarantee 2 jobs"
-	halfjobs=3
-fi
-
-echo Kernel `uname -r`
-echo Performing $num_runs runs of
-if [[ $single_runs -gt 0 ]] ; then
-	echo make
-fi
-if [[ $half_runs -gt 0 ]] ; then
-	echo make -j $halfjobs
-fi
-if [[ $opti_runs -gt 0 ]] ; then
-	echo make -j $optijobs
-fi
-if [[ $max_runs -gt 0 ]] ; then
-	echo make -j
-fi
-echo
-
-echo All data logged to kernbench.log
-
-if [[ $fast_run -eq 0 ]] ; then
-	echo Warmup run...
-	make -j $optijobs > /dev/null 2>&1
-fi
-
-date >> kernbench.log
-uname -r >> kernbench.log
-
-add_data_point()
-{
-    echo $@ | awk '{printf "%.6f %.6f %d", $1 + $2, $1 * $1 + $3, $4 + 1}'
-}
-
-show_statistics()
-{
-    case $3 in
-	0)
-	    echo "No data"
-	    ;;
-	1)
-	    echo $1
-	    ;;
-	*)
-	    avg=`echo $1 $3 | awk '{print $1 / $2}'`
-	    var=`echo $1 $2 $3 | awk '{print ($2 - ($1 * $1) / $3) / ($3 - 1)}'`
-	    sdev=`echo $var | awk '{print $1^0.5}'`
-	    echo "$avg ($sdev)"
-	    ;;
-    esac
-}
-
-do_log()
-{
-	echo "Average $runname Run (std deviation):" > templog
-	echo Elapsed Time  `show_statistics $temp_elapsed` >> templog
-	echo User Time  `show_statistics $temp_user` >> templog
-	echo System Time  `show_statistics $temp_sys` >> templog
-	echo Percent CPU  `show_statistics $temp_percent` >> templog
-	echo Context Switches  `show_statistics $temp_ctx` >> templog
-	echo Sleeps  `show_statistics $temp_sleeps` >> templog
-	echo >> templog
-	cat templog
-	cat templog >> kernbench.log
-}
-
-do_runs()
-{
-	temp_elapsed="a"
-	for (( i=1 ; i <= temp_runs ; i++ ))
-	do
-		echo $runname run number $i...
-		make clean > /dev/null 2>&1
-		sync
-		if [[ $fast_run -eq 0 ]] ; then
-			sleep 5
-		fi
-		$time -f "%e %U %S %P %c %w" -o timelog make -j $tempjobs > /dev/null 2>&1
-		read elapsed_time user_time sys_time percent ctx sleeps <timelog
-		temp_elapsed=`add_data_point $elapsed_time $temp_elapsed`
-		temp_user=`add_data_point $user_time $temp_user`
-		temp_sys=`add_data_point $sys_time $temp_sys`
-		temp_percent=`add_data_point $percent $temp_percent`
-		temp_ctx=`add_data_point $ctx $temp_ctx`
-		temp_sleeps=`add_data_point $sleeps $temp_sleeps`
-	done
-	if [[ $temp_runs -ne 0 ]] ; then
-		do_log
-	fi
-}
-
-temp_runs=$single_runs
-tempjobs=1
-runname="Single threaded"
-do_runs
-
-temp_runs=$half_runs
-tempjobs=$halfjobs
-runname="Half load -j $halfjobs"
-do_runs
-
-temp_runs=$opti_runs
-tempjobs=$optijobs
-runname="Optimal load -j $optijobs"
-do_runs
-
-temp_runs=$max_runs
-tempjobs=""
-runname="Maximal load -j"
-do_runs
-- 
2.33.0

