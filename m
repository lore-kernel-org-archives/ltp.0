From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Jul 2018 14:29:11 +0200
Subject: [LTP] [RFC PATCH 1/1] pounder21: Remove
Message-ID: <20180723122911.10714-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It's is obsolete, not being built.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tools/Makefile                                |   2 -
 tools/pounder21/CHANGELOG                     | 241 -------
 tools/pounder21/COPYING                       | 340 ---------
 tools/pounder21/Install                       | 151 ----
 tools/pounder21/Makefile                      |  72 --
 tools/pounder21/README                        | 239 ------
 tools/pounder21/build_scripts/bonnie++        |  76 --
 tools/pounder21/build_scripts/build_kernel    |  38 -
 tools/pounder21/build_scripts/cpufreq         |  33 -
 tools/pounder21/build_scripts/ide_cdrom_copy  |  56 --
 tools/pounder21/build_scripts/ipmitool        |  73 --
 tools/pounder21/build_scripts/lame            | 127 ----
 tools/pounder21/build_scripts/ltp             |  38 -
 tools/pounder21/build_scripts/mem_alloc       |  25 -
 tools/pounder21/build_scripts/memtest         |  71 --
 tools/pounder21/build_scripts/memxfer5b       |  25 -
 tools/pounder21/build_scripts/ramsnake        |  26 -
 tools/pounder21/build_scripts/random_syscall  |  26 -
 .../pounder21/build_scripts/time_consistency  |  24 -
 tools/pounder21/build_scripts/time_drift      |  25 -
 tools/pounder21/build_scripts/xterm_stress    |  39 -
 tools/pounder21/config                        |  42 --
 tools/pounder21/debug.c                       |  74 --
 tools/pounder21/debug.h                       |  31 -
 tools/pounder21/doc/CONFIGURATION             | 107 ---
 tools/pounder21/doc/SCHEDULER                 | 352 ---------
 tools/pounder21/fancy_timed_loop.c            | 218 ------
 tools/pounder21/infinite_loop.c               | 174 -----
 tools/pounder21/libpounder.sh                 |  65 --
 tools/pounder21/nfs_logging                   |  95 ---
 tools/pounder21/pounder                       | 275 -------
 tools/pounder21/proclist.c                    |  72 --
 tools/pounder21/proclist.h                    |  40 -
 tools/pounder21/run.c                         | 681 ------------------
 .../pounder21/schedulers/default-tests.tar.gz | Bin 1663 -> 0 bytes
 tools/pounder21/schedulers/fast-tests.tar.gz  | Bin 1494 -> 0 bytes
 tools/pounder21/schedulers/test-tests.tar.gz  | Bin 1057 -> 0 bytes
 tools/pounder21/src/cpufreq/Makefile          |  31 -
 tools/pounder21/src/cpufreq/cpufreq.c         | 193 -----
 tools/pounder21/src/dump_xserver_statm        |  27 -
 tools/pounder21/src/libidecd.sh               |  95 ---
 tools/pounder21/src/mem_alloc_test/Makefile   |  26 -
 .../pounder21/src/mem_alloc_test/mem_alloc.c  | 425 -----------
 tools/pounder21/src/memtest.patch             |  37 -
 tools/pounder21/src/memxfer5b/Makefile        |  27 -
 tools/pounder21/src/memxfer5b/memxfer5b.c     | 338 ---------
 tools/pounder21/src/ramsnake/Makefile         |  30 -
 tools/pounder21/src/ramsnake/snake.c          | 313 --------
 tools/pounder21/src/randacoords/Makefile      |  27 -
 tools/pounder21/src/randacoords/coords.c      |  73 --
 tools/pounder21/src/randasyscall/Makefile     |  27 -
 tools/pounder21/src/randasyscall/randasys.c   | 252 -------
 tools/pounder21/src/time_tests/Makefile       |  28 -
 tools/pounder21/src/time_tests/drift-test.py  |  90 ---
 .../src/time_tests/inconsistency-check.c      | 102 ---
 tools/pounder21/src/xbonkers/Makefile         |  28 -
 tools/pounder21/src/xbonkers/xbonkers.c       | 562 ---------------
 tools/pounder21/test_repo/D01stats            |   1 -
 tools/pounder21/test_repo/T00hwinfo           |   1 -
 tools/pounder21/test_repo/T00sysrq_on         |   1 -
 tools/pounder21/test_repo/T01screen_noblank   |   1 -
 .../test_repo/T10single/T00xterm_stress       |   1 -
 tools/pounder21/test_repo/T10single/T01ltp    |   1 -
 .../pounder21/test_repo/T10single/T02ipmitool |   6 -
 tools/pounder21/test_repo/T90ramp/D01bonnie++ |   5 -
 .../test_repo/T90ramp/D02build_kernel         |   5 -
 .../test_repo/T90ramp/D03copy_large_tree      |   5 -
 tools/pounder21/test_repo/T90ramp/D04ddhappy  |   5 -
 .../test_repo/T90ramp/D05ide_cdrom_copy       |   5 -
 tools/pounder21/test_repo/T90ramp/D06lame     |   5 -
 tools/pounder21/test_repo/T90ramp/D07cpufreq  |   5 -
 tools/pounder21/test_repo/T90ramp/D08memtest  |   5 -
 .../pounder21/test_repo/T90ramp/D09memxfer5b  |   5 -
 tools/pounder21/test_repo/T90ramp/D10nfs      |   5 -
 tools/pounder21/test_repo/T90ramp/D11ramsnake |   5 -
 .../test_repo/T90ramp/D12random_syscall       |   5 -
 .../pounder21/test_repo/T90ramp/D13mem_alloc  |   5 -
 tools/pounder21/test_repo/T90ramp/D14ltp      |   5 -
 .../test_repo/T90ramp/D15time_consistency     |   5 -
 .../pounder21/test_repo/T90ramp/D16time_drift |   5 -
 .../test_repo/T90ramp/D17xterm_stress         |   5 -
 tools/pounder21/test_repo/T90ramp/T01rampup   |   1 -
 tools/pounder21/test_repo/T90ramp/T02rampup   |   1 -
 tools/pounder21/test_repo/T90ramp/T03rampup   |   1 -
 tools/pounder21/test_repo/T90ramp/T04rampup   |   1 -
 tools/pounder21/test_repo/T90ramp/T05rampup   |   1 -
 tools/pounder21/test_repo/T90ramp/T06rampup   |   1 -
 tools/pounder21/test_repo/T90ramp/T07rampup   |   1 -
 tools/pounder21/test_repo/T90ramp/T08rampup   |   1 -
 tools/pounder21/test_repo/T90ramp/T09rampup   |   1 -
 tools/pounder21/test_repo/T90ramp/T10rampup   |   1 -
 tools/pounder21/test_repo/T90ramp/T11rampup   |   1 -
 tools/pounder21/test_repo/T90ramp/T12rampup   |   1 -
 tools/pounder21/test_repo/T90ramp/T13rampup   |   1 -
 tools/pounder21/test_repo/T90ramp/T14rampup   |   1 -
 tools/pounder21/test_repo/T90ramp/T15rampup   |   1 -
 tools/pounder21/test_repo/T90ramp/T16rampup   |   1 -
 tools/pounder21/test_repo/T90ramp/T17rampup   |   1 -
 .../pounder21/test_repo/T90ramp/T99runawhile  |   4 -
 tools/pounder21/test_repo/T90ramp/ramp_wait   |   3 -
 tools/pounder21/test_repo/T99screen_blank     |   1 -
 tools/pounder21/test_repo/excluded/testlist   |   7 -
 tools/pounder21/test_scripts/abort.sh         |  23 -
 tools/pounder21/test_scripts/bonnie++         |  81 ---
 tools/pounder21/test_scripts/build_kernel     |  62 --
 tools/pounder21/test_scripts/copy_large_tree  |  43 --
 tools/pounder21/test_scripts/cpufreq          | 111 ---
 tools/pounder21/test_scripts/ddhappy          |  51 --
 tools/pounder21/test_scripts/fail.sh          |  23 -
 tools/pounder21/test_scripts/get_hw_info      |  87 ---
 tools/pounder21/test_scripts/ide_cdrom_copy   |  91 ---
 tools/pounder21/test_scripts/ipmitool         | 127 ----
 tools/pounder21/test_scripts/lame             |  51 --
 tools/pounder21/test_scripts/ltp              |  40 -
 tools/pounder21/test_scripts/mem_alloc        |  43 --
 tools/pounder21/test_scripts/memtest          |  53 --
 tools/pounder21/test_scripts/memxfer5b        |  42 --
 tools/pounder21/test_scripts/nfs              |  88 ---
 tools/pounder21/test_scripts/pass.sh          |  22 -
 tools/pounder21/test_scripts/passloop.sh      |  23 -
 tools/pounder21/test_scripts/ping_nfs_server  |  29 -
 tools/pounder21/test_scripts/ramsnake         |  68 --
 tools/pounder21/test_scripts/random_syscall   |  70 --
 tools/pounder21/test_scripts/screen_blank     |  26 -
 tools/pounder21/test_scripts/screen_noblank   |  27 -
 tools/pounder21/test_scripts/sigfpe.sh        |  24 -
 tools/pounder21/test_scripts/simpleD          |   4 -
 tools/pounder21/test_scripts/sleep            |  24 -
 tools/pounder21/test_scripts/statslogging     | 112 ---
 tools/pounder21/test_scripts/sysrq-on         |   7 -
 tools/pounder21/test_scripts/time_consistency |  35 -
 tools/pounder21/test_scripts/time_drift       |  72 --
 tools/pounder21/test_scripts/xterm_stress     | 176 -----
 tools/pounder21/timed_loop.c                  | 197 -----
 134 files changed, 8765 deletions(-)
 delete mode 100644 tools/pounder21/CHANGELOG
 delete mode 100644 tools/pounder21/COPYING
 delete mode 100755 tools/pounder21/Install
 delete mode 100644 tools/pounder21/Makefile
 delete mode 100644 tools/pounder21/README
 delete mode 100755 tools/pounder21/build_scripts/bonnie++
 delete mode 100755 tools/pounder21/build_scripts/build_kernel
 delete mode 100755 tools/pounder21/build_scripts/cpufreq
 delete mode 100755 tools/pounder21/build_scripts/ide_cdrom_copy
 delete mode 100755 tools/pounder21/build_scripts/ipmitool
 delete mode 100755 tools/pounder21/build_scripts/lame
 delete mode 100755 tools/pounder21/build_scripts/ltp
 delete mode 100755 tools/pounder21/build_scripts/mem_alloc
 delete mode 100755 tools/pounder21/build_scripts/memtest
 delete mode 100755 tools/pounder21/build_scripts/memxfer5b
 delete mode 100755 tools/pounder21/build_scripts/ramsnake
 delete mode 100755 tools/pounder21/build_scripts/random_syscall
 delete mode 100755 tools/pounder21/build_scripts/time_consistency
 delete mode 100755 tools/pounder21/build_scripts/time_drift
 delete mode 100755 tools/pounder21/build_scripts/xterm_stress
 delete mode 100644 tools/pounder21/config
 delete mode 100644 tools/pounder21/debug.c
 delete mode 100644 tools/pounder21/debug.h
 delete mode 100644 tools/pounder21/doc/CONFIGURATION
 delete mode 100644 tools/pounder21/doc/SCHEDULER
 delete mode 100644 tools/pounder21/fancy_timed_loop.c
 delete mode 100644 tools/pounder21/infinite_loop.c
 delete mode 100644 tools/pounder21/libpounder.sh
 delete mode 100755 tools/pounder21/nfs_logging
 delete mode 100755 tools/pounder21/pounder
 delete mode 100644 tools/pounder21/proclist.c
 delete mode 100644 tools/pounder21/proclist.h
 delete mode 100644 tools/pounder21/run.c
 delete mode 100644 tools/pounder21/schedulers/default-tests.tar.gz
 delete mode 100644 tools/pounder21/schedulers/fast-tests.tar.gz
 delete mode 100644 tools/pounder21/schedulers/test-tests.tar.gz
 delete mode 100644 tools/pounder21/src/cpufreq/Makefile
 delete mode 100644 tools/pounder21/src/cpufreq/cpufreq.c
 delete mode 100755 tools/pounder21/src/dump_xserver_statm
 delete mode 100755 tools/pounder21/src/libidecd.sh
 delete mode 100644 tools/pounder21/src/mem_alloc_test/Makefile
 delete mode 100644 tools/pounder21/src/mem_alloc_test/mem_alloc.c
 delete mode 100644 tools/pounder21/src/memtest.patch
 delete mode 100644 tools/pounder21/src/memxfer5b/Makefile
 delete mode 100644 tools/pounder21/src/memxfer5b/memxfer5b.c
 delete mode 100644 tools/pounder21/src/ramsnake/Makefile
 delete mode 100644 tools/pounder21/src/ramsnake/snake.c
 delete mode 100644 tools/pounder21/src/randacoords/Makefile
 delete mode 100644 tools/pounder21/src/randacoords/coords.c
 delete mode 100644 tools/pounder21/src/randasyscall/Makefile
 delete mode 100644 tools/pounder21/src/randasyscall/randasys.c
 delete mode 100644 tools/pounder21/src/time_tests/Makefile
 delete mode 100755 tools/pounder21/src/time_tests/drift-test.py
 delete mode 100644 tools/pounder21/src/time_tests/inconsistency-check.c
 delete mode 100644 tools/pounder21/src/xbonkers/Makefile
 delete mode 100644 tools/pounder21/src/xbonkers/xbonkers.c
 delete mode 120000 tools/pounder21/test_repo/D01stats
 delete mode 120000 tools/pounder21/test_repo/T00hwinfo
 delete mode 120000 tools/pounder21/test_repo/T00sysrq_on
 delete mode 120000 tools/pounder21/test_repo/T01screen_noblank
 delete mode 120000 tools/pounder21/test_repo/T10single/T00xterm_stress
 delete mode 120000 tools/pounder21/test_repo/T10single/T01ltp
 delete mode 100755 tools/pounder21/test_repo/T10single/T02ipmitool
 delete mode 100755 tools/pounder21/test_repo/T90ramp/D01bonnie++
 delete mode 100755 tools/pounder21/test_repo/T90ramp/D02build_kernel
 delete mode 100755 tools/pounder21/test_repo/T90ramp/D03copy_large_tree
 delete mode 100755 tools/pounder21/test_repo/T90ramp/D04ddhappy
 delete mode 100755 tools/pounder21/test_repo/T90ramp/D05ide_cdrom_copy
 delete mode 100755 tools/pounder21/test_repo/T90ramp/D06lame
 delete mode 100755 tools/pounder21/test_repo/T90ramp/D07cpufreq
 delete mode 100755 tools/pounder21/test_repo/T90ramp/D08memtest
 delete mode 100755 tools/pounder21/test_repo/T90ramp/D09memxfer5b
 delete mode 100755 tools/pounder21/test_repo/T90ramp/D10nfs
 delete mode 100755 tools/pounder21/test_repo/T90ramp/D11ramsnake
 delete mode 100755 tools/pounder21/test_repo/T90ramp/D12random_syscall
 delete mode 100755 tools/pounder21/test_repo/T90ramp/D13mem_alloc
 delete mode 100755 tools/pounder21/test_repo/T90ramp/D14ltp
 delete mode 100755 tools/pounder21/test_repo/T90ramp/D15time_consistency
 delete mode 100755 tools/pounder21/test_repo/T90ramp/D16time_drift
 delete mode 100755 tools/pounder21/test_repo/T90ramp/D17xterm_stress
 delete mode 120000 tools/pounder21/test_repo/T90ramp/T01rampup
 delete mode 120000 tools/pounder21/test_repo/T90ramp/T02rampup
 delete mode 120000 tools/pounder21/test_repo/T90ramp/T03rampup
 delete mode 120000 tools/pounder21/test_repo/T90ramp/T04rampup
 delete mode 120000 tools/pounder21/test_repo/T90ramp/T05rampup
 delete mode 120000 tools/pounder21/test_repo/T90ramp/T06rampup
 delete mode 120000 tools/pounder21/test_repo/T90ramp/T07rampup
 delete mode 120000 tools/pounder21/test_repo/T90ramp/T08rampup
 delete mode 120000 tools/pounder21/test_repo/T90ramp/T09rampup
 delete mode 120000 tools/pounder21/test_repo/T90ramp/T10rampup
 delete mode 120000 tools/pounder21/test_repo/T90ramp/T11rampup
 delete mode 120000 tools/pounder21/test_repo/T90ramp/T12rampup
 delete mode 120000 tools/pounder21/test_repo/T90ramp/T13rampup
 delete mode 120000 tools/pounder21/test_repo/T90ramp/T14rampup
 delete mode 120000 tools/pounder21/test_repo/T90ramp/T15rampup
 delete mode 120000 tools/pounder21/test_repo/T90ramp/T16rampup
 delete mode 120000 tools/pounder21/test_repo/T90ramp/T17rampup
 delete mode 100755 tools/pounder21/test_repo/T90ramp/T99runawhile
 delete mode 100755 tools/pounder21/test_repo/T90ramp/ramp_wait
 delete mode 120000 tools/pounder21/test_repo/T99screen_blank
 delete mode 100644 tools/pounder21/test_repo/excluded/testlist
 delete mode 100755 tools/pounder21/test_scripts/abort.sh
 delete mode 100755 tools/pounder21/test_scripts/bonnie++
 delete mode 100755 tools/pounder21/test_scripts/build_kernel
 delete mode 100755 tools/pounder21/test_scripts/copy_large_tree
 delete mode 100755 tools/pounder21/test_scripts/cpufreq
 delete mode 100755 tools/pounder21/test_scripts/ddhappy
 delete mode 100755 tools/pounder21/test_scripts/fail.sh
 delete mode 100755 tools/pounder21/test_scripts/get_hw_info
 delete mode 100755 tools/pounder21/test_scripts/ide_cdrom_copy
 delete mode 100755 tools/pounder21/test_scripts/ipmitool
 delete mode 100755 tools/pounder21/test_scripts/lame
 delete mode 100755 tools/pounder21/test_scripts/ltp
 delete mode 100755 tools/pounder21/test_scripts/mem_alloc
 delete mode 100755 tools/pounder21/test_scripts/memtest
 delete mode 100755 tools/pounder21/test_scripts/memxfer5b
 delete mode 100755 tools/pounder21/test_scripts/nfs
 delete mode 100755 tools/pounder21/test_scripts/pass.sh
 delete mode 100755 tools/pounder21/test_scripts/passloop.sh
 delete mode 100755 tools/pounder21/test_scripts/ping_nfs_server
 delete mode 100755 tools/pounder21/test_scripts/ramsnake
 delete mode 100755 tools/pounder21/test_scripts/random_syscall
 delete mode 100755 tools/pounder21/test_scripts/screen_blank
 delete mode 100755 tools/pounder21/test_scripts/screen_noblank
 delete mode 100755 tools/pounder21/test_scripts/sigfpe.sh
 delete mode 100755 tools/pounder21/test_scripts/simpleD
 delete mode 100755 tools/pounder21/test_scripts/sleep
 delete mode 100755 tools/pounder21/test_scripts/statslogging
 delete mode 100755 tools/pounder21/test_scripts/sysrq-on
 delete mode 100755 tools/pounder21/test_scripts/time_consistency
 delete mode 100755 tools/pounder21/test_scripts/time_drift
 delete mode 100755 tools/pounder21/test_scripts/xterm_stress
 delete mode 100644 tools/pounder21/timed_loop.c

diff --git a/tools/Makefile b/tools/Makefile
index 53bc8ef77..def1c6fa9 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -24,8 +24,6 @@ top_srcdir		?= ..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-FILTER_OUT_DIRS		:= pounder21
-
 INSTALL_TARGETS		:= *.awk *.pl *.sh html_report_header.txt
 
 INSTALL_DIR		:= bin
diff --git a/tools/pounder21/CHANGELOG b/tools/pounder21/CHANGELOG
deleted file mode 100644
index b5296d214..000000000
--- a/tools/pounder21/CHANGELOG
+++ /dev/null
@@ -1,241 +0,0 @@
-This is a log of changes to pounder21.
-
-pounder30-2011-08-09
-- Created new documentation CONFIGURATION and moved it and SCHEDULER
-  into a newly created doc/ directory
-- Deleted the test-all test scheduler
-- Created /schedulers directory and moved the remaining test schedulers there
-- Removed option to specify "NONE" when asked to unpack test scheduler during build
-- Removed check for existing kernel directory in /tmp in test_scripts/build_kernel
-  since it appears that some files get lost after running build_kernel once; Instead
-  just untar the kernel each time we run the test script to be on the safe side
-- ltp test script would pass even if it didn't build currently, fixed this in
-  test_scripts/ltp
-- changed ltp build_script to install ltp to $POUNDER_TMPDIR
-- removed QUICKSTART and included it in README instead
-- removed trailing "/" from POUNDER_LOGLOCAL export in libpounder.sh
-- Added functionality for automatic skipping of subtests (see README)
-- Created xterm_stress build script and merged 00xbonkers with it
-- Created ide_cdrom_copy build script and merged 00check_cdrom_presence with it
-- Merged nasm and schedutils build scripts with the lame build script
-- Merged time_test build script with the time_consistency and time_drift build
-  scripts
-- Created test_repo/ directory
-- Uncommented a piece of code in time_drift that allowed it to always pass
-- Added pounder -c option for creating new test schedulers
-- Modified POUNDER_VERSION in libpounder.sh
-
-pounder30-2011-07-21
-- Updated bonnie++, ipmitool, kernel (used in build_kernel), and memtest script to latest versions
-- Updated memtest build scripts and $POUNDER_HOME/src/memtest.patch
-- Added functionality for skipping of subtests
-  - Added functionality for automating the skipping of subtests (see README)
-- Removed unnecessary 00checklatest test
-- Moved checking for system requirements from test run to build phase
-  - Affects bonnie++, memtest, cpufreq, and ide_cdrom_copy
-- Added environment variable MAX_FAILURES that, if defined, sets
-  an upper bound on the number of failures a looped test will allow
-  before aborting the test altogether (see SCHEDULER)
-- Added functionality for removing and re-adding subtests to the test scheduler (see SCHEDULER)
-- Updated README, SCHEDULER, and config files
-
-pounder21-2011-04-08:
-- LTP: Updated to LTP 20101031 release.
-- Build kernel testcase - Updated kernel from 2.6.18 to 2.6.38.
-- Updated 2.6.38 kernel source tar in pounder cache.
-- Did corresponding kernel changes i.e for 2.6.38 in "memtest" testcase too.
-- Files modified are:-
-  -$POUNDER_HOME/test_scripts/memtest.
-  -$POUNDER_HOME/test_scripts/build_kernel .
-  -$POUNDER_HOME/build_scripts/memtest.
-  -$POUNDER_HOME/build_scripts/build_kernel.
-  -$POUNDER_HOME/opt/memtest.sh. [Actually this file need to get changed in tux1 cache].
-
-pounder21-2011-04-12
--Integrated bash-memory testcase in pounder21
--Files added/modified are:-
- -Copied bash-memory test case tar to pounder cache.
- -Added file $POUNDER_HOME/build_scripts/bash-memory
- -Added file $POUNDER_HOME/test_scripts/bash_memory
- -Added file $POUNDER_HOME/tests/T10single/T03bashmemory
-
-pounder21-2006-11-07:
-- Fix a bug in randasys on x86-64 where we had insufficient random bits and
-  would truncate whatever we got, leading to all 0 arguments by simply
-  generating enough random bytes to fill an unsigned long.  Also add a -z
-  switch to enable this zero-only mode because it found some bugs.  :)
-
-pounder21-2006-10-12:
-- Include /sysfs contents in the hw inventory
-- Put 'lspci' into the PCI inventory for easy finding.
-
-pounder21-2006-09-23:
-- Various time test fixes from jstultz.
-- IPMI tests from James Simshaw/Carol Hebert.
-- Update kernel from 2.6.15 to 2.6.18.
-
-pounder21-2006-01-24:
-- Establish all files in the tarball as originating from IBM LTC.
-- License all files under the GNU Public License (GPL) v2.
-- Install: Make USE_CACHE=0 if the pounder cache dir is not set.
-- Makefile: distclean -> mrclean for more GNUness.
-- nfs_logging: Clarify some of the documentation, and use TCP NFS mounts.
-- 00checklatest: Handle leading zeroes in date components.
-- build_kernel: Update to kernel 2.6.15.
-- ltp: Update to 20060105 release.
-- memtest: Update to kernel 2.6.15.
-- cpufreq: Report the return code in the log, and kill cpufreq programs
-  when it's time to terminate.
-- randasyscall: Add -Wall to CFLAGS and fix warnings.  Also add -d option
-  to log every call made.  NOTE: That may affect race conditions exposed
-  by this program!
-- drift_test: Only set system time from NTP source if -s option is passed
-  (John Stultz)
-- inconsistency_check: Use CLOCK_MONOTONIC if available (John Stultz)
-- nfs test: Use TCP NFS connections.
-- copytree: Diff source and dest before deletion.
-
-pounder21-2005-12-02:
-- Make CHANGELOG reflect the CVS history.
-- pounder: Make the -d switch (total test duration) work again.
-- check_cdrom_presence: Remove unnecessary variable.
-- build_kernel: Update kernel to 2.6.14.3.
-- libidecd.sh: Grep for "^$DEV[<space><tab>]" so that we ONLY look for
-  full device names in the first columns.  Also update documentation to
-  reflect the code intent better.
-- memtest: Update kernel to 2.6.14.3.
-- time_tests: New code from John:
-  o Use CLOCK_MONOTONIC (calls to settimeofday won't affect this)
-  o Takes an argument to run for a set number of seconds(nothing or -1 ==
-    run forever)
-  o Exits if any time inconsistency is found.
-  o Outputs the delta size of the inconsistency found
-- mem_alloc: Only run every 15min.  Constantly being OOM is annoying.
-- nfs: Better status printing during cleanup.
-- random_syscall: Put the program in /tmp again.
-
-pounder21-2005-11-18:
-- Install: Check for g++ and lex.
-- statslogging: Copy README to the log dir to capture version and
-  relevant notes.
-- randasys: Use $POUNDER_TMPDIR, not /tmp, and use quotes with
-  variable expansions.  Also forbid calling settimeofday(2).
-- checklatest: Be more intelligent about figuring out the version
-  number--if what we're running is newer than what's on the server,
-  that's fine.  We're probably just running a development version.
-- cpufreq: This is a new test that detects the presence of speedstep,
-  powernow, or whatever other CPU frequency changing mechanisms are
-  in place.  If present, it will cycle the CPUs through all power
-  state changes in arbitrary order.  It's also clever enough to find
-  and ignore CPUs whose frequency is tied to another processor.
-- pounder: Fix argument passing so that -l switch works.  Added -s
-  switch to disable NFS logging.
-- nfs_logging: Move variable definitions into libpounder.sh and flatten
-  the function calls into a more procedural script.
-- ide_cdrom_copy: Total rewrite of this script: The old script did not
-  detect SCSI CD-ROM drives at all unless /dev/cdrom was set up properly
-  (this is not the case if you netinstall RHEL4 on a blade with the
-  media tray disconnected) and it did not deal with multiple optical
-  drives at all.  This new one creates a list of potential CD/DVD
-  devices and tries to mount each of them; each drive that has a disc
-  inserted is then queued up for testing.  Also, the actual device
-  detection code is in src/libidecd.sh so that the 00check_cdrom script
-  can take advantage of it.
-- 00check_cdrom: Rewritten to use libidecd.sh; if no discs are found,
-  all drive trays are ejected.
-- default/fast-tests.tar.gz: Updated to incorporate cpufreq test.
-- libpounder.sh: Added and rearranged variables as required for NFS
-  logging support.
-
-pounder21-2005-11-03:
-- fast-tests: Run mem_alloc
-- statslogging: Start the logfile tail.
-
-pounder21-2005-11-01:
-- README: pounder 2005-10-31
-- nfs_logging: Put log files in /crash/pounder-logs, not /crash.  Also use
-  uname-arch as a key, not just uname.
-- pounder: Add help() func and -r flag to remount log storage.
-
-
-pounder21-2005-10-28:
-- Sarunya's NFS logging support.
-- Sarunya's memory allocation stress test.
-- NFS test only removes what it copies (it was deleting
-  the per-host directory too).
-- IDE CDROM copy test only probes the first CDROM device
-  found in fstab... rather than grabbing both entries and
-  breaking.
-
-pounder21-2005-10-11:
-- Check CDROM presence when installing pounder. (patch by Sarunya)
-- Fix NFS test's diff failure detection. (patch by Darrick)
-- Clamp ramsnake so that it won't use more than 1/4 of the
-  address space so that i386-bigsmp boxes won't fail. (found by
-  Russ, patch by Darrick)
-
-pounder21-2005-09-20:
-- README: pounder 2005-09-20 release.
-- get_hw_info: Add missing '-l' to list partitions.
-- nfs: $SHORTHOST needs to extract from $HOSTNAME, not $SHORTHOST.  This was
-  causing nfs failures.
-- xterm_stress: Remove old log files before starting X server, copy the log
-  file if the X server failed to start, and kill the X server
-  if there's a failure to start.
-
-pounder21-2005-09-19:
-- get_hw_info: Record partition layout.
-- ramsnake: Kill program after 300s, not thirty!
-
-pounder21-2005-09-09:
-- checklatest: Download tarball to $POUNDER_HOME/../ so that untar goes in
-  the right place.
-- xterm_stress: Make script use kill -9 on X servers that ignore -4 after
-  180s and abort the script if it's still not dead after 360.
-
-pounder21-2005-08-31:
-- nfs: Strip domain bits (".ibm.com", ".west.foo.com", etc) out of the
-  $HOSTNAME, put that into $SHORTHOST, and use that on the NFS
-  server so that we cut down on the number of bogus dirs and crud
-  on that filesystem.
-
-pounder21-2005-08-26:
-- xbonkers: Program to make windows in an X session move all over the screen.
-  Add this to xterm_stress so that our poor window placement doesn't
-  much matter anymore.
-- xterm_stress: We're allowed 1 fatal error at the end because killing X
-  is a fatal error.
-- time_consistency: We're NOT allowed to excuse any errors.
-
-pounder21-2005-08-17:
-- More fixes to make sure the xterm_stress test dies when it should, an LTP refresh,
-  and a couple of patches designed to make pounder work better with the
-  mainline testing rig.  I haven't seen any problems with it, so I'm
-  pushing it out to the group to find more error cases.  :)
-
-pounder21-2005-08-16:
-- README: Add warning that changing the first line is a bad idea.
-- Install: Build helpers after building tests, so that the 00checklatest
-  script runs immediately.
-- checklatest: Compares this pounder's version (as defined as the sixth
-  column in README) against what's on the server.  If there's
-  a mismatch, ask the user if he wants to download the new one.
-- libpounder.sh: Add a $POUNDER_VERSION variable and location of
-  $POUNDER_HEAD.
-
-pounder21-2005-08-15:
-- NFS test: diff whatever it is we copy.  Hope that nobody's changing /usr...
-- X test: Use `startx' to start X with the appropriate KDE/GNOME session,
-  and start some OpenGL tests too.
-
-pounder21-2005-07-13:
-- Modify build scripts to use a download_from_sourceforge fxn that will retry
-  failed downloads with other SF mirrors.
-
-pounder21-2005-04-04:
-- No more bluebench.
-
-pounder21-2005-02-25:
-- Fix install failure on SLES8.
-- New test to stress concurrent memory access on shared memory
-  on numa-ish systems.  Well, any system with shared memory...
diff --git a/tools/pounder21/COPYING b/tools/pounder21/COPYING
deleted file mode 100644
index d60c31a97..000000000
--- a/tools/pounder21/COPYING
+++ /dev/null
@@ -1,340 +0,0 @@
-		    GNU GENERAL PUBLIC LICENSE
-		       Version 2, June 1991
-
- Copyright (C) 1989, 1991 Free Software Foundation, Inc.
-     59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- Everyone is permitted to copy and distribute verbatim copies
- of this license document, but changing it is not allowed.
-
-			    Preamble
-
-  The licenses for most software are designed to take away your
-freedom to share and change it.  By contrast, the GNU General Public
-License is intended to guarantee your freedom to share and change free
-software--to make sure the software is free for all its users.  This
-General Public License applies to most of the Free Software
-Foundation's software and to any other program whose authors commit to
-using it.  (Some other Free Software Foundation software is covered by
-the GNU Library General Public License instead.)  You can apply it to
-your programs, too.
-
-  When we speak of free software, we are referring to freedom, not
-price.  Our General Public Licenses are designed to make sure that you
-have the freedom to distribute copies of free software (and charge for
-this service if you wish), that you receive source code or can get it
-if you want it, that you can change the software or use pieces of it
-in new free programs; and that you know you can do these things.
-
-  To protect your rights, we need to make restrictions that forbid
-anyone to deny you these rights or to ask you to surrender the rights.
-These restrictions translate to certain responsibilities for you if you
-distribute copies of the software, or if you modify it.
-
-  For example, if you distribute copies of such a program, whether
-gratis or for a fee, you must give the recipients all the rights that
-you have.  You must make sure that they, too, receive or can get the
-source code.  And you must show them these terms so they know their
-rights.
-
-  We protect your rights with two steps: (1) copyright the software, and
-(2) offer you this license which gives you legal permission to copy,
-distribute and/or modify the software.
-
-  Also, for each author's protection and ours, we want to make certain
-that everyone understands that there is no warranty for this free
-software.  If the software is modified by someone else and passed on, we
-want its recipients to know that what they have is not the original, so
-that any problems introduced by others will not reflect on the original
-authors' reputations.
-
-  Finally, any free program is threatened constantly by software
-patents.  We wish to avoid the danger that redistributors of a free
-program will individually obtain patent licenses, in effect making the
-program proprietary.  To prevent this, we have made it clear that any
-patent must be licensed for everyone's free use or not licensed at all.
-
-  The precise terms and conditions for copying, distribution and
-modification follow.
-
-		    GNU GENERAL PUBLIC LICENSE
-   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
-
-  0. This License applies to any program or other work which contains
-a notice placed by the copyright holder saying it may be distributed
-under the terms of this General Public License.  The "Program", below,
-refers to any such program or work, and a "work based on the Program"
-means either the Program or any derivative work under copyright law:
-that is to say, a work containing the Program or a portion of it,
-either verbatim or with modifications and/or translated into another
-language.  (Hereinafter, translation is included without limitation in
-the term "modification".)  Each licensee is addressed as "you".
-
-Activities other than copying, distribution and modification are not
-covered by this License; they are outside its scope.  The act of
-running the Program is not restricted, and the output from the Program
-is covered only if its contents constitute a work based on the
-Program (independent of having been made by running the Program).
-Whether that is true depends on what the Program does.
-
-  1. You may copy and distribute verbatim copies of the Program's
-source code as you receive it, in any medium, provided that you
-conspicuously and appropriately publish on each copy an appropriate
-copyright notice and disclaimer of warranty; keep intact all the
-notices that refer to this License and to the absence of any warranty;
-and give any other recipients of the Program a copy of this License
-along with the Program.
-
-You may charge a fee for the physical act of transferring a copy, and
-you may at your option offer warranty protection in exchange for a fee.
-
-  2. You may modify your copy or copies of the Program or any portion
-of it, thus forming a work based on the Program, and copy and
-distribute such modifications or work under the terms of Section 1
-above, provided that you also meet all of these conditions:
-
-    a) You must cause the modified files to carry prominent notices
-    stating that you changed the files and the date of any change.
-
-    b) You must cause any work that you distribute or publish, that in
-    whole or in part contains or is derived from the Program or any
-    part thereof, to be licensed as a whole at no charge to all third
-    parties under the terms of this License.
-
-    c) If the modified program normally reads commands interactively
-    when run, you must cause it, when started running for such
-    interactive use in the most ordinary way, to print or display an
-    announcement including an appropriate copyright notice and a
-    notice that there is no warranty (or else, saying that you provide
-    a warranty) and that users may redistribute the program under
-    these conditions, and telling the user how to view a copy of this
-    License.  (Exception: if the Program itself is interactive but
-    does not normally print such an announcement, your work based on
-    the Program is not required to print an announcement.)
-
-These requirements apply to the modified work as a whole.  If
-identifiable sections of that work are not derived from the Program,
-and can be reasonably considered independent and separate works in
-themselves, then this License, and its terms, do not apply to those
-sections when you distribute them as separate works.  But when you
-distribute the same sections as part of a whole which is a work based
-on the Program, the distribution of the whole must be on the terms of
-this License, whose permissions for other licensees extend to the
-entire whole, and thus to each and every part regardless of who wrote it.
-
-Thus, it is not the intent of this section to claim rights or contest
-your rights to work written entirely by you; rather, the intent is to
-exercise the right to control the distribution of derivative or
-collective works based on the Program.
-
-In addition, mere aggregation of another work not based on the Program
-with the Program (or with a work based on the Program) on a volume of
-a storage or distribution medium does not bring the other work under
-the scope of this License.
-
-  3. You may copy and distribute the Program (or a work based on it,
-under Section 2) in object code or executable form under the terms of
-Sections 1 and 2 above provided that you also do one of the following:
-
-    a) Accompany it with the complete corresponding machine-readable
-    source code, which must be distributed under the terms of Sections
-    1 and 2 above on a medium customarily used for software interchange; or,
-
-    b) Accompany it with a written offer, valid for at least three
-    years, to give any third party, for a charge no more than your
-    cost of physically performing source distribution, a complete
-    machine-readable copy of the corresponding source code, to be
-    distributed under the terms of Sections 1 and 2 above on a medium
-    customarily used for software interchange; or,
-
-    c) Accompany it with the information you received as to the offer
-    to distribute corresponding source code.  (This alternative is
-    allowed only for noncommercial distribution and only if you
-    received the program in object code or executable form with such
-    an offer, in accord with Subsection b above.)
-
-The source code for a work means the preferred form of the work for
-making modifications to it.  For an executable work, complete source
-code means all the source code for all modules it contains, plus any
-associated interface definition files, plus the scripts used to
-control compilation and installation of the executable.  However, as a
-special exception, the source code distributed need not include
-anything that is normally distributed (in either source or binary
-form) with the major components (compiler, kernel, and so on) of the
-operating system on which the executable runs, unless that component
-itself accompanies the executable.
-
-If distribution of executable or object code is made by offering
-access to copy from a designated place, then offering equivalent
-access to copy the source code from the same place counts as
-distribution of the source code, even though third parties are not
-compelled to copy the source along with the object code.
-
-  4. You may not copy, modify, sublicense, or distribute the Program
-except as expressly provided under this License.  Any attempt
-otherwise to copy, modify, sublicense or distribute the Program is
-void, and will automatically terminate your rights under this License.
-However, parties who have received copies, or rights, from you under
-this License will not have their licenses terminated so long as such
-parties remain in full compliance.
-
-  5. You are not required to accept this License, since you have not
-signed it.  However, nothing else grants you permission to modify or
-distribute the Program or its derivative works.  These actions are
-prohibited by law if you do not accept this License.  Therefore, by
-modifying or distributing the Program (or any work based on the
-Program), you indicate your acceptance of this License to do so, and
-all its terms and conditions for copying, distributing or modifying
-the Program or works based on it.
-
-  6. Each time you redistribute the Program (or any work based on the
-Program), the recipient automatically receives a license from the
-original licensor to copy, distribute or modify the Program subject to
-these terms and conditions.  You may not impose any further
-restrictions on the recipients' exercise of the rights granted herein.
-You are not responsible for enforcing compliance by third parties to
-this License.
-
-  7. If, as a consequence of a court judgment or allegation of patent
-infringement or for any other reason (not limited to patent issues),
-conditions are imposed on you (whether by court order, agreement or
-otherwise) that contradict the conditions of this License, they do not
-excuse you from the conditions of this License.  If you cannot
-distribute so as to satisfy simultaneously your obligations under this
-License and any other pertinent obligations, then as a consequence you
-may not distribute the Program at all.  For example, if a patent
-license would not permit royalty-free redistribution of the Program by
-all those who receive copies directly or indirectly through you, then
-the only way you could satisfy both it and this License would be to
-refrain entirely from distribution of the Program.
-
-If any portion of this section is held invalid or unenforceable under
-any particular circumstance, the balance of the section is intended to
-apply and the section as a whole is intended to apply in other
-circumstances.
-
-It is not the purpose of this section to induce you to infringe any
-patents or other property right claims or to contest validity of any
-such claims; this section has the sole purpose of protecting the
-integrity of the free software distribution system, which is
-implemented by public license practices.  Many people have made
-generous contributions to the wide range of software distributed
-through that system in reliance on consistent application of that
-system; it is up to the author/donor to decide if he or she is willing
-to distribute software through any other system and a licensee cannot
-impose that choice.
-
-This section is intended to make thoroughly clear what is believed to
-be a consequence of the rest of this License.
-
-  8. If the distribution and/or use of the Program is restricted in
-certain countries either by patents or by copyrighted interfaces, the
-original copyright holder who places the Program under this License
-may add an explicit geographical distribution limitation excluding
-those countries, so that distribution is permitted only in or among
-countries not thus excluded.  In such case, this License incorporates
-the limitation as if written in the body of this License.
-
-  9. The Free Software Foundation may publish revised and/or new versions
-of the General Public License from time to time.  Such new versions will
-be similar in spirit to the present version, but may differ in detail to
-address new problems or concerns.
-
-Each version is given a distinguishing version number.  If the Program
-specifies a version number of this License which applies to it and "any
-later version", you have the option of following the terms and conditions
-either of that version or of any later version published by the Free
-Software Foundation.  If the Program does not specify a version number of
-this License, you may choose any version ever published by the Free Software
-Foundation.
-
-  10. If you wish to incorporate parts of the Program into other free
-programs whose distribution conditions are different, write to the author
-to ask for permission.  For software which is copyrighted by the Free
-Software Foundation, write to the Free Software Foundation; we sometimes
-make exceptions for this.  Our decision will be guided by the two goals
-of preserving the free status of all derivatives of our free software and
-of promoting the sharing and reuse of software generally.
-
-			    NO WARRANTY
-
-  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
-FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
-OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
-PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
-OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
-MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
-TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
-PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
-REPAIR OR CORRECTION.
-
-  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
-WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
-REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
-INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
-OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
-TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
-YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
-PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
-POSSIBILITY OF SUCH DAMAGES.
-
-		     END OF TERMS AND CONDITIONS
-
-	    How to Apply These Terms to Your New Programs
-
-  If you develop a new program, and you want it to be of the greatest
-possible use to the public, the best way to achieve this is to make it
-free software which everyone can redistribute and change under these terms.
-
-  To do so, attach the following notices to the program.  It is safest
-to attach them to the start of each source file to most effectively
-convey the exclusion of warranty; and each file should have at least
-the "copyright" line and a pointer to where the full notice is found.
-
-    <one line to give the program's name and a brief idea of what it does.>
-    Copyright (C) <year>  <name of author>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-
-
-Also add information on how to contact you by electronic and paper mail.
-
-If the program is interactive, make it output a short notice like this
-when it starts in an interactive mode:
-
-    Gnomovision version 69, Copyright (C) year  name of author
-    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
-    This is free software, and you are welcome to redistribute it
-    under certain conditions; type `show c' for details.
-
-The hypothetical commands `show w' and `show c' should show the appropriate
-parts of the General Public License.  Of course, the commands you use may
-be called something other than `show w' and `show c'; they could even be
-mouse-clicks or menu items--whatever suits your program.
-
-You should also get your employer (if you work as a programmer) or your
-school, if any, to sign a "copyright disclaimer" for the program, if
-necessary.  Here is a sample; alter the names:
-
-  Yoyodyne, Inc., hereby disclaims all copyright interest in the program
-  `Gnomovision' (which makes passes at compilers) written by James Hacker.
-
-  <signature of Ty Coon>, 1 April 1989
-  Ty Coon, President of Vice
-
-This General Public License does not permit incorporating your program into
-proprietary programs.  If your program is a subroutine library, you may
-consider it more useful to permit linking proprietary applications with the
-library.  If this is what you want to do, use the GNU Library General
-Public License instead of this License.
diff --git a/tools/pounder21/Install b/tools/pounder21/Install
deleted file mode 100755
index 6fb3a8f09..000000000
--- a/tools/pounder21/Install
+++ /dev/null
@@ -1,151 +0,0 @@
-#!/bin/bash
-
-# Download pounder components and build them.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-source libpounder.sh
-
-export USE_CACHE=1
-
-# do we actually _have_ a cache server?
-if [ -z "$POUNDER_CACHE" -o "$POUNDER_CACHE" == "0" ]; then
-	export USE_CACHE=0
-fi
-
-#check utilities needed to run the tests before getting started.
-#If you test uses something else or a build fails add
-#the command to the list manually.
-COMMANDS="make g++ lex gcc python wget sudo diff patch egrep rm echo test which cp mkdir"
-MISSING_TOOLS=""
-echo -en "Looking for tools..."
-for cmd in $COMMANDS
-do
-	echo -en "$cmd "
-	if which $cmd > /dev/null
-	then
-		true;
-	else
-		MISSING_TOOLS="$cmd $MISSING_TOOLS"
-	fi
-done
-
-echo .
-
-if [ -n "$MISSING_TOOLS" ]; then
-	echo "Please install these tools: $MISSING_TOOLS."
-	exit 1
-fi
-
-echo "All tools were found."
-
-# Parse arguments
-while getopts n? o
-do
-	case "$o" in
-		n) echo "Not using tarball cache."; export USE_CACHE=0;;
-	esac
-done
-
-# Set up optdir
-mkdir -p "$POUNDER_OPTDIR"
-if [ ! -d "$POUNDER_OPTDIR" ]; then
-	echo "Could not create $POUNDER_OPTDIR; aborting."
-	exit 1
-fi
-
-UNPACKED=0
-
-while [ "$UNPACKED" -lt 1 ]; do
-	# Unpack default test configuration?
-	SCHEDULERS=`ls $POUNDER_HOME/schedulers | awk -F"-tests.tar.gz" '{print $1}'`
-	echo "WHICH TEST SCHEDULER SETUP DO YOU WANT TO UNPACK?"
-	echo "[Choose from:"
-	echo "$SCHEDULERS"
-	echo "[Or simply press ENTER for the default scheduler]"
-	echo -n "Scheduler selection: "
-	read f
-	if [ -z "$f" ]; then
-		SCHEDPACK="$DEFAULT_SCHEDPACK"
-	else
-		SCHEDPACK="$f"
-	fi
-
-	rm -rf tests/*
-
-	tar -xzvf "$POUNDER_HOME/schedulers/$SCHEDPACK-tests.tar.gz"
-
-	if [ "$?" -ne 0 ]; then
-		echo "Unable to untar $SCHEDPACK-tests.tar.gz; please try again."
-	else
-		echo "Untarred $SCHEDPACK-tests.tar.gz successfully."
-		UNPACKED=1
-	fi
-done
-
-echo -en "Would you like to automate skipping of failed subtests? (subtests that failed to build will automatically be removed from test scheduler) [y/n]? "
-read f
-if [ "$f" == "y" -o "$f" == "Y" ]; then
-	AUTO_SKIP=1
-else
-	AUTO_SKIP=0
-fi
-
-# start builds...
-for i in $BUILDS
-do
-	if [ "$i" = "CVS" ]; then
-		continue
-	fi
-	if [ -x "build_scripts/$i" ]; then
-		FOUND=`find $POUNDER_HOME/tests -name *$i`
-		if [ -n "$FOUND" ]; then
-			"build_scripts/$i" $*
-			BUILD_ERR=$?
-			if [ "$BUILD_ERR" -ne 0 ]; then
-				if [ $AUTO_SKIP -eq 0 ]; then
-					echo -en "$i build failed with Error $BUILD_ERR. If this is a subtest, would you like to skip it [y/n]? "
-					read f
-					if [ "$f" == "y" -o "$f" == "Y" ]; then
-                        			rm `find $POUNDER_HOME/tests -name *$i` > /dev/null 2>&1
-						if [ "$?" -ne 0 ]; then
-							echo "Failed to remove $i from test scheduler. $i is either not a subtest included in $SCHEDPACK-tests.tar.gz or is incorrectly defined in $POUNDER_HOME/tests (See SCHEDULER for naming rules if this is the case)."
-							echo -en "Skip anyway? [y/n] "
-							read f
-							if [ "$?" == "y" -o "$f" == "Y" ]; then
-								exit 0
-							elif [ "$f" == "n" -o "$f" == "N" -o -z "$f" ]; then
-								exit 1
-							fi
-						fi
-                			elif [ "$f" == "n" -o "$f" == "N" -o -z "$f" ]; then
-						echo "Exiting install ..."
-						exit 1
-					fi
-				else
-					rm `find ./tests -name *$i` > /dev/null 2>&1
-				fi
-			fi
-		fi
-	fi
-done
-
-# build our little helper program
-make helpers
-
-echo Pounder is done building. ENJOY!
diff --git a/tools/pounder21/Makefile b/tools/pounder21/Makefile
deleted file mode 100644
index 70f945b8d..000000000
--- a/tools/pounder21/Makefile
+++ /dev/null
@@ -1,72 +0,0 @@
-# Quickie makefile to (sort of) automate various pounder tasks.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-# Quickie makefile to do pounder stuff.
-NAME=ltpounder
-CFLAGS=-O3 -Wall -g
-HELPERS=timed_loop infinite_loop run-helper fancy_timed_loop
-
-install:;
-	./Install
-
-helpers: $(HELPERS)
-
-fancy_timed_loop: fancy_timed_loop.c debug.o
-	$(CC) $(CFLAGS) -o fancy_timed_loop fancy_timed_loop.c debug.o
-
-timed_loop: timed_loop.c debug.o
-	$(CC) $(CFLAGS) -o timed_loop timed_loop.c debug.o
-
-infinite_loop: infinite_loop.c debug.o
-	$(CC) $(CFLAGS) -o infinite_loop infinite_loop.c debug.o
-
-run-helper: run.c debug.o proclist.o
-	$(CC) $(CFLAGS) -o run-helper run.c debug.o proclist.o
-
-srctar:;
-	cd ../../../; make clean; tar -cvzf $(NAME)-`date '+%Y-%m-%d'`.src.tar.gz --exclude '*CVS*' $(NAME)
-
-bintar:;
-	echo "Making binary tarball for" `uname -m` "platform."
-	./Install
-	cd ../../../; tar -czf $(NAME)-`date '+%Y-%m-%d'`.`uname -m`.tar.gz $(NAME) --exclude='*CVS*'
-
-helpers_clean:;
-	rm -rf $(HELPERS) *.o
-
-# Clean out all cruft from a pounder run
-clean: helpers_clean
-	./pounder -u
-	if [ -d opt ]; then cd opt; for i in *; do if [ -d $$i ]; then cd $$i; make clean; cd -; fi; done; fi;
-	cd src; for i in *; do if [ -d $$i ]; then cd $$i; make clean; cd -; fi; done;
-	rm -rf tmp pounder.pid
-
-# Put everything back as it was when this tarball was unpacked.
-mrclean: helpers_clean;
-	./pounder -u
-	rm -rf opt log run-helper infinite_loop timed_loop debug.o tmp proclist.o
-	find src/ -name Makefile | while read f; do cd `dirname $$f`; $(MAKE) clean; cd -; done;
-	rm -rf `find tests/* 2>/dev/null | grep -v CVS`
-	rm -rf pounder.pid
-
-distclean: mrclean;
-
-
-testtar:;
-	tar -cvzf default-tests.tar.gz tests/D* tests/T*
diff --git a/tools/pounder21/README b/tools/pounder21/README
deleted file mode 100644
index a016be864..000000000
--- a/tools/pounder21/README
+++ /dev/null
@@ -1,239 +0,0 @@
-This is pounder30 as of 2011-08-09.  Copyright (C) 2003-2011 IBM.
-(Do not delete top line. It is used for version checking.)
-
-It would be a good idea to read this README file and the SCHEDULER and
-CONFIGURATION files (in the doc/ directory) prior to dabbling with pounder!
-
-Licensing
-=========
-All files in this tarball are licensed under the GPL.  Please see
-the file COPYING for more details.
-
-Contents
-========
-1. Overview
-2. Getting Started
-3. Files and Directories
-4. The Install Script
-5. Configuration
-6. The Pounder Script
-7. Credits
-
-Overview
-========
-Pounder provides a framework for building, running, and logging results
-for user-defined sets of tests.  Almost any test or test suite may be run
-as a subtest from within this framework, including the LTP test suite.
-(For more guidelines on building, scheduling, and running user-defined
-subtests, see doc/SCHEDULER)
-
-Getting Started
-===============
-
-Some sample test "schedules" comprised of various publically available
-tests, including LTP, are provided. The default test schedule illustrates
-how one might use pounder and is also a useful general purpose stress test.
-
-The following steps describe how to build and run the default schedule:
-
-	0. Install your operating system.  gcc and related development packages are
-		required to build pounder.  Missing dependencies will be identified at
-		build time. X development packages are needed for the included video test.
-
-	1. Download and unpack the LTP tarball.  You've already done this.
-
-	2. cd tools/pounder21/.  You've already done this too.
-
-	3. (optional) Set up a NFS server to export "/pounder21" (unless you wish
-		to skip nfs tests).
-
-	4. (optional) Modify any variables in "config" (see doc/CONFIGURATION for details).
-
-	5. Run "make install" to build tests for your machine
-		The Install script will attempt to build all the subtests in the
-		build_scripts folder. It will prompt you for the test scheduler
-		you want to unpack. Go ahead of type "default" or simply press
-		enter. It will then ask if you want to automate skipping of
-		failed subtests. If you enter "y", the script will automatically
-		delete any subtests from the test scheduler that fail to build.
-		If you enter "n", the script will prompt you each time a test
-		fails to build on whether or not to skip the failed test.
-
-	6. Run "./pounder" to start the tests (run "./pounder -h" for usage options).
-
-	7. Press ^C or run "./pounder -k" to stop the tests
-		The default scheduler runs tests for 48 hours, but you can set a new
-		duration in seconds by modifying config (see doc/CONFIGURATION for details)
-		or by using the -d option when starting pounder (./pounder -d <duration in seconds>)
-
-	8. Run "make mrclean" to restore everything to the state before the tarball
-		was unpacked (running this command will of course require you to
-		rebuild with "make install" for the next pounder run)
-
-See doc/SCHEDULER for details on defining the order in which tests are run, and whether they
-are run serially or in parallel.
-
-A few of the sample subtests have prerequisites:
-
-	- ide_cdrom_copy: Requires a CD with some data on it to be put in the drive.
-
-	- nfs, ping_nfs: Make sure you can mount an NFS server. Specify NFS in config
-		or run "./pounder -n ipaddr"
-
-	- xterm_stress: Make sure you can start X sessions. Enable X testing by setting
-		the DO_X_TESTS flag in config or run "./pounder -x"
-
-These tests can be skipped during the build phase if reqs aren't met though.
-
-Files and Directories
-=====================
-Below are brief descriptions of the files and directories found under the pounder/
-directory.
-
-Files:
-
-	CHANGELOG
-		- A log of changes made to pounder
-	COPYING
-		- GNU general public license info
-	Install
-		- The script used to build pounder
-	Makefile
-		- Makefile for pounder
-	debug.c
-		- Debugging routines used for logging pounder results
-	infinite_loop.c, timed_loop.c, fancy_timed_loop.c
-		- Procedures used to run tests repeatedly (see doc/SCHEDULER for more
-		information)
-	config
-		- Environment variables used for customizing pounder run are defined
-		here (see doc/CONFIGURATION for details)
-	libpounder.sh
-		- More environment variables defined here. Unlike the ones in config,
-		these are not meant to be modified by the user. (see doc/CONFIGURATION
-		for details)
-	nfs_logging
-		- Script that sets up user-defined NFS server for logging pounder output.
-		This script is executed when pounder is run with $NFS_LOGGING enabled in
-		config (see doc/CONFIGURATION) or when "pounder -r" is used. Normally when
-		running pounder, test output will be directly logged to $POUNDER_LOGLOCAL,
-		but with NFS logging enabled, output will instead be logged to user-specified
-		remote directory of an NFS server, $NFS_LOGSERVER:$NFS_LOGDIR.
-		See doc/CONFIGURATION for more information on these variables.
-	pounder
-		- Script used to run pounder. (see "The Pounder Script" section below
-		for details)
-	proclist.c
-		- Manages list of processes during pounder run.
-	README
-		- This file, which gives an overview of pounder's structure and how to
-		build and start pounder.
-	run.c
-		- Program to run the tests in the test scheduler.
-
-Directories:
-
-	build_scripts/
-		- Scripts to build your subtests go here. (see doc/SCHEDULER for details)
-	doc/
-		- Contains the SCHEDULER file, which describes how to create, build,
-		schedule, and run your own tests with pounder.
-		- Contains the CONFIGURATION file, which describes pounder's environment
-		variables.
-	schedulers/
-		- Test scheduler tarballs are in here. (see doc/SCHEDULER for details)
-	src/
-		- Sources packaged with pounder are in here.
-	test_repo/
-		- This directory is a copy of the default test scheduler. It provides an
-		example of what an test scheduler should look like after unpacking.
-	test_scripts/
-		- Scripts to run your subtests go here. (see doc/SCHEDULER for details)
-	tests/
-		- Symlinks to run the tests in a particular order. (see doc/SCHEDULER for
-		details)
-
-After running "make install," you will see three additional directories:
-
-	opt/
-		- Third party packages (LTP, kernel, etc) go here.
-	tmp/
-		- Temporary directory to hold files that a test needs.
-	log/
-		- Logs of output from pounder runs go here.
-
-Note that for the provided tests, third party test packages (bonnie, kernel, etc) aren't
-packaged with pounder. The build scripts should download them to opt/ (stored in
-$POUNDER_OPTDIR) and build them as necessary. The use of a cache might come in handy here
-(see doc/CONFIGURATION for details regarding the $POUNDER_CACHE variable).
-
-The Install Script
-==================
-The Install script has no options.  Run it to build whatever tests have been
-imported into the pounder package.
-
-Configuration
-=============
-See doc/CONFIGURATION documentation file for details.
-
-The Pounder Script
-==================
-The pounder script has the following syntax:
-
-Usage: ./pounder [-g logdir] [-x] [-d duration] [-n ipaddr] [-m max_failures] [-f] [-h|-u|-r|-k|-l|-e subtests|-i subtests|-c scheduler] [-s]
-
--h              Brings up this menu
--c scheduler    Creates a new test scheduler called scheduler-tests.tar.gz in the pounder/schedulers folder.
-                All subtests to be packaged with this scheduler must first be placed in the pounder/tests folder.
--x              Enable X stress tests.
--d duration     Run pounder for duration seconds.
--n ipaddr       Use ipaddr for NFS tests.
--f              Remove pounder pid file before running.
--u              Unmount NFS log storage.
--r              Remount NFS log storage.
--g logdir       Use logdir as the log directory. (You probably want -s too.)
--s              Store logs locally.
--l              List (both included and excluded) subtests that came with the test scheduler
--e subtests     Exclude subtests from next pounder run
--i subtests     Include previously excluded subtests in the next pounder run
--k              Kill pounder.
-
-run "./pounder" to run all subtests
-run "./pounder subtest" to run just one particular subtest
-        (example: ./pounder tests/T90ramp/D02build_kernel)
-
-Credits
-=======
-o Inspired by Sammy Benjamin (sammy@us.ibm.com).  None of his code remains
-  in this version of pounder today.
-o Modifications and additions by members of the LTC xSeries Kernel Team:
-    Darrick Wong (djwong@us.ibm.com)
-    Chris McDermott (lcm@us.ibm.com)
-    Jack Vogel (jfv@us.ibm.com)
-    Keith Mannthey (kmannth@us.ibm.com)
-    James Cleverdon (jamesclv@us.ibm.com)
-    Pat Gaughen (gone@us.ibm.com)
-    John Stultz (jstultz@us.ibm.com)
-    Roger Mach (bigmach@us.ibm.com)
-    Sarunya Jimenez
-    Alexis Bruemmer (alexisb@us.ibm.com)
-    James Takahashi (jmtt@us.ibm.com)
-    Pradeep Kumar (pradeepkumars@in.ibm.com)
-    Bhaskar Rangaswamy (bharanga@in.ibm.com)
-    Manikandan Chidambaram (cmanikandan@in.ibm.com)
-    Lucy Liang (lgliang@us.ibm.com)
-o Other contributers:
-
-Also utilizes:
-o memxfer5b, from IBM DeveloperWorks
-o Linux kernel's build system.
-    http://www.kernel.org
-o bonnie++
-o The Linux Test Project
-o Doug Ledford's (of RH) memtest script
-o lame, for MMX/SSE/SSE2/3dnow testing
-o nasm, to build lame
-o schedutils, to test CPU affinity (with lame)
-
-(note that the above packages are not distributed with pounder
- and are simply installed by the installer script)
diff --git a/tools/pounder21/build_scripts/bonnie++ b/tools/pounder21/build_scripts/bonnie++
deleted file mode 100755
index 907a2c69e..000000000
--- a/tools/pounder21/build_scripts/bonnie++
+++ /dev/null
@@ -1,76 +0,0 @@
-#!/bin/bash
-
-# Builds bonnie++
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-PKGNAME=bonnie++-1.03e
-TARNAME="$PKGNAME.tgz"
-PROGNAME=bonnie++
-
-# How much RAM do we have?
-RAM=`cat /proc/meminfo | grep MemTotal | awk -F " " '{print $2}'`
-SPACE_REQUIRED=`expr $RAM \* 4`
-
-# Now figure out where we have mounted filesystems
-MOUNTS=`egrep "(ext|reiser)" /proc/mounts | awk -F " " '{print $2}'`
-
-RET=$(
-	echo $MOUNTS | sed -e 's/ /\n/g' | while read f; do
-
-        	# Do we have enough space? (assume 4x RAM is enough)
-        	FREE_SPACE=`df -k -P "$f" | tail -n 1 | awk -F " " '{print $4}'`
-
-        	if [ "$FREE_SPACE" -lt "$SPACE_REQUIRED" ]; then
-			break
-        	fi
-	done
-)
-
-if [ ! -z $RET ]; then
-        echo "[bonnie++] Insufficient space. Free space: $FREE_SPACE kB. Space required: $SPACE_REQUIRED kB. Not building bonnie."
-	exit 1
-fi
-
-# Is it already installed?
-PROG=`which $PROGNAME`
-if [ ! -z "$PROG" ]; then
-	exit 0
-fi
-
-# Retrieve binary, if necessary
-cd "$POUNDER_OPTDIR"
-if [ ! -f "$TARNAME" ]; then
-	if [ $USE_CACHE -eq 1 ]; then
-		wget "${POUNDER_CACHE}${TARNAME}"
-	fi
-	if [ ! -f "$TARNAME" ]; then
-		wget "http://www.coker.com.au/bonnie++/$TARNAME"
-	fi
-fi
-
-# Unpack if req'd
-if [ ! -d "$PKGNAME" ]; then
-	tar -xzf "$TARNAME"
-fi
-
-# Build
-cd "$PKGNAME"
-./configure
-make $*
diff --git a/tools/pounder21/build_scripts/build_kernel b/tools/pounder21/build_scripts/build_kernel
deleted file mode 100755
index 4a753b5fd..000000000
--- a/tools/pounder21/build_scripts/build_kernel
+++ /dev/null
@@ -1,38 +0,0 @@
-#!/bin/bash
-
-# Grabs kernel tarball
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-TARNAME=linux-2.6.39.tar.bz2
-# WARNING: If you update the kernel version that we use, be sure to
-# update $POUNDER_SRCDIR/memtest.patch, $POUNDER_HOME/test_scripts/memtest,
-# $POUNDER_HOME/test_scripts/build_kernel, and
-# $POUNDER_HOME/build_scripts/build_kernel.
-
-# Retrieve binary, if necessary
-cd "$POUNDER_OPTDIR"
-if [ ! -f "$TARNAME" ]; then
-	if [ $USE_CACHE -eq 1 ]; then
-		wget "${POUNDER_CACHE}${TARNAME}"
-	fi
-	if [ ! -f "$TARNAME" ]; then
-		wget "http://www.kernel.org/pub/linux/kernel/v2.6/$TARNAME"
-	fi
-fi
diff --git a/tools/pounder21/build_scripts/cpufreq b/tools/pounder21/build_scripts/cpufreq
deleted file mode 100755
index 33735755f..000000000
--- a/tools/pounder21/build_scripts/cpufreq
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/bash
-
-# Build CPU frequency switching test program
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-# Do any CPU support cpufreq?
-CPUFREQ_ENABLED_CPUS=`/bin/ls -lad /sys/devices/system/cpu/cpu*/cpufreq 2> /dev/null | wc -l`
-if [ "$CPUFREQ_ENABLED_CPUS" -lt 1 ]; then
-        echo "[cpufreq] None of your CPUs support cpufreq. Not building cpufreq."
-        exit 255
-fi
-
-cd "$POUNDER_SRCDIR/cpufreq/"
-
-make $*
-exit $?
diff --git a/tools/pounder21/build_scripts/ide_cdrom_copy b/tools/pounder21/build_scripts/ide_cdrom_copy
deleted file mode 100755
index 07e6c712c..000000000
--- a/tools/pounder21/build_scripts/ide_cdrom_copy
+++ /dev/null
@@ -1,56 +0,0 @@
-#!/bin/bash
-
-# Looks for CD/DVD drives and then determine
-# if there is at least ONE disc in the system's CDROM drives.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-. "$POUNDER_SRCDIR/libidecd.sh"
-
-DRIVES_FOUND=`find_discs_with_media`
-if [ "$DRIVES_FOUND" == "NONE 0" ]; then
-        echo "[ide_cdrom_copy] No CD/DVD drives found. CD test will not build."
-        exit 1;
-fi
-
-DEFAULT_MOUNT="$POUNDER_TMPDIR/cdmount"
-
-# Ensure that our default mountpoint and destination dirs exist.
-mkdir -p "$DEFAULT_MOUNT"
-
-# How many discs can we find?
-DISCS_FOUND=`find_discs_with_media | wc -l`
-if [ $DISCS_FOUND -lt 1 ]; then
-        echo -en "Examined "
-        find_disc_devices | while read f; do
-                echo -en "$f "
-                eject "$f"
-        done
-        echo " and found no discs to test."
-        echo "Please put a disc into the CD/DVD drive(s) and press ENTER."
-        read garbage
-
-        DISCS_FOUND=`find_discs_with_media | wc -l`
-        if [ $DISCS_FOUND -lt 1 ]; then
-                echo "Still can't find any discs.  CD test will probably not run."
-                exit 0
-        fi
-fi
-
-exit 0
-
diff --git a/tools/pounder21/build_scripts/ipmitool b/tools/pounder21/build_scripts/ipmitool
deleted file mode 100755
index 5de7de6bd..000000000
--- a/tools/pounder21/build_scripts/ipmitool
+++ /dev/null
@@ -1,73 +0,0 @@
-#!/bin/bash
-
-# Builds ipmitool
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-source "$POUNDER_HOME/libpounder.sh"
-
-#TODO: Move to config file variables
-Req_Maj=1
-Req_Min=8
-Req_Pat=7
-
-TESTCURRENTIPMI=1 #TODO: 0
-
-PKGNAME=ipmitool-1.8.9
-#end of stuff to move
-TARNAME="$PKGNAME.tar.gz"
-PROGNAME=ipmitool
-if [ $TESTCURRENTIPMI -ne 0 ]; then
-
-	# Is it already installed?
-	PROG=`which $PROGNAME`
-	if [ ! -z "$PROG" ]; then
-		Maj_ver=`ipmitool -V | cut -b 18- | awk -F "." '{print $1}'`
-		Min_ver=`ipmitool -V | cut -b 18- | awk -F "." '{print $2}'`
-		Pat_ver=`ipmitool -V | cut -b 18- | awk -F "." '{print $3}'`
-		if [ $Maj_ver -gt $Req_Maj ]; then
-			exit 0;
-		elif [[ $Maj_ver -eq $Req_Maj && $Min_ver -gt $Req_Min ]]; then
-			exit 0;
-		elif [[ $Maj_ver -eq $Req_Maj && $Min_ver -eq $Req_Min && $Pat_ver -ge $Req_Pat ]]; then
-			exit 0;
-		fi
-	fi
-
-	# Retrieve binary, if necessary
-	cd "$POUNDER_OPTDIR"
-	if [ ! -f "$TARNAME" ]; then
-		if [ $USE_CACHE -eq 1 ]; then
-			wget "${POUNDER_CACHE}${TARNAME}"
-		fi
-		if [ ! -f "$TARNAME" ]; then
-			get_from_sourceforge $PROGNAME $TARNAME
-		fi
-		#TODO: what if no target found?
-	fi
-
-	# Unpack if req'd
-	if [ ! -d "$PKGNAME" ]; then
-		tar -xzf "$TARNAME"
-	fi
-
-	# Build
-	cd "$PKGNAME"
-	./configure
-	make $*
-fi
diff --git a/tools/pounder21/build_scripts/lame b/tools/pounder21/build_scripts/lame
deleted file mode 100755
index 240d6aee9..000000000
--- a/tools/pounder21/build_scripts/lame
+++ /dev/null
@@ -1,127 +0,0 @@
-#!/bin/bash
-
-# Builds lame for MMX/SSE testing
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-source "$POUNDER_HOME/libpounder.sh"
-
-# Is it already installed?
-PROG=`which lame`
-if [ ! -z "$PROG" ]; then
-	exit 0
-fi
-
-# If we can't find nasm...
-NASM=`which nasm`
-if [ -z "$NASM" ]; then
-	# Build it so we can test MMX/SSE.
-	NASM_PKG=nasm-0.98.38
-	NASM_TAR="$NASM_PKG.tar.gz"
-
-	# Retrieve tarball
-	cd "$POUNDER_OPTDIR"
-	if [ ! -f "$NASM_TAR" ]; then
-        	if [ $USE_CACHE -eq 1 ]; then
-                	wget "${POUNDER_CACHE}${NASM_TAR}"
-        	fi
-        	if [ ! -f "$NASM_TAR" ]; then
-                	get_from_sourceforge nasm $NASM_TAR
-        	fi
-	fi
-
-	# Unpack if necessary
-	if [ ! -d "NASM_PKG" ]; then
-        	tar -xzf "$NASM_TAR"
-	fi
-
-	# Build
-	cd "$NASM_PKG"
-	./configure
-	make $*
-
-	export PATH=`/bin/ls -d $POUNDER_OPTDIR/nasm*/`:$PATH
-
-fi
-
-# Retrieve binary for lame, if necessary
-PKGNAME=lame-3.96.1
-TARNAME="$PKGNAME.tar.gz"
-PROGNAME=lame
-
-cd "$POUNDER_OPTDIR"
-if [ ! -f "$TARNAME" ]; then
-	if [ $USE_CACHE -eq 1 ]; then
-		wget "${POUNDER_CACHE}${TARNAME}"
-	fi
-	if [ ! -f "$TARNAME" ]; then
-		get_from_sourceforge $PROGNAME $TARNAME
-	fi
-fi
-
-# Unpack if necessary
-if [ ! -d "PKGNAME" ]; then
-	tar -xzf "$TARNAME"
-fi
-
-# Build with MMX/SSE/3dnow/whatever support
-cd "$PKGNAME"
-./configure --enable-nasm
-make $*
-
-# Now build schedutils for CPU affinity assignments
-_PKGNAME=schedutils-1.4.0
-S_TARNAME="$S_PKGNAME.tar.gz"
-S_PROGNAME=taskset
-
-# Is it already installed?
-S_PROG=`which $S_PROGNAME`
-if [ ! -z "$S_PROG" ]; then
-        exit 0
-fi
-
-# Does this OS support taskset?
-grep sched_setaffinity /usr/include/sched.h > /dev/null 2>&1
-if [ $? -ne 0 ]; then
-        # Can't find the sched_setaffinity syscall; abort.
-        # Probably we want to remove the schedutils dir in case
-        # this install was leftover from another distro.
-        cd "$POUNDER_OPTDIR"
-        rm -rf "$S_PKGNAME"
-        exit 0
-fi
-
-# Retrieve tarball, if necessary
-cd "$POUNDER_OPTDIR"
-if [ ! -f "$S_TARNAME" ]; then
-        if [ $USE_CACHE -eq 1 ]; then
-                wget "${POUNDER_CACHE}${S_TARNAME}"
-        fi
-        if [ ! -f "$S_TARNAME" ]; then
-                wget "http://tech9.net/rml/schedutils/packages/$VERSION/$S_TARNAME"
-        fi
-fi
-
-# Unpack if necessary
-if [ ! -d "S_PKGNAME" ]; then
-        tar -xzf "$S_TARNAME"
-fi
-
-# Build
-cd "$S_PKGNAME"
-make $*
diff --git a/tools/pounder21/build_scripts/ltp b/tools/pounder21/build_scripts/ltp
deleted file mode 100755
index 314719c15..000000000
--- a/tools/pounder21/build_scripts/ltp
+++ /dev/null
@@ -1,38 +0,0 @@
-#!/bin/bash
-
-# Builds ltp
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-source "$POUNDER_HOME/libpounder.sh"
-
-# Go up two levels to the top ltp dir.
-cd "$POUNDER_HOME/../../"
-
-# Build
-./configure
-make -j$NR_CPUS
-MK_RET=$?
-
-if [ $MK_RET -eq 0 ]; then
-	make DESTDIR=$POUNDER_TMPDIR install
-	MK_RET=$?
-fi
-
-exit $MK_RET
diff --git a/tools/pounder21/build_scripts/mem_alloc b/tools/pounder21/build_scripts/mem_alloc
deleted file mode 100755
index eecd71897..000000000
--- a/tools/pounder21/build_scripts/mem_alloc
+++ /dev/null
@@ -1,25 +0,0 @@
-#!/bin/bash
-
-# Build OOM tester
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-cd "$POUNDER_SRCDIR/mem_alloc_test/"
-
-make $*
diff --git a/tools/pounder21/build_scripts/memtest b/tools/pounder21/build_scripts/memtest
deleted file mode 100755
index 480d5c317..000000000
--- a/tools/pounder21/build_scripts/memtest
+++ /dev/null
@@ -1,71 +0,0 @@
-#!/bin/bash -f
-
-# Build lowmem exhaustion/corruption tester
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-# How much RAM do we have?
-RAM=`cat /proc/meminfo | grep MemTotal | awk -F " " '{print $2}'`
-SPACE_REQUIRED=`expr $RAM \* 2`
-
-# Do we have enough space?
-MEMTESTDIR="$POUNDER_TMPDIR/memtest/"
-rm -rf "$MEMTESTDIR"
-mkdir -p "$MEMTESTDIR"
-FREE_SPACE=`df -k -P "$MEMTESTDIR" | tail -n 1 | awk -F " " '{print $4}'`
-if [ "$FREE_SPACE" -lt "$SPACE_REQUIRED" ]; then
-        echo "[memtest] Insufficient space. Free space: $FREE_SPACE kB. Space required: $SPACE_REQUIRED kB. Not building memtest."
-        exit -1
-fi
-
-cd "$POUNDER_OPTDIR"
-
-# Download a script and parse out the junk we don't want.
-if [ ! -f "memtest.sh" ]; then
-	if [ $USE_CACHE -eq 1 ]; then
-		wget "${POUNDER_CACHE}memtest.shtml"
-	fi
-	if [ ! -f "memtest.shtml" ]; then
-		wget "http://people.redhat.com/dledford/memtest.shtml"
-	fi
-	IN_BLOCK=0
-
-	if [ ! -f "memtest.shtml" ]; then
-		echo "[memtest] Could not download memtest.shtml.  Aborting!"
-		exit -1
-	fi
-
-	(cat memtest.shtml | while read f; do
-		echo "$f" | grep -q BLOCKQUOTE
-		if [ "$?" -eq 0 ]; then
-			if [ "$IN_BLOCK" -eq 0 ]; then
-				IN_BLOCK=1
-			else
-				IN_BLOCK=0
-			fi
-		else
-			if [ "$IN_BLOCK" -eq 1 ]; then
-				echo "$f"
-			fi
-		fi
-	done) | sed -e 's/\/bin\/bash2/\/bin\/bash/g' > memtest.sh
-	chmod a+x memtest.sh
-	patch -p0 < "$POUNDER_SRCDIR/memtest.patch"
-	rm -rf memtest.shtml
-fi
diff --git a/tools/pounder21/build_scripts/memxfer5b b/tools/pounder21/build_scripts/memxfer5b
deleted file mode 100755
index c28b2dab3..000000000
--- a/tools/pounder21/build_scripts/memxfer5b
+++ /dev/null
@@ -1,25 +0,0 @@
-#!/bin/bash
-
-# Build memory streaming benchmark program
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-cd "$POUNDER_SRCDIR/memxfer5b/"
-
-make $*
diff --git a/tools/pounder21/build_scripts/ramsnake b/tools/pounder21/build_scripts/ramsnake
deleted file mode 100755
index ef4041e41..000000000
--- a/tools/pounder21/build_scripts/ramsnake
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/bin/bash
-
-# Build shared memory exerciser
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-cd "$POUNDER_SRCDIR/ramsnake/"
-
-make $*
-exit $?
diff --git a/tools/pounder21/build_scripts/random_syscall b/tools/pounder21/build_scripts/random_syscall
deleted file mode 100755
index a28f47397..000000000
--- a/tools/pounder21/build_scripts/random_syscall
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/bin/bash
-
-# Build random system call generator
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-cd "$POUNDER_SRCDIR/randasyscall/"
-
-make $*
-exit $?
diff --git a/tools/pounder21/build_scripts/time_consistency b/tools/pounder21/build_scripts/time_consistency
deleted file mode 100755
index dede6e7e1..000000000
--- a/tools/pounder21/build_scripts/time_consistency
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/bin/bash
-
-# Build time tests
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-cd "$POUNDER_SRCDIR/time_tests/"
-
-make $*
diff --git a/tools/pounder21/build_scripts/time_drift b/tools/pounder21/build_scripts/time_drift
deleted file mode 100755
index ec856b718..000000000
--- a/tools/pounder21/build_scripts/time_drift
+++ /dev/null
@@ -1,25 +0,0 @@
-#!/bin/bash
-
-# Build time tests
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-cd "$POUNDER_SRCDIR/time_tests/"
-
-make $*
-
diff --git a/tools/pounder21/build_scripts/xterm_stress b/tools/pounder21/build_scripts/xterm_stress
deleted file mode 100755
index 77e091728..000000000
--- a/tools/pounder21/build_scripts/xterm_stress
+++ /dev/null
@@ -1,39 +0,0 @@
-#!/bin/bash
-
-# Build the program that wiggles X windows.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-cd "$POUNDER_SRCDIR/xbonkers/"
-
-make $*
-RESULT=$?
-
-if [ $RESULT -ne 0 ]; then
-        echo
-        echo "[xterm_stress] build failed; you probably need X11 devel packages."
-        exit 1
-fi
-
-# Build a program to generate random coordinates for X11
-# programs' -geometry flag.
-
-cd "$POUNDER_SRCDIR/randacoords/"
-
-make $*
-
diff --git a/tools/pounder21/config b/tools/pounder21/config
deleted file mode 100644
index 69c15dc9d..000000000
--- a/tools/pounder21/config
+++ /dev/null
@@ -1,42 +0,0 @@
-#Set the following variables as needed
-
-export DURATION=0			#Time in seconds for pounder to run. Setting this variable
-					#to 0 will not put an upper bound on pounder run time.
-
-export MAX_FAILURES=5			#Maximum number of test failures allowed for each subtest
-					#before aborting. Setting this variable to 0 will not put
-					#an upper bound on any subtest failures.
-
-export NFS_LOGGING=0			#1 to enable NFS logging of pounder output, pounder will
-					#log output to remote directory on NFS server  specified
-					#by $NFS_LOGDIR and  $NFS_LOGSERVER (see below), which
-					#will be mounted on $POUNDER_LOGLOCAL (see libpounder.sh).
-					#0 to disable this feature, all output for pounder runs
-					#will be stored locally directly in $POUNDER_LOGLOCAL instead.
-
-export NFS_LOGSERVER=0			#IP address of the NFS server to use for logging pounder results.
-					#NFS_LOGGING should be enabled to use this feature.
-
-export NFS_LOGDIR=/path/to/log		#path to the log directory on $NFS_LOGSERVER; If $NFS_LOGGING
-					#is enabled, pounder will attempt to mount $NFS_LOGSERVER:$NFS_LOGDIR/
-					#on $POUNDER_LOGLOCAL (see libpounder.sh).
-
-export POUNDER_CACHE=0  		#address of the cache to use for fetching outside packages,
-                        		#The cache is a user-created web-accessible directory
-                        		#containing cached tarballs/scripts/etc. used for
-                        		#the various tests you intend to build. This is optional
-                        		#but useful for saving download time.
-
-#These variables below are used by specific subtests contained in the provided default test scheduler,
-#but they can be incorporated into user-defined subtests as well.
-
-export DO_X_TESTS=0			#0 disables X system testing, 1 enables X system testing.
-					#Used by the xterm_stress subtest.
-
-export NFS_SERVER=0			#IP address of the NFS server to use for nfs and ping_nfs
-					#subtests. Setting this variable to 0 disables nfs testing.
-
-export NTP_SERVER=pool.ntp.org		#Or use another NTP server of your choice.
-					#Used by the time_drift subtest.
-
-#Feel free to add more variables as you see fit.
diff --git a/tools/pounder21/debug.c b/tools/pounder21/debug.c
deleted file mode 100644
index 4de709516..000000000
--- a/tools/pounder21/debug.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/* Debugging routines for the control program. */
-
-/*
- * Copyright (C) 2003-2006 IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <unistd.h>
-#include <stdlib.h>
-#include <time.h>
-#include <stdarg.h>
-#include <sys/types.h>
-#include <sys/time.h>
-
-#include "debug.h"
-
-#define BUF_LEN 256
-
-int pounder_fprintf(FILE * stream, const char *format, ...)
-{
-	struct timeval tv;
-	struct tm *time;
-	char buf[BUF_LEN];
-	int ret;
-	va_list args;
-	FILE *logfile;
-
-	snprintf(buf, BUF_LEN, "%s/POUNDERLOG", getenv("POUNDER_LOGDIR"));
-	logfile = fopen(buf, "a");
-	if (logfile == NULL) {
-		perror(buf);
-	}
-
-	gettimeofday(&tv, NULL);
-	time = localtime(&tv.tv_sec);
-	strftime(buf, BUF_LEN, "[%Y-%m-%d %H:%M:%S]", time);
-
-	fprintf(stream, "%s (%d) ", buf, getpid());
-
-	va_start(args, format);
-	ret = vfprintf(stream, format, args);
-	va_end(args);
-
-	if (logfile != NULL) {
-		fprintf(logfile, "%s (%d) ", buf, getpid());
-		va_start(args, format);
-		vfprintf(logfile, format, args);
-		va_end(args);
-		fclose(logfile);
-	}
-
-	fflush(stream);
-
-	return ret;
-}
-
-const char *fail_msg = "\e[33;1mFAIL\e[0m";
-const char *pass_msg = "\e[32;1mPASS\e[0m";
-const char *abort_msg = "\e[31;1mABORT\e[0m";
-const char *start_msg = "\e[36;1mSTART\e[0m";
diff --git a/tools/pounder21/debug.h b/tools/pounder21/debug.h
deleted file mode 100644
index b3678d306..000000000
--- a/tools/pounder21/debug.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* Function prototypes for debugging functions. */
-
-/*
- * Copyright (C) 2003-2006 IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#ifndef DEBUG_H_
-#define DEBUG_H_
-
-#include <stdio.h>
-
-int pounder_fprintf(FILE *stream, const char *format, ...);
-
-extern const char *fail_msg, *pass_msg, *abort_msg, *start_msg;
-
-#endif
diff --git a/tools/pounder21/doc/CONFIGURATION b/tools/pounder21/doc/CONFIGURATION
deleted file mode 100644
index 1878b5027..000000000
--- a/tools/pounder21/doc/CONFIGURATION
+++ /dev/null
@@ -1,107 +0,0 @@
-This document describes the environment variables found in the pounder30 package
-as of 2011-8-09.
-
-Author:
-Lucy Liang <lgliang@us.ibm.com>
-
-Copyright (C) 2011 IBM.
-
-Contents
-========
-1. The libpounder.sh File
-2. The config File
-
-The libpounder.sh File
-======================
-The "libpounder.sh" file defines most of the environment variables used in the test
-suite and referenced throughout the documentation. These variables are not
-intended to be modified by the user, although they can be if customization is desired.
-Below is a brief description of these variables (see libpounder.sh for details):
-
-	DATE			- the current date, used for logging
-	DEFAULT_SCHEDPACK	- name of the default test scheduler, "default"
-	TESTS			- list of scripts from the test_scripts/ directory
-	BUILDS			- list of scripts from the build_scripts/ directory
-	POUNDER_HOME		- the pounder/ directory
-	POUNDER_PIDFILE		- pid file created when running pounder
-	POUNDER_LOGLOCAL	- the log/ directory where output of ALL pounder runs
-				get logged
-	POUNDER_LOGDIR		- the log/$DATE directory where output of only the
-				current pounder run get logged
-	POUNDER_TMPDIR		- the tmp/ directory used for storing temporary files
-				used for test runs
-	POUNDER_OPTDIR		- the opt/ directory used for storing third party packages
-				used by subtests, which can be fetched from web or from
-				a user-created cache (see $POUNDER_CACHE below)
-	POUNDER_SRCDIR		- the src/ directory containing source files packaged with
-				pounder
-	POUNDER_VERSION		- the pounder version
-	NR_CPUS			- the number of cpus on the system
-
-The config File
-===============
-The "config" file defines a few environment variables that ARE intended to be modified
-by the user for customizing pounder runs. The variables are described below:
-
-	DURATION		- Time in seconds for pounder to run. Setting this variable
-				to 0 will not put an upper bound on pounder run time.
-
-	MAX_FAILURES		- Maximum number of test failures allowed for each subtest
-				using infinite_loop or timed_loop (see the "Running Tests Repeatedly"
-				section in SCHEDULER for more info on these two procedures) before aborting.
-				Setting this variable to 0 will not put an upper bound on any
-				subtest failures.
-
-
-	NFS_LOGGING             - Enables/disables NFS logging. Setting this variable to
-				1 will enable NFS logging of pounder output; pounder will
-                             	log output to remote directory on NFS server specified
-                                by $NFS_LOGDIR and  $NFS_LOGSERVER (see below), which
-                                will be mounted on $POUNDER_LOGLOCAL (see libpounder.sh).
-                                Setting this variable to 0 will disable this feature; all
-				output for pounder runs will be stored locally directly in
-				$POUNDER_LOGLOCAL instead.
-
-	NFS_LOGSERVER           - IP address of the NFS server to use for logging pounder results.
-				NFS_LOGGING should be enabled to use this feature.
-
-	NFS_LOGDIR		- Path to the log directory on $NFS_LOGSERVER; If $NFS_LOGGING
-				is enabled, pounder will attempt to mount $NFS_LOGSERVER:$NFS_LOGDIR/
-				on $POUNDER_LOGLOCAL (see libpounder.sh).
-
-	POUNDER_CACHE  		- Address of the cache to use for fetching outside packages,
-                        	The cache is a user-created web-accessible directory
-                        	containing cached tarballs/scripts/etc. used for
-                        	the various tests you intend to build. This is optional
-                        	but useful for saving download time and keeping everything in one place.
-
-				For instance, the build_kernel subtest requires downloading a
-				linux kernel tarball during build time (see build_scripts/build_kernel).
-				Instead of calling "wget http://www.kernel.org/pub/linux/kernel/v2.6/$TARNAME"
-				to retrieve the tarball, we can pre-download and store it in a user-created online
-				directory, then call "wget ${POUNDER_CACHE}${TARNAME}," where POUNDER_CACHE
-				is the address of the directory. Other provided subtests: bonnie++, lame, ipmitool,
-				and memtest also make use of this cache.
-
-				Examples of some things you may want to include in your cache for building
-				the provided tests:
-					bonnie++-1.03e.tgz	(for the bonnie++ subtest)
-					linux-2.6.39.tar.gz	(for the build_kernel subtest)
-					ipmitool-1.8.9.tar.gz	(for the ipmitool subtest)
-					...
-
-				These can be found in $POUNDER_OPTDIR after you run "make install" on the
-				default package.
-
-	[These variables below are used by specific subtests contained in the provided default
-	test scheduler, but they can be incorporated into other user-defined subtests as well.]
-
-	DO_X_TESTS		- 0 disables X system testing, 1 enables X system testing.
-				Used by the xterm_stress subtest.
-
-
-	NFS_SERVER=0		- IP address of the NFS server to use for nfs and ping_nfs
-				subtests. Setting this variable to 0 disables nfs testing.
-
-	NTP_SERVER		The NTP server to use. By default, it's set to pool.ntp.org.
-				Used by the time_drift subtest.
diff --git a/tools/pounder21/doc/SCHEDULER b/tools/pounder21/doc/SCHEDULER
deleted file mode 100644
index 979df5151..000000000
--- a/tools/pounder21/doc/SCHEDULER
+++ /dev/null
@@ -1,352 +0,0 @@
-This document describes the operation of the test scheduling framework in
-the pounder30 package.  This document reflects pounder30 as of 2011-8-09.
-
-Authors:
-Darrick Wong <djwong@us.ibm.com>
-Lucy Liang <lgliang@us.ibm.com>
-
-Copyright (C) 2011 IBM.
-
-Contents
-========
-1. Overview
-2. Test Files
-3. Build Scripts
-4. Test Scripts
-5. Scheduling Tests
-6. Running Tests Repeatedly
-7. The Provided Test Schedulers
-8. Creating Your Own Test Scheduler
-9. Including and Excluding Tests
-
-Overview
-========
-The scheduler in the original pounder release was too simplistic--it would kick
-off every test at once, simultaneously.  There was no attempt to ramp up the
-machine's stress levels test by test, or to run only certain combinations, or
-even run the tests one by one before beginning the real load testing.
-
-In addition, the test scripts had a very simple pass/fail mechanism--failure
-was defined by a kernel panic/oops/bug, and passing was defined by the lack of
-that condition.  There was no attempt to find soft failures--situations where
-a test program would fail, but without bringing the machine down.  The test
-suite would not alert the user that these failures had occurred.
-
-Consequently, Darrick Wong rewrote the test scheduling framework to achieve
-several goals--first, to separate the test automation code from the tests
-themselves, to allow for more intelligent scheduling of tests, to give better
-summary reports of what passed (and what didn't), and finally to improve the
-load testing that this suite could do.
-
-Test Files
-==========
-Each test should only need to provide three files:
-
-1) build_scripts/<testname>
-	- The build_scripts/ directory contains scripts that take care of checking for
-	system requirements, downloading the relevant packages and binaries, and building
-	any code necessary to run the subtests. See the "Build Scripts" section below for
-	more information.
-
-2) test_scripts/<testname>
-	- The test_script/ directory contains scripts that take care of running the actual tests.
-	See the "Test Scripts" section below for more information.
-
-3) tests/.../[T|D]XX<testname>
-	- The tests/ directory represents our unpackaged "test scheduler" (if your tests/
-	directory is empty, that means you haven't unpacked any test schedulers yet and will
-	need run "make install" to unpack a scheduler - see "The Provided Test Schedulers"
-	section for more information. The test_repo/ directory also provides an example of what
-	an unpacked test scheduler should look like). The files in the tests/ directory are
-	usually symlinks that point to files in test_scripts/. The order in which the subtests are
-	run upon starting pounder depends on how the files in tests/ are named and organized.
-	See the "Scheduling Tests" section below for more information.
-
-Note: <testname> should be the same in the build_scripts/, test_scripts/, and tests/ folders.
-(Example: build_scripts/subtest1, test_scripts/subtest1, and tests/D99subtest1 would be valid.
-build_scripts/subtest1, test_scripts/subtest1_different, and tests/D99subtest1 would not.)
-See "Scheduling Tests" below for a detailed description of naming rules for files in the tests/
-directory.
-
-Build Scripts
-=============
-As the name implies, a script in build_scripts/ is in charge of downloading
-and building whatever bits of code are necessary to make the test run.
-
-Temporary files needed to run a test should go in $POUNDER_TMPDIR. Third party source,
-packages, binaries should go in $POUNDER_OPTDIR. Third party packages can be fetched
-from the web or from a user-created cache, a web-accessible directory containing
-cached tarballs and files used for whatever it is you'll need to build.
-(see "$POUNDER_CACHE" in doc/CONFIGURATION for more information)
-
-Should there be a failure in the build script that is essential to the ability
-to run a test, the build script should exit with error to halt the main build
-process immediately.
-
-Also, be aware that distributing pre-built binary tarballs is not always a good
-idea. Though one could cache pre-built binary tarballs rather than source, it may
-not be a good idea because distros are not always good at ABI/library path compatibility,
-despite the efforts of LSB, FHS, etc.  It is always safest to build your
-subtests from source on your target system.
-
-The build_scripts/ directory provides some examples.
-
-Test Scripts
-============
-A script in test_scripts/ is in charge of running the actual test.
-
-The requirements on test scripts are pretty light.  First, the building of the
-test ought to go in the build script unless it's absolutely necessary to build
-a test component at run time. Any checking for system requirements should also
-go in the build script.
-
-Second, the script must catch SIGTERM and clean up after itself.  SIGTERM is
-used by the test scheduler to stop tests.
-
-The third requirement is much more stringent: Return codes.  The script should
-return 0 to indicate success, 1-254 to indicate failure (the common use is to
-signify the number of failures), and -1 or 255 to indicate that the there was
-a failure that cannot be fixed.
-
-Note: If a test is being run in a timed or infinite loop (see the
-"Running Tests Repeatedly" section below for details), returning -1 or 255
-has the effect of cancelling all subsequent loops.
-
-Quick map of return codes to what gets reported:
-0             = "PASS"
--1            = "ABORT"
-255           = "ABORT"
-anything else = "FAIL"
-
-Also note: If a test is killed by an unhandled signal, the test is reported as
-failing.
-
-Put any temporary files created during test run in $POUNDER_TMPDIR.
-
-The test_scripts/ directory provides some examples.
-
-Scheduling Tests
-================
-Everything under the tests/ directory is used for scheduling purposes. The current
-test scheduler borrows a System V rc script-like structure for specifying how and
-when tests should be run. Files under tests/ should have names that follow the this
-standard:
-
-   [type][sequence number][name]
-
-"type" is the type of test. Currently, there are two types, 'D' and 'T'.  'T'
-signifies a test, which means that the scheduler starts the test, waits for the
-test to complete, and reports on its exit status.  'D' signifies a daemon
-"test", which is to say that the scheduler will start the test, let it run in
-the background, and kill it when it's done running all the tests in that
-directory.
-
-The "sequence number" dictates the order in which the test are run. 00 goes
-first, 99 goes last.  Tests with the same number are started simultaneously,
-regardless of the type.
-
-"name" is just a convenient mnemonic to distinguish between tests. However,
-it should be the same as the corresponding name using in build_scripts and
-test_scripts. (A test with build script "build_scripts/subtest" and
-test script "test_scripts/subtest" should be defined as  something like
-"tests/T00subtest" as opposed to "tests/T00whatever_i_feel_like")
-
-Test names must be unique!
-
-File system objects under the tests/ directory can be nearly anything--
-directories, symbolic links, or files.  The test scheduler will not run
-anything that doesn't have the execute bit set.  If a FS object is a
-directory, then the contents of the directory are executed sequentially.
-
-Example:
-
-Let's examine the following test scheduler hierarchy:
-
-tests/
-    D00stats
-    T01foo
-    T01bar
-    T02dir/
-        T00gav -> ../../test_scripts/gav
-        T01hic -> ../../test_scripts/hic
-    T03lat
-
-Let's see how the tests are run.  The test scheduler will start off by scanning
-the tests/ directory.  First it spawns D00stats and lets it run in the
-background.  Next, T01foo and T01bar are launched at the same time; the
-scheduler will wait for both of them to complete before proceeding.  Since T01foo
-is a file and not just a symbolic link, there is a fair chance that T01foo runs
-some test in a loop for a certain amount of time.  In any case, the scheduler
-next sees T02dir and proceeds into it.
-
-In the T02dir/, we find two test scripts.  First T00gav runs, followed by
-T01hic.  Now there are no more tests to run in T02dir/, so the scheduler heads
-back up to the parent directory.  T03lat is forked and allowed to run to
-completion, after which D00stats is killed, and the test suite exits.
-
-Running Tests Repeatedly
-========================
-Two helper programs are provided to run tests repeatedly, timed_loop and infinite_loop.
-(This version of pounder currently also includes a fancy_timed_loop.c file, but it's only
-meant to be used for the random_syscall and will most likely be merged with timed_loop.c
-in the future, so we will ignore it here for now.)
-
-1. timed_loop
-
-    timed_loop [-m max_failures] duration_in_seconds command [arguments]
-
-This program will run "command" with the given arguments repeated
-until the number of seconds given as "duration" has passed or the
-command has failed a total of "max_failures" times, whichever comes first.
-If the $MAX_FAILURES variable is set (defined in config, see CONFIGURATION
-for details), then the program will run until command has failed a total of
-$MAX_FAILURES time (as long as it's not overridden by the -m option).
-
-2. infinite_loop
-
-    infinite_loop [-m max_failures] command [arguments]
-
-This program runs "command" repeatedly until sent SIGTERM or the
-command has failed a total of "max_failures" times. If the $MAX_FAILURES
-variable is set (defined in config, see CONFIGURATION for details), then
-the program will run until command has failed a total of $MAX_FAILURES time
-(as long as it's not overridden by the -m option).
-
-Examples:
-
-1. test_repo/T90ramp/D02build_kernel contains the following line:
-
-	"$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/build_kernel"
-
-	which will run the build_kernel test script repeatedly until sent SIGTERM
-	or until it has failed a total of $MAX_FAILURES times.
-
-	"$POUNDER_HOME/infinite_loop -m 10 $POUNDER_HOME/test_scripts/build_kernel"
-
-	would run the build_kernel test script repeatedly until sent SIGTERM or
-	until it has failed 10 times, regardless of what $MAX_FAILURES is.
-
-2. test_scripts/time_drift contains the following line:
-
-	"$POUNDER_HOME/timed_loop 900 "$POUNDER_SRCDIR/time_tests/drift-test.py" $NTP_SERVER $FREQ"
-
-	which will run the drift-test.py script ($NTP_SERVER and $FREQ are some args passed to drift-test.py)
-	for 15 minutes or until it has failed a total of $MAX_FAILURES times.
-
-	"$POUNDER_HOME/timed_loop -m 10 900 "$POUNDER_SRCDIR/time_tests/drift-test.py" $NTP_SERVER $FREQ"
-
-	would run the drift-test.py script for 15 minutes or until it has failed 10 times, regardless of
-	what $MAX_FAILURES is.
-
-The Provided Test Schedulers
-============================
-This version of pounder provides 3 test schedulers: the "default," "fast," and "test" test schedulers.
-The tarred versions can be found in the schedulers/ directory as default-tests.tar.gz, fast-tests.tar.gz,
-and test-tests.tar.gz respectively.
-
-To unpack a test scheduler, run "make install" in the pounder/ directory and enter the name of the
-scheduler you would like to unpack at the first prompt.
-
-Example of unpacking the "fast" test scheduler:
-
-	# make install
-	./Install
-	Looking for tools...make g++ lex gcc python wget sudo diff patch egrep rm echo test which cp mkdir .
-	All tools were found.
-	WHICH TEST SCHEDULER SETUP DO YOU WANT TO UNPACK?
-	[Choose from:
-	default-tests.tar.gz
-	fast-tests.tar.gz
-	test-tests.tar.gz]
-	[Or simply press ENTER for the default scheduler]
-	Scheduler selection: fast
-
-Descriptions of the provided test schedulers:
-
-1. default - provides a general purpose stress test, runs for 48 hours unless the -d option
-		is used when starting pounder.
-2. fast - basically the same as default, except it runs for 12 hours by default.
-3. test - provides a set of useless tests. Each test simply passes, fails, aborts, or sleeps for
-		some period of time. They don't do anything useful but can be used to see how
-		the test scheduling setup works.
-
-Creating Your Own Test Schedulers
-=================================
-From the pounder directory, place the desired tests in the tests/ directory according to
-the rules described in the "Scheduling Tests" section above. Then run the following command:
-
-./pounder -c name_of_scheduler
-
-to create a new test scheduler, which will be tarred as name_of_scheduler-tests.tar.gz and
-placed in the schedulers/ directory.
-
-Example Usage:
-
-	# ls ./schedulers
-	default-tests.tar.gz  fast-tests.tar.gz     test-tests.tar.gz
-
-	# ls ./tests
-	T00hwinfo
-
-	# ./pounder -c new_sched
-
-	# ls ./schedulers
-	default-tests.tar.gz  fast-tests.tar.gz     new_sched-tests.tar.gz      test-tests.tar.gz
-
-	After unpacking the "new_sched" test scheduler during install, the tests/ directory should
-	contain the T00hwinfo subtest along with a tests/excluded/ directory (see the "Including and
-	Excluding Tests" section below for details regarding the tests/excluded directory).
-
-Including and Excluding Tests
-=============================
-After unpacking the test scheduler and building each individual test, running
-"./pounder" will automatically run every test included in the tests folder. If you
-would like to run only ONE test, run "./pounder ./tests/<some subtest>". If you would
-like to run a portion of tests, you can use the "./pounder -e" option to exclude
-certain subtests from subsequent pounder runs:
-
-Example:
-
-Suppose you have already ran "make install" and unpacked the default test scheduler.
-The tests/ directory should now contain the subtests to be run
-
-1) ./pounder -l
-	- lists all of the subtests that came with the currently active test scheduler.
-	The output should look something like:
-
-	------------------
-	#./pounder -l
-	Included subtests:
-	...
-	.../ltp-full-xxxxxxxx/tools/pounder/tests/T10single/T00xterm_stress
-	.../ltp-full-xxxxxxxx/tools/pounder/tests/T00hwinfo
-	...
-
-	Excluded subtests:
-	[NONE]
-	------------------
-
-2) ./pounder -e "tests/T10single/T00xterm_stress tests/T00hwinfo"
-	- will exclude T00xterm_stress and T00hwinfo from any subsequent pounder runs.
-	This command essentially moves the two tests from the "tests" folder to the
-	"tests/excluded" folder for temporary storage, where they will remain until
-	re-included back into the test scheduler (this is also why all test names
-	should be unique). A file "tests/excluded/testlist" keeps track of which tests
-	have been excluded from the test scheduler and what their original paths were.
-
-3) ./pounder -l
-	- should now output something like:
-
-	------------------
-	#./pounder -l
-	Included subtests:
-	...
-
-	Excluded subtests:
-	T00xterm_stress
-	T00hwinfo
-	------------------
-
-4) ./pounder -i "T00xterm_stress T00hwinfo" - will re-include these subtests back into
-	the test scheduler. They will be moved from the tests/excluded folder back into
-	the tests folder under their original paths.
diff --git a/tools/pounder21/fancy_timed_loop.c b/tools/pounder21/fancy_timed_loop.c
deleted file mode 100644
index f88be3df8..000000000
--- a/tools/pounder21/fancy_timed_loop.c
+++ /dev/null
@@ -1,218 +0,0 @@
-/* Repeatedly run a program with a given uid, gid and termination signal. */
-
-/*
- * Copyright (C) 2003-2006 IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <stdio.h>
-#include <string.h>
-#include <strings.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-
-#include "debug.h"
-
-static int res = 0;
-static char *progname;
-static pid_t test_pgrp;
-static FILE *out;
-
-static int the_signal = SIGTERM;
-
-static void int_func(int signum)
-{
-	pounder_fprintf(out,
-			"%s: Killed by interrupt.  Last exit code = %d.\n",
-			progname, res);
-	kill(-test_pgrp, the_signal);
-	exit(res);
-}
-
-static void alarm_func(int signum)
-{
-	pounder_fprintf(out, "%s: Killed by timer.  Last exit code = %d.\n",
-			progname, res);
-	kill(-test_pgrp, the_signal);
-	exit(res);
-}
-
-int main(int argc, char *argv[])
-{
-	int secs, stat;
-	pid_t pid;
-	unsigned int revs = 0;
-	struct sigaction zig;
-	uid_t uid;
-	gid_t gid;
-	int use_max_failures = 0;
-	int max_failures = 0;
-	int fail_counter = 1;
-
-	if (argc < 5) {
-		printf
-		    ("Usage: %s [-m max_failures] time_in_sec uid gid signal command [args]\n",
-		     argv[0]);
-		exit(1);
-	}
-	//by default, set max_failures to whatever the env variable $MAX_FAILURES is
-	char *max_failures_env = getenv("MAX_FAILURES");
-	max_failures = atoi(max_failures_env);
-
-	//if the -m option is used when calling fancy_timed_loop, override max_failures
-	//specified by $MAX_FAILURES with the given argument instead
-	if (argc > 6 && strcmp(argv[1], "-m") == 0) {
-		if ((max_failures = atoi(argv[2])) >= 0) {
-			use_max_failures = 1;
-		} else {
-			printf
-			    ("Usage: %s [-m max_failures] time_in_sec uid gid signal command [args]\n",
-			     argv[0]);
-			printf
-			    ("max_failures should be a nonnegative integer\n");
-			exit(1);
-		}
-	}
-
-	out = stdout;
-
-	if (use_max_failures) {
-		progname = strrchr(argv[7], '/');
-		if (progname == NULL) {
-			progname = argv[7];
-		} else {
-			progname++;
-		}
-	} else {
-		progname = strrchr(argv[5], '/');
-		if (progname == NULL) {
-			progname = argv[5];
-		} else {
-			progname++;
-		}
-	}
-
-	/* Set up signals */
-	memset(&zig, 0x00, sizeof(zig));
-	zig.sa_handler = alarm_func;
-	sigaction(SIGALRM, &zig, NULL);
-	zig.sa_handler = int_func;
-	sigaction(SIGINT, &zig, NULL);
-	sigaction(SIGTERM, &zig, NULL);
-
-	/* set up process groups so that we can kill the
-	 * loop test and descendants easily */
-
-	if (use_max_failures) {
-		secs = atoi(argv[3]);
-		alarm(secs);
-
-		the_signal = atoi(argv[6]);
-		uid = atoi(argv[4]);
-		gid = atoi(argv[5]);
-	} else {
-		secs = atoi(argv[1]);
-		alarm(secs);
-
-		the_signal = atoi(argv[4]);
-		uid = atoi(argv[2]);
-		gid = atoi(argv[3]);
-	}
-
-	pounder_fprintf(out, "%s: uid = %d, gid = %d, sig = %d\n",
-			progname, uid, gid, the_signal);
-
-	while (1) {
-		pounder_fprintf(out, "%s: %s loop #%d.\n", progname,
-				start_msg, revs++);
-		pid = fork();
-		if (pid == 0) {
-			// set process group
-			if (setpgrp() < 0) {
-				perror("setpgid");
-			}
-			// set group and user id
-			if (setregid(gid, gid) != 0) {
-				perror("setregid");
-				exit(-1);
-			}
-
-			if (setreuid(uid, uid) != 0) {
-				perror("setreuid");
-				exit(-1);
-			}
-			// run the program
-			if (use_max_failures) {
-				if (argc > 5) {
-					stat = execvp(argv[7], &argv[7]);
-				} else {
-					stat = execvp(argv[7], &argv[7]);
-				}
-
-				perror(argv[7]);
-			} else {
-				if (argc > 3) {
-					stat = execvp(argv[5], &argv[5]);
-				} else {
-					stat = execvp(argv[5], &argv[5]);
-				}
-
-				perror(argv[5]);
-			}
-
-			exit(-1);
-		}
-
-		/* save the pgrp of the spawned process */
-		test_pgrp = pid;
-
-		// wait for it to be done
-		if (waitpid(pid, &stat, 0) != pid) {
-			perror("waitpid");
-			exit(1);
-		}
-		// interrogate it
-		if (WIFSIGNALED(stat)) {
-			pounder_fprintf(out, "%s: %s on signal %d.\n",
-					progname, fail_msg, WTERMSIG(stat));
-			res = 255;
-		} else {
-			res = WEXITSTATUS(stat);
-			if (res == 0) {
-				pounder_fprintf(out, "%s: %s.\n", progname,
-						pass_msg);
-			} else if (res < 0 || res == 255) {
-				pounder_fprintf(out,
-						"%s: %s with code %d.\n",
-						progname, abort_msg, res);
-				exit(-1);
-				// FIXME: add test to blacklist
-			} else {
-				pounder_fprintf(out,
-						"%s: %s with code %d.\n",
-						progname, fail_msg, res);
-				if (max_failures > 0) {
-					if (++fail_counter > max_failures) {
-						exit(-1);
-					}
-				}
-			}
-		}
-	}
-}
diff --git a/tools/pounder21/infinite_loop.c b/tools/pounder21/infinite_loop.c
deleted file mode 100644
index e1a0d3dfb..000000000
--- a/tools/pounder21/infinite_loop.c
+++ /dev/null
@@ -1,174 +0,0 @@
-/* Repeatedly run a program. */
-
-/*
- * Copyright (C) 2003-2006 IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <stdio.h>
-#include <string.h>
-#include <strings.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-
-#include "debug.h"
-
-static int res = 0;
-static char *progname;
-static pid_t test_pgrp;
-static FILE *out;
-
-static void int_func(int signum)
-{
-	pounder_fprintf(out,
-			"%s: Killed by interrupt.  Last exit code = %d.\n",
-			progname, res);
-	kill(-test_pgrp, SIGTERM);
-	exit(res);
-}
-
-int main(int argc, char *argv[])
-{
-	int stat;
-	pid_t pid;
-	struct sigaction zig;
-	unsigned int revs = 0;
-	int use_max_failures = 0;
-	int max_failures = 0;
-	int fail_counter = 1;
-
-	if (argc < 2) {
-		printf("Usage: %s [-m max_failures] command [args]\n", argv[0]);
-		exit(1);
-	}
-	//by default, set max_failures to whatever the env variable $MAX_FAILURES is
-	char *max_failures_env = getenv("MAX_FAILURES");
-	max_failures = atoi(max_failures_env);
-
-	//if the -m option is used when calling infinite_loop, override max_failures
-	//specified by $MAX_FAILURES with the given argument instead
-	if (argc > 3 && strcmp(argv[1], "-m") == 0) {
-		if ((max_failures = atoi(argv[2])) >= 0) {
-			use_max_failures = 1;
-		} else {
-			printf("Usage: %s [-m max_failures] command [args]\n",
-			       argv[0]);
-			printf
-			    ("max_failures should be a nonnegative integer\n");
-			exit(1);
-		}
-	}
-
-	out = stdout;
-
-	if (use_max_failures) {
-		progname = strrchr(argv[3], '/');
-		if (progname == NULL) {
-			progname = argv[3];
-		} else {
-			progname++;
-		}
-	} else {
-		progname = strrchr(argv[1], '/');
-		if (progname == NULL) {
-			progname = argv[1];
-		} else {
-			progname++;
-		}
-	}
-
-	/* Set up signals */
-	memset(&zig, 0x00, sizeof(zig));
-	zig.sa_handler = int_func;
-	sigaction(SIGINT, &zig, NULL);
-	sigaction(SIGTERM, &zig, NULL);
-
-	/* set up process groups so that we can kill the
-	 * loop test and descendants easily */
-
-	while (1) {
-		pounder_fprintf(out, "%s: %s loop #%d.\n", progname,
-				start_msg, revs++);
-		pid = fork();
-		if (pid == 0) {
-			if (setpgrp() < 0) {
-				perror("setpgid");
-			}
-			// run the program
-			if (use_max_failures) {
-				if (argc > 5) {
-					stat = execvp(argv[3], &argv[3]);
-				} else {
-					stat = execvp(argv[3], &argv[3]);
-				}
-
-				perror(argv[3]);
-			} else {
-				if (argc > 3) {
-					stat = execvp(argv[1], &argv[1]);
-				} else {
-					stat = execvp(argv[1], &argv[1]);
-				}
-
-				perror(argv[1]);
-			}
-
-			exit(-1);
-		}
-
-		/* save the pgrp of the spawned process */
-		test_pgrp = pid;
-
-		// wait for it to be done
-		if (waitpid(pid, &stat, 0) != pid) {
-			perror("waitpid");
-			exit(1);
-		}
-		// interrogate it
-		if (WIFSIGNALED(stat)) {
-			pounder_fprintf(out, "%s: %s on signal %d.\n",
-					progname, fail_msg, WTERMSIG(stat));
-			res = 255;
-		} else {
-			res = WEXITSTATUS(stat);
-			if (res == 0) {
-				pounder_fprintf(out, "%s: %s.\n", progname,
-						pass_msg);
-			} else if (res < 0 || res == 255) {
-				pounder_fprintf(out,
-						"%s: %s with code %d.\n",
-						progname, abort_msg, res);
-				exit(-1);
-				// FIXME: add test to blacklist
-			} else {
-				pounder_fprintf(out,
-						"%s: %s with code %d.\n",
-						progname, fail_msg, res);
-				if (max_failures > 0) {
-					if (++fail_counter > max_failures) {
-						pounder_fprintf
-						    ("Reached max number of failures allowed: %d. Aborting.",
-						     max_failures);
-						exit(-1);
-					}
-				}
-			}
-		}
-	}
-}
diff --git a/tools/pounder21/libpounder.sh b/tools/pounder21/libpounder.sh
deleted file mode 100644
index 21e46133b..000000000
--- a/tools/pounder21/libpounder.sh
+++ /dev/null
@@ -1,65 +0,0 @@
-# Common shell functions and variables that all pounder scripts can use.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-# Start by setting environment variables...
-export DATE=`date +%Y%h%d-%H%M%S`
-
-export DEFAULT_SCHEDPACK=default
-export TESTS=`/bin/ls test_scripts/`
-export BUILDS=`/bin/ls build_scripts/`
-export POUNDER_HOME=`pwd`
-export POUNDER_PIDFILE="$POUNDER_HOME/pounder.pid"
-export POUNDER_LOGLOCAL="$POUNDER_HOME/log"
-export POUNDER_LOGDIR="$POUNDER_LOGLOCAL/$DATE/"
-export POUNDER_TMPDIR="$POUNDER_HOME/tmp/"
-export POUNDER_OPTDIR="$POUNDER_HOME/opt/"
-export POUNDER_SRCDIR="$POUNDER_HOME/src/"
-export POUNDER_VERSION=`head -1 "$POUNDER_HOME/README" | awk -F " " '{print $3}' | sed -e 's/\.//g'`
-export NR_CPUS=`getconf _NPROCESSORS_ONLN`
-export NFS_LOGLOCAL="`echo "$HOSTNAME" | sed -e 's/\..*//g'`/`uname -r`-`uname -m`"
-
-if [ -e "$POUNDER_HOME/config" ]; then
-	source "$POUNDER_HOME/config"
-fi
-
-function get_from_sourceforge {
-	PROGNAME=$1
-	TARNAME=$2
-
-	# Correct arguments?
-	if [ -z "$1" -o -z "$2" ]; then
-		echo "get_from_sourceforge: Called with empty arguments."
-		exit
-	fi
-
-	# File already exists?
-	if [ -f "$TARNAME" ]; then
-		echo "get_from_sourceforge: Target file already exists."
-		exit
-	fi
-
-	# Else try download...
-	for SERVER in voxel.dl.sourceforge.net easynews.dl.sourceforge.net umn.dl.sourceforge.net; do
-		wget -t 1 --timeout=15 "http://$SERVER/sourceforge/$PROGNAME/$TARNAME"
-
-		if [ -f "$TARNAME" ]; then
-			break
-		fi
-	done
-}
diff --git a/tools/pounder21/nfs_logging b/tools/pounder21/nfs_logging
deleted file mode 100755
index 405a95be2..000000000
--- a/tools/pounder21/nfs_logging
+++ /dev/null
@@ -1,95 +0,0 @@
-#!/bin/bash
-
-# Mount an NFS export for remote log storage.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-# @author Sarunya Jimenez (sjimen@us.ibm.com)
-# Reworked by Darrick Wong <djwong@us.ibm.com>
-#  - If unable to connect to NFS_SERVER => save log files in local machine
-#  - Otherwise,
-#    1. log files produced from ./pounder will be in
-#       NFS_LOGSERVER (e.g. 10.0.0.211)
-#       |--- /pounder
-#            |---   /$HOSTNAME (e.g. testbox)
-#                   |--- KERNEL_VERSION-ARCH (e.g. 2.6.14-i686)
-#    2. Run "$./pounder -u" to umount nfs log server
-#       Otherwise, by default, when ./pounder completed, nfs remains
-#       mounted to the local machine.
-# ASSUMPTION  : Already imported global variables from "libpounder.sh"
-
-if [ -z "$NFS_LOGSERVER" -o -z "$NFS_LOGDIR" ]; then
-	echo "NFS log server not configured."
-	exit 0
-fi
-
-# Path construction:
-
-#nfsserv:/crash/pounder-logs/testbox/2.6.14-i686/somedate/
-#$NFS_LOGSERVER:$NFS_LOGDIR/$NFS_LOGLOCAL/$DATE
-
-#/home/pounder/log
-#$POUNDER_LOGLOCAL
-
-#/home/pounder/log/somedate
-#$POUNDER_LOGDIR or $POUNDER_LOGLOCAL/$DATE
-
-# Are we already mounted?
-IS_MOUNTED=`grep "$POUNDER_LOGLOCAL " /proc/mounts | wc -l`
-if [ $IS_MOUNTED -eq 1 ]; then
-	echo "Log directory already mounted on $POUNDER_LOGLOCAL"
-	exit 0
-fi
-
-# Create local directory for mounting
-mkdir -p "$POUNDER_LOGLOCAL/"
-if [ ! -d "$POUNDER_LOGLOCAL/" ]; then
-	echo "Cannot create $POUNDER_LOGLOCAL/."
-	exit 1
-fi
-
-# Mount NFS log server's top-level log dir
-mount "$NFS_LOGSERVER:$NFS_LOGDIR/" "$POUNDER_LOGLOCAL/" -t nfs -o tcp
-RESULT=$?
-
-if [ $RESULT -gt 0 ]; then
-	echo "Mounting $NFS_LOGSERVER:$NFS_LOGDIR/ on $POUNDER_LOGLOCAL/ failed; logs will be local."
-	exit 2;
-fi
-
-# Create a directory for this run's log files
-mkdir -p "$POUNDER_LOGLOCAL/$NFS_LOGLOCAL/"
-if [ ! -d "$POUNDER_LOGLOCAL/$NFS_LOGLOCAL/" ]; then
-	echo "Cannot create local log dir on log server $POUNDER_LOGLOCAL/$NFS_LOGLOCAL/; logs will be local."
-	umount "$POUNDER_LOGLOCAL/"
-	exit 3
-fi
-
-# Now remount the real log dir on our local machine.
-umount "$POUNDER_LOGLOCAL/"
-mount  "$NFS_LOGSERVER:$NFS_LOGDIR/$NFS_LOGLOCAL/" "$POUNDER_LOGLOCAL/" -t nfs -o tcp
-RESULT=$?
-
-if [ $RESULT -gt 0 ]; then
-	echo "Mounting $NFS_LOGSERVER:$NFS_LOGDIR/$NFS_LOGLOCAL on $POUNDER_LOGLOCAL/ failed; logs will be local."
-	exit 4;
-fi
-
-# Once we return to pounder, it'll create $POUNDER_LOGDIR.
-
-exit 0
diff --git a/tools/pounder21/pounder b/tools/pounder21/pounder
deleted file mode 100755
index caf60d320..000000000
--- a/tools/pounder21/pounder
+++ /dev/null
@@ -1,275 +0,0 @@
-#!/bin/bash
-
-# Main pounder control script.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-source libpounder.sh
-
-# This function kills off pounder and related subprocesses.
-function dokill() {
-	echo "Killing off pounder(s)..."
-	kill -INT `cat $POUNDER_PIDFILE`;
-	rm -rf $POUNDER_PIDFILE
-	#killall -9 randasys 2> /dev/null	# These run as user 'daemon' and have to be killed manually.
-}
-
-# Main function follows
-
-function help() {
-	cat << ENDL
-Usage: ./pounder [-g logdir] [-x] [-d duration] [-n ipaddr] [-m max_failures] [-f] [-h|-u|-r|-k|-l|-e subtests|-i subtests|-c scheduler] [-s]
-
--h      	Brings up this menu
--c scheduler	Creates a new test scheduler called scheduler-tests.tar.gz in the pounder/schedulers folder.
-		All subtests to be packaged with this scheduler must first be placed in the pounder/tests folder.
--x      	Enable X stress tests.
--d duration	Run pounder for duration seconds.
--n ipaddr	Use ipaddr for NFS tests.
--f		Remove pounder pid file before running.
--u      	Unmount NFS log storage.
--r      	Remount NFS log storage.
--g logdir      	Use logdir as the log directory. (You probably want -s too.)
--s      	Store logs locally.
--l      	List (both included and excluded) subtests that came with the test scheduler
--e subtests     Exclude subtests from next pounder run
--i subtests     Include previously excluded subtests in the next pounder run
--k      	Kill pounder.
-
-run "./pounder" to run all subtests
-run "./pounder subtest" to run just one particular subtest
-        (example: ./pounder tests/T90ramp/D02build_kernel)
-ENDL
-}
-
-function exclude() {
-	echo "excluding from tests $@..."
-
-	POUNDER_TESTS=$POUNDER_HOME/tests
-	SUBTESTS_INC=`find $POUNDER_TESTS -name excluded -prune -o -type f -print -o -type l -print`
-
-	for i in $@
-	do
-		BASENAME=`basename "$i"`
-
-		ORIG_DIR=`pwd`
-		cd `dirname $i`
-		FULL_PATH=`pwd`/"$BASENAME"
-		cd $ORIG_DIR
-
-		FOUND=`echo "$SUBTESTS_INC" | grep -x "$FULL_PATH"`
-
-		if [ -n "$FOUND" -a -x "$i" ]; then
-
-			ALREADY_EXCLUDED=`grep -w "$BASENAME" $POUNDER_TESTS/excluded/testlist | cut -d " " -f1`
-			if [ $ALREADY_EXCLUDED ]; then
-				echo $ALREADY_EXCLUDED
-				echo "$BASENAME has already been excluded from the test scheduler. Make sure the test names in the test scheduler are unique."
-				exit 1
-			fi
-
-			echo "$BASENAME" "$FULL_PATH" >> "$POUNDER_TESTS"/excluded/testlist
-			mv "$i" "$POUNDER_TESTS"/excluded/"$BASENAME"
-
-			if [ $? -eq 0 ]; then
-				echo "Successfully removed $i from test scheduler."
-			else
-				echo "Removal of $i from tests UNSUCCESSFUL."
-			fi
-		else
-			echo "$i is not a subtest included in the current scheduler. Use ./pounder -l for list of valid, excludable subtests."
-		fi
-	done
-}
-
-function include() {
-	echo "including in tests $@..."
-
-        POUNDER_EXCLUDED=$POUNDER_HOME/tests/excluded
-
-        for i in $@
-        do
-		ORIG_FILE=`grep -w "$i" $POUNDER_EXCLUDED/testlist | cut -d " " -f2`
-
-		if [ -n "$ORIG_FILE" ]; then
-			mv $POUNDER_EXCLUDED/$i $ORIG_FILE
-			if [ $? -eq 0 ]; then
-				sed "/$i /d" $POUNDER_EXCLUDED/testlist > $POUNDER_EXCLUDED/tempfile
-				mv $POUNDER_EXCLUDED/tempfile $POUNDER_EXCLUDED/testlist
-				echo "Successfully added $i back to test scheduler."
-			else
-				echo "Addition of $i to tests UNSUCCESSFUL."
-			fi
-		else
-			echo "$i is not an excluded subtest. It may already be included in the current scheduler. Use ./pounder -l for list of valid, includable subtests."
-		fi
-        done
-}
-
-function list_tests() {
-
-	if [ ! -d $POUNDER_HOME/tests ]; then
-		echo "Error: No test schedule found. Did you run make install?"
-		exit 1
-	fi
-
-	echo "Included subtests:"
-	INCLUDED_TESTS=`find $POUNDER_HOME/tests -name excluded -prune -o -type f -print -o -type l -print`
-	if [ -z "$INCLUDED_TESTS" ]; then
-		echo "[NONE]"
-	else
-		echo "$INCLUDED_TESTS"
-	fi
-	echo
-
-	echo "Excluded subtests:"
-
-	if [ ! -d $POUNDER_HOME/tests/excluded ]; then
-		echo "Error: $POUNDER_HOME/tests/excluded folder does not exist. Make sure your test scheduler was created or unpackaged correctly. Did you run make install?"
-		exit 1
-	fi
-
-	EXCLUDED_TESTS=`grep -v "#" $POUNDER_HOME/tests/excluded/testlist`
-	if [ -z "$EXCLUDED_TESTS" ]; then
-		echo "[NONE]"
-	else
-		echo "$EXCLUDED_TESTS" | cut -d " " -f1
-	fi
-
-}
-
-function create_scheduler() {
-	TESTS_EXCLUDED=$POUNDER_HOME/tests/excluded
-	REPO_EXCLUDED=$POUNDER_HOME/test_repo/excluded
-
-	if [ ! -d $TESTS_EXCLUDED ]; then
-		cp -r $REPO_EXCLUDED $TESTS_EXCLUDED
-	elif [ ! -e $TESTS_EXCLUDED/testlist ]; then
-		cp $REPO_EXCLUDED/testlist $TESTS_EXCLUDED/testlist
-	fi
-
-	tar -czf $POUNDER_HOME/schedulers/$@-tests.tar.gz tests
-}
-# process options: -x to run in xterms, -k to kill tests, -d to set duration,
-# -f to remove bogus pounder.pid files.
-while getopts d:kn:g:xure:i:m:c:shl? o
-do
-	case "$o" in
-	   d) export DURATION="$OPTARG";;
-	   k) dokill; exit;;
-	   n) export NFS_SERVER="$OPTARG";;
-	   g) export POUNDER_LOGDIR="$OPTARG";;
-	   x) export DO_X_TESTS=1;;
-	   f) rm -rf "$POUNDER_PIDFILE";;
-	   u) umount $POUNDER_HOME/log 2> /dev/null; exit 0;;
-	   s) export NFS_LOGGING=0;;
-	   r) ./nfs_logging; exit;;
-	   e) exclude $OPTARG; exit;;
-	   i) include $OPTARG; exit;;
-	   l) list_tests; exit;;
-	   m) export MAX_FAILURES="$OPTARG";;
-	   c) create_scheduler $OPTARG; exit;;
-	   h) help $0; exit;;
-	   '?') help $0; exit 1;;
-	esac
-done
-
-# Did user ask for X tests when DISPLAY is set?
-# Probably _not_ what the user wants.
-if [ $DO_X_TESTS -eq 1 ] && [ ! -z "$DISPLAY" ]; then
-	echo "WARNING: X tests are enabled and DISPLAY is set.  xterms will appear on this desktop!"
-	echo "WARNING: Kill pounder NOW if this is not what you intended."
-fi
-
-# Get set up to read arguments, even though there aren't any...
-shift `expr $OPTIND - 1`
-
-# Are we already running?
-if [ -f "$POUNDER_PIDFILE" ]; then
-	echo "File $POUNDER_PIDFILE exists; pounder may already be running."
-	echo "Either run 'pounder -k' to stop all tests, or remove it."
-	exit 1
-fi
-
-# Did the user run Install?
-if [ ! -x run-helper -o ! -x timed_loop -o ! -x infinite_loop ]; then
-	echo "Could not find run-helper, infinite_loop or timed_loop.  Did you run Install?"
-	exit -1
-fi
-
-# Try to mount NFS log store.
-if [ -z "$NFS_LOGSERVER" -o -z "$NFS_LOGDIR" ]; then
-	echo "NFS logging disabled because NFS_LOGSERVER or NFS_LOGDIR are not set."
-	export NFS_LOGGING=0
-else
-	if [ $NFS_LOGGING -gt 0 ]; then
-		./nfs_logging
-	fi
-fi
-
-# Set up log directory
-mkdir -p "$POUNDER_LOGDIR" 2> /dev/null
-if [ ! -d "$POUNDER_LOGDIR" ]; then
-	echo "Could not create $POUNDER_LOGDIR; aborting."
-	exit 1
-fi
-
-# Set up dir for optional components
-mkdir -p "$POUNDER_OPTDIR"
-if [ ! -d "$POUNDER_OPTDIR" ]; then
-	echo "Could not create $POUNDER_OPTDIR; aborting."
-	exit 1
-fi
-
-# Set up tmpdir
-mkdir -p "$POUNDER_TMPDIR"
-if [ ! -d "$POUNDER_TMPDIR" ]; then
-	echo "Could not create $POUNDER_TMPDIR; aborting."
-	exit 1
-fi
-
-TEST_HEAD="$1"
-if [ -z $TEST_HEAD ]; then
-	TEST_HEAD=tests
-fi
-
-# needs to be a separate check in case there is no tests/ dir...
-if [ ! -d "$TEST_HEAD" -a ! -f "$TEST_HEAD" ]; then
-	echo "$TEST_HEAD does not exist!"
-	exit 1
-fi
-
-
-# Dump environment variables...
-export > "$POUNDER_LOGDIR/environment"
-
-echo "Starting $POUNDER_VERSION"
-echo "STARTING TESTS."
-echo "To kill all tests, run 'pounder -k' or press ^C."
-
-# Handle the duration thing...
-function kill_after {
-	sleep $DURATION
-	./pounder -k
-}
-if [ ! -z "$DURATION" -a "$DURATION" -gt 0 ]; then
-	kill_after &
-fi
-
-# Now run the tests
-./run-helper $TEST_HEAD --leader
diff --git a/tools/pounder21/proclist.c b/tools/pounder21/proclist.c
deleted file mode 100644
index afc1ee684..000000000
--- a/tools/pounder21/proclist.c
+++ /dev/null
@@ -1,72 +0,0 @@
-/* Manage a list of processes. */
-
-/*
- * Copyright (C) 2003-2006 IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <malloc.h>
-#include "proclist.h"
-
-void add_to_proclist(struct proclist_t *list, struct proclist_item_t *item)
-{
-	struct proclist_item_t *curr;
-
-	if (list->head == NULL) {
-		item->next = NULL;
-		list->head = item;
-		return;
-	}
-
-	curr = list->head;
-	while (curr->next != NULL) {
-		curr = curr->next;
-	}
-
-	item->next = NULL;
-	curr->next = item;
-}
-
-void remove_from_proclist(struct proclist_t *list, struct proclist_item_t *item)
-{
-	struct proclist_item_t *curr, *prev;
-
-	if (list->head == NULL) {
-		return;
-	}
-
-	if (list->head == item) {
-		list->head = item->next;
-		item->next = NULL;
-		return;
-	}
-
-	prev = list->head;
-	curr = list->head->next;
-
-	while (curr != NULL && curr != item) {
-		prev = curr;
-		curr = curr->next;
-	}
-
-	if (curr == NULL) {
-		return;
-	}
-
-	prev->next = item->next;
-	item->next = NULL;
-}
diff --git a/tools/pounder21/proclist.h b/tools/pounder21/proclist.h
deleted file mode 100644
index f8ddae467..000000000
--- a/tools/pounder21/proclist.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* Declarations to manage a list of processes. */
-
-/*
- * Copyright (C) 2003-2006 IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#ifndef PROCLIST_H_
-#define PROCLIST_H_
-
-#include <sys/types.h>
-
-struct proclist_item_t {
-	struct proclist_item_t *next;
-	pid_t pid;
-	char *name;
-};
-
-struct proclist_t {
-	struct proclist_item_t *head;
-};
-
-void add_to_proclist(struct proclist_t *list, struct proclist_item_t *item);
-void remove_from_proclist(struct proclist_t *list, struct proclist_item_t *item);
-
-#endif
diff --git a/tools/pounder21/run.c b/tools/pounder21/run.c
deleted file mode 100644
index 5f5903c45..000000000
--- a/tools/pounder21/run.c
+++ /dev/null
@@ -1,681 +0,0 @@
-/*
- * The main pounder process controller and scheduler program.
- * Author: Darrick Wong <djwong@us.ibm.com>
- */
-
-/*
- * Copyright (C) 2003-2006 IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <errno.h>
-#include <signal.h>
-#include <sys/wait.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <stdlib.h>
-#include <ctype.h>
-#include <stdarg.h>
-#include <sys/time.h>
-#include <time.h>
-#include <stdio.h>
-#include <dirent.h>
-#include <sys/stat.h>
-
-#include "proclist.h"
-#include "debug.h"
-
-// List of subprocesses to wait upon
-struct proclist_t wait_ons = { NULL };
-struct proclist_t daemons = { NULL };
-
-static int is_leader = 0;
-static char *pidfile = "";
-
-static inline int is_executable(const char *fname);
-static inline int is_directory(const char *fname);
-static inline int test_filter(const struct dirent *p);
-static inline int test_sort(const struct dirent **a, const struct dirent **b);
-static int wait_for_pids(void);
-static void wait_for_daemons(void);
-static void note_process(pid_t pid, char *name);
-static void note_daemon(pid_t pid, char *name);
-static void kill_tests(void);
-static void kill_daemons(void);
-static int process_dir(const char *fname);
-static pid_t spawn_test(char *fname);
-static void note_child(pid_t pid, char *fname, char type);
-static int child_finished(const char *name, int stat);
-static char *progname;
-
-#define TEST_PATH_LEN 512
-#define TEST_FORK_WAIT 100
-
-/**
- * Kill everything upon ^C.
- */
-static void jump_out(int signum)
-{
-	pounder_fprintf(stdout, "Control-C received; aborting!\n");
-	//unlink("pounder_pgrp");
-	kill_tests();
-	kill_daemons();
-	if (is_leader) {
-		unlink(pidfile);
-	}
-	exit(0);
-}
-
-/**
- * Kills tests launched from within.
- */
-static void kill_tests(void)
-{
-	struct proclist_item_t *curr;
-
-	curr = wait_ons.head;
-	while (curr != NULL) {
-		kill(-curr->pid, SIGTERM);
-		curr = curr->next;
-	}
-}
-
-/**
- * Kills daemons launched from within.
- */
-static void kill_daemons(void)
-{
-	struct proclist_item_t *curr;
-
-	curr = daemons.head;
-	while (curr != NULL) {
-		kill(-curr->pid, SIGTERM);
-		curr = curr->next;
-	}
-}
-
-/**
- * Record the pounder leader's PID in a file.
- */
-static void record_pid(void)
-{
-	FILE *fp;
-
-	pidfile = getenv("POUNDER_PIDFILE");
-	if (pidfile == NULL) {
-		pidfile = "pounder.pid";
-	}
-
-	fp = fopen(pidfile, "w");
-	if (fp == NULL) {
-		perror(pidfile);
-	}
-	fprintf(fp, "%d", getpid());
-	fclose(fp);
-}
-
-/**
- * Main program.  Returns 1 if all programs run successfully, 0 if
- * something failed and -1 if there was an error running programs.
- */
-int main(int argc, char *argv[])
-{
-	int retcode;
-	struct sigaction zig;
-	pid_t pid;
-	char *c;
-
-	/* Check parameters */
-	if (argc < 2) {
-		fprintf(stderr, "Usage: %s test_prog\n", argv[0]);
-		return 1;
-	}
-
-	if (argc > 2 && strcmp(argv[2], "--leader") == 0) {
-		pounder_fprintf(stdout,
-				"Logging this test output to %s/POUNDERLOG.\n",
-				getenv("POUNDER_LOGDIR"));
-		is_leader = 1;
-		record_pid();
-	}
-
-	progname = argv[0];
-
-	/* Set up signals */
-	memset(&zig, 0x00, sizeof(zig));
-	zig.sa_handler = jump_out;
-	sigaction(SIGHUP, &zig, NULL);
-	sigaction(SIGINT, &zig, NULL);
-	sigaction(SIGTERM, &zig, NULL);
-
-	if (is_directory(argv[1])) {
-		retcode = process_dir(argv[1]);
-	} else {
-		if (is_executable(argv[1])) {
-			c = strrchr(argv[1], '/');
-			c++;
-
-			// Start the test
-			pid = spawn_test(argv[1]);
-			if (pid < 0) {
-				perror("fork");
-				retcode = -1;
-				goto out;
-			}
-			// Track the test
-			note_process(pid, argv[1]);
-			if (wait_for_pids() == 0) {
-				retcode = 1;
-			} else {
-				retcode = 0;
-			}
-		} else {
-			pounder_fprintf(stderr,
-					"%s: Not a directory or a test.\n",
-					argv[1]);
-			retcode = -1;
-		}
-	}
-
-out:
-	kill_daemons();
-	wait_for_daemons();
-	if (is_leader) {
-		if (retcode == 0) {
-			pounder_fprintf(stdout, "%s: %s.\n", argv[1], pass_msg);
-		} else if (retcode < 0 || retcode == 255) {
-			pounder_fprintf(stdout, "%s: %s with code %d.\n",
-					argv[1], abort_msg, retcode);
-		} else {
-			pounder_fprintf(stdout, "%s: %s with code %d.\n",
-					argv[1], fail_msg, retcode);
-		}
-		unlink(pidfile);
-	}
-	exit(retcode);
-}
-
-/**
- * Helper function to determine if a file is executable.
- * Returns 1 if yes, 0 if no and -1 if error.
- */
-static inline int is_executable(const char *fname)
-{
-	struct stat tmp;
-
-	if (stat(fname, &tmp) < 0) {
-		return -1;
-	}
-
-	if (geteuid() == 0) {
-		return 1;
-	} else if (geteuid() == tmp.st_uid) {
-		return tmp.st_mode & S_IXUSR;
-	} else if (getegid() == tmp.st_gid) {
-		return tmp.st_mode & S_IXGRP;
-	} else {
-		return tmp.st_mode & S_IXOTH;
-	}
-}
-
-/**
- * Helper function to determine if a file is a directory.
- * Returns 1 if yes, 0 if no and -1 if error.
- */
-static inline int is_directory(const char *fname)
-{
-	struct stat tmp;
-
-	if (stat(fname, &tmp) < 0) {
-		return 0;
-	}
-
-	return S_ISDIR(tmp.st_mode);
-}
-
-/**
- * Returns 1 if the directory entry's filename fits the test name pattern.
- */
-static inline int test_filter(const struct dirent *p)
-{
-	return ((p->d_name[0] == 'T' || p->d_name[0] == 'D')
-		&& isdigit(p->d_name[1]) && isdigit(p->d_name[2]));
-}
-
-/**
- * Simple routine to compare two tests names such that lower number/name pairs
- * are considered "lesser" values.
- */
-//static inline int test_sort(const struct dirent **a, const struct dirent **b) {
-static inline int test_sort(const struct dirent **a, const struct dirent **b)
-{
-	return strcmp(&(*b)->d_name[1], &(*a)->d_name[1]);
-}
-
-/**
- * Takes the wait() status integer and prints a log message.
- * Returns 1 if there was a failure.
- */
-static int child_finished(const char *name, int stat)
-{
-	int x;
-	// did we sig-exit?
-	if (WIFSIGNALED(stat)) {
-		pounder_fprintf(stdout, "%s: %s on signal %d.\n",
-				name, fail_msg, WTERMSIG(stat));
-		return 1;
-	} else {
-		x = WEXITSTATUS(stat);
-		if (x == 0) {
-			pounder_fprintf(stdout, "%s: %s.\n", name, pass_msg);
-			return 0;
-		} else if (x < 0 || x == 255) {
-			pounder_fprintf(stdout, "%s: %s with code %d.\n",
-					name, abort_msg, x);
-			return 1;
-			// FIXME: add test to blacklist
-		} else {
-			pounder_fprintf(stdout, "%s: %s with code %d.\n",
-					name, fail_msg, x);
-			return 1;
-		}
-	}
-}
-
-/**
- * Wait for some number of PIDs.  If any of them return nonzero, we
- * assume that there was some kind of failure and return 0.  Otherwise,
- * we return 1 to indicate success.
- */
-static int wait_for_pids(void)
-{
-	struct proclist_item_t *curr;
-	int i, stat, res, nprocs;
-	pid_t pid;
-
-	res = 1;
-
-	// figure out how many times we have to wait...
-	curr = wait_ons.head;
-	nprocs = 0;
-	while (curr != NULL) {
-		nprocs++;
-		curr = curr->next;
-	}
-
-	// now wait for children.
-	for (i = 0; i < nprocs;) {
-		pid = wait(&stat);
-
-		if (pid < 0) {
-			perror("wait");
-			return 0;
-		}
-		// go find the child
-		curr = wait_ons.head;
-		while (curr != NULL) {
-			if (curr->pid == pid) {
-				res =
-				    (child_finished(curr->name, stat) ? 0 :
-				     res);
-
-				// one less pid to wait for
-				i++;
-
-				// stop observing
-				remove_from_proclist(&wait_ons, curr);
-				free(curr->name);
-				free(curr);
-				break;
-			}
-			curr = curr->next;
-		}
-
-		curr = daemons.head;
-		while (curr != NULL) {
-			if (curr->pid == pid) {
-				child_finished(curr->name, stat);
-				remove_from_proclist(&daemons, curr);
-				free(curr->name);
-				free(curr);
-				break;
-			}
-			curr = curr->next;
-		}
-	}
-
-	return res;
-}
-
-/**
- * Wait for daemons to finish.  This function does NOT wait for wait_ons.
- */
-static void wait_for_daemons(void)
-{
-	struct proclist_item_t *curr;
-	int i, stat, res, nprocs;
-	pid_t pid;
-
-	res = 1;
-
-	// figure out how many times we have to wait...
-	curr = daemons.head;
-	nprocs = 0;
-	while (curr != NULL) {
-		nprocs++;
-		curr = curr->next;
-	}
-
-	// now wait for daemons.
-	for (i = 0; i < nprocs;) {
-		pid = wait(&stat);
-
-		if (pid < 0) {
-			perror("wait");
-			if (errno == ECHILD) {
-				return;
-			}
-		}
-
-		curr = daemons.head;
-		while (curr != NULL) {
-			if (curr->pid == pid) {
-				child_finished(curr->name, stat);
-				i++;
-				remove_from_proclist(&daemons, curr);
-				free(curr->name);
-				free(curr);
-				break;
-			}
-			curr = curr->next;
-		}
-	}
-}
-
-/**
- * Creates a record of processes that we want to watch for.
- */
-static void note_process(pid_t pid, char *name)
-{
-	struct proclist_item_t *it;
-
-	it = calloc(1, sizeof(struct proclist_item_t));
-	if (it == NULL) {
-		perror("malloc proclist_item_t");
-		// XXX: Maybe we should just waitpid?
-		return;
-	}
-	it->pid = pid;
-	it->name = calloc(strlen(name) + 1, sizeof(char));
-	if (it->name == NULL) {
-		perror("malloc procitem name");
-		// XXX: Maybe we should just waitpid?
-		return;
-	}
-	strcpy(it->name, name);
-
-	add_to_proclist(&wait_ons, it);
-}
-
-/**
- * Creates a record of daemons that should be killed on exit.
- */
-static void note_daemon(pid_t pid, char *name)
-{
-	struct proclist_item_t *it;
-
-	it = calloc(1, sizeof(struct proclist_item_t));
-	if (it == NULL) {
-		perror("malloc proclist_item_t");
-		// XXX: what do we do here?
-		return;
-	}
-	it->pid = pid;
-	it->name = calloc(strlen(name) + 1, sizeof(char));
-	if (it->name == NULL) {
-		perror("malloc procitem name");
-		// XXX: what do we do here?
-		return;
-	}
-	strcpy(it->name, name);
-
-	add_to_proclist(&daemons, it);
-}
-
-/**
- * Starts a test, with the stdin/out/err fd's redirected to logs.
- * The 'fname' parameter should be a relative path from $POUNDER_HOME.
- */
-static pid_t spawn_test(char *fname)
-{
-	pid_t pid;
-	int fd, tmp;
-	char buf[TEST_PATH_LEN], buf2[TEST_PATH_LEN];
-	char *last_slash;
-
-	pid = fork();
-	if (pid == 0) {
-		if (setpgrp() < 0) {
-			perror("setpgid");
-		}
-
-		pounder_fprintf(stdout, "%s: %s test.\n", fname, start_msg);
-
-		// reroute stdin
-		fd = open("/dev/null", O_RDWR);
-		if (fd < 0) {
-			perror("/dev/null");
-			exit(-1);
-		}
-		close(0);
-		tmp = dup2(fd, 0);
-		if (tmp < 0) {
-			perror("dup(/dev/null)");
-			exit(-1);
-		}
-		close(fd);
-
-		// generate log name-- '/' -> '-'.
-		snprintf(buf2, TEST_PATH_LEN, "%s|%s",
-			 getenv("POUNDER_LOGDIR"), fname);
-
-		fd = strlen(buf2);
-		for (tmp = (strchr(buf2, '|') - buf2); tmp < fd; tmp++) {
-			if (buf2[tmp] == '/') {
-				buf2[tmp] = '-';
-			} else if (buf2[tmp] == '|') {
-				buf2[tmp] = '/';
-			}
-		}
-
-		// make it so that we have a way to get back to the
-		// original console.
-		tmp = dup2(1, 3);
-		if (tmp < 0) {
-			perror("dup(stdout, 3)");
-			exit(-1);
-		}
-		// reroute stdout/stderr
-		fd = open(buf2, O_RDWR | O_CREAT | O_TRUNC | O_SYNC,
-			  S_IWUSR | S_IRUSR | S_IRGRP | S_IROTH);
-		if (fd < 0) {
-			perror(buf2);
-			exit(-1);
-		}
-		close(1);
-		tmp = dup2(fd, 1);
-		if (tmp < 0) {
-			perror("dup(log, 1)");
-			exit(-1);
-		}
-		close(2);
-		tmp = dup2(fd, 2);
-		if (tmp < 0) {
-			perror("dup(log, 2)");
-			exit(-1);
-		}
-		close(fd);
-
-		// let us construct the absolute pathname of the test.
-		// first find the current directory
-		if (getcwd(buf, TEST_PATH_LEN) == NULL) {
-			perror("getcwd");
-			exit(-1);
-		}
-		// then splice cwd + fname
-		snprintf(buf2, TEST_PATH_LEN, "%s/%s", buf, fname);
-
-		// find the location of the last slash
-		last_slash = strrchr(buf2, '/');
-
-		if (last_slash != NULL) {
-			// copy the filename part into a new buffer
-			snprintf(buf, TEST_PATH_LEN, "./%s", last_slash + 1);
-
-			// truncate@the last slash
-			*last_slash = 0;
-
-			// and chdir
-			if (chdir(buf2) != 0) {
-				perror(buf2);
-				exit(-1);
-			}
-			// reassign variables
-			fname = buf;
-		}
-		// spawn the process
-		execlp(fname, fname, NULL);
-
-		// If we get here, we can't run the test.
-		perror(fname);
-		exit(-1);
-	}
-
-	tmp = errno;
-	/* yield for a short while, so that the test has
-	 * a little bit of time to run.
-	 */
-	usleep(TEST_FORK_WAIT);
-	errno = tmp;
-
-	return pid;
-}
-
-/**
- * Adds a child process to either the running-test or running-daemon
- * list.
- */
-static void note_child(pid_t pid, char *fname, char type)
-{
-	if (type == 'T') {
-		note_process(pid, fname);
-	} else if (type == 'D') {
-		note_daemon(pid, fname);
-	} else {
-		pounder_fprintf(stdout,
-				"Don't know what to do with child `%s' of type %c.\n",
-				fname, type);
-	}
-}
-
-/**
- * Process a directory--for each entry in a directory, execute files or spawn
- * a new copy of ourself on the new directory.  Process execution is subject to
- * these rules:
- *
- * - Test files that start with the same number '00foo' and '00bar' are allowed
- *   to run simultaneously.
- * - Test files are run in order of number and then name.
- *
- * If a the fork fails, bit 1 of the return code is set.  If a
- * program runs but fails, bit 2 is set.
- */
-static int process_dir(const char *fname)
-{
-	struct dirent **namelist;
-	int i, result = 0;
-	char buf[TEST_PATH_LEN];
-	int curr_level_num = -1;
-	int test_level_num;
-	pid_t pid;
-	int children_ok = 1;
-
-	pounder_fprintf(stdout, "%s: Entering directory.\n", fname);
-
-	i = scandir(fname, &namelist, test_filter,
-		    (int (*)(const void *, const void *))test_sort);
-	if (i < 0) {
-		perror(fname);
-		return -1;
-	}
-
-	while (i--) {
-		/* determine level number */
-		test_level_num = ((namelist[i]->d_name[1] - '0') * 10)
-		    + (namelist[i]->d_name[2] - '0');
-
-		if (curr_level_num == -1) {
-			curr_level_num = test_level_num;
-		}
-
-		if (curr_level_num != test_level_num) {
-			children_ok &= wait_for_pids();
-			curr_level_num = test_level_num;
-		}
-
-		snprintf(buf, TEST_PATH_LEN, "%s/%s", fname,
-			 namelist[i]->d_name);
-		if (is_directory(buf)) {
-			pid = fork();
-			if (pid == 0) {
-				if (setpgrp() < 0) {
-					perror("setpgid");
-				}
-				// spawn a new copy of ourself.
-				execl(progname, progname, buf, NULL);
-
-				perror(progname);
-				exit(-1);
-			}
-		} else {
-			pid = spawn_test(buf);
-		}
-
-		if (pid < 0) {
-			perror("fork");
-			result |= 1;
-			free(namelist[i]);
-			continue;
-		}
-
-		note_child(pid, buf, namelist[i]->d_name[0]);
-
-		free(namelist[i]);
-	}
-	free(namelist);
-
-	/* wait for remaining runners */
-	children_ok &= wait_for_pids();
-	if (children_ok == 0) {
-		result |= 2;
-	}
-
-	pounder_fprintf(stdout, "%s: Leaving directory.\n", fname);
-
-	return result;
-}
diff --git a/tools/pounder21/schedulers/default-tests.tar.gz b/tools/pounder21/schedulers/default-tests.tar.gz
deleted file mode 100644
index ac20bc9683618886e385a17e9fb2fe19b830e2fd..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 1663
zcmV-_27vh=iwFQgJ~~bS1MQt#Z`(E$$NlV2!J!5A&?VtTB%7zbq(uv?&Cq2S_9Vy_
z9ShN|lDs6}ex&ToHk(FuL2*odeh+aHUr6}RbKwz5b*k;!v&pDnjH%?@JYp&KA2&=0
z5ri>{ss3F*OCmf$eB5rWS+!l#AmpQ|5b1jT)!jT_r79g~AnfXodwrkKKcW+?|DfEn
z{!LYNKH3WmOMmlcp0#ej2_vwGqOa=DB4O#zA{tE)cG`=taOC>GKvzqJ>Qz%$twPlT
zb<3<pi!4`2KXw(mQL08=GHX#)PG6wgWj0@;x>}W~YEZkH^#cecjY1ED2rZhb(4V99
z%gwW>S(T^guca#0Kl(kVXAkc_Q4b$*(p4v$x9d0QhF7ghe=(o&@CsBWg+fW0qB`l8
z=vs9sudc6Es$aiUjXIs`UoI}u$IC19;qv1B+rQD(yZ3*fx9@*@b2|OMzvXaQ+y52D
z%iFA6RHL-f+q;y5@n1wtFri;Z1dhlA(bLo3A;s;y$!gtAt$Mt?jh%KB;=j@V95+c(
zkCX>~YyPM8mslA8ujLnz|M_5F|Eu$J?W_~+<a6b&jb87k^w-Z3%m^ifP^t3+LWTGE
zf26$l>1>vjXS1YTnh5%7RiZ`JpzgLpX>#9A+uX!|BI#?4A&mZb?A!kZmh*bGXw+wy
zZS30rWBEVX<o_oA3ufX!BOLO7FYMSqnoheWsnO5sF6$8f84*5x`TOOcA1~f~ir-y+
zcyp!`udK{E73Wn|qy6Xh61B}Bn)aXc@>g&i!Lo1v=0|*+WbWtxPsV>Lw(*~t{Et#S
zU4Z!SfxY;@4)zQJ{qbPOf1af(o~KP!#Ph1YchbgS{5SdkL;S}k{zs7@5dVEJPW;~=
zM34rAi)H^r-gT-e;<js4+d67vDE<@9tojdQ9OAzh#<Bn1K?K$xGPeEGCMi?xx7+)6
zp5(ccHiqqg8~>$b#{LC^`kxoZvH$%+1Rfw<tolD;=5bX!ZR7Cke-V!O1krKI5&Imu
z{oDHUQ1q9ezYpyB|LZ~(=6^2R7>xhB^?yC_$AmKMd;Wi<j1&Jig9rkD@L2vI2NVAz
z@c%xr<G&0<e@;MuAK3awf#|PO0?^+BcKrvJ3s+^|{}|5y=(hf2)`=5605If#J{Twe
z(}M_dzh{B%|8Xe(pMwAQft~*clmB7R-v_q+lR)&380hZ<+x|r;`a}KK3%31-qCfb5
zKiKtuW)^J4dD2{~xNDS?T|k5LKfbO1bKbB2mqNh&&j%x||KA@(Fc%CKyZ*xpRm4f2
zS95o54BP+C{!h|h|KkkmKVBH^`rmpGf#nB|ZU0f;xlR5i2i1QirfgmRh4p`47{~tg
zAOg#O7TEbeovpGwjc-&_DmSZt4_f~(c+{`|r5x7(cwrp--yKBY2tvk=|Gdiz70;`(
z&Du_ta~C@RhwWc(<3Ho3{zD|p|GhAd{o8{Gd_bt!_Ah$r(k5HDE4mKbKiS%UWa@uZ
zn(IGc|Kl^F{r7_iEI(}Q>wo8=T>pXfA6~Hizq$V3mdTC7<KMoa{v)^R|N84cG&1M^
zg8v_%vG#wi2N8Jx(6Q@3QJOB3+R?!;8;0$F=lZW)pZ^5)A3uy^|C>Ps<{vzE{uj*p
zKgj>QVEcbEtI9G{uU<K9W7q%VN6-J<=6{^7&;Rtk{{znda#{c13?c{sp=101*Mazd
z*#GGVd;KpBM1R=-?FZZbgE{{N_Wydp)<2m2-*Enu7wr81yimp6LN$Emu8qO^&vyN<
zkZisF7sL6VUKnlt?|Kly1R!v1{~t{L2m3$0VEccOCxy#ve}+N-A8prv3fkZQlQXFQ
zdts#Y-+B;%>wgZc?f(K3Z3dn5lYiD6?*9eB?2-FF_I)(B{mja1SDia@```F~f?NHa
z=4zBXK;lF0|1He<Pgqj8|F;)x{dESI)kW4-m8;z!-w^*vG$EK{$|A{d)UW>(6ym=R
z2IBwpshhlP#t8)aXUv!OkDcEE=HU2G3GeIwI{w=!fb-5Bx&42sKXJYT`0)IXo7;ds
zs=xEjf&Tsd---T$l`7-1n&nA(<Ft*#?H^Mr9?Snn=p*Rg*MH78->rM~zsLS1<NWLT
zJMAOr-`hWK@7v~cT$LlV@g4qOQu&zvrjI9X`*`H~0{{R30000000000008jg@-MXS
Je}({{0038brBMI?

diff --git a/tools/pounder21/schedulers/fast-tests.tar.gz b/tools/pounder21/schedulers/fast-tests.tar.gz
deleted file mode 100644
index 5984a5ce372367e33902adcc831d830ba7910dac..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 1494
zcmZvZdpMH|9LML<X}N?J2dR04mQLj8Ns%q5#K~oqsE(Lio-R+Q$8BkP3s2O_s7|^u
zE#*=OT|~1YO)1QzqNtE%W@7Kgw)g#=&iVU%|N8v<`FzQ2BEhHKBZ#0UEA&qoT4O3q
zSC&TR&r#kx*OE=Cr1S0B;l+*1`xg4pGY*OJP5DkQ1C{+Q%RL_i+KbY>YmL?mHrfbH
z46e?08u^xVv#aFJj-k&i#W{&+&dtfmBkfsvd54!oE^wVy<xK9+sQ=W`cW**n;?vf;
zmD+8h{MDpAs_;xt?$Yso#s{^7CfFwM9;;bbs7#PHq`DUE+ppY7XFqW}=6LaBi!HMk
z|BX0TGuLSPMBBT0h7_*tAqA!A%X1lWD*pGASCjjD3OAqz=<b0VArVA-vc~$;JW(-q
zcT!o^?R^qzdx6!#vE;wcSR_kZKX0HMn3I-dcmJSt`*BWQ!p>@5O8A>D#+9<?f+@E;
zwvf(c3tiUArPDIuNcQkkX;2C6j-1JwTXBASamki#7Zg?v=3Y)?{bBj9RQq`5b>-TT
zDeLsdP2SvU7h3wvqE9TXVy=4f`@1_I6hLjqYeiuE;zN2w<-rxvMrj<LNK2kNL9*C_
zW$$W5Jgyn*ET6a(H_+B{F_crMc`rHn2VSsDxqx)kTHVoMNs9sss~K-`b^0*+wz51^
zPqP9eeRPbCKConxj|yrL(+Vvo#EO6l^ybSDH*R}OVVgaJm>6xOJpK|t8$b*lp`F`B
z8AY;A8F^Mg(8W5gv&GTm8o!1^9x{WF@i}Lsj2y%V4wr$y&B|+Ng*jZdi4K4mPYC|O
za5T7uSTE=j7%CN<+v27`Yene#VXx){voB(IK{(8gOpU2#hS1SFhP#=gAp`9CGU+di
zn^Lxx#TD-NV2Q6WY%eq0Z{Tk^Gt`%FR7k{Y*fB;9eyd}!kvfcQ-T*;NJ0SVtrI|%=
zwCD`;%EM$U7wNY<`L3I%1uU6BOD@A{LuNe?bngO~6cS$%5Rrn;%Z|7o`w^{_1U%3a
zqMa!i8KpK`rlw<~n`&-C`Z8TqbG8cUa}04BN>M!sbM)C8b2fU4W?0^h_}Tq*8J9rU
zX<OYHb}uXo@TyvLGuj5hT%J|{U3P!z{B=h#sdBXGJvRdjFYbiF0^Sb9ZQTo33|Vs*
zZm!PK%Jn^G5$UG98NM$Y-WO=;OLM@vYZ@6ojb)=qBqEh4O;|NF9Zll~Ieb1C%QBZR
zG2c{_9E>r(&*_5Xj6yZt!>s3cwXPQ)P5&zB1HB)E)HF;UhzXzK&Rr;deGSd{*}p_i
zi$WyO;QdbEuFRg1>+_+rC!@07uP@9@Rk^CxaDNgmRP};*FQnR+X03w66Sq*v4$@Eb
zP7rBmcNfN9U+BYM?f#-3PyNC5al(V0#RSQqPHz>&T_;|YuWP_FdG2A_z+5TBPXNz=
z@LwK=hZzMzir+y}O$U2*6DiK&^<CU69;3B7ft$hXpmB;qAm3z4WNq$*C!PLgF4Btj
z#)uvMBu|16CCjF04i&KRv$}fGxP*~vm!s3flhSMg3LehB+9OWh12Lt@nsMM*D&TtL
zHpnEMoWeE>aCg;++T<=A&R7C(QK;H7VKjitJk_*DHOE+m6zhD1R^x|CB>p;)Cy+}p
zu5DmliEGkO!O9`^U?bjG4wOv1nlvu?d5tY17fERez2J?F>U-fAe8NK>GgTd*ErmUZ
zy}_v&&J7sV_s5`;<gGio*b5h^?C}<y?k<rc<;#@W*kF7YDu079BB7d;q&ZdxizZ-L
zpO143c&uHgFS)!v=lU1OtKn9X1e(<}_g!Joc*O29ftkAm_~j4@r6k1++2YRwQ+?d1
zCs6kYPppR(Ul#TvYoB$i6TWXURWtNB02lnk^R~5y@G0lVIwY39LgdVH2Ra76hC=37
r^<W=D9V`l)?uC3U*)^B@NFa({e?+54_}@*cXMg#YHC{<5CJ_Ds-z7Vp

diff --git a/tools/pounder21/schedulers/test-tests.tar.gz b/tools/pounder21/schedulers/test-tests.tar.gz
deleted file mode 100644
index ddff53ee18b6c115b6cc0292f64a13abaccb048c..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 1057
zcmV++1m61}iwFRrp*c<f1MOVjZ__Xk?sNZ&8|9I<wqrYhgm~!?lNd!%gm{{=#%&_H
zBuY})pO2j;Yz<vUt2k84eX5lHaN=t|pYOY~+gxRNHttykA%wX?m?L!sHAg}@FODU8
zlu9Zjqr$YKggK-K!me2xth3xp0sf(#N;CWBw2i#re@28KrnZK`zw$2~>Pr2bP|942
z{I`KE{%1rkyl~ZYABJGpbt}I2@=uA>{JSobJz%5JSU-%3SJ^xb6K$!nZ<Gbi8CUV2
z#&N#CT^IOw6EAE0TOQ0m)1Qmo{2Tj_|K?ERUz`m84)Wgyw)meA;;WlDqRsYE@V_Vi
z8_p@A(iPI>jvgnJNvZW8Y1WM0=y?1eoQ<!;Xq*LoH4kFg&=2OG<YBZN8T9+Vf^elE
zPuHsN$9(|(SkO1rJkxJPs{g;g1>#uL=l_$@e-Ffe)PK#Q&cAmZr+e?i5jZ0LI}ho<
z!oDU40P?Tzs=A%8*1q!XQ~>Vf|9ko8j?Vja;;-YsOWc<8f8^irZ(gp#tl1gB5G?Qb
z{)>Ny%NqY&=xLx`{nt_c2QUj1B<nPZGX?Pi@*vD$Vf3Cp<}v(GDuLX)&LEEZ1JF`%
z9zYVWBVVPEt*?s#1YWA38bq*2;~RY)rJI{iAzeo!_!g*0{nY1-#?{$FRb611$HVe;
zeUk22-);Yexkl9jBJW0l7x|EQc>qh5!zx}bm9N_eDpgvg4q!5ckJA}kPA3=dzQgSO
z#TR&Y@!@=g`t(6m@t@jA{7W3J|D>q&pWWoY*LnZ1_?IV9|7T>g{-fi7!1{k1*y4Xi
zURu-t`}miRssFf|d`F9cqW)v_Kh}TjqgMZUR^?Z(!JGd$gW_cvEzh3y)oqvq69R+j
zQ$o%EU!6+*pAoG8w}CDGtNK4{wvWf=|FZsX=6{|4kz)SmZRdZFw|kQOWBtF|sQEuF
z27uFS9|!oqL&Zk_anygUV3+?h^#9IaTmMmFP5<r7{}}z_|AH6(&(Z(e!9D*s`5i%5
z?iRNE-%<_u5dUY=)PI@I2GRf90Q!HoQIG%D_W$gy|K90;zRCYNL;r6D_4;qQzv?y2
z%sOzf@@n2vepLY;I*j8a@no>=|8@kxLGhm#{$H&Bq5s<l#{X`k@_%My;kU%W>pyxb
zaLA7RAB}JR?BV)P$v-z!|0<3X3w<21{^wBs!2Ta&Bkuog3>E*54dGwnaQ~N_(;fUb
zzWKk0{FnT@S-4yz%1R&i_<!{G-xdGT*}?zD#%4!A$MxTa{|O;kc$2Ku#6};FuKzJs
z{{Msd;ZL#upHTe$Un{uN|Ia^7zkZyYf4+J@y*wX>(ISk(TwR%X3)`R7e6kofoAd#m
bzr_Rsfj}S-2m}IwI9dD#?ssbA08jt`(w|Tl

diff --git a/tools/pounder21/src/cpufreq/Makefile b/tools/pounder21/src/cpufreq/Makefile
deleted file mode 100644
index b2a1ed099..000000000
--- a/tools/pounder21/src/cpufreq/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-# Makefile for CPU frequency tester
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-#
-
-
-CFLAGS += -O3 -Wall
-bins = cpufreq.bin
-
-all: ${bins}
-
-cpufreq.bin: cpufreq.c
-	$(CC) $(CFLAGS) -o cpufreq.bin $<
-
-clean:
-	rm -f ${bins}
diff --git a/tools/pounder21/src/cpufreq/cpufreq.c b/tools/pounder21/src/cpufreq/cpufreq.c
deleted file mode 100644
index 714f1a38f..000000000
--- a/tools/pounder21/src/cpufreq/cpufreq.c
+++ /dev/null
@@ -1,193 +0,0 @@
-/**
- * Program to exercise CPU frequency switching via sysfs.
- * You probably want to turn on userspace switching and disable
- * powernowd/cpuspeed/powersaved programs.
- */
-
-/*
- * Copyright (C) 2003-2006 IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <fcntl.h>
-#include <stdlib.h>
-
-static unsigned int cpunum = 0;
-
-static int check_writable(const char *fname)
-{
-	int fd;
-
-	fd = open(fname, O_WRONLY);
-	if (fd >= 0)
-		close(fd);
-
-	return fd >= 0;
-}
-
-static int seed_random(void)
-{
-	int fp;
-	long seed;
-
-	fp = open("/dev/urandom", O_RDONLY);
-	if (fp < 0) {
-		perror("/dev/urandom");
-		return 0;
-	}
-
-	if (read(fp, &seed, sizeof(seed)) != sizeof(seed)) {
-		perror("read random seed");
-		return 0;
-	}
-
-	close(fp);
-	srand(seed);
-
-	return 1;
-}
-
-static unsigned int get_randnum(unsigned int max)
-{
-	return (unsigned int)((float)max * (rand() / (RAND_MAX + 1.0)));
-}
-
-static int set_cpuspeed(const char *ctrlfile, unsigned int speed)
-{
-	int fd, x;
-	unsigned int y;
-	char buf[256];
-
-	/* First try to write a new speed. */
-	fd = open(ctrlfile, O_WRONLY);
-	if (fd < 0) {
-		perror(ctrlfile);
-		return 0;
-	}
-
-	printf("CPU %d speed set to %u kHz.\n", cpunum, speed);
-	fflush(stdout);
-
-	x = snprintf(buf, 256, "%u\n", speed);
-	x = write(fd, buf, x);
-
-	if (x == 0) {
-		perror("Setting new speed");
-		close(fd);
-		return 0;
-	}
-	close(fd);
-
-	/* Sleep for a while */
-	usleep(500000);
-
-	/* Now try to read the speed */
-	fd = open(ctrlfile, O_RDONLY);
-	if (fd < 0) {
-		perror(ctrlfile);
-		return 0;
-	}
-
-	x = read(fd, buf, 256);
-	if (x == 0) {
-		perror("Reading speed");
-		close(fd);
-		return 0;
-	}
-	close(fd);
-
-	y = atoi(buf);
-	if (y != speed) {
-		printf("ERROR: Set CPU %d speed to %u but speed is now %u!\n",
-		       cpunum, speed, y);
-		fflush(stdout);
-		return -1;
-	}
-
-	return 1;
-}
-
-int main(int argc, char *argv[])
-{
-	const char *ctrl;
-	unsigned int rounds;
-	unsigned int *frequencies;
-	int y;
-	unsigned int x, num_freqs;
-	int ret = 0;
-
-	/* Usage: cpufreq control_file rounds [frequencies...] */
-	if (argc < 6) {
-		printf
-		    ("Usage: %s control_file rounds cpunum [frequencies...]\n",
-		     argv[0]);
-		ret = 1;
-		goto out;
-	}
-
-	/* copy command line args */
-	ctrl = argv[1];
-	if (!check_writable(ctrl)) {
-		perror(ctrl);
-		ret = 2;
-		goto out;
-	}
-
-	rounds = atoi(argv[2]);
-	cpunum = atoi(argv[3]);
-
-	num_freqs = argc - 4;
-	frequencies = calloc(num_freqs, sizeof(unsigned int));
-	if (frequencies == NULL) {
-		perror("Error allocating memory");
-		ret = 3;
-		goto out;
-	}
-
-	for (x = 4; x < argc; x++) {
-		frequencies[x - 4] = atoi(argv[x]);
-	}
-
-	/* Now run program. */
-	printf("Running %u loops with these %d frequencies:\n", rounds,
-	       num_freqs);
-	for (x = 0; x < num_freqs; x++) {
-		printf("%u KHz\n", frequencies[x]);
-	}
-
-	fflush(stdout);
-
-	seed_random();
-
-	for (x = rounds; x > 0; x--) {
-		y = get_randnum(num_freqs);
-		y = set_cpuspeed(ctrl, frequencies[y]);
-		if (y != 1) {
-			ret = 4;
-			goto out;
-		}
-	}
-
-out:
-	printf("Exiting with return code %d.\n", ret);
-	fflush(stdout);
-	return ret;
-}
diff --git a/tools/pounder21/src/dump_xserver_statm b/tools/pounder21/src/dump_xserver_statm
deleted file mode 100755
index 8d0538a9e..000000000
--- a/tools/pounder21/src/dump_xserver_statm
+++ /dev/null
@@ -1,27 +0,0 @@
-#!/bin/bash
-
-# Dump X11 server statm data
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-while true; do
-	cat /proc/`ps -ef | grep "$XSERVER_FILE :2" | egrep -v "(timed_loop|grep)" | awk '{print $2}'`/statm >> $POUNDER_LOGDIR/xserver_statm
-	echo "---------------------------------------" >> $POUNDER_LOGDIR/xserver_statm
-	echo "Running."
-	sleep 10
-done
diff --git a/tools/pounder21/src/libidecd.sh b/tools/pounder21/src/libidecd.sh
deleted file mode 100755
index 9648574c9..000000000
--- a/tools/pounder21/src/libidecd.sh
+++ /dev/null
@@ -1,95 +0,0 @@
-#!/bin/bash
-
-# Library to find CD devices.
-#
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-# Create a list of potential devices.  Note that this may pick up some non-block
-# devices; it is assumed that they will be filtered out by find_discs_with_media.
-function find_disc_devices() {
-	NUM_DEVICES=`/bin/ls $(egrep '(cdr|dvd)' /etc/fstab | awk -F " " '{print $1}') /dev/cdr* /dev/dvd* /dev/cdrom/* /dev/sr* 2> /dev/null | sort | uniq | wc -l`
-	if [ $NUM_DEVICES -lt 1 ]; then
-		# No CDs at all?
-		echo NONE
-	fi
-	/bin/ls $(egrep '(cdr|dvd)' /etc/fstab | awk -F " " '{print $1}') /dev/cdr* /dev/dvd* /dev/cdrom/* /dev/sr* 2> /dev/null | sort | uniq
-}
-
-# Try to find a disc with media in it.  Hopefully, $DEFAULT_MOUNT already exists.
-function find_discs_with_media() {
-	# If the caller doesn't specify a DEFAULT_MOUNT point, specify one.
-	if [ -z "$DEFAULT_MOUNT" ]; then
-		DEFAULT_MOUNT=/mnt
-	fi
-	POTENTIAL_DEVICES=`find_disc_devices`
-	# Grab a list of all CD/DVD devices that we can find.
-	for i in `echo "$POTENTIAL_DEVICES"`
-	do
-		# Did we get nothing at all?
-		if [ "$i" == "NONE" ]; then
-			echo NONE 0
-			return
-		fi
-
-		# Is this a link pointing to a device that's in the
-		# list of potential discs AND isn't in fstab?
-		# We want to avoid considering /dev entries that are symlinked
-		# elsewhere ... but we also assume that anything in fstab was
-		# put there for a reason and ought to be considered anyway.
-		if [ -L "$i" ]; then
-			IN_LIST=`echo "$POTENTIAL_DEVICES" | grep "$(readlink $i)" -c`
-			if [ $IN_LIST -gt 0 ]; then
-				IN_FSTAB=`grep "^$i[ 	]" /etc/fstab -c`
-				if [ $IN_FSTAB -eq 0 ]; then
-					continue;
-				fi
-			fi
-		fi
-
-		# Block device?
-		if [ -b "$i" ]; then
-			IN_FSTAB=`grep -c "^$i[ 	]" /etc/fstab`
-			FSTAB_TYPE=`grep "^$i[ 	]" /etc/fstab | awk -F " " '{print $3}'`
-			if [ $IN_FSTAB -gt 0 -a "$FSTAB_TYPE" != "subfs" ]; then
-				# This device is listed in fstab and is NOT of
-				# type "subfs" (SLES9 weirdness); try to mount it.
-				mount "$i" > /dev/null 2> /dev/null
-				RESULT=$?
-
-				if [ $RESULT -eq 0 ]; then
-					# Mounted ok!
-					umount "$i"
-					echo "$i" 1
-					continue
-				fi
-			fi
-
-			# Not in fstab, or the mount failed.
-			mount "$i" "$DEFAULT_MOUNT" -t auto > /dev/null 2> /dev/null
-			RESULT=$?
-
-			if [ $RESULT -eq 0 ]; then
-				# Mounted ok once we gave it options.
-				umount "$i"
-				echo "$i" 0
-				continue
-			fi
-		fi
-	done
-}
diff --git a/tools/pounder21/src/mem_alloc_test/Makefile b/tools/pounder21/src/mem_alloc_test/Makefile
deleted file mode 100644
index 85887a886..000000000
--- a/tools/pounder21/src/mem_alloc_test/Makefile
+++ /dev/null
@@ -1,26 +0,0 @@
-# Makefile for OOM tester
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-CFLAGS += -O3
-bins = mem_alloc
-
-all: ${bins}
-
-clean:
-	rm -f ${bins}
diff --git a/tools/pounder21/src/mem_alloc_test/mem_alloc.c b/tools/pounder21/src/mem_alloc_test/mem_alloc.c
deleted file mode 100644
index 8694c8858..000000000
--- a/tools/pounder21/src/mem_alloc_test/mem_alloc.c
+++ /dev/null
@@ -1,425 +0,0 @@
-/* ************************************************************************************
- *	mem_alloc.c
- *	@description : This program will consume memory using sbrk() to a size where
- *		       there is about COMMITED_AS KB left in free{swap+ram}.
- *		       The program realized that a process can consume so much memory,
- *		       space, so it will fork more child to consume as much as memory
- *		       possible, aiming for final free{swap+ram} < COMMITED_AS.
- *		       EXEPTION: If overcommit_momory is set, the program will only
- *			         consume as much as momory as oom-killer allows, and
- *				 will exit when then limit reached even the
- *				 free{swap+ram} not < COMMITTED_AS KB.
- *	@author	     : Sarunya Jimenez (sjimene@us.ibm.com)
- * ********************************************************************************** */
-
-/*
- * Copyright (C) 2003-2006 IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <signal.h>
-#include <sys/types.h>
-#include <sys/sysinfo.h>
-#include <sys/mman.h>
-#include <errno.h>
-
-/////////////////////////// GLOBAL STATIC VAIRABLE FOR SIGNAL HANDLER /////////////////
-static volatile sig_atomic_t sigflag;	// set nonzero by sig handler
-static sigset_t newmask, oldmask, zeromask;
-////////////////////////////////////////////////////////////////////////////////////////
-
-//////////////////////////////// GLOBAL DEFINES ////////////////////////////////////////
-#define KB_VALUE        1024	// value in bytes -> 1024 bytes
-#define COMMITTED_AS  102400	// value in KB    -> 102400 KB -> 100MB
-#define MALLOC_SIZE   0x10000	// = 64KB... for each sbrk(MALLOC_SIZE) in
-					// malloc_data()
-					// MUST ALWAYS BE POSSITIVE VALUE
-#define PAGE_SIZE     0x400	// = 1024 KB
-/////////////////////////////////////////////////////////////////////////////////////////
-
-//////////////////////////////// GLOBAL VARIABLES ////////////////////////////////////////
-long sbrk_num;			// global sbrk_num to keep track of # of times sbrk() get called
-char *start_addr;		// heap @before a process allocate memory - get updated in eat_mem()
-char *end_addr;			// heap @after a process allocate memory  - get updated in alloc_data()
-			// and dealloc_data()
-//////////////////////////////////////////////////////////////////////////////////////////
-
-//////////////////////////////// ERROR HANDLING PRINT FUNCTIONS //////////////////////////
-/* ========================================================================================
- *	Print linux error message, will exit the current process.
- * ======================================================================================== */
-void unix_error(char *msg)
-{
-	printf("LINUX ERROR: %s: %s\n", msg, strerror(errno));
-	exit(0);
-}
-
-/* ========================================================================================
- *	Print functionality-error message for user process, will not exit the current process.
- * ======================================================================================== */
-void user_error(char *msg)
-{
-	printf("APPLICATION ERROR: %s\n", msg);
-}
-
-/////////////////////////////////////////////////////////////////////////////////////////////
-
-//////////////////////////// SIGNAL HANDLING FUNCTIONS ///////////////////////////////////////
-/* =====================================================================================
- *	One Signal Handler for SIGUSR1 and SIGUSR2.
- * ===================================================================================== */
-static void sig_usr(int signo)	// signal hanlder for SIGUSR1 and SIGUSR2
-{
-	sigflag = 1;
-}
-
-/* ========================================================================================
- *	SET UP signal handler before TELL_PARENT(), WAIT_PARENT(), TELL_CHILD(), WAIT_CHILD().
- *	- This function must be called before fork() and TELL/WAIT_PARENT/CHILD() functions.
- * ======================================================================================== */
-void TELL_WAIT(void)
-{
-	if (signal(SIGUSR1, sig_usr) == SIG_ERR)
-		unix_error("signal (SIGUSR1) FAILED");
-	if (signal(SIGUSR2, sig_usr) == SIG_ERR)
-		unix_error("signal (SIGUSR2) FAILED");
-
-	sigemptyset(&zeromask);
-	sigemptyset(&newmask);
-	sigaddset(&newmask, SIGUSR1);
-	sigaddset(&newmask, SIGUSR2);
-
-	if (sigprocmask(SIG_BLOCK, &newmask, &oldmask) < 0)
-		unix_error("signal (SIG_BLOCK) FAILED");
-}
-
-/* ========================================================================================
- *	TELL parent that we are done: used in child process.
- *	- This function must be called after TELL_WAIT() setup the SIGUSR1 & SIGUSR2 propery.
- *	- INPUT: parent process ID; can be obtained through getppid().
- * ======================================================================================== */
-void TELL_PARENT(pid_t pid)
-{
-	kill(pid, SIGUSR2);	// send signal SIGUSR2 to pid process
-}
-
-/* ========================================================================================
- *	TELL child that we are done: used in parent process.
- *	- This function must be called after TELL_WAIT() setup the SIGUSR1 & SIGUSR2 propery.
- *	- INPUT: child process ID; can be obtained through pid = fork() where pid > 0.
- * ======================================================================================== */
-void TELL_CHILD(pid_t pid)
-{
-	kill(pid, SIGUSR1);	// send signal SIGUSR1 to pid process
-}
-
-/* ========================================================================================
- *	WAIT for parent: used in child process.
- *	- This function must be called after TELL_WAIT() setup the SIGUSR1 & SIGUSR2 propery.
- * ======================================================================================== */
-void WAIT_PARENT(void)
-{
-	while (sigflag == 0)
-		sigsuspend(&zeromask);	// wait for child
-	sigflag = 0;
-
-	// reset signal mask to original value
-	if (sigprocmask(SIG_SETMASK, &oldmask, NULL) < 0)
-		unix_error("signal (SIG_SETMASK) FAILED");
-}
-
-/* ========================================================================================
- *	WAIT for child: used in parent process.
- *	- This function must be called after TELL_WAIT() setup the SIGUSR1 & SIGUSR2 propery.
- * ======================================================================================== */
-void WAIT_CHILD(void)
-{
-	while (sigflag == 0)
-		sigsuspend(&zeromask);	// wait for parent
-	sigflag = 0;
-
-	// reset signal mask to original value
-	if (sigprocmask(SIG_SETMASK, &oldmask, NULL) < 0)
-		unix_error("signal (SIG_SETMASK) FAILED");
-}
-
-/////////////////////////////////////////////////////////////////////////////////////////////
-
-/////////////////////////////////////// MEMORY ALLOCATION FUNCTIONS /////////////////////////
-/* =====================================================================================
- *	SET sbrk_num @start of each process to count # of sbrk() calls within that process.
- *	- INPUT: input number for globak sbrk_num to be set to.
- * ===================================================================================== */
-void set_sbrk_num(int in)
-{
-	sbrk_num = in;
-}
-
-/* ========================================================================================
- *	PRINT system information; e.g. free {ram, swap}, total {ram, swap}.
- * ======================================================================================== */
-void print_sysinfo(void)
-{
-	struct sysinfo si;
-	sysinfo(&si);
-
-	printf
-	    ("freeram (%luKB),  freeswap (%luKB), totalram (%luKB), totalswap (%luKB)\n",
-	     (si.freeram / KB_VALUE) * si.mem_unit,
-	     (si.freeswap / KB_VALUE) * si.mem_unit,
-	     (si.totalram / KB_VALUE) * si.mem_unit,
-	     (si.totalswap / KB_VALUE) * si.mem_unit);
-}
-
-/* ========================================================================================
- *	CALCULATE freeswap space.
- *	- OUTPUT: Return size of free swap space in KB.
- * ======================================================================================== */
-long unsigned freeswap(void)
-{
-	struct sysinfo si;
-	sysinfo(&si);
-
-	return ((si.freeswap / KB_VALUE) * si.mem_unit);
-}
-
-/* ========================================================================================
- *	CALCULATE freeram space.
- *	- OUTPUT: Return size of free ram space in KB.
- * ======================================================================================== */
-long unsigned freeram(void)
-{
-	struct sysinfo si;
-	sysinfo(&si);
-
-	return ((si.freeram / KB_VALUE) * si.mem_unit);
-}
-
-/* ========================================================================================
- *	ALLOCATE data using sbrk(incr).
- *  	- Global sbrk_num will be updated for each time calling sbrk() to increase heap size.
- *	- OUTPUT: Return 1 if success,
- *			 0 if failed, and will decrement the heap space for future library calls
- * ======================================================================================== */
-int malloc_data(void)
-{
-	int return_value = 0;	// default return = true;
-	intptr_t incr = MALLOC_SIZE;	// 64KB
-	char *src = NULL;	// to hold addr return from sbrk(incr)
-	long i;			// loop counter
-
-	src = sbrk(incr);
-
-	if (((void *)src == (void *)-1) && (errno == ENOMEM)) {	// error handling
-		src = sbrk(-(2 * incr));	// freeing some space for later library calls
-		sbrk_num -= 2;
-		end_addr = src + (-(2 * incr));	// update end of heap
-	} else {		// sucess case
-		// must write to data, write once for each 1KB
-		for (i = 0x0; i < incr; i += PAGE_SIZE)
-			src[i] = '*';
-		++sbrk_num;	// update global sbrk() call counter when success
-		return_value = 1;	// update return value to true
-		end_addr = src + incr;	// update end of heap
-	}
-
-	return return_value;
-}
-
-/* ========================================================================================
- *	DEALLOCATE data using sbrk(-incr).
- *  	- Global sbrk_num will be updated for each time calling sbrk() to decrease heap size.
- *	- OUTPUT: Return 1 if success,
- *			 0 if failed.
- * ======================================================================================== */
-int dealloc_data(void)
-{
-	int return_value = 0;	// default return = true
-	intptr_t incr = MALLOC_SIZE;	// 64KB
-	char *src = NULL;	// to hold adrr return from sbrk(incr)
-	long i;			// loop counter
-	long old_sbrk_num = sbrk_num;	// save old sbrk_num counter, because sbrk_num will be updated
-
-	for (i = 0; i < old_sbrk_num; ++i) {
-		src = sbrk(-incr);
-
-		// error handling: Fatal Fail
-		if (((void *)src == (void *)-1) && (errno == ENOMEM))
-			goto OUT;	// error
-
-		--sbrk_num;	// update # of sbrk() call
-		end_addr = src + (-incr);	// update end of heap
-	}
-	return_value = 1;	// update return value to true
-
-OUT:
-	return return_value;
-}
-
-/* ========================================================================================
- *	Write to the memory because of Copy-On-Write behavior from LINUX kernel.
- *	IDEA: Because fork() is implemented through Copy-On-Write. This technique
- *	      delay/prevent the copy of data, child & parent share memory, and their
- *	      duplication of the address of child & parent are shared read-only. For parent
- *	      & child to have its very own separate space, both must write to their own data.
- *	      So this function will deal with the write for the child process created
- *	      by fork().
- *	OUTPUT: Return 1 if success,
- *		       0 if failed.
- * ======================================================================================== */
-int handle_COW(void)
-{
-	int return_value = 0;	// default return = true
-	intptr_t incr = MALLOC_SIZE;	// 64KB
-	char *src = NULL;	// to hold adrr return from sbrk(incr)
-	char *i;		// loop counter
-
-	// error handling: Make sure the start_addr is not NULL
-	if (start_addr == NULL) {
-		user_error("start_addr from parent is not initialized");
-		goto OUT;
-	}
-	// error handling: Make sure the end_addr is not NULL
-	if (end_addr == NULL) {
-		user_error("end_addr from parent is not initialized");
-		goto OUT;
-	}
-	// Writing to heap
-	if (start_addr < end_addr) {	// Heap grows up to higher address
-		for (i = start_addr; i < end_addr; i += PAGE_SIZE) {
-			if ((freeswap() + freeram()) < COMMITTED_AS)
-				goto OUT;
-			*i = 'u';
-		}
-		return_value = 1;
-	} else if (start_addr > end_addr) {	// Heap grows down to lower address
-		for (i = end_addr; i > start_addr; i -= PAGE_SIZE) {
-			if ((freeswap() + freeram()) < COMMITTED_AS)
-				goto OUT;
-			*i = 'd';
-		}
-		return_value = 1;
-	} else;			// Heap doesn't grows
-
-OUT:
-	return return_value;
-}
-
-/* ========================================================================================
- *	EAT lots and lots of memory...
- *	- If a process can eat all of the free resouces
- *	  specified, that process will exit the program.
- * ======================================================================================== */
-void eat_mem(void)
-{
-	// saving the current heap pointer befoer start to allocate more memory
-	start_addr = NULL;
-	end_addr = NULL;
-	start_addr = sbrk(0);
-
-	// eating memory
-	while ((freeswap() + freeram()) > COMMITTED_AS) {
-		if (!malloc_data())
-			return;
-	}
-
-	print_sysinfo();
-	exit(0);
-}
-
-/* ========================================================================================
- *	EAT lots and lots of memory...If a process can eat all of the free resouces
- *	specified, that process will exit the program
- * ======================================================================================== */
-void eat_mem_no_exit(void)
-{
-	// saving the current heap pointer befoer start to allocate more memory
-	start_addr = NULL;
-	end_addr = NULL;
-	start_addr = sbrk(0);
-
-	// eating memory
-	while ((freeswap() + freeram()) > COMMITTED_AS) {
-		if (!malloc_data())
-			break;
-	}
-}
-
-///////////////////////////////////////////////////////////////////////////////////////////////////
-
-///////////////////////////////// MAIN PROGRAM ////////////////////////////////////////////////////
-int main(int argc, char **argv)
-{
-	pid_t pid;		// used for fork()
-	print_sysinfo();	// sytem resouces before start allocation
-	set_sbrk_num(0);	// at start of process, ensure sbrk_num is set
-	eat_mem();
-
-	// @beyound this point -> 1 process can't consume all memory so it must fork a child to consume more
-	// memory
-START:
-	pid = fork();
-	pid = pid < 0 ? -1 : pid;
-
-	switch (pid) {
-	case -1:
-		if (!dealloc_data())
-			unix_error
-			    ("SBRK(-incr) FROM DEALLOC_DATA() FAILED. FATAL!!!");
-		goto LAST_CONDITION;
-
-	case 0:
-		if (!handle_COW()) {	// Re-touch child pages
-			print_sysinfo();	// FINAL RESULT, LAST RESOURCES
-			exit(0);	// child can't allocate no more, DONE!!!
-		}
-		goto START;
-
-	default:
-		if (waitpid(-1, NULL, 0) != pid)	// Parent Waiting
-			unix_error("WAIT_PID FAILED. FATAL!!!");
-		exit(0);
-	}
-
-LAST_CONDITION:
-	TELL_WAIT();		// set up parent/child signal handler
-	pid = fork();
-	pid = pid < 0 ? -1 : pid;
-
-	switch (pid) {
-	case -1:
-		unix_error("FORK FAILED.");
-
-	case 0:
-		eat_mem_no_exit();
-		WAIT_PARENT();
-		print_sysinfo();	// FINAL RESULT, LAST RESOUCES
-		TELL_PARENT(getppid());
-		exit(0);
-
-	default:
-		eat_mem_no_exit();
-		TELL_CHILD(pid);
-		WAIT_CHILD();
-		exit(0);
-	}
-}
-
-///////////////////////////////////////////////////////////////////////////////////////////////////////////////
diff --git a/tools/pounder21/src/memtest.patch b/tools/pounder21/src/memtest.patch
deleted file mode 100644
index dd46b8162..000000000
--- a/tools/pounder21/src/memtest.patch
+++ /dev/null
@@ -1,37 +0,0 @@
---- memtest.sh.orig	2004-09-16 11:29:13.000000000 -0700
-+++ memtest.sh	2004-09-16 11:30:50.000000000 -0700
-@@ -74,21 +74,21 @@
- cd $TEST_DIR
-
- # Remove any possible left over directories from a cancelled previous run
--rm -fr linux linux.orig linux.pass.*
-+rm -fr linux-2.6.18 linux.orig linux.pass.*
-
- # Unpack the one copy of the source tree that we will be comparing against
- tar -xzf $SOURCE_FILE
--mv linux linux.orig
-+mv linux-2.6.18 linux.orig
-
- i=0
- while [ "$i" -lt "$NR_PASSES" ]; do
- j=0
- while [ "$j" -lt "$NR_SIMULTANEOUS" ]; do
- if [ $PARALLEL = "yes" ]; then
--(mkdir $j; tar -xzf $SOURCE_FILE -C $j; mv $j/linux linux.pass.$j; rmdir $j) &
-+(mkdir $j; tar -xzf $SOURCE_FILE -C $j; mv $j/linux-2.6.18 linux.pass.$j; rmdir $j) &
- else
- tar -xzf $SOURCE_FILE
--mv linux linux.pass.$j
-+mv linux-2.6.18 linux.pass.$j
- fi
- j=`expr $j + 1`
- done
-@@ -108,7 +108,7 @@
- done
-
- # Clean up after ourselves
--rm -fr linux linux.orig linux.pass.*
-+rm -fr linux-2.6.18 linux.orig linux.pass.*
-
-
-
diff --git a/tools/pounder21/src/memxfer5b/Makefile b/tools/pounder21/src/memxfer5b/Makefile
deleted file mode 100644
index 172391b76..000000000
--- a/tools/pounder21/src/memxfer5b/Makefile
+++ /dev/null
@@ -1,27 +0,0 @@
-# Makefile for memory streaming benchmark
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-CFLAGS += -O3
-bins = memxfer5b
-
-all: ${bins}
-
-clean:
-	rm -f ${bins}
diff --git a/tools/pounder21/src/memxfer5b/memxfer5b.c b/tools/pounder21/src/memxfer5b/memxfer5b.c
deleted file mode 100644
index c76201490..000000000
--- a/tools/pounder21/src/memxfer5b/memxfer5b.c
+++ /dev/null
@@ -1,338 +0,0 @@
-/* Memory streaming benchmark */
-
-/*
- * Copyright (C) 2003-2006 IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#define __int64 long long
-#include <sys/time.h>
-#define SLASHC		'/'
-#define SLASHSTR	"/"
-#include <sys/types.h>
-#include <string.h>
-#include <stddef.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <ctype.h>
-
-#define equal !strcmp
-
-size_t atoik(char *);
-void *Malloc(size_t sz);
-void tstart(void);
-void tend(void);
-double tval(void);
-
-char *methods[] = {
-	"\"memcpy\"",
-	"\"char *\"",
-	"\"short *\"",
-	"\"int *\"",
-	"\"long *\"",
-	"\"__int64 *\"",
-	"\"double *\"",
-};
-
-int nmethods = sizeof(methods) / sizeof(methods[0]);
-
-int fflag = 0;			// if 0, then just Malloc once; else malloc/free each time
-int wflag = 0;			// if 1, call SetProcessWorkingSetSize() (WINDOWS ONLY)
-int sflag = 0;			// if 1, only print averages.
-int pflag = 0;
-int csvflag = 0;		// Print Comma separated list for spreadsheet input.
-char *progname;
-
-double tottim = 0.0;
-
-int main(int ac, char *av[])
-{
-	size_t size;
-	int i;
-	unsigned ui;
-	size_t j;
-	unsigned cnt;
-	int method = 0;
-	char *p1, *p2;
-	char *p, *q;
-	short *sp, *sq;
-	int *ip, *iq;
-	long *lp, *lq;
-	__int64 *llp, *llq;
-	double *dp, *dq;
-	double t;
-
-	progname = av[0];
-	if (strrchr(progname, SLASHC))
-		progname = strrchr(progname, SLASHC) + 1;
-
-	while (ac > 1) {
-		if (equal(av[1], "-f")) {
-			ac--;
-			fflag = 1;
-			av++;
-		} else if (equal(av[1], "-w")) {
-			ac--;
-			wflag = 1;
-			av++;
-		} else if (equal(av[1], "-s")) {
-			ac--;
-			sflag = 1;
-			av++;
-		} else if (equal(av[1], "-p")) {
-			ac--;
-			pflag = 1;
-			av++;
-		} else if (equal(av[1], "-csv")) {
-			ac--;
-			csvflag++;
-			av++;
-		} else
-			break;
-	}
-	if (ac < 3) {
-		(void)
-		    printf("Usage: %s [-f] [-w] [-s] [-p] size cnt [method]\n",
-			   progname);
-		(void)
-		    printf
-		    ("\t-f flag says to malloc and free of the \"cnt\" times.\n");
-		(void)
-		    printf
-		    ("\t-w = set process min and max working set size to \"size\"\n");
-		(void)printf("\t-s = silent; only print averages\n");
-		(void)
-		    printf
-		    ("\t-p = prep; \"freshen\" cache before; -w disables\n");
-		(void)printf("\t-csv = print output in CSV format\n");
-
-		(void)printf("\tmethods:\n");
-		for (i = 0; i < nmethods; i++)
-			printf("\t%2d:\t%s\n", i, methods[i]);
-		return 0;
-	}
-
-	size = atoik(av[1]);
-
-	//
-	// Round size up to 4*sizeof(double) bytes.
-	//
-	if (size != ((size / (4 * sizeof(double))) * (4 * sizeof(double)))) {
-		size += (4 * sizeof(double));
-		size /= (4 * sizeof(double));
-		size *= (4 * sizeof(double));
-	}
-	cnt = (unsigned)atoik(av[2]);
-
-	if (fflag == 0) {
-		p1 = (char *)Malloc(size);
-		p2 = (char *)Malloc(size);
-		if (pflag)
-			memcpy(p1, p2, size);
-	}
-
-	printf("%s ", progname);
-	if (fflag)
-		printf("-f ");
-	if (wflag)
-		printf("-w ");
-	if (sflag)
-		printf("-s ");
-	if (pflag)
-		printf("-p ");
-	if (csvflag)
-		printf("-csv ");
-	printf("%u %u ", size, cnt);
-	if (csvflag) {
-		printf("Linux");
-	}
-	printf("\n");
-
-	if (ac == 3) {
-		ac = 4;
-		av[3] = "0";
-	}
-
-	for (; ac > 3; ac--, av++) {
-		if (isdigit(*av[3]))
-			method = *av[3] - '0';
-		if (method < 0 || method >= nmethods)
-			method = 0;
-		if (sflag)
-			tstart();
-		for (ui = 0; ui < cnt; ui++) {
-			if (!sflag) {
-				(void)printf("%s %d %d %-18.18s\t",
-					     progname, size, cnt,
-					     methods[method]);
-				tstart();
-			}
-			if (fflag == 1) {
-				p1 = (char *)Malloc(size);
-				p2 = (char *)Malloc(size);
-			}
-			switch (method) {
-			case 0:
-				(void)memcpy(p1, p2, size);
-				break;
-			case 1:
-				p = p1;
-				q = p2;
-				for (j = 0; j < size; j++)
-					*p++ = *q++;
-				break;
-			case 2:
-				sp = (short *)p1;
-				sq = (short *)p2;
-				for (j = 0; j < size; j += sizeof(short))
-					*sp++ = *sq++;
-				break;
-			case 3:
-				ip = (int *)p1;
-				iq = (int *)p2;
-				for (j = 0; j < size; j += sizeof(int))
-					*ip++ = *iq++;
-				break;
-			case 4:
-				lp = (long *)p1;
-				lq = (long *)p2;
-				for (j = 0; j < size; j += sizeof(long))
-					*lp++ = *lq++;
-				break;
-			case 5:
-				llp = (__int64 *) p1;
-				llq = (__int64 *) p2;
-				for (j = 0; j < size; j += sizeof(__int64))
-					*llp++ = *llq++;
-				break;
-			case 6:
-				dp = (double *)p1;
-				dq = (double *)p2;
-				for (j = 0; j < size; j += 4 * sizeof(double)) {
-					*dp++ = *dq++;
-					*dp++ = *dq++;
-					*dp++ = *dq++;
-					*dp++ = *dq++;
-				}
-				break;
-
-			}
-			if (fflag == 1) {
-				free(p1);
-				free(p2);
-			}
-			if (!sflag) {
-				tend();
-				t = tval();
-				tottim += t;
-				if (t == 0.0)
-					t = .0001;
-				printf(" %8.6f seconds %8.3f MB/s\n",
-				       t, (double)size / t / 1000000.);
-			}
-		}
-		if (sflag) {
-			tend();
-			tottim = tval();
-		}
-		if (csvflag) {
-			printf("%s,%u,%u,%8.3f,%8.3f\n",
-			       methods[method], size, size * cnt, tottim,
-			       (double)size / (tottim / cnt) / 1000000.);
-		} else {
-			(void)printf("\tAVG: %d %-18.18s\t", size,
-				     methods[method]);
-			(void)printf(" %8.3f MB/s\n",
-				     (double)size / (tottim / cnt) / 1000000.);
-		}
-		tottim = 0.0;
-	}
-	return 0;
-}
-
-size_t atoik(char *s)
-{
-	size_t ret = 0;
-	size_t base;
-
-	if (*s == '0') {
-		base = 8;
-		if (*++s == 'x' || *s == 'X') {
-			base = 16;
-			s++;
-		}
-	} else
-		base = 10;
-
-	for (; isxdigit(*s); s++) {
-		if (base == 16)
-			if (isalpha(*s))
-				ret = base * ret + (toupper(*s) - 'A');
-			else
-				ret = base * ret + (*s - '0');
-		else if (isdigit(*s))
-			ret = base * ret + (*s - '0');
-		else
-			break;
-	}
-	for (; isalpha(*s); s++) {
-		switch (toupper(*s)) {
-		case 'K':
-			ret *= 1024;
-			break;
-		case 'M':
-			ret *= 1024 * 1024;
-			break;
-		default:
-			return ret;
-		}
-	}
-	return ret;
-}
-
-void *Malloc(size_t sz)
-{
-	char *p;
-
-	p = (char *)malloc(sz);
-	if (p == NULL) {
-		(void)printf("malloc(%d) failed\n", sz);
-		exit(1);
-	}
-	return (void *)p;
-}
-
-static struct timeval _tstart, _tend;
-
-void tstart(void)
-{
-	gettimeofday(&_tstart, NULL);
-}
-
-void tend(void)
-{
-	gettimeofday(&_tend, NULL);
-}
-
-double tval()
-{
-	double t1, t2;
-
-	t1 = (double)_tstart.tv_sec + (double)_tstart.tv_usec / (1000 * 1000);
-	t2 = (double)_tend.tv_sec + (double)_tend.tv_usec / (1000 * 1000);
-	return t2 - t1;
-}
diff --git a/tools/pounder21/src/ramsnake/Makefile b/tools/pounder21/src/ramsnake/Makefile
deleted file mode 100644
index e22d33504..000000000
--- a/tools/pounder21/src/ramsnake/Makefile
+++ /dev/null
@@ -1,30 +0,0 @@
-# Build shared memory stress test
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-CFLAGS += -O3 -Wall
-bins = snake.exe
-
-all: ${bins}
-
-snake.exe: snake.c
-	$(CC) $(CFLAGS) -o snake.exe $<
-
-clean:
-	rm -f ${bins}
diff --git a/tools/pounder21/src/ramsnake/snake.c b/tools/pounder21/src/ramsnake/snake.c
deleted file mode 100644
index 4a2f49bfb..000000000
--- a/tools/pounder21/src/ramsnake/snake.c
+++ /dev/null
@@ -1,313 +0,0 @@
-
-/*
- * Cheesy program to create a "graph" of nodes, spawn threads and
- * walk the graph.
- */
-
-/*
- * Copyright (C) 2003-2006 IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#define _GNU_SOURCE
-#include <sys/mman.h>
-#include <malloc.h>
-#include <sys/sysinfo.h>
-#include <limits.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <signal.h>
-#include <sys/time.h>
-#include <strings.h>
-#include <time.h>
-//#define __USE_GNU
-#include <sched.h>
-
-static int seed_random(void);
-static void populate_graph(void *region, unsigned long long node_count);
-static void alarm_func(int signum);
-static void print_help(const char *name);
-
-static struct timeval last;
-volatile unsigned long speed = 0;
-static unsigned long report_interval = 30;
-
-/*
- * A quick note: each graph "node" consists of some pointer off to another
- * part of the graph array.
- */
-
-static void print_help(const char *name)
-{
-	printf
-	    ("Usage: %s [-p num_threads] [-d ram_divisor | -n num_nodes] [-s report_intrvl] [-a add_intrvl] [-t]\n",
-	     name);
-	printf
-	    ("-d ram_divisor:	Use (total_ram / ram_divisor) as a graph (16).\n");
-	printf("-p num_threads:	Start up some number of threads (1).\n");
-	printf("-n num_nodes:	Create a graph with some number of nodes.\n");
-	printf("-s report_intvl	Seconds between speed reports (30).\n");
-	printf("-a add_intrvl:	Seconds between adding children (never).\n");
-#ifdef __cpu_set_t_defined
-	printf
-	    ("-t:		Assign each process to its own processor (no).\n");
-#else
-	printf("-t:		Not enabled because you need kernel 2.5.8+.\n");
-#endif
-}
-
-static void populate_graph(void *graph, unsigned long long node_count)
-{
-	unsigned long i;
-	void **ptr;
-	unsigned long gunk;
-
-	seed_random();
-
-	/* Each cell of the array points to another place in the array. */
-	for (i = 0, ptr = graph; i < node_count; i++, ptr++) {
-		gunk = (node_count - 1) * (rand() / (RAND_MAX + 1.0));
-		*ptr = (void *)(graph + (gunk * sizeof(void *)));
-	}
-}
-
-static int seed_random(void)
-{
-	int fp;
-	long seed;
-
-	fp = open("/dev/urandom", O_RDONLY);
-	if (fp < 0) {
-		perror("/dev/urandom");
-		return 0;
-	}
-
-	if (read(fp, &seed, sizeof(seed)) != sizeof(seed)) {
-		perror("read random seed");
-		return 0;
-	}
-
-	close(fp);
-	srand(seed);
-
-	return 1;
-}
-
-static void alarm_func(int signum)
-{
-	struct timeval now;
-	float time;
-
-	gettimeofday(&now, NULL);
-	time = (now.tv_usec + (now.tv_sec * 1000000))
-	    - (last.tv_usec + (last.tv_sec * 1000000));
-	time /= 1000000;
-
-	printf("%d: %.0f nodes/sec.\n", getpid(), speed / time);
-	fflush(stdout);
-	speed = 0;
-	last = now;
-
-	alarm(report_interval);
-}
-
-static void walk_graph(void *graph)
-{
-	void **curr = graph;
-
-	while (1) {
-		curr = *curr;
-		speed++;
-	}
-}
-
-int main(int argc, char *argv[])
-{
-	unsigned long long num_nodes, ram_size;
-	unsigned long num_forks = 1;
-	struct sysinfo info;
-	void *shm;
-	int *cond;
-	struct sigaction zig;
-	int c, add_wait = -1, is_parent = 1;
-#ifdef __cpu_set_t_defined
-	int affinity = 0;
-	cpu_set_t my_cpu_mask;
-#endif
-
-	/* By default we'll use 1/16th of total RAM, rounded
-	 * down to the nearest page. */
-	if (sysinfo(&info) != 0) {
-		perror("sysinfo");
-		return 1;
-	}
-
-	ram_size = info.totalram / 16;
-	ram_size = ram_size & ~(getpagesize() - 1);
-	num_nodes = ram_size / sizeof(void *);
-
-	/* Parse command line args */
-	while ((c = getopt(argc, argv, "a:p:n:d:s:t")) != -1) {
-		switch (c) {
-		case 'p':
-			num_forks = atoi(optarg);
-			break;
-		case 'd':
-			ram_size = info.totalram / atoi(optarg);
-			ram_size = ram_size & ~(getpagesize() - 1);
-			num_nodes = ram_size / sizeof(void *);
-			break;
-		case 'n':
-			num_nodes = atoi(optarg);
-			ram_size = num_nodes * sizeof(void *);
-			break;
-		case 's':
-			report_interval = atoi(optarg);
-			break;
-		case 'a':
-			add_wait = atoi(optarg);
-			break;
-#ifdef __cpu_set_t_defined
-		case 't':
-			affinity = 1;
-			break;
-#endif
-		default:
-			print_help(argv[0]);
-			return 0;
-		}
-	}
-
-	/* Will we exceed half the address space size?  Use 1/4 of it@most.  */
-	if (ram_size > ((unsigned long long)1 << ((sizeof(void *) * 8) - 1))) {
-		printf
-		    ("Was going to use %lluKB (%llu nodes) but that's too big.\n",
-		     ram_size / 1024, num_nodes);
-		ram_size = ((unsigned long long)1 << (sizeof(void *) * 8));
-		ram_size /= 4;
-		num_nodes = ram_size / sizeof(void *);
-		printf("Clamping to %lluKB (%llu nodes) instead.\n",
-		       ram_size / 1024, num_nodes);
-	}
-
-	/* Talk about what we're going to do. */
-	printf("Going to use %lluKB (%llu nodes).\n", ram_size / 1024,
-	       num_nodes);
-
-	/* Make a shared anonymous map of the RAM */
-	shm = mmap(NULL, ram_size, PROT_READ | PROT_WRITE,
-		   MAP_SHARED | MAP_ANONYMOUS, 0, 0);
-	if (shm == MAP_FAILED) {
-		perror("mmap");
-		return 2;
-	}
-	printf("mmap region: %p (%llu nodes)\n", shm, num_nodes);
-
-	/* Create an SHM condition variable.  Bogus, I know... */
-	cond = mmap(NULL, sizeof(int), PROT_READ | PROT_WRITE,
-		    MAP_SHARED | MAP_ANONYMOUS, 0, 0);
-	if (cond == MAP_FAILED) {
-		perror("mmap");
-		return 4;
-	}
-	*cond = 1;
-
-	/* Create a "graph" by populating it with random pointers. */
-	printf("Populating nodes...");
-	fflush(stdout);
-	populate_graph(shm, num_nodes);
-	printf("done.\n");
-
-	printf("Creating %lu processes with reports every %lu seconds \
-and %d seconds between adding children.\n", num_forks, report_interval, add_wait);
-
-	/* Fork off separate processes.  The shared region is shared
-	 * across all children.  If we only wanted one thread, we shouldn't
-	 * fork anything.  Note that the "cond" mmap is a really crappy
-	 * condition variable kludge that works well enough for HERE ONLY. */
-	for (c = (add_wait >= 0 ? 0 : 1); c < num_forks; c++) {
-		/* Child should wait for the condition and then break. */
-		if (!fork()) {
-#ifdef __cpu_set_t_defined
-			if (affinity) {
-				CPU_ZERO(&my_cpu_mask);
-				CPU_SET(c, &my_cpu_mask);
-				if (0 !=
-				    sched_setaffinity(0, sizeof(cpu_set_t),
-						      &my_cpu_mask)) {
-					perror("sched_setaffinity");
-				}
-			}
-#endif
-
-			is_parent = 0;
-			while (*cond) {
-				usleep(10000);
-			}
-			break;
-		}
-	}
-	if (is_parent) {
-#ifdef __cpu_set_t_defined
-		if (affinity) {
-			CPU_ZERO(&my_cpu_mask);
-			CPU_SET(0, &my_cpu_mask);
-			if (0 !=
-			    sched_setaffinity(0, sizeof(cpu_set_t),
-					      &my_cpu_mask)) {
-				perror("sched_setaffinity");
-			}
-		}
-#endif
-		printf("All threads created.  Launching!\n");
-		*cond = 0;
-	}
-
-	/* now start the work */
-	if (!is_parent) {
-start_thread:
-		/* Set up the alarm handler to print speed info. */
-		memset(&zig, 0x00, sizeof(zig));
-		zig.sa_handler = alarm_func;
-		sigaction(SIGALRM, &zig, NULL);
-		gettimeofday(&last, NULL);
-		alarm(report_interval);
-
-		/* Walk the graph. */
-		walk_graph(shm);
-
-		/* This function never returns */
-	} else {
-		/* Start the ramp-up.  The children will never die,
-		 * so we don't need to wait() for 'em.
-		 */
-		while (add_wait != -1) {
-			sleep(add_wait);
-			if (fork() == 0) {
-				/* goto is cheesy, but works. */
-				goto start_thread;
-			} else {
-				printf("Added thread.\n");
-			}
-		}
-		goto start_thread;
-	}
-
-	return 0;
-}
diff --git a/tools/pounder21/src/randacoords/Makefile b/tools/pounder21/src/randacoords/Makefile
deleted file mode 100644
index 9081ca0fd..000000000
--- a/tools/pounder21/src/randacoords/Makefile
+++ /dev/null
@@ -1,27 +0,0 @@
-# Build program to generate random coordinates
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-CFLAGS += -O3 -Wall
-bins = coords
-
-all: ${bins}
-
-clean:
-	rm -f ${bins}
diff --git a/tools/pounder21/src/randacoords/coords.c b/tools/pounder21/src/randacoords/coords.c
deleted file mode 100644
index 6b290f06d..000000000
--- a/tools/pounder21/src/randacoords/coords.c
+++ /dev/null
@@ -1,73 +0,0 @@
-/* Generate window size/position coordinates for -geometry switches */
-
-/*
- * Copyright (C) 2003-2006 IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <unistd.h>
-#include <limits.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <stdlib.h>
-
-int seed_random(void)
-{
-	int fp;
-	long seed;
-
-	fp = open("/dev/urandom", O_RDONLY);
-	if (fp < 0) {
-		perror("/dev/urandom");
-		return 0;
-	}
-
-	if (read(fp, &seed, sizeof(seed)) != sizeof(seed)) {
-		perror("read random seed");
-		return 0;
-	}
-
-	close(fp);
-	srand(seed);
-
-	return 1;
-}
-
-int main(int argc, char *argv[])
-{
-	unsigned long xmax, ymax;
-	unsigned long x, y;
-
-	if (argc < 3) {
-		fprintf(stderr, "Usage: %s xmax ymax\n", argv[0]);
-		return 2;
-	}
-
-	xmax = atoi(argv[1]);
-	ymax = atoi(argv[2]);
-
-	if (!seed_random()) {
-		return 1;
-	}
-
-	x = 1 + (unsigned long)((float)xmax * (rand() / (RAND_MAX + 1.0f)));
-	y = 1 + (unsigned long)((float)ymax * (rand() / (RAND_MAX + 1.0f)));
-
-	printf("+%lu+%lu\n", x, y);
-
-	return 0;
-}
diff --git a/tools/pounder21/src/randasyscall/Makefile b/tools/pounder21/src/randasyscall/Makefile
deleted file mode 100644
index 77d1fdc30..000000000
--- a/tools/pounder21/src/randasyscall/Makefile
+++ /dev/null
@@ -1,27 +0,0 @@
-# Build the random syscall generator
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-CFLAGS += -O3 -Wall
-bins = randasys
-
-all: ${bins}
-
-clean:
-	rm -f ${bins}
diff --git a/tools/pounder21/src/randasyscall/randasys.c b/tools/pounder21/src/randasyscall/randasys.c
deleted file mode 100644
index 14cbb5a4e..000000000
--- a/tools/pounder21/src/randasyscall/randasys.c
+++ /dev/null
@@ -1,252 +0,0 @@
-/*
- * Program that makes random system calls with random arguments.
- */
-
-/*
- * Copyright (C) 2003-2006 IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <signal.h>
-#include <limits.h>
-#include <strings.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <stdio.h>
-#include <sys/syscall.h>
-#include <stdint.h>
-#include <stdlib.h>
-
-unsigned long callnum, args[6];
-
-int seed_random(void)
-{
-	int fp;
-	long seed;
-
-	fp = open("/dev/urandom", O_RDONLY);
-	if (fp < 0) {
-		perror("/dev/urandom");
-		return 0;
-	}
-
-	if (read(fp, &seed, sizeof(seed)) != sizeof(seed)) {
-		perror("read random seed");
-		return 0;
-	}
-
-	close(fp);
-	srand(seed);
-
-	return 1;
-}
-
-void get_big_randnum(void *buf, unsigned int size)
-{
-	uint32_t *x = buf;
-	int i;
-
-	for (i = 0; i < size; i += 4, x++) {
-		*x = (unsigned long)((float)UINT_MAX *
-				     (rand() / (RAND_MAX + 1.0)));
-	}
-}
-
-unsigned long get_randnum(unsigned long min, unsigned long max)
-{
-	return min + (unsigned long)((float)max * (rand() / (RAND_MAX + 1.0)));
-}
-
-int find_syscall(void)
-{
-	int x;
-
-badcall:
-	x = get_randnum(0, 384);
-
-	/* poorly implemented blacklist */
-	switch (x) {
-		/* don't screw with signal handling */
-#ifdef SYS_signal
-	case SYS_signal:
-#endif
-#ifdef SYS_sigaction
-	case SYS_sigaction:
-#endif
-#ifdef SYS_sigsuspend
-	case SYS_sigsuspend:
-#endif
-#ifdef SYS_sigpending
-	case SYS_sigpending:
-#endif
-#ifdef SYS_sigreturn
-	case SYS_sigreturn:
-#endif
-#ifdef SYS_sigprocmask
-	case SYS_sigprocmask:
-#endif
-#ifdef SYS_rt_sigreturn
-	case SYS_rt_sigreturn:
-#endif
-#ifdef SYS_rt_sigaction
-	case SYS_rt_sigaction:
-#endif
-#ifdef SYS_rt_sigprocmask
-	case SYS_rt_sigprocmask:
-#endif
-#ifdef SYS_rt_sigpending
-	case SYS_rt_sigpending:
-#endif
-#ifdef SYS_rt_sigtimedwait
-	case SYS_rt_sigtimedwait:
-#endif
-#ifdef SYS_rt_sigqueueinfo
-	case SYS_rt_sigqueueinfo:
-#endif
-#ifdef SYS_rt_sigsuspend
-	case SYS_rt_sigsuspend:
-#endif
-#ifdef SYS_sigaltstack
-	case SYS_sigaltstack:
-#endif
-#ifdef SYS_settimeofday
-	case SYS_settimeofday:
-#endif
-
-		/* don't exit the program :P */
-#ifdef SYS_exit
-	case SYS_exit:
-#endif
-#ifdef SYS_exit_group
-	case SYS_exit_group:
-#endif
-
-		/* don't put it to sleep either */
-#ifdef SYS_pause
-	case SYS_pause:
-#endif
-#ifdef SYS_select
-	case SYS_select:
-#endif
-#ifdef SYS_read
-	case SYS_read:
-#endif
-#ifdef SYS_write
-	case SYS_write:
-#endif
-
-		/* these can fill the process table */
-#ifdef SYS_fork
-	case SYS_fork:
-#endif
-#ifdef SYS_vfork
-	case SYS_vfork:
-#endif
-#ifdef SYS_clone
-	case SYS_clone:
-#endif
-
-		/* This causes OOM conditions */
-#if 1
-#ifdef SYS_brk
-	case SYS_brk:
-#endif
-#endif
-
-		/* these get our program killed */
-#ifdef SYS_vm86
-	case SYS_vm86:
-#endif
-#ifdef SYS_vm86old
-	case SYS_vm86old:
-#endif
-		goto badcall;
-	}
-
-	return x;
-}
-
-void bogus_signal_handler(int signum)
-{
-	fprintf(stderr,
-		"                                    Signal %d on syscall(%lu, 0x%lX, 0x%lX, 0x%lX, 0x%lX, 0x%lX, 0x%lX).\n",
-		signum, callnum, args[0], args[1], args[2], args[3], args[4],
-		args[5]);
-}
-
-void real_signal_handler(int signum)
-{
-	exit(0);
-}
-
-void install_signal_handlers(void)
-{
-	int x;
-	struct sigaction zig;
-
-	memset(&zig, 0x00, sizeof(zig));
-	zig.sa_handler = bogus_signal_handler;
-	for (x = 0; x < 64; x++) {
-		sigaction(x, &zig, NULL);
-	}
-
-	zig.sa_handler = real_signal_handler;
-	sigaction(SIGINT, &zig, NULL);
-	sigaction(SIGTERM, &zig, NULL);
-}
-
-int main(int argc, char *argv[])
-{
-	int i;
-	int debug = 0, zero_mode = 0;
-
-	if (!seed_random()) {
-		return 1;
-	}
-
-	for (i = 1; i < argc; i++) {
-		if (!strcmp(argv[i], "-d"))
-			debug = 1;
-		else if (!strcmp(argv[i], "-z"))
-			zero_mode = 1;
-	}
-
-	memset(args, 0, sizeof(unsigned long) * 6);
-
-	install_signal_handlers();
-
-	while (1) {
-		callnum = find_syscall();
-		if (!zero_mode)
-			get_big_randnum(&args[0], sizeof(unsigned long) * 6);
-
-		if (debug) {
-			printf("syscall(%lu, 0x%lX, 0x%lX, 0x%lX, 0x%lX, "
-			       "0x%lX, 0x%lX);       \n",
-			       callnum, args[0], args[1], args[2], args[3],
-			       args[4], args[5]);
-			fflush(stdout);
-		}
-
-		syscall(callnum, args[0], args[1], args[2],
-			args[3], args[4], args[5]);
-	}
-
-	return 0;
-}
diff --git a/tools/pounder21/src/time_tests/Makefile b/tools/pounder21/src/time_tests/Makefile
deleted file mode 100644
index 378da5935..000000000
--- a/tools/pounder21/src/time_tests/Makefile
+++ /dev/null
@@ -1,28 +0,0 @@
-# Build time tests
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-LDFLAGS += -lrt
-CFLAGS += -O3
-bins = inconsistency-check
-
-all: ${bins}
-
-clean:
-	rm -f ${bins}
diff --git a/tools/pounder21/src/time_tests/drift-test.py b/tools/pounder21/src/time_tests/drift-test.py
deleted file mode 100755
index 3fe8ba55e..000000000
--- a/tools/pounder21/src/time_tests/drift-test.py
+++ /dev/null
@@ -1,90 +0,0 @@
-#!/usr/bin/env python3
-
-# Time Drift Script
-#		Periodically checks and displays time drift
-#		by john stultz (jstultz@us.ibm.com)
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-# Usage: drift-test.py [-s] [ntp_server [sleep_time]]
-
-import subprocess
-import sys
-import string
-import time
-
-server_default = "bvrgsa.ibm.com"
-sleep_time_default  = 60
-
-server = ""
-sleep_time = 0
-set_time = 0
-
-#parse args
-for arg in sys.argv[1:]:
-	if arg == "-s":
-		set_time = 1
-	elif server == "":
-		server = arg
-	elif sleep_time == 0:
-		sleep_time = string.atoi(arg)
-
-if server == "":
-	server = server_default
-if sleep_time == 0:
-	sleep_time = sleep_time_default
-
-#set time
-if (set_time == 1):
-	cmd = subprocess.getoutput('/usr/sbin/ntpdate -ub ' + server)
-
-cmd = subprocess.getoutput('/usr/sbin/ntpdate -uq ' + server)
-line = string.split(cmd)
-
-#parse original offset
-start_offset = string.atof(line[-2]);
-#parse original time
-start_time = time.localtime(time.time())
-datestr = time.strftime("%d %b %Y %H:%M:%S", start_time)
-
-time.sleep(1)
-while 1:
-	cmd = subprocess.getoutput('/usr/sbin/ntpdate -uq ' + server)
-	line = string.split(cmd)
-
-	#parse offset
-	now_offset = string.atof(line[-2]);
-
-	#parse time
-	now_time = time.localtime(time.time())
-	datestr = time.strftime("%d %b %Y %H:%M:%S", now_time)
-
-	# calculate drift
-	delta_time = time.mktime(now_time) - time.mktime(start_time)
-	delta_offset = now_offset - start_offset
-	drift =  delta_offset / delta_time * 1000000
-
-	#print output
-	print(time.strftime("%d %b %H:%M:%S",now_time), end=' ')
-	print("	offset:", now_offset, end=' ')
-	print("	drift:", drift ,"ppm")
-	sys.stdout.flush()
-
-	#sleep
-	time.sleep(sleep_time)
diff --git a/tools/pounder21/src/time_tests/inconsistency-check.c b/tools/pounder21/src/time_tests/inconsistency-check.c
deleted file mode 100644
index 38f4b29d5..000000000
--- a/tools/pounder21/src/time_tests/inconsistency-check.c
+++ /dev/null
@@ -1,102 +0,0 @@
-/* Time inconsistency check test
- *		by: john stultz (johnstul@us.ibm.com)
- *		(C) Copyright IBM 2003, 2004, 2005
- */
-
-/*
- * Copyright (C) 2003-2006 IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <stdio.h>
-#include <time.h>
-#include <sys/time.h>
-
-#define CALLS_PER_LOOP 64
-#define NSEC_PER_SEC 1000000000ULL
-
-/* returns 1 if a <= b, 0 otherwise */
-static inline int in_order(struct timespec a, struct timespec b)
-{
-	if (a.tv_sec < b.tv_sec)
-		return 1;
-	if (a.tv_sec > b.tv_sec)
-		return 0;
-	if (a.tv_nsec > b.tv_nsec)
-		return 0;
-	return 1;
-}
-
-int main(int argc, char *argv[])
-{
-	struct timespec list[CALLS_PER_LOOP];
-	int i, inconsistent;
-	unsigned long seconds = -1;
-	long now, then;
-	int clock_type = CLOCK_MONOTONIC;
-
-	if (argc > 1)
-		seconds = atol(argv[1]);
-
-	/* make sure CLOCK_MONOTONIC is supported */
-	if (clock_gettime(clock_type, &list[0])) {
-		printf("Using CLOCK_REALTIME\n");
-		clock_type = CLOCK_REALTIME;
-	}
-
-	clock_gettime(clock_type, &list[0]);
-	now = then = list[0].tv_sec;
-
-	/* timestamp start of test */
-	system("date");
-	while (seconds == -1 || now - then < seconds) {
-		inconsistent = 0;
-
-		/* Fill list */
-		for (i = 0; i < CALLS_PER_LOOP; i++)
-			clock_gettime(clock_type, &list[i]);
-
-		/* Check for inconsistencies */
-		for (i = 0; i < CALLS_PER_LOOP - 1; i++)
-			if (!in_order(list[i], list[i + 1]))
-				inconsistent = i;
-
-		/* display inconsistency */
-		if (inconsistent) {
-			unsigned long long delta;
-			for (i = 0; i < CALLS_PER_LOOP; i++) {
-				if (i == inconsistent)
-					printf("--------------------\n");
-				printf("%lu:%lu\n", list[i].tv_sec,
-				       list[i].tv_nsec);
-				if (i == inconsistent + 1)
-					printf("--------------------\n");
-			}
-			delta = list[inconsistent].tv_sec * NSEC_PER_SEC;
-			delta += list[inconsistent].tv_nsec;
-			delta -= list[inconsistent + 1].tv_sec * NSEC_PER_SEC;
-			delta -= list[inconsistent + 1].tv_nsec;
-			printf("Delta: %llu ns\n", delta);
-			fflush(0);
-			/* timestamp inconsistency */
-			system("date");
-			return -1;
-		}
-		now = list[0].tv_sec;
-	}
-	return 0;
-}
diff --git a/tools/pounder21/src/xbonkers/Makefile b/tools/pounder21/src/xbonkers/Makefile
deleted file mode 100644
index 4ceea9f1a..000000000
--- a/tools/pounder21/src/xbonkers/Makefile
+++ /dev/null
@@ -1,28 +0,0 @@
-# Build a program to move X windows across a screen
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-CFLAGS += -O3 -Wall
-LDFLAGS=-lX11 -L/usr/X11R6/lib -L/usr/X11R6/lib64
-bins = xbonkers
-
-all: ${bins}
-
-clean:
-	rm -f ${bins}
diff --git a/tools/pounder21/src/xbonkers/xbonkers.c b/tools/pounder21/src/xbonkers/xbonkers.c
deleted file mode 100644
index 31b2e544c..000000000
--- a/tools/pounder21/src/xbonkers/xbonkers.c
+++ /dev/null
@@ -1,562 +0,0 @@
-/*
- * Add more stress to X server by moving, resizing and activating windows
- * Author: Darrick Wong <djwong@us.ibm.com>
- */
-
-/*
- * Copyright (C) 2003-2006 IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <X11/Xlib.h>
-#include <X11/Xatom.h>
-#include <string.h>
-#include <stdint.h>
-#include <limits.h>
-
-static int enable_fullscreen = 0;
-
-#define MAX_PROPERTY_VALUE_LEN	4096
-#define _NET_WM_STATE_TOGGLE	2
-#define SLIDE_THRESHOLD 	32
-
-/* We assume that the workspace number will either be -1 or some
- * huge number for "On All Workspaces" windows.  Presumably there
- * aren't 1,000,000 workspaces, so that should be a safe number.
- */
-#define DESKTOP_MAX		1000000
-
-#define ACTION_MOVE_WINDOW		0
-#define ACTION_ACTIVATE_WINDOW		1
-#define ACTION_MAXIMIZE_WINDOW		2
-#define ACTION_FULLSCREEN_WINDOW	3
-#define ACTION_HIDDEN_WINDOW		4
-#define ACTION_SLIDE_WINDOW_0		5
-#define ACTION_SLIDE_WINDOW_1		6
-#define ACTION_SLIDE_WINDOW_2		7
-#define ACTION_SLIDE_WINDOW_3		8
-#define ACTION_SLIDE_WINDOW_4		9
-#define ACTION_SLIDE_WINDOW_5		10
-#define ACTION_MIN		ACTION_MOVE_WINDOW
-#define ACTION_MAX		ACTION_SLIDE_WINDOW_5
-
-/* The goal of this program:
- * 0. Seed random number generator
- * 1. Grab the list of windows and the desktop size.
- * 2. Filter out the panel/desktop/whatever.  We're going to make
- *    a cheesy assumption that a window on desktop -1 should be left
- *    alone.  (Actually, the -1 denotes "all desktops")
- * 3. For each window:
- *    a. Figure out what we're going to do--activate, move/resize,
- *       or maximize it.
- *    b. If we're going to move/resize, grab 4 random numbers.
- *    c. Actually perform the action.
- * 4. Every so often, jump back to (2) in case there are new windows.
- *    Maybe every 10,000 moves or so.
- *
- * Note that you do NOT want to run this on any X session you care about.
- * It shouldn't take down X, but YMMV and in any case mad window resizing
- * makes it hard to get work done.
- */
-static int seed_random(void);
-static int get_desktop_size(Display * disp, unsigned long *w, unsigned long *h);
-static char *get_property(Display * disp, Window win, Atom xa_prop_type,
-			  char *prop_name, unsigned long *size,
-			  unsigned long *items);
-static void go_bonkers(Display * disp, unsigned long iterations,
-		       unsigned long sleep);
-static Window *get_interesting_windows(Display * disp,
-				       unsigned long *num_windows);
-static Window *get_client_list(Display * disp, unsigned long *size,
-			       unsigned long *items);
-static long get_randnum(long min, long max);
-static int send_client_msg(Display * disp, Window win, char *msg,
-			   unsigned long data0, unsigned long data1,
-			   unsigned long data2, unsigned long data3,
-			   unsigned long data4);
-static int activate_window(Display * disp, Window * win);
-static int wm_supports(Display * disp, const char *prop);
-static void move_window(Display * disp, Window * win, unsigned long desk_w,
-			unsigned long desk_h);
-static int toggle_property(Display * disp, Window * win, const char *property);
-static inline unsigned long clamp_value(unsigned long value,
-					unsigned long min, unsigned long max);
-static int ignore_xlib_error(Display * disp, XErrorEvent * xee);
-
-/* Actual functions begin here. */
-
-static int seed_random(void)
-{
-	int fp;
-	long seed;
-
-	fp = open("/dev/urandom", O_RDONLY);
-	if (fp < 0) {
-		perror("/dev/urandom");
-		return 0;
-	}
-
-	if (read(fp, &seed, sizeof(seed)) != sizeof(seed)) {
-		perror("read random seed");
-		return 0;
-	}
-
-	close(fp);
-	srand(seed);
-
-	return 1;
-}
-
-static int get_desktop_size(Display * disp, unsigned long *w, unsigned long *h)
-{
-	*w = DisplayWidth(disp, 0);
-	*h = DisplayHeight(disp, 0);
-
-	return 1;
-}
-
-static char *get_property(Display * disp, Window win, Atom xa_prop_type,
-			  char *prop_name, unsigned long *size,
-			  unsigned long *items)
-{
-	Atom xa_prop_name;
-	Atom xa_ret_type;
-	int ret_format;
-	unsigned long ret_nitems;
-	unsigned long ret_bytes_after;
-	unsigned long tmp_size;
-	unsigned char *ret_prop;
-	char *ret;
-
-	xa_prop_name = XInternAtom(disp, prop_name, False);
-
-	if (XGetWindowProperty
-	    (disp, win, xa_prop_name, 0, MAX_PROPERTY_VALUE_LEN / 4, False,
-	     xa_prop_type, &xa_ret_type, &ret_format, &ret_nitems,
-	     &ret_bytes_after, &ret_prop) != Success) {
-		fprintf(stderr, "Cannot get %s property.\n", prop_name);
-		return NULL;
-	}
-
-	if (xa_ret_type != xa_prop_type) {
-		fprintf(stderr, "Invalid type of %s property.\n", prop_name);
-		XFree(ret_prop);
-		return NULL;
-	}
-
-	/* XXX: EVIL HACK to get around a bug when sizeof(Window) is 8 yet ret_format
-	 * is listed as 32bits and we're trying to get the client list.  Just double
-	 * ret_format and proceed. */
-	if (ret_format == 32 && strcmp(prop_name, "_NET_CLIENT_LIST") == 0 &&
-	    sizeof(Window) == 8) {
-		ret_format *= 2;
-	}
-
-	/* null terminate the result to make string handling easier */
-	tmp_size = (ret_format / 8) * ret_nitems;
-	ret = calloc(tmp_size + 1, 1);
-	if (!ret) {
-		perror("get_property malloc failed");
-		return NULL;
-	}
-	memcpy(ret, ret_prop, tmp_size);
-	ret[tmp_size] = '\0';
-
-	if (size) {
-		*size = ret_format / 8;
-	}
-	if (items) {
-		*items = ret_nitems;
-	}
-
-	XFree(ret_prop);
-	return ret;
-}
-
-static long get_randnum(long min, long max)
-{
-	return min + (long)((float)max * (rand() / (RAND_MAX + 1.0)));
-}
-
-static int wm_supports(Display * disp, const char *prop)
-{
-	Atom xa_prop = XInternAtom(disp, prop, False);
-	Atom *list;
-	unsigned long size, items;
-	int i;
-
-	if (!(list = (Atom *) get_property(disp, DefaultRootWindow(disp),
-					   XA_ATOM, "_NET_SUPPORTED", &size,
-					   &items))) {
-		fprintf(stderr, "Cannot get _NET_SUPPORTED property.\n");
-		return 0;
-	}
-
-	size *= items;
-
-	for (i = 0; i < size / sizeof(Atom); i++) {
-		if (list[i] == xa_prop) {
-			free(list);
-			return 1;
-		}
-	}
-
-	free(list);
-	return 0;
-}
-
-static inline unsigned long clamp_value(unsigned long value,
-					unsigned long min, unsigned long max)
-{
-	return (value < min ? min : (value > max ? max : value));
-}
-
-static int ignore_xlib_error(Display * disp, XErrorEvent * xee)
-{
-	char errbuf[256];
-
-	XGetErrorText(disp, xee->error_code, errbuf, 256);
-	fprintf(stderr,
-		"IGNORING Xlib error %d (%s) on request (%d.%d), sernum = %lu.\n",
-		xee->error_code, errbuf, xee->request_code, xee->minor_code,
-		xee->serial);
-	return 1;
-}
-
-static void slide_window(Display * disp, Window * win, unsigned long desk_w,
-			 unsigned long desk_h)
-{
-	unsigned long x, y;
-	unsigned long w, h;
-	XWindowAttributes moo;
-	Window junk;
-
-	if (XGetWindowAttributes(disp, *win, &moo) != 1) {
-		fprintf(stderr, "Cannot get attributes of window 0x%lx.\n",
-			*win);
-		return;
-	}
-
-	if (XTranslateCoordinates(disp, *win, moo.root,
-				  -moo.border_width, -moo.border_width, &moo.x,
-				  &moo.y, &junk) != 1) {
-		fprintf(stderr,
-			"Cannot translate coordinates of window 0x%lx.\n",
-			*win);
-		return;
-	}
-
-	x = moo.x + get_randnum(-SLIDE_THRESHOLD, SLIDE_THRESHOLD);
-	y = moo.y + get_randnum(-SLIDE_THRESHOLD, SLIDE_THRESHOLD);
-	w = moo.width + get_randnum(-SLIDE_THRESHOLD, SLIDE_THRESHOLD);
-	h = moo.height + get_randnum(-SLIDE_THRESHOLD, SLIDE_THRESHOLD);
-
-	x = clamp_value(x, 0, desk_w);
-	y = clamp_value(y, 0, desk_h);
-	w = clamp_value(w, 0, desk_w);
-	h = clamp_value(h, 0, desk_h);
-
-	if (wm_supports(disp, "_NET_MOVERESIZE_WINDOW")) {
-		send_client_msg(disp, *win, "_NET_MOVERESIZE_WINDOW",
-				0, x, y, w, h);
-	} else {
-		XMoveResizeWindow(disp, *win, x, y, w, h);
-	}
-}
-
-static void move_window(Display * disp, Window * win, unsigned long desk_w,
-			unsigned long desk_h)
-{
-	unsigned long x, y, w, h;
-
-	x = get_randnum(0, desk_w);
-	y = get_randnum(0, desk_h);
-	w = get_randnum(150, desk_w);
-	h = get_randnum(150, desk_h);
-
-	if (wm_supports(disp, "_NET_MOVERESIZE_WINDOW")) {
-		send_client_msg(disp, *win, "_NET_MOVERESIZE_WINDOW",
-				0, x, y, w, h);
-	} else {
-		XMoveResizeWindow(disp, *win, x, y, w, h);
-	}
-}
-
-static int toggle_property(Display * disp, Window * win, const char *property)
-{
-	Atom prop;
-
-	prop = XInternAtom(disp, property, False);
-	return send_client_msg(disp, *win, "_NET_WM_STATE",
-			       _NET_WM_STATE_TOGGLE, prop, 0, 0, 0);
-}
-
-static void go_bonkers(Display * disp, unsigned long iterations,
-		       unsigned long sleep)
-{
-	unsigned long desk_w, desk_h;
-	Window *windows, *window;
-	unsigned long windows_length = 0, i;
-
-	if (!get_desktop_size(disp, &desk_w, &desk_h)) {
-		fprintf(stderr, "WARNING: Assuming desktop to be 1024x768!\n");
-		desk_w = 1024;
-		desk_h = 768;
-	}
-	printf("Desktop is %lu by %lu.\n", desk_w, desk_h);
-
-	windows = get_interesting_windows(disp, &windows_length);
-	if (!windows) {
-		usleep(1000000);
-		return;
-	}
-	printf("There are %lu interesting windows.\n", windows_length);
-
-	/* Bump up the iteration count so that all windows get
-	 * some exercise. */
-	iterations += iterations % windows_length;
-
-	for (i = 0; i < iterations; i++) {
-		window = &windows[i % windows_length];
-		switch (get_randnum(ACTION_MIN, ACTION_MAX)) {
-		case ACTION_MOVE_WINDOW:
-			move_window(disp, window, desk_w, desk_h);
-			break;
-		case ACTION_ACTIVATE_WINDOW:
-			activate_window(disp, window);
-			break;
-		case ACTION_MAXIMIZE_WINDOW:
-			toggle_property(disp, window,
-					"_NET_WM_STATE_MAXIMIZED_VERT");
-			toggle_property(disp, window,
-					"_NET_WM_STATE_MAXIMIZED_HORZ");
-			break;
-		case ACTION_FULLSCREEN_WINDOW:
-			if (!enable_fullscreen)
-				break;
-			toggle_property(disp, window,
-					"_NET_WM_STATE_FULLSCREEN");
-			break;
-		case ACTION_HIDDEN_WINDOW:
-			toggle_property(disp, window, "_NET_WM_STATE_HIDDEN");
-			break;
-		case ACTION_SLIDE_WINDOW_0:
-		case ACTION_SLIDE_WINDOW_1:
-		case ACTION_SLIDE_WINDOW_2:
-		case ACTION_SLIDE_WINDOW_3:
-		case ACTION_SLIDE_WINDOW_4:
-		case ACTION_SLIDE_WINDOW_5:
-			slide_window(disp, window, desk_w, desk_h);
-			break;
-		}
-		usleep(sleep);
-	}
-
-	free(windows);
-}
-
-static int send_client_msg(Display * disp, Window win, char *msg,
-			   unsigned long data0, unsigned long data1,
-			   unsigned long data2, unsigned long data3,
-			   unsigned long data4)
-{
-	XEvent event;
-	long mask = SubstructureRedirectMask | SubstructureNotifyMask;
-
-	event.xclient.type = ClientMessage;
-	event.xclient.serial = 0;
-	event.xclient.send_event = True;
-	event.xclient.message_type = XInternAtom(disp, msg, False);
-	event.xclient.window = win;
-	event.xclient.format = 32;
-	event.xclient.data.l[0] = data0;
-	event.xclient.data.l[1] = data1;
-	event.xclient.data.l[2] = data2;
-	event.xclient.data.l[3] = data3;
-	event.xclient.data.l[4] = data4;
-
-	if (XSendEvent(disp, DefaultRootWindow(disp), False, mask, &event)) {
-		return 1;
-	} else {
-		fprintf(stderr, "Cannot send %s event.\n", msg);
-		return 0;
-	}
-}
-
-static int activate_window(Display * disp, Window * win)
-{
-	int ret;
-
-	ret = send_client_msg(disp, *win, "_NET_ACTIVE_WINDOW", 0, 0, 0, 0, 0);
-	XMapRaised(disp, *win);
-
-	return ret;
-}
-
-static Window *get_client_list(Display * disp, unsigned long *size,
-			       unsigned long *items)
-{
-	void *res;
-
-	if ((res = (Window *) get_property(disp, DefaultRootWindow(disp),
-					   XA_WINDOW, "_NET_CLIENT_LIST", size,
-					   items)) == NULL) {
-		if ((res =
-		     (Window *) get_property(disp, DefaultRootWindow(disp),
-					     XA_CARDINAL, "_WIN_CLIENT_LIST",
-					     size, items)) == NULL) {
-			fprintf(stderr,
-				"Cannot get client list properties. \n"
-				"(_NET_CLIENT_LIST or _WIN_CLIENT_LIST)" "\n");
-			return NULL;
-		}
-	}
-
-	return (Window *) res;
-}
-
-static Window *get_interesting_windows(Display * disp,
-				       unsigned long *num_windows)
-{
-	Window *client_list, *ret, *tmp;
-	unsigned long client_list_size, client_list_items, i;
-	long *desktop;
-	unsigned long num_needed = 0;
-
-	if ((client_list = get_client_list(disp, &client_list_size,
-					   &client_list_items)) == NULL) {
-		return NULL;
-	}
-
-	/* Figure out how many Window structs we'll ultimately need. */
-	for (i = 0; i < client_list_items; i++) {
-		/* desktop ID */
-		if ((desktop = (long *)get_property(disp, client_list[i],
-						    XA_CARDINAL,
-						    "_NET_WM_DESKTOP", NULL,
-						    NULL)) == NULL) {
-			desktop =
-			    (long *)get_property(disp, client_list[i],
-						 XA_CARDINAL, "_WIN_WORKSPACE",
-						 NULL, NULL);
-		}
-
-		/* Ignore windows on unknown desktops */
-		if (desktop && *desktop >= 0 && *desktop < DESKTOP_MAX) {
-			num_needed++;
-			free(desktop);
-		}
-	}
-
-	ret = calloc(num_needed, sizeof(Window));
-	if (!ret) {
-		perror("get_interesting_window allocations");
-		free(client_list);
-		return NULL;
-	}
-	tmp = ret;
-
-	/* Now copy all that crud. */
-	for (i = 0; i < client_list_items; i++) {
-		/* desktop ID */
-		if ((desktop = (long *)get_property(disp, client_list[i],
-						    XA_CARDINAL,
-						    "_NET_WM_DESKTOP", NULL,
-						    NULL)) == NULL) {
-			desktop =
-			    (long *)get_property(disp, client_list[i],
-						 XA_CARDINAL, "_WIN_WORKSPACE",
-						 NULL, NULL);
-		}
-
-		if (desktop && *desktop >= 0 && *desktop < DESKTOP_MAX) {
-			memcpy(tmp, &client_list[i], sizeof(Window));
-			tmp++;
-			free(desktop);
-		}
-	}
-	free(client_list);
-
-	*num_windows = num_needed;
-	return ret;
-}
-
-int main(int argc, char *argv[])
-{
-	char *disp_string = NULL;
-	unsigned long iterations = 10000, rounds = -1, i;
-	unsigned long sleep = 100000;
-	int opt;
-	Display *disp;
-
-	while ((opt = getopt(argc, argv, "d:i:r:s:f")) != -1) {
-		switch (opt) {
-		case 'd':
-			disp_string = optarg;
-			break;
-		case 'i':
-			iterations = atoi(optarg);
-			break;
-		case 'r':
-			rounds = atoi(optarg);
-			break;
-		case 's':
-			sleep = atoi(optarg);
-			break;
-		case 'f':
-			enable_fullscreen = 1;
-			break;
-		default:
-			fprintf(stderr,
-				"Usage: %s [-d DISPLAY] [-i ITERATIONS] [-r ROUNDS] [-s SLEEP] [-f]\n\
-	DISPLAY is an X11 display string.\n\
-	ITERATIONS is the approximate number of windows to play with before generating a new window list.\n\
-	SLEEP is the amount of time (in usec) to sleep between window tweaks.\n\
-	-f enables fullscreen toggling.\n\
-	ROUNDS is the number of iterations to run, or -1 to run forever.\n",
-				argv[0]);
-			return 0;
-		}
-	}
-
-	if (!(disp = XOpenDisplay(disp_string))) {
-		fprintf(stderr, "Unable to connect to display '%s'.\n",
-			(disp_string !=
-			 NULL ? disp_string : getenv("DISPLAY")));
-		return 1;
-	}
-
-	seed_random();
-
-	XSetErrorHandler(&ignore_xlib_error);
-
-	for (i = 0; i < rounds || rounds == -1; i++) {
-		go_bonkers(disp, iterations, sleep);
-	}
-
-	printf("Enough of that; I'm done.\n");
-
-	XCloseDisplay(disp);
-
-	return 0;
-}
diff --git a/tools/pounder21/test_repo/D01stats b/tools/pounder21/test_repo/D01stats
deleted file mode 120000
index 5b98648d6..000000000
--- a/tools/pounder21/test_repo/D01stats
+++ /dev/null
@@ -1 +0,0 @@
-../test_scripts/statslogging
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T00hwinfo b/tools/pounder21/test_repo/T00hwinfo
deleted file mode 120000
index e7db6e728..000000000
--- a/tools/pounder21/test_repo/T00hwinfo
+++ /dev/null
@@ -1 +0,0 @@
-../test_scripts/get_hw_info
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T00sysrq_on b/tools/pounder21/test_repo/T00sysrq_on
deleted file mode 120000
index d44b81e9a..000000000
--- a/tools/pounder21/test_repo/T00sysrq_on
+++ /dev/null
@@ -1 +0,0 @@
-../test_scripts/sysrq-on
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T01screen_noblank b/tools/pounder21/test_repo/T01screen_noblank
deleted file mode 120000
index c6c8761c3..000000000
--- a/tools/pounder21/test_repo/T01screen_noblank
+++ /dev/null
@@ -1 +0,0 @@
-../test_scripts/screen_noblank
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T10single/T00xterm_stress b/tools/pounder21/test_repo/T10single/T00xterm_stress
deleted file mode 120000
index 580fa031a..000000000
--- a/tools/pounder21/test_repo/T10single/T00xterm_stress
+++ /dev/null
@@ -1 +0,0 @@
-../../test_scripts/xterm_stress
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T10single/T01ltp b/tools/pounder21/test_repo/T10single/T01ltp
deleted file mode 120000
index 40eebf5b8..000000000
--- a/tools/pounder21/test_repo/T10single/T01ltp
+++ /dev/null
@@ -1 +0,0 @@
-../../test_scripts/ltp
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T10single/T02ipmitool b/tools/pounder21/test_repo/T10single/T02ipmitool
deleted file mode 100755
index 0fa5b8c9e..000000000
--- a/tools/pounder21/test_repo/T10single/T02ipmitool
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/bash
-
-trap 'exit 0' 15
-
-$POUNDER_HOME/test_scripts/ipmitool
-exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D01bonnie++ b/tools/pounder21/test_repo/T90ramp/D01bonnie++
deleted file mode 100755
index 624bd001a..000000000
--- a/tools/pounder21/test_repo/T90ramp/D01bonnie++
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-
-trap 'exit 0' 15
-$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/bonnie++
-exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D02build_kernel b/tools/pounder21/test_repo/T90ramp/D02build_kernel
deleted file mode 100755
index 6c259245b..000000000
--- a/tools/pounder21/test_repo/T90ramp/D02build_kernel
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-
-trap 'exit 0' 15
-$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/build_kernel
-exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D03copy_large_tree b/tools/pounder21/test_repo/T90ramp/D03copy_large_tree
deleted file mode 100755
index a77107655..000000000
--- a/tools/pounder21/test_repo/T90ramp/D03copy_large_tree
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-
-trap 'exit 0' 15
-$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/copy_large_tree
-exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D04ddhappy b/tools/pounder21/test_repo/T90ramp/D04ddhappy
deleted file mode 100755
index 93db6aa5b..000000000
--- a/tools/pounder21/test_repo/T90ramp/D04ddhappy
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-
-trap 'exit 0' 15
-$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/ddhappy
-exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D05ide_cdrom_copy b/tools/pounder21/test_repo/T90ramp/D05ide_cdrom_copy
deleted file mode 100755
index 57ee221f0..000000000
--- a/tools/pounder21/test_repo/T90ramp/D05ide_cdrom_copy
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-
-trap 'exit 0' 15
-$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/ide_cdrom_copy
-exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D06lame b/tools/pounder21/test_repo/T90ramp/D06lame
deleted file mode 100755
index 9bd6751c0..000000000
--- a/tools/pounder21/test_repo/T90ramp/D06lame
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-
-trap 'exit 0' 15
-$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/lame
-exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D07cpufreq b/tools/pounder21/test_repo/T90ramp/D07cpufreq
deleted file mode 100755
index 94e42743c..000000000
--- a/tools/pounder21/test_repo/T90ramp/D07cpufreq
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-
-trap 'exit 0' 15
-$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/cpufreq
-exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D08memtest b/tools/pounder21/test_repo/T90ramp/D08memtest
deleted file mode 100755
index 0b6de26ba..000000000
--- a/tools/pounder21/test_repo/T90ramp/D08memtest
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-
-trap 'exit 0' 15
-$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/memtest
-exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D09memxfer5b b/tools/pounder21/test_repo/T90ramp/D09memxfer5b
deleted file mode 100755
index b3367686b..000000000
--- a/tools/pounder21/test_repo/T90ramp/D09memxfer5b
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-
-trap 'exit 0' 15
-$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/memxfer5b
-exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D10nfs b/tools/pounder21/test_repo/T90ramp/D10nfs
deleted file mode 100755
index 1c2064105..000000000
--- a/tools/pounder21/test_repo/T90ramp/D10nfs
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-
-trap 'exit 0' 15
-$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/nfs
-exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D11ramsnake b/tools/pounder21/test_repo/T90ramp/D11ramsnake
deleted file mode 100755
index a080b73d3..000000000
--- a/tools/pounder21/test_repo/T90ramp/D11ramsnake
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-
-trap 'exit 0' 15
-$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/ramsnake
-exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D12random_syscall b/tools/pounder21/test_repo/T90ramp/D12random_syscall
deleted file mode 100755
index d29d767d7..000000000
--- a/tools/pounder21/test_repo/T90ramp/D12random_syscall
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-
-trap 'exit 0' 15
-$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/random_syscall
-exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D13mem_alloc b/tools/pounder21/test_repo/T90ramp/D13mem_alloc
deleted file mode 100755
index 718a4ec7b..000000000
--- a/tools/pounder21/test_repo/T90ramp/D13mem_alloc
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-
-trap 'exit 0' 15
-$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/mem_alloc
-exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D14ltp b/tools/pounder21/test_repo/T90ramp/D14ltp
deleted file mode 100755
index c4aa4cf17..000000000
--- a/tools/pounder21/test_repo/T90ramp/D14ltp
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-
-trap 'exit 0' 15
-$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/ltp
-exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D15time_consistency b/tools/pounder21/test_repo/T90ramp/D15time_consistency
deleted file mode 100755
index 741c98f58..000000000
--- a/tools/pounder21/test_repo/T90ramp/D15time_consistency
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-
-trap 'exit 0' 15
-$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/time_consistency
-exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D16time_drift b/tools/pounder21/test_repo/T90ramp/D16time_drift
deleted file mode 100755
index e738739ca..000000000
--- a/tools/pounder21/test_repo/T90ramp/D16time_drift
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-
-trap 'exit 0' 15
-$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/time_drift
-exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D17xterm_stress b/tools/pounder21/test_repo/T90ramp/D17xterm_stress
deleted file mode 100755
index c6d5bed57..000000000
--- a/tools/pounder21/test_repo/T90ramp/D17xterm_stress
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-
-trap 'exit 0' 15
-$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/xterm_stress
-exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/T01rampup b/tools/pounder21/test_repo/T90ramp/T01rampup
deleted file mode 120000
index cfb100c63..000000000
--- a/tools/pounder21/test_repo/T90ramp/T01rampup
+++ /dev/null
@@ -1 +0,0 @@
-ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T02rampup b/tools/pounder21/test_repo/T90ramp/T02rampup
deleted file mode 120000
index cfb100c63..000000000
--- a/tools/pounder21/test_repo/T90ramp/T02rampup
+++ /dev/null
@@ -1 +0,0 @@
-ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T03rampup b/tools/pounder21/test_repo/T90ramp/T03rampup
deleted file mode 120000
index cfb100c63..000000000
--- a/tools/pounder21/test_repo/T90ramp/T03rampup
+++ /dev/null
@@ -1 +0,0 @@
-ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T04rampup b/tools/pounder21/test_repo/T90ramp/T04rampup
deleted file mode 120000
index cfb100c63..000000000
--- a/tools/pounder21/test_repo/T90ramp/T04rampup
+++ /dev/null
@@ -1 +0,0 @@
-ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T05rampup b/tools/pounder21/test_repo/T90ramp/T05rampup
deleted file mode 120000
index cfb100c63..000000000
--- a/tools/pounder21/test_repo/T90ramp/T05rampup
+++ /dev/null
@@ -1 +0,0 @@
-ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T06rampup b/tools/pounder21/test_repo/T90ramp/T06rampup
deleted file mode 120000
index cfb100c63..000000000
--- a/tools/pounder21/test_repo/T90ramp/T06rampup
+++ /dev/null
@@ -1 +0,0 @@
-ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T07rampup b/tools/pounder21/test_repo/T90ramp/T07rampup
deleted file mode 120000
index cfb100c63..000000000
--- a/tools/pounder21/test_repo/T90ramp/T07rampup
+++ /dev/null
@@ -1 +0,0 @@
-ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T08rampup b/tools/pounder21/test_repo/T90ramp/T08rampup
deleted file mode 120000
index cfb100c63..000000000
--- a/tools/pounder21/test_repo/T90ramp/T08rampup
+++ /dev/null
@@ -1 +0,0 @@
-ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T09rampup b/tools/pounder21/test_repo/T90ramp/T09rampup
deleted file mode 120000
index cfb100c63..000000000
--- a/tools/pounder21/test_repo/T90ramp/T09rampup
+++ /dev/null
@@ -1 +0,0 @@
-ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T10rampup b/tools/pounder21/test_repo/T90ramp/T10rampup
deleted file mode 120000
index cfb100c63..000000000
--- a/tools/pounder21/test_repo/T90ramp/T10rampup
+++ /dev/null
@@ -1 +0,0 @@
-ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T11rampup b/tools/pounder21/test_repo/T90ramp/T11rampup
deleted file mode 120000
index cfb100c63..000000000
--- a/tools/pounder21/test_repo/T90ramp/T11rampup
+++ /dev/null
@@ -1 +0,0 @@
-ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T12rampup b/tools/pounder21/test_repo/T90ramp/T12rampup
deleted file mode 120000
index cfb100c63..000000000
--- a/tools/pounder21/test_repo/T90ramp/T12rampup
+++ /dev/null
@@ -1 +0,0 @@
-ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T13rampup b/tools/pounder21/test_repo/T90ramp/T13rampup
deleted file mode 120000
index cfb100c63..000000000
--- a/tools/pounder21/test_repo/T90ramp/T13rampup
+++ /dev/null
@@ -1 +0,0 @@
-ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T14rampup b/tools/pounder21/test_repo/T90ramp/T14rampup
deleted file mode 120000
index cfb100c63..000000000
--- a/tools/pounder21/test_repo/T90ramp/T14rampup
+++ /dev/null
@@ -1 +0,0 @@
-ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T15rampup b/tools/pounder21/test_repo/T90ramp/T15rampup
deleted file mode 120000
index cfb100c63..000000000
--- a/tools/pounder21/test_repo/T90ramp/T15rampup
+++ /dev/null
@@ -1 +0,0 @@
-ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T16rampup b/tools/pounder21/test_repo/T90ramp/T16rampup
deleted file mode 120000
index cfb100c63..000000000
--- a/tools/pounder21/test_repo/T90ramp/T16rampup
+++ /dev/null
@@ -1 +0,0 @@
-ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T17rampup b/tools/pounder21/test_repo/T90ramp/T17rampup
deleted file mode 120000
index cfb100c63..000000000
--- a/tools/pounder21/test_repo/T90ramp/T17rampup
+++ /dev/null
@@ -1 +0,0 @@
-ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T99runawhile b/tools/pounder21/test_repo/T90ramp/T99runawhile
deleted file mode 100755
index 56f19468f..000000000
--- a/tools/pounder21/test_repo/T90ramp/T99runawhile
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/bash
-
-# Run for two days
-sleep 172800
diff --git a/tools/pounder21/test_repo/T90ramp/ramp_wait b/tools/pounder21/test_repo/T90ramp/ramp_wait
deleted file mode 100755
index edddf4261..000000000
--- a/tools/pounder21/test_repo/T90ramp/ramp_wait
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/bash
-
-sleep 30
diff --git a/tools/pounder21/test_repo/T99screen_blank b/tools/pounder21/test_repo/T99screen_blank
deleted file mode 120000
index 684b876e3..000000000
--- a/tools/pounder21/test_repo/T99screen_blank
+++ /dev/null
@@ -1 +0,0 @@
-../test_scripts/screen_blank
\ No newline@end of file
diff --git a/tools/pounder21/test_repo/excluded/testlist b/tools/pounder21/test_repo/excluded/testlist
deleted file mode 100644
index 48c7df50d..000000000
--- a/tools/pounder21/test_repo/excluded/testlist
+++ /dev/null
@@ -1,7 +0,0 @@
-# The purpose of this file is to keep tabs on
-# which pounder subtests are excluded from the
-# test run. Whenever ./pounder -e subtest-to-exclude
-# is used, the subtest name and path get logged
-# here.
-
-# DO NOT MODIFY THIS FILE.
diff --git a/tools/pounder21/test_scripts/abort.sh b/tools/pounder21/test_scripts/abort.sh
deleted file mode 100755
index 887c669b3..000000000
--- a/tools/pounder21/test_scripts/abort.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/sh
-
-# Abort a test.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-echo "abort.sh: ack! aborting!"
-exit 255
diff --git a/tools/pounder21/test_scripts/bonnie++ b/tools/pounder21/test_scripts/bonnie++
deleted file mode 100755
index abd97dee0..000000000
--- a/tools/pounder21/test_scripts/bonnie++
+++ /dev/null
@@ -1,81 +0,0 @@
-#!/bin/bash
-
-# Runs the bonnie++ test on filesystems...
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-TEST_PID=$$
-
-# Try to find bonnie++ on the system
-BONNIE=`which bonnie++ 2> /dev/null`
-
-if [ -z "$BONNIE" ]; then
-	BONNIE=`ls $POUNDER_OPTDIR/bonnie++*/bonnie++`
-	if [ -z "$BONNIE" ]; then
-		echo "Cannot find bonnie++; did you run Install?"
-		exit -1
-	fi
-fi
-
-# Note old errors
-LOGFILE=/proc/$$/fd/1
-OLD_ERRORS=`egrep -ic "(err|fail|invalid|cannot|denied)" $LOGFILE`
-
-# Now figure out where we have mounted filesystems
-MOUNTS=`egrep "(ext|reiser)" /proc/mounts | awk -F " " '{print $2}'`
-
-rm -rf $POUNDER_TMPDIR/bonnie-script-$TEST_PID
-echo '#/bin/bash' > $POUNDER_TMPDIR/bonnie-script-$TEST_PID
-echo >> $POUNDER_TMPDIR/bonnie-script-$TEST_PID
-
-echo $MOUNTS | sed -e 's/ /\n/g' | while read f; do
-	# Clean out space for bonnie
-	rm -rf "$f/bonnie/"
-
-	# Set up for bonnie
-	mkdir -p "$f/bonnie/"
-
-	# Engage!
-	echo $BONNIE -u 0 -d \"$f/bonnie/\" \& >> $POUNDER_TMPDIR/bonnie-script-$TEST_PID
-done
-
-echo wait >> $POUNDER_TMPDIR/bonnie-script-$TEST_PID
-
-# Are we actually going to start any bonnie's?
-if [ `wc -l < $POUNDER_TMPDIR/bonnie-script-$TEST_PID` -lt 4 ]; then
-	echo "Not running bonnie@all.  Abort."
-	exit -1
-fi
-
-bash $POUNDER_TMPDIR/bonnie-script-$TEST_PID
-rm -rf $POUNDER_TMPDIR/bonnie-script-$TEST_PID
-
-# Clean ourselves up
-echo $MOUNTS | sed -e 's/ /\n/g' | while read f; do
-	# Clean out space for bonnie
-	rm -rf "$f/bonnie/"
-done
-
-# Did we find any new errors?
-NEW_ERRORS=`egrep -ic "(err|fail|invalid|cannot|denied)" $LOGFILE`
-ERRORS=$(( NEW_ERRORS - OLD_ERRORS ))
-if [ $ERRORS -eq 255 ]; then
-        ERRORS=254
-fi
-
-exit $ERRORS
diff --git a/tools/pounder21/test_scripts/build_kernel b/tools/pounder21/test_scripts/build_kernel
deleted file mode 100755
index 6dcfdef35..000000000
--- a/tools/pounder21/test_scripts/build_kernel
+++ /dev/null
@@ -1,62 +0,0 @@
-#!/bin/bash
-
-# Build Linux kernel
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-CPUS=`grep processor /proc/cpuinfo | wc -l`
-ARCH=`uname -m`
-VERSION=2.6.39
-# WARNING: If you update the kernel version that we use, be sure to
-# update $POUNDER_SRCDIR/memtest.patch, $POUNDER_HOME/test_scripts/memtest,
-# $POUNDER_HOME/test_scripts/build_kernel, and
-# $POUNDER_HOME/build_scripts/build_kernel.
-
-#LOG_ALL_MAKE=1
-
-# Decompress tarball if necessary
-cd "$POUNDER_TMPDIR"
-tar -xvf "$POUNDER_OPTDIR/linux-$VERSION.tar.bz2"
-
-# Clean up the tree.
-cd linux-$VERSION
-
-make mrproper
-
-# Create a config file
-make allmodconfig
-
-# Build system
-if [ $LOG_ALL_MAKE ]; then
-	#Let all ouput flow to the external logging
-	make -j$CPUS oldconfig
-       	time make -j$CPUS
-else
-	#Just log std err
-	make -j$CPUS oldconfig > /dev/null
-	time make -j$CPUS > /dev/null
-fi
-
-# Did we get a kernel image?
-RETCODE=1
-if [ -f vmlinux ]; then
-	RETCODE=0
-fi
-
-exit $RETCODE
diff --git a/tools/pounder21/test_scripts/copy_large_tree b/tools/pounder21/test_scripts/copy_large_tree
deleted file mode 100755
index df325a56a..000000000
--- a/tools/pounder21/test_scripts/copy_large_tree
+++ /dev/null
@@ -1,43 +0,0 @@
-#!/bin/bash
-
-# Test the copying of a large directory hierarchy...while deleting it.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-TREE_DEST="$POUNDER_TMPDIR/copytree/"
-
-# Set up the erase
-trap 'echo Cleaning up...; rm -rf "$TREE_DEST"; echo Clean.; exit 0'  1 2 15
-
-# Copy the data
-mkdir -p "$TREE_DEST"
-cp -pRdu /usr "$TREE_DEST"
-
-# Compare the data
-diff -Naur /usr "$TREE_DEST/usr/" | tee "$POUNDER_TMPDIR/copytree.diff"
-
-# Clean up
-rm -rf "$TREE_DEST"
-
-# Anything in the diff?
-DIFF_ERRORS=`wc -l < $POUNDER_TMPDIR/copytree.diff`
-if [ $DIFF_ERRORS -gt 0 ]; then
-        exit $DIFF_ERRORS
-fi
-
-exit 0
diff --git a/tools/pounder21/test_scripts/cpufreq b/tools/pounder21/test_scripts/cpufreq
deleted file mode 100755
index ba94a76e6..000000000
--- a/tools/pounder21/test_scripts/cpufreq
+++ /dev/null
@@ -1,111 +0,0 @@
-#!/bin/bash
-
-# Cycle the CPUs through various frequencies.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-# Do any CPU support cpufreq?
-#CPUFREQ_ENABLED_CPUS=`/bin/ls -lad /sys/devices/system/cpu/cpu*/cpufreq 2> /dev/null | wc -l`
-
-#if [ "$CPUFREQ_ENABLED_CPUS" -lt 1 ]; then
-#	echo "None of your CPUs support cpufreq.  Bye."
-#	exit 255
-#fi
-
-# Turn on acpi_pstate_strict to ensure that state transitions actually happen...
-if [ -f /sys/module/acpi_cpufreq/parameters/acpi_pstate_strict ]; then
-	echo 1 > /sys/module/acpi_cpufreq/parameters/acpi_pstate_strict
-fi
-if [ -f /sys/module/acpi/parameters/acpi_pstate_strict ]; then
-	echo 1 > /sys/module/acpi/parameters/acpi_pstate_strict
-fi
-
-# First, knock off any powersaving daemons...
-for i in `ls /etc/init.d/*powernow /etc/init.d/*cpuspeed* /etc/init.d/*powersave* 2> /dev/null`; do
-	"$i" stop
-done
-
-# Ensure that we have the userspace governor running
-for i in /sys/devices/system/cpu/cpu*; do
-	echo userspace > "$i/cpufreq/scaling_governor"
-done
-
-# Trap ^C
-trap 'kill -9 `pgrep -P $$` `pgrep cpufreq.bin` 2> /dev/null; exit 0' 1 2 15
-
-# Did we see any failures?
-LOGFILE=/proc/$$/fd/1
-OLD_ERRORS=`egrep -ic "(error|fail|invalid|denied|cannot)" $LOGFILE`
-
-# For all CPUs with cpufreq: remove CPUs that are locked with another.
-function find_cpufreq_cpus() {
-	for cpu in `ls -d /sys/devices/system/cpu/cpu*/cpufreq 2> /dev/null`; do
-		# Locked CPUs are done with symlinks in 2.6.14.
-		if [ -L "$cpu" ]; then
-			continue;
-		fi
-
-		CPU_NUM=`dirname $cpu | sed -e 's/.*cpu//g'`
-		MATCHES=`(cat /sys/devices/system/cpu/cpu*/cpufreq/affected_cpus /dev/null 2> /dev/null | while read car cdr; do echo $cdr; done) | grep "^$CPU_NUM$" -c`
-		if [ $MATCHES -eq 0 ]; then
-			echo $CPU_NUM
-		fi
-	done
-}
-
-# Find the frequencies for a given CPU
-function find_cpu_frequencies() {
-	i="/sys/devices/system/cpu/cpu$1"
-
-	if [ -f "$i/cpufreq/scaling_available_frequencies" ]; then
-		cat "$i/cpufreq/scaling_available_frequencies"
-	else
-		cat "$i/cpufreq/scaling_min_freq" "$i/cpufreq/scaling_max_freq"
-	fi
-}
-
-# Figure out which CPUs have cpufreq support.
-find_cpufreq_cpus | while read f; do
-	echo Starting CPU frequency testing on CPU $f
-	i=/sys/devices/system/cpu/cpu$f
-
-	# Does this CPU have cpufreq?
-	if [ ! -d "$i/cpufreq/" ]; then
-		continue;
-	fi
-
-	# Kick off the test.
-	"$POUNDER_HOME/timed_loop" 900 "$POUNDER_SRCDIR/cpufreq/cpufreq.bin" "$i/cpufreq/scaling_setspeed" 10000 $f `find_cpu_frequencies $f` &
-done
-
-# Wait for this to finish
-while [ `pgrep cpufreq.bin | wc -l` -gt 0 ]; do
-	sleep 5
-done
-
-# Did we see any failures?
-NEW_ERRORS=`egrep -ic "(error|fail|invalid|denied|cannot)" $LOGFILE`
-ERRORS=$(( NEW_ERRORS - OLD_ERRORS ))
-if [ $ERRORS -eq 255 ]; then
-	ERRORS=254
-fi
-
-# Failures will show up in the test output.  Or better yet,
-# panic/oops/BUG the machine.
-exit $ERRORS
diff --git a/tools/pounder21/test_scripts/ddhappy b/tools/pounder21/test_scripts/ddhappy
deleted file mode 100755
index 975998a84..000000000
--- a/tools/pounder21/test_scripts/ddhappy
+++ /dev/null
@@ -1,51 +0,0 @@
-#!/bin/bash
-
-# Each CPU reads every block off a block device...twice.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-BLKDEVS=$(cat /proc/partitions | grep [sh]d.[0-9] | awk '{if ($3 > 10000)  print $4}')
-WORK=$((NR_CPUS * 2))
-
-echo "Running dd's on these devices:"
-echo "$BLKDEVS"
-echo "using $WORK dd's per device."
-
-# Did we see any failures?
-LOGFILE=/proc/$$/fd/1
-OLD_ERRORS=`egrep -ic "(error|fail|invalid|denied|cannot)" $LOGFILE`
-
-for ((k=1; k < $WORK; k++))
-do
-for i in $BLKDEVS
-	do
-		dd if=/dev/$i of=/dev/null bs=2k > /dev/null &
-	done
-done
-
-# Wait for children
-wait
-
-# Did we see any failures?
-NEW_ERRORS=`egrep -ic "(error|fail|invalid|denied|cannot)" $LOGFILE`
-ERRORS=$(( NEW_ERRORS - OLD_ERRORS ))
-if [ $ERRORS -eq 255 ]; then
-	ERRORS=254
-fi
-exit $ERRORS
diff --git a/tools/pounder21/test_scripts/fail.sh b/tools/pounder21/test_scripts/fail.sh
deleted file mode 100755
index 9eedfbb23..000000000
--- a/tools/pounder21/test_scripts/fail.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/sh
-
-# Fail a test.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-echo "fail.sh: This test failed!"
-exit -324
diff --git a/tools/pounder21/test_scripts/get_hw_info b/tools/pounder21/test_scripts/get_hw_info
deleted file mode 100755
index 71054934e..000000000
--- a/tools/pounder21/test_scripts/get_hw_info
+++ /dev/null
@@ -1,87 +0,0 @@
-#!/bin/bash
-
-# Script to collect hardware information
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-echo "Hardware Information for `hostname` at `date`."
-if [ "$UID" -ne 0 ]; then
-	echo "You are not running as root.  Hardware data may be restricted."
-fi
-echo
-echo "dmesg output:"
-echo "============="
-dmesg
-echo
-echo "/proc/cmdline:"
-echo "=============="
-cat /proc/cmdline
-echo
-echo "CPU Information:"
-echo "================"
-cat /proc/cpuinfo
-echo
-echo "DMI Table Dump:"
-echo "==============="
-dmidecode
-echo
-echo "Registered Devices:"
-echo "==================="
-cat /proc/devices
-echo
-echo "Registered DMA Channels:"
-echo "========================"
-cat /proc/dma
-echo
-echo "Registered Interrupts:"
-echo "======================"
-cat /proc/interrupts
-echo
-echo "IO Memory:"
-echo "=========="
-cat /proc/iomem
-echo
-echo "IO Ports:"
-echo "========="
-cat /proc/ioports
-echo
-echo "PCI Device Tree via lspci:"
-echo "=========================="
-lspci -v
-echo
-echo "IDE Device/Driver Info:"
-echo "======================="
-find /proc/ide -type f | while read f; do echo $f; cat $f; done;
-echo
-echo "SCSI Device/Driver Info:"
-echo "========================"
-find /proc/scsi -type f | while read f; do echo $f; cat $f; done;
-echo
-echo "Network Devices:"
-echo "================"
-ifconfig -a
-echo
-echo "Partition Layout:"
-echo "================="
-fdisk -l /dev/sd[a-z] /dev/hd[a-z]
-echo
-echo "sysfs Device Info:"
-echo "=================="
-find /sys -mount -type f | while read f; do echo $f: `cat $f`; done
-
-exit 0
diff --git a/tools/pounder21/test_scripts/ide_cdrom_copy b/tools/pounder21/test_scripts/ide_cdrom_copy
deleted file mode 100755
index f98071483..000000000
--- a/tools/pounder21/test_scripts/ide_cdrom_copy
+++ /dev/null
@@ -1,91 +0,0 @@
-#!/bin/bash
-
-# Validate the CD/DVD devices in the system by progressively mounting them,
-# copying the CDs to the hard disk, and then diffing the results.
-# Note that this test also examines SCSI CD drives, making the "ide" part a
-# misnomer that's maintained solely because it's familiar to the users.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-. "$POUNDER_SRCDIR/libidecd.sh"
-
-DEFAULT_MOUNT="$POUNDER_TMPDIR/cdmount"
-DESTINATION="$POUNDER_TMPDIR/cddata"
-
-# Ensure that our default mountpoint and destination dirs exist.
-mkdir -p "$DEFAULT_MOUNT"
-
-# Scoop up the old error count.
-LOGFILE=/proc/$$/fd/1
-OLD_ERRORS=`egrep -ic "(err|fail|invalid|cannot|denied)" $LOGFILE`
-OLD_DIFFS=`egrep -ic "^---" $LOGFILE`
-
-# Trap a SIGABRT which signifies an aborted test...
-trap 'exit 255' SIGABRT
-
-# Now, mount each disc and do the test.
-find_discs_with_media | while read DEV USE_FSTAB; do
-
-	# Are there no CDs at all?
-	if [ "$DEV" == "NONE" ]; then
-		echo "No CD/DVD drives found.  Aborting."
-		kill -SIGABRT $$
-	fi
-
-	# Mount the disc.
-	echo "Mounting $DEV."
-	if [ $USE_FSTAB -gt 0 ]; then
-		MOUNTPOINT=`grep "^$DEV[ 	]" /etc/fstab | awk -F " " '{print $2}'`
-		mount "$DEV"
-	else
-		MOUNTPOINT="$DEFAULT_MOUNT"
-		mount "$DEV" "$MOUNTPOINT" -t auto
-	fi
-
-	# Create destination and set up auto-removal
-	trap 'echo Cleaning up...; rm -rf $DESTINATION; umount $MOUNTPOINT; echo Clean.; exit 0' 1 2 15
-	mkdir -p "$DESTINATION"
-
-	# Copy the CD
-	echo "Copying $DEV."
-	cp -pRdu "$MOUNTPOINT" "$DESTINATION"
-
-	# Diff the copy
-	echo "Comparing $DEV to $DESTINATION."
-	diff -rq "$MOUNTPOINT" "$DESTINATION/`basename $MOUNTPOINT`"
-
-	# Unmount
-	echo "Done with $DEV."
-	umount "$DEV"
-
-	# Remove the copy
-	rm -rf "$DESTINATION"
-done
-
-
-# Look for new errors.
-NEW_ERRORS=`egrep -ic "(err|fail|invalid|cannot|denied)" $LOGFILE`
-NEW_DIFFS=`egrep -ic "^---" $LOGFILE`
-
-ERRORS=$(( NEW_ERRORS - OLD_ERRORS ))
-DIFFS=$(( NEW_DIFFS - OLD_DIFFS ))
-WRONG=$(( ERRORS + DIFFS ))
-if [ $WRONG -eq 255 ]; then
-	WRONG=254
-fi
-exit $WRONG
diff --git a/tools/pounder21/test_scripts/ipmitool b/tools/pounder21/test_scripts/ipmitool
deleted file mode 100755
index b13dcfb5a..000000000
--- a/tools/pounder21/test_scripts/ipmitool
+++ /dev/null
@@ -1,127 +0,0 @@
-#!/bin/bash
-
-function runtest() {
-
-	$IPMITOOL $*
-	RETURN=$?
-	if [ $RETURN -ne 0 ]; then
-		echo "Test ipmitool $* failed with code $RETURN."
-		status=$(($status+1))
-	fi
-}
-
-CHECK=`dmidecode | egrep '(Baseboard Management Controller|IPMI)'`
-if [ -z "$CHECK" ]; then
-	echo "BMC is not detected. Aborting."
-	exit 255
-fi
-
-IPMITOOL=`ls $POUNDER_OPTDIR/ipmitool*/src/ipmitool 2> /dev/null`
-if [ -z "$IPMITOOL" ]; then
-	IPMITOOL=`which ipmitool 2> /dev/null`
-	if [ -z "$IPMITOOL" ]; then
-		echo "Cannot find ipmitool; ipmitool utility not installed on system."
-		echo "Please install package containing ipmitool utility and re-run test."
-		exit -1
-	fi
-else
-	IPMITOOL="$POUNDER_OPTDIR/ipmitool*/src/ipmitool"
-fi
-
-status=0
-/etc/init.d/ipmi restart #maybe start
-RETURN=$?
-if [ $RETURN -ne 0 ]; then
-	echo "Could not start driver with code $RETURN."
-	status=$(($status+1))
-	exit $status
-fi
-
-echo
-echo "ipmitool utility version:  "
-runtest -V
-echo
-echo "OpenIPMI Driver version:  "
-dmesg |grep ipmi |grep -i -m 1 version
-echo
-
-runtest bmc info
-if [ $status -eq 0 ]; then
-	BMC2=`$IPMITOOL bmc info | grep "IPMI Version" | cut -b 29`
-	#possibly log this stuff here
-	if [ $BMC2 -ge 2 ]; then
-		runtest firewall info lun 0 netfn 0
-		 		 runtest firewall info lun 0 netfn 1
-		 		 runtest firewall info lun 0 netfn 4
-		 		 runtest firewall info lun 0 netfn 0 command 0
-		 		 runtest firewall info lun 0 netfn 0 command 1
-		 		 runtest firewall info lun 0 netfn 0 command 2
-		 		 runtest firewall info lun 0 netfn 1 command 0
-		 		 runtest firewall info lun 0 netfn 1 command 1
-		 		 runtest firewall info lun 0 netfn 1 command 2
-		 		 runtest firewall info lun 0 netfn 4 command 0
-		 		 runtest firewall info lun 0 netfn 4 command 1
-		 		 runtest firewall info lun 0 netfn 4 command 2
-	 		        runtest firewall disable lun 0 netfn 0 command 2
-		 		 runtest firewall enable lun 0 netfn 0 command 2
-		 		 runtest firewall info lun 0 netfn 0 command 2
-		 		 runtest channel getciphers ipmi 1
-		 		 runtest channel getciphers sol 1
-
-	else
-		echo "BMC is not 2.0 compatible; skipping firewall tests."
-	fi
-fi
-runtest lan print
-runtest bmc getenables
-runtest channel info 0
-runtest channel info 1
-runtest channel info 2
-runtest channel info 14
-runtest channel info 15
-runtest channel authcap 1 1
-runtest channel authcap 1 2
-runtest channel authcap 1 3
-runtest channel authcap 1 4
-runtest channel getaccess 0x1
-runtest channel getaccess 0x2
-runtest chassis status
-runtest chassis identify
-runtest chassis restart_cause
-runtest chassis power status
-runtest pef info
-runtest pef status
-runtest pef list
-runtest sdr info
-runtest sdr list all
-runtest sdr list full
-runtest sdr list compact
-runtest sdr list event
-runtest sdr list mcloc
-runtest sdr list fru
-runtest sdr list generic
-runtest sdr type list
-runtest sdr entity
-runtest sel
-runtest sel info
-runtest sel list
-runtest sel elist
-runtest sel list 5
-runtest sel time get
-runtest sel writeraw testing
-runtest sel readraw testing
-runtest sensor list
-runtest session info all
-runtest session info active
-runtest user summary 0x1
-runtest user summary 0x2
-runtest user list 0x1
-runtest user list 0x2
-
-if [ $status -eq 255 ]; then
-	status=254
-fi
-
-
-
-exit $status
diff --git a/tools/pounder21/test_scripts/lame b/tools/pounder21/test_scripts/lame
deleted file mode 100755
index 9c179f68d..000000000
--- a/tools/pounder21/test_scripts/lame
+++ /dev/null
@@ -1,51 +0,0 @@
-#!/bin/bash
-
-# MP3-encode something
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-# Try to find the program on the system
-PROGRAM=lame
-PROGFILE=`which $PROGRAM 2> /dev/null`
-
-if [ -z "$PROGFILE" ]; then
-	PROGFILE=`ls $POUNDER_OPTDIR/$PROGRAM*/frontend/$PROGRAM`
-	if [ -z "$PROGFILE" ]; then
-		echo "Cannot find $PROGRAM; did you run Install?"
-		exit -1
-	fi
-fi
-
-# Can we set processor affinities?
-TASKSET=`which taskset 2> /dev/null`
-if [ -z "$TASKSET" ]; then
-	TASKSET=`ls $POUNDER_OPTDIR/schedutils*/taskset`
-fi
-
-# Attach a process to each CPU
-for ((k=0; k < $NR_CPUS; k++))
-do
-	dd if=/dev/urandom bs=1024k count=200 | "$TASKSET" `echo -en "obase=16\n$((1 << k))\n" | bc` "$PROGFILE" - /dev/null &
-done
-
-# Wait for children (even though they won't die...)
-wait
-
-# If we don't crash the system, we're ok.
-# We actually don't care about the output. (mp3 encoded garbage?)
-exit 0
diff --git a/tools/pounder21/test_scripts/ltp b/tools/pounder21/test_scripts/ltp
deleted file mode 100755
index 01aa2cd57..000000000
--- a/tools/pounder21/test_scripts/ltp
+++ /dev/null
@@ -1,40 +0,0 @@
-#!/bin/bash
-
-# Runs the LTP suite
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-LTPRUNALL=`ls $POUNDER_TMPDIR/opt/ltp/runltp`
-
-# Catch errors
-LOGFILE=/proc/$$/fd/1
-OLD_ERRORS=`egrep -c "FAIL  :" $LOGFILE`
-
-"$LTPRUNALL"
-
-if [ $? -ne 0 ]; then
-	exit 255
-fi
-
-# Catch errors
-NEW_ERRORS=`egrep -c "FAIL  :" $LOGFILE`
-ERRORS=$(( NEW_ERRORS - OLD_ERRORS ))
-if [ $ERRORS -eq 255 ]; then
-        ERRORS=254
-fi
-exit $ERRORS
diff --git a/tools/pounder21/test_scripts/mem_alloc b/tools/pounder21/test_scripts/mem_alloc
deleted file mode 100755
index 95a0214cc..000000000
--- a/tools/pounder21/test_scripts/mem_alloc
+++ /dev/null
@@ -1,43 +0,0 @@
-#!/bin/bash
-
-# Run the system to OOM.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-# How many errors are already here?
-LOGFILE=/proc/$$/fd/1
-OLD_ERRORS=`egrep -ic "(USER|LINUX) ERROR:" $LOGFILE`
-
-# Slow this guy down
-sleep 873
-
-# Eat a ton of memory.
-echo "Kicking off mem_alloc at `date`."
-$POUNDER_SRCDIR/mem_alloc_test/mem_alloc
-echo "Finished mem_alloc@`date`."
-
-# Can we find any new errors?
-NEW_ERRORS=`egrep -ic "(USER|LINUX) ERROR:" $LOGFILE`
-
-TOTAL_ERRORS=$(( NEW_ERRORS - OLD_ERRORS))
-if [ $TOTAL_ERRORS -eq 255 ]; then
-        TOTAL_ERRORS=254
-fi
-exit $TOTAL_ERRORS
-
diff --git a/tools/pounder21/test_scripts/memtest b/tools/pounder21/test_scripts/memtest
deleted file mode 100755
index e212bde0d..000000000
--- a/tools/pounder21/test_scripts/memtest
+++ /dev/null
@@ -1,53 +0,0 @@
-#!/bin/bash
-
-# Tests CPU/DMA hitting on memory
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-# Can we find the script?
-if [ ! -f "$POUNDER_OPTDIR/memtest.sh" ]; then
-	echo "Can't find memtest.sh; did you run Install?"
-	exit -1
-fi
-
-MEMTESTDIR="$POUNDER_TMPDIR/memtest/"
-rm -rf "$MEMTESTDIR"
-mkdir -p "$MEMTESTDIR"
-
-# Did we see any failures?
-LOGFILE=/proc/$$/fd/1
-OLD_ERRORS=`egrep -ic "(err|fail|invalid|cannot|denied|diff)" $LOGFILE`
-
-# Run the test
-cd "$POUNDER_OPTDIR"
-cp "$POUNDER_OPTDIR/linux-2.6.39.tar.bz2" "$MEMTESTDIR/linux-2.6.39.tar.bz2"
-#NR_PASSES=2 TEST_DIR="$MEMTESTDIR" SOURCE_FILE="$POUNDER_OPTDIR/linux-2.6.39.tar.gz"
-./memtest.sh
-
-# Now clean up
-rm -rf "$POUNDER_TMPDIR/memtest/"
-
-# Did we see any failures?
-NEW_ERRORS=`egrep -ic "(err|fail|invalid|denied|cannot|diff)" $LOGFILE`
-ERRORS=$((NEW_ERRORS - OLD_ERRORS))
-if [ $ERRORS -eq 255 ]; then
-        ERRORS=254
-fi
-exit $ERRORS
-
diff --git a/tools/pounder21/test_scripts/memxfer5b b/tools/pounder21/test_scripts/memxfer5b
deleted file mode 100755
index 58088ffe0..000000000
--- a/tools/pounder21/test_scripts/memxfer5b
+++ /dev/null
@@ -1,42 +0,0 @@
-#!/bin/bash
-
-# Flood memory bus by pounding on the CPU...
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-# Try to find memxfer5b on the system
-MEMXFER5B=`ls $POUNDER_SRCDIR/memxfer5b/memxfer5b`
-if [ -z "$MEMXFER5B" ]; then
-	echo "Cannot find memxfer5b; did you run Install?"
-	exit -1
-fi
-
-# How much RAM do we have?
-RAM=`cat /proc/meminfo | grep MemTotal | awk -F " " '{print $2}'`
-MEM_BLOB=`expr $RAM \* 32` # convert to KB and then divide by 32
-
-# Run this test ten times.
-TIMES=0
-while [ $TIMES -lt 2 ]; do
-	"$MEMXFER5B" -s -p $MEM_BLOB 10 0 1 2 3 4 5 6
-	TIMES=$((TIMES + 1))
-done
-
-# No output; if system stays up, we pass.
-exit 0
diff --git a/tools/pounder21/test_scripts/nfs b/tools/pounder21/test_scripts/nfs
deleted file mode 100755
index d76b5627a..000000000
--- a/tools/pounder21/test_scripts/nfs
+++ /dev/null
@@ -1,88 +0,0 @@
-#!/bin/bash
-
-# Repeatedly copy files to NFS server.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-if [ -z "$NFS_SERVER" -o "$NFS_SERVER" == "0" ]; then
-	echo "NFS server not configured."
-	exit 255
-fi
-
-SHORTHOST=`echo "$HOSTNAME" | sed -e 's/\..*//g'`
-
-# set up to delete nfs data and unmount nfs when we die
-NFSMOUNT=/pounder
-NFSLOCAL="$POUNDER_TMPDIR/nfs-$$"
-trap 'echo Cleaning up...; mv $NFSLOCAL/$SHORTHOST/testnet $NFSLOCAL/$SHORTHOST/testnet.del; rm -rf $NFSLOCAL/$SHORTHOST/testnet.del; umount $NFSLOCAL; rm -rf $NFSLOCAL; echo Clean.; exit 0' 1 2 15
-
-[ ! -x $NFSLOCAL ] && mkdir $NFSLOCAL
-echo "Mounting remote storage via NFS..."
-
-echo Mounting $NFS_SERVER:$NFSMOUNT on $NFSLOCAL...
-
-# Did we see any failures?
-LOGFILE=/proc/$$/fd/1
-OLD_ERRORS=`egrep -ic "(err|fail|cannot|invalid|denied)" $LOGFILE`
-
-if (mount "$NFS_SERVER:$NFSMOUNT" $NFSLOCAL -t nfs -o tcp); then
-	# Create a dir for this machine and sleep to give our mkdir a
-	# better chance of making it.
-	[ ! -x $NFSLOCAL/$SHORTHOST ] && mkdir $NFSLOCAL/$SHORTHOST
-	sleep 5
-
-	# If we've already stuff here, move it and delete it.
-	# Meanwhile, create ourselves a new directory for the copy
-	[ -x $NFSLOCAL/$SHORTHOST/testnet ] && \
-		mv $NFSLOCAL/$SHORTHOST/testnet $NFSLOCAL/$SHORTHOST/testnet.del
-	[ -x $NFSLOCAL/$SHORTHOST/testnet.del ] && \
-		rm -rf $NFSLOCAL/$SHORTHOST/testnet.del &
-
-	# Actually copy data...
-	echo "Remote NFS copy in progress..."
-	cp -pr /usr $NFSLOCAL/$SHORTHOST/testnet
-
-	# Now diff it...
-	diff -Naur /usr $NFSLOCAL/$SHORTHOST/testnet > $POUNDER_TMPDIR/nfs.diff
-
-	# Now remove it
-	rm -rf $NFSLOCAL/$SHORTHOST/testnet
-
-	# and unmount
-	umount $NFSLOCAL
-	rm -rf $NFSLOCAL
-else
-	echo Unable to connect to the NFS server $NFS_SERVER.
-	echo Please check network configuration and update the script.
-	exit -1
-fi
-
-# Anything in the diff?
-DIFF_ERRORS=`wc -l < $POUNDER_TMPDIR/nfs.diff`
-if [ $DIFF_ERRORS -gt 0 ]; then
-	exit $DIFF_ERRORS
-fi
-
-# Did we see any failures?
-NEW_ERRORS=`egrep -ic "(err|fail|cannot|invalid|denied)" $LOGFILE`
-ERRORS=$((NEW_ERRORS - OLD_ERRORS))
-if [ $ERRORS -eq 255 ]; then
-        ERRORS=254
-fi
-exit $ERRORS
-
diff --git a/tools/pounder21/test_scripts/pass.sh b/tools/pounder21/test_scripts/pass.sh
deleted file mode 100755
index e373c85d3..000000000
--- a/tools/pounder21/test_scripts/pass.sh
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/sh
-
-# Pass
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-exit 0
diff --git a/tools/pounder21/test_scripts/passloop.sh b/tools/pounder21/test_scripts/passloop.sh
deleted file mode 100755
index 3983ac74f..000000000
--- a/tools/pounder21/test_scripts/passloop.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/sh
-
-# Repeatedly pass a test.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-$POUNDER_HOME/timed_loop 1 $POUNDER_HOME/test_scripts/pass.sh
-exit $?
diff --git a/tools/pounder21/test_scripts/ping_nfs_server b/tools/pounder21/test_scripts/ping_nfs_server
deleted file mode 100755
index 9325d7113..000000000
--- a/tools/pounder21/test_scripts/ping_nfs_server
+++ /dev/null
@@ -1,29 +0,0 @@
-#!/bin/sh
-
-# Ping NFS server 100 times
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-if [ -z "$NFS_SERVER" -o "$NFS_SERVER" == "0" ]; then
-	echo "NFS server not configured."
-	exit -1
-fi
-
-ping -c 100 -s 1024 "$NFS_SERVER"
-
-exit $?
diff --git a/tools/pounder21/test_scripts/ramsnake b/tools/pounder21/test_scripts/ramsnake
deleted file mode 100755
index 19ce45225..000000000
--- a/tools/pounder21/test_scripts/ramsnake
+++ /dev/null
@@ -1,68 +0,0 @@
-#!/bin/bash
-
-# Control script for a program that tests shared memory access speeds.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-# Kill anything in this process group
-trap 'kill -9 `pgrep -P $$` 2> /dev/null; exit 0' 1 2 15
-
-# Try to find ramsnake
-PROGRAM="$POUNDER_SRCDIR/ramsnake/snake.exe"
-if [ -z "$PROGRAM" ]; then
-	echo "Cannot find ramsnake; did you run Install?"
-	exit -1
-fi
-
-# We want enough nodes to consume 1/2 of whatever RAM isn't being used
-# for programs or buffers.  Note that we must divide again by the number
-# of CPUs in the system so that the _total_ memory used is 1/4.
-#
-# Does the LONG_BIT config variable really refer to the size
-# of a pointer?
-MEM_AVAIL=$(( `grep ^MemFree: /proc/meminfo | awk -F " " '{print $2}'` + `grep ^Cached: /proc/meminfo | awk -F " " '{print $2}'`))
-NUM_NODES=$(( (MEM_AVAIL * 1024 / (2 * NR_CPUS)) / $((`getconf LONG_BIT` / 8)) ))
-
-# Start up a bunch of ramsnakes in the background.
-for ((k=0; k < $NR_CPUS; k++))
-do
-	"$POUNDER_HOME/timed_loop" 300 "$PROGRAM" -p $NR_CPUS -n $NUM_NODES &
-done
-
-LOGFILE=/proc/$$/fd/1
-OLD_ERRORS=0
-
-# Check for errors while snake runs.
-while [ `pgrep -P $$ | wc -l` -gt 1 ];
-do
-	NEW_ERRORS=`egrep -ic "(segmentation|fault|error|illegal)" $LOGFILE`
-	ERRORS=$(( NEW_ERRORS - OLD_ERRORS ))
-	if [ $ERRORS -eq 255 ]; then
-		ERRORS=254
-	fi
-
-	if [ $ERRORS -gt 0 ]; then
-		echo "Program crash detected.  Aborting."
-		exit 1
-	fi
-	OLD_ERRORS=$ERRORS
-	sleep 5
-done
-
-# Failures will probably hang the system or segfault snake.
-exit 0
diff --git a/tools/pounder21/test_scripts/random_syscall b/tools/pounder21/test_scripts/random_syscall
deleted file mode 100755
index 9d00bad4f..000000000
--- a/tools/pounder21/test_scripts/random_syscall
+++ /dev/null
@@ -1,70 +0,0 @@
-#!/bin/bash
-
-# Pound on syscall interface
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-RANDASYS_USER=daemon
-RANDASYS_UID=`id -u $RANDASYS_USER`
-RANDASYS_GROUP=daemon
-RANDASYS_GID=`id -u $RANDASYS_GROUP`
-
-# Try to find randasyscall on the system
-PROGRAM=`ls "$POUNDER_TMPDIR/randasys" 2> /dev/null`
-if [ -z "$PROGRAM" ]; then
-	PROGRAM=`ls "$POUNDER_SRCDIR/randasyscall/randasys"`
-	if [ -z "$PROGRAM" ]; then
-		echo "Cannot find randasys; did you run Install?"
-		exit -1
-	fi
-fi
-
-trap 'rm -rf "$POUNDER_TMPDIR/randasys"; kill -9 `pgrep -P $$` 2> /dev/null; exit 0' 1 2 15
-
-# Change the permissions on the log file
-chown $RANDASYS_USER `ls -la /proc/$$/fd/1 | awk -F " " '{print $11}'`
-
-# We need to dump this somewhere where the daemon user can read this
-cp "$PROGRAM" "/tmp"
-PROGRAM="/tmp/randasys"
-
-# Save a copy of dmesg
-dmesg > "$POUNDER_TMPDIR/randasys-before"
-
-# Start the program
-for ((k=0; k < $NR_CPUS; k++))
-do
-	"$POUNDER_HOME/fancy_timed_loop" 900 $RANDASYS_UID $RANDASYS_GID 9 "$PROGRAM" &
-	"$POUNDER_HOME/fancy_timed_loop" 900 $RANDASYS_UID $RANDASYS_GID 9 "$PROGRAM" -z &
-done
-
-# Wait for this to finish (it won't)
-wait
-
-# Save another copy of dmesg
-dmesg > "$POUNDER_TMPDIR/randasys-after"
-echo "CECHK 5"
-
-# Diff
-DMESG_DIFF_LINES=`diff "$POUNDER_TMPDIR/randasys-before" "$POUNDER_TMPDIR/randasys-after" | wc -l`
-diff "$POUNDER_TMPDIR/randasys-before" "$POUNDER_TMPDIR/randasys-after"
-rm -rf "$POUNDER_TMPDIR/randasys-before" "$POUNDER_TMPDIR/randasys-after"
-
-# Failures will show up in the test output.  Or better yet,
-# panic/oops/BUG the machine.
-exit 0
diff --git a/tools/pounder21/test_scripts/screen_blank b/tools/pounder21/test_scripts/screen_blank
deleted file mode 100755
index f611b42a8..000000000
--- a/tools/pounder21/test_scripts/screen_blank
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/bin/bash
-
-# enable blanking, etc
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-(for i in /dev/tty[0-9]* /dev/vc/*; do
-	setterm -reset > $i
-done) 2> /dev/null
-
-exit 0
diff --git a/tools/pounder21/test_scripts/screen_noblank b/tools/pounder21/test_scripts/screen_noblank
deleted file mode 100755
index 55c2c7f07..000000000
--- a/tools/pounder21/test_scripts/screen_noblank
+++ /dev/null
@@ -1,27 +0,0 @@
-#!/bin/bash
-
-# disable blanking
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-(for i in /dev/tty[0-9]* /dev/vc/*; do
-	setterm -reset > $i
-	setterm -blank 0 -msg on -msglevel 8 -powersave off -powerdown 0 > $i
-done) 2> /dev/null
-
-exit 0
diff --git a/tools/pounder21/test_scripts/sigfpe.sh b/tools/pounder21/test_scripts/sigfpe.sh
deleted file mode 100755
index 3776da92e..000000000
--- a/tools/pounder21/test_scripts/sigfpe.sh
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/bin/bash
-
-# Test that dies with a signal
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-kill -FPE $$
-exit 0
diff --git a/tools/pounder21/test_scripts/simpleD b/tools/pounder21/test_scripts/simpleD
deleted file mode 100755
index 0fddc95b7..000000000
--- a/tools/pounder21/test_scripts/simpleD
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-echo simpleD running....
-sleep 100
-exit  $?
diff --git a/tools/pounder21/test_scripts/sleep b/tools/pounder21/test_scripts/sleep
deleted file mode 100755
index 14c95a968..000000000
--- a/tools/pounder21/test_scripts/sleep
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/bin/bash
-
-# Sleep for five seconds.  Dumb test.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-echo $$
-sleep 5
-exit 0
diff --git a/tools/pounder21/test_scripts/statslogging b/tools/pounder21/test_scripts/statslogging
deleted file mode 100755
index f1774eca5..000000000
--- a/tools/pounder21/test_scripts/statslogging
+++ /dev/null
@@ -1,112 +0,0 @@
-#!/bin/sh
-
-#log script, by john stultz (jstultz@us.ibm.com)
-# other bits by darrick wong (djwong@us.ibm.com)
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-trap 'exit 0' 15
-
-function startup() {
-	# change into the pounder log dir
-	if [ -x $POUNDER_LOGDIR ]; then
-		cd $POUNDER_LOGDIR
-	fi
-	#create log dir
-	mkdir statlogs
-	cd statlogs
-}
-
-
-INFOFILE=info
-#generic system info
-function sysinfo() {
-	uname -a >> $INFOFILE
-	printf "\n[cpuinfo]=================\n" >>$INFOFILE
-	cat /proc/cpuinfo >> $INFOFILE
-	printf "\n[meminfo]=================\n" >>$INFOFILE
-	cat /proc/meminfo >> $INFOFILE
-	printf "\n[ifinfo]=================\n" >>$INFOFILE
-	/sbin/ifconfig >> $INFOFILE
-	printf "\n[sysctl]=================\n" >>$INFOFILE
-	sysctl -a >> $INFOFILE
-}
-
-PROC_ENTRIES="buddyinfo diskstats meminfo slabinfo net/netstat net/snmp"
-function procinfo() {
-	#get a timestamp
-	NOW=`date`
-	for i in $PROC_ENTRIES
-	do
-		logfile=`basename $i`
-		printf "\n$NOW\n" >> $logfile.log
-		cat /proc/$i >> $logfile.log
-		sleep 1
-	done
-}
-
-# ten second delay; run 150s before outputting timestamp
-DELAY=10
-COUNT=15
-
-#single shot logging apps
-function singleshots(){
-	echo > vmstat.log
-	echo > iostat.log
-
-	while true; do
-		vmstat $DELAY $COUNT >> vmstat.log
-		NOW=`date`
-		printf "\n$NOW\n\n" >> vmstat.log
-	done &
-
-	IOSTAT=`which iostat 2> /dev/null`
-	if [ -n "$IOSTAT" -a -x "$IOSTAT" ]; then
-		while true; do
-			iostat -x $DELAY $COUNT >> iostat.log
-			NOW=`date`
-			printf "\n$NOW\n\n" >> iostat.log
-		done &
-	fi
-}
-
-# periodically run apps & functions
-function runlogging() {
-	CMDS="procinfo"
-	while true
-	do
-		for i in $CMDS
-		do
-			$i
-			sleep 1
-		done
-		sleep $DELAY
-	done
-}
-
-trap 'exit 0' 15
-
-startup $*
-sysinfo
-singleshots
-tail -f /var/log/messages /var/log/syslog /var/log/daemon.log /var/log/kern.log /var/log/warn /var/log/faillog > system_logs &
-cp -pRdu $POUNDER_HOME/README .
-runlogging
-
-exit 0
diff --git a/tools/pounder21/test_scripts/sysrq-on b/tools/pounder21/test_scripts/sysrq-on
deleted file mode 100755
index 714443fef..000000000
--- a/tools/pounder21/test_scripts/sysrq-on
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/bash
-
-if [ -w /proc/sys/kernel/sysrq ]; then
-	echo 1 > /proc/sys/kernel/sysrq
-fi
-
-exit 0
diff --git a/tools/pounder21/test_scripts/time_consistency b/tools/pounder21/test_scripts/time_consistency
deleted file mode 100755
index 2be6ffccf..000000000
--- a/tools/pounder21/test_scripts/time_consistency
+++ /dev/null
@@ -1,35 +0,0 @@
-#!/bin/sh
-
-# Control script for time consistency tests.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-# How many errors are already here?
-LOGFILE=/proc/$$/fd/1
-OLD_ERRORS=`grep ^--- $LOGFILE | wc -l`
-
-$POUNDER_HOME/timed_loop 600 "$POUNDER_SRCDIR/time_tests/inconsistency-check"
-# Can we find any new errors?
-NEW_ERRORS=`grep ^--- $LOGFILE | wc -l`
-
-TOTAL_ERRORS=$(( NEW_ERRORS - OLD_ERRORS))
-if [ $TOTAL_ERRORS -eq 255 ]; then
-        TOTAL_ERRORS=254
-fi
-exit $TOTAL_ERRORS
diff --git a/tools/pounder21/test_scripts/time_drift b/tools/pounder21/test_scripts/time_drift
deleted file mode 100755
index 1e0f143a2..000000000
--- a/tools/pounder21/test_scripts/time_drift
+++ /dev/null
@@ -1,72 +0,0 @@
-#!/bin/sh
-
-# Monitor NTP drift
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-if [ -z "$NTP_SERVER" -o "$NTP_SERVER" == "0" ]; then
-	echo "NTP server is not configured."
-	exit 255
-fi
-
-# NTP server is set in libpounder.sh
-# Check NTP server every 15 seconds.  Evil, I know.
-FREQ=15
-# Threshold at which we warn about excessive drift
-DWT=100
-# Threshold at which we fail the test because of drift
-DFT=500
-
-LOGFILE=/proc/$$/fd/1
-
-# Why do we need this?  Output is already being logged!
-cp -f $LOGFILE $POUNDER_TMPDIR/ntpdrift-$$
-
-# Do we have a python interpreter?
-PYTHON=`which python`
-if [ -n "$PYTHON" -a -x "$PYTHON" ]; then
-		$POUNDER_HOME/timed_loop 900 "$POUNDER_SRCDIR/time_tests/drift-test.py" $NTP_SERVER $FREQ
-else
-	echo "There is no python interpreter installed.  Aborting."
-	exit -1
-fi
-
-# Did drift-test.py fail to run properly?
-if [ $? -ne 0 ]; then
-	exit 1
-fi
-
-# Did we see any failures in actual drift test?
-ERRORS=0
-cp -f $LOGFILE $POUNDER_TMPDIR/ntpdrift2-$$
-diff -u $POUNDER_TMPDIR/ntpdrift-$$ $LOGFILE | while read a b c d e field drift garbage; do
-	if [ "$field" != "drift:" ]; then
-		continue;
-	fi
-	drift=`echo $drift | awk -F "." '{print $1}'`
-	if [ $drift -gt $DFT -o $drift -lt -$DFT ]; then
-		echo ERROR: drift exceeded $DFT ppm: $a $b \
-		$c $d $e $field $drift $garbage
-		ERRORS=$((ERRORS + 1))
-	elif [ $drift -gt $DWT -o $drift -lt -$DWT ]; then
-		echo WARNING: drift exceeded $DWT ppm: $a $b \
-		$c $d $e $field $drift $garbage
-	fi
-done
-
-exit $ERRORS
diff --git a/tools/pounder21/test_scripts/xterm_stress b/tools/pounder21/test_scripts/xterm_stress
deleted file mode 100755
index f576976cf..000000000
--- a/tools/pounder21/test_scripts/xterm_stress
+++ /dev/null
@@ -1,176 +0,0 @@
-#!/bin/bash -x
-
-# Start an X session, fire up some xterms and GL apps, then bounce them
-# all over the screen.
-
-# Copyright (C) 2003-2006 IBM
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-# X11 testing -- this is a daemon test!
-# Run for 20m
-TEST_DURATION=1200
-
-# Always start X.
-NEED_TO_START_X=1
-#if [ -z "$DISPLAY" ]; then
-#	NEED_TO_START_X=1
-#fi
-
-# Kill test if we don't want it.
-if [ -z "$DO_X_TESTS" -o "$DO_X_TESTS" == "0" ]; then
-	echo "X11 testing is off."
-	exit -1
-fi
-
-# Can we find the startx script?
-RAW_X_SERVER=0
-XSERVER_FILE=`which startx 2> /dev/null`
-if [ -z "$XSERVER_FILE" -o ! -x "$XSERVER_FILE" ]; then
-	RAW_X_SERVER=1
-	XSERVER_FILE=`which X 2> /dev/null`
-	if [ -z "$XSERVER_FILE" -o ! -x "$XSERVER_FILE" ]; then
-		echo "startx script not found."
-		exit -1
-	fi
-fi
-
-# Count X servers
-OLD_XSERVERS=`pgrep -l X | grep -v Xprt | wc -l`
-
-# Start X server
-if [ $NEED_TO_START_X -eq 1 ]; then
-	echo "xterm_stress: Starting X..."
-
-	rm -rf /var/log/Xorg.2.log /var/log/XFree86.2.log
-
-	export DISPLAY=:2
-	if [ $RAW_X_SERVER -eq 0 ]; then
-		$XSERVER_FILE -- $DISPLAY -ac vt9 &
-	else
-		$POUNDER_HOME/timed_loop $TEST_DURATION $XSERVER_FILE $DISPLAY -ac vt9 &
-	fi
-
-	while true; do
-		NEW_XSERVERS=`pgrep -l X | grep -v Xprt | wc -l`
-		if [ $NEW_XSERVERS -gt $OLD_XSERVERS ]; then
-			export XPID=`pgrep -l X -n | grep -v Xprt | awk -F " " '{print $1}'`
-			echo -n " -$XPID" >> $POUNDER_PIDFILE
-			break
-		fi
-	done
-fi
-
-trap 'kill -4 $XPID' 15
-
-# Did we see any failures?
-LOGFILE=`ls /var/log/X*.2.log`
-ERRORS=`egrep -ic "(fatal)" $LOGFILE`
-if [ $ERRORS -gt 0 ]; then
-	if [ $ERRORS -eq 255 ]; then
-		ERRORS=254
-	fi
-	cp $LOGFILE $POUNDER_TMPDIR/x-log-$XPID
-	kill -4 $XPID
-	exit $ERRORS
-fi
-
-# Now start the window manager if we couldn't find startx.
-if [ $NEED_TO_START_X -eq 1 -a $RAW_X_SERVER -eq 1 ]; then
-	sleep 5
-	echo "xterm_stress: Starting twm - 5s"
-	twm &
-fi
-
-# Sleep a little more so that the session can start before
-# we start flooding X with crud.
-sleep 15
-
-# sets the list delimiter to :
-IFS=:
-# Add some screensavers to the path (OpenGL testing)
-export PATH=$PATH:/usr/lib/xscreensaver:/usr/X11R6/lib/xscreensaver
-
-# command list
-cmd="dmesg:ls -l:cat /var/log/messages:dmesg:ls -l:cat /var/log/messages"
-xcmd="sproingies -fps -delay 0:flyingtoasters -fps -delay 0:glmatrix -fps -delay 0"
-
-# Begin logging
-xterm -geom 80x25+0+0 -e "bash -c $POUNDER_SRCDIR/dump_xserver_statm" &
-
-#start text-based programs
-for i in $cmd
-do
-	exe="while true; do $i; done"
-	xterm -geometry 80x25`$POUNDER_SRCDIR/randacoords/coords 600 400` -e "bash -c '$exe'" &
-	sleep 1
-done
-
-#start gui programs
-for i in $xcmd
-do
-	bash -c "$i" &
-	sleep 1
-done
-
-# Put up a top window for top monitoring.
-xterm -geom 100x9+0+0 -e top &
-echo "xterm_stress: Test started"
-
-# Now make the windows go bonkers!
-$POUNDER_SRCDIR/xbonkers/xbonkers -i 500 -s 10000 &
-
-# If we started X via startx, we need to wait 1200s and then
-# kill $XPID.
-if [ $RAW_X_SERVER -eq 0 ]; then
-	sleep $TEST_DURATION
-	kill -4 $XPID
-fi
-
-# Track the number of times we wait for X server to die.
-DIE_TIMEOUT_LOOPS=0
-
-# Loop until the X server goes away
-while true; do
-	XSERVERS=`pgrep -l X | grep -v Xprt | wc -l`
-	if [ $XSERVERS -lt $OLD_XSERVERS ]; then
-		# Did we see any failures?
-		LOGFILE=`ls /var/log/X*.2.log`
-		ERRORS=`egrep -ic "(fatal)" $LOGFILE`
-
-		# There will always be one fatal error--we killed X.
-		exit $((ERRORS - 1))
-	fi
-	if [ $DIE_TIMEOUT_LOOPS -gt 180 ]; then
-		# Three minutes; try something stronger.
-		echo "First attempt to kill X server failed; trying -9."
-		kill -9 $XPID
-	fi
-	if [ $DIE_TIMEOUT_LOOPS -gt 360 ]; then
-		# Six minutes.  Still not dead?  Abort script.
-		echo "Second attempt to kill X server failed.  Aborting."
-		exit -1
-	fi
-
-	OLD_XSERVERS=$XSERVERS
-	DIE_TIMEOUT_LOOPS=$((DIE_TIMEOUT_LOOPS + 1))
-	sleep 1
-done
-
-echo "ERROR: Jumped to somewhere where we should never be."
-# We're not supposed to get here.
-exit 254
diff --git a/tools/pounder21/timed_loop.c b/tools/pounder21/timed_loop.c
deleted file mode 100644
index 3dffba0dc..000000000
--- a/tools/pounder21/timed_loop.c
+++ /dev/null
@@ -1,197 +0,0 @@
-/* Repeatedly run a program for a given length of time. */
-
-/*
- * Copyright (C) 2003-2006 IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <stdio.h>
-#include <string.h>
-#include <strings.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-
-#include "debug.h"
-
-static int res = 0;
-static char *progname;
-static pid_t test_pgrp;
-static FILE *out;
-
-static void int_func(int signum)
-{
-	pounder_fprintf(out,
-			"%s: Killed by interrupt.  Last exit code = %d.\n",
-			progname, res);
-	kill(-test_pgrp, SIGTERM);
-	exit(res);
-}
-
-static void alarm_func(int signum)
-{
-	pounder_fprintf(out, "%s: Killed by timer.  Last exit code = %d.\n",
-			progname, res);
-	kill(-test_pgrp, SIGTERM);
-	exit(res);
-}
-
-/*
-static void term_func(int signum) {
-	exit(res);
-}
-*/
-
-int main(int argc, char *argv[])
-{
-	int secs, stat;
-	pid_t pid;
-	unsigned int revs = 0;
-	struct sigaction zig;
-	int use_max_failures = 0;
-	int max_failures = 0;
-	int fail_counter = 1;
-
-	if (argc < 3) {
-		printf
-		    ("Usage: %s [-m max_failures] time_in_sec command [args]\n",
-		     argv[0]);
-		exit(1);
-	}
-	//by default, set max_failures to whatever the env variable $MAX_FAILURES is
-	char *max_failures_env = getenv("MAX_FAILURES");
-	max_failures = atoi(max_failures_env);
-
-	//if the -m option is used when calling timed_loop, override max_failures
-	//specified by $MAX_FAILURES with the given argument instead
-	if (argc > 4 && strcmp(argv[1], "-m") == 0) {
-		if ((max_failures = atoi(argv[2])) >= 0) {
-			use_max_failures = 1;
-		} else {
-			printf
-			    ("Usage: %s [-m max_failures] time_in_sec command [args]\n",
-			     argv[0]);
-			printf
-			    ("max_failures should be a nonnegative integer\n");
-			exit(1);
-		}
-	}
-
-	out = stdout;
-
-	if (use_max_failures) {
-		progname = strrchr(argv[4], '/');
-		if (progname == NULL) {
-			progname = argv[4];
-		} else {
-			progname++;
-		}
-	} else {
-		progname = strrchr(argv[2], '/');
-		if (progname == NULL) {
-			progname = argv[2];
-		} else {
-			progname++;
-		}
-	}
-
-	/* Set up signals */
-	memset(&zig, 0x00, sizeof(zig));
-	zig.sa_handler = alarm_func;
-	sigaction(SIGALRM, &zig, NULL);
-	zig.sa_handler = int_func;
-	sigaction(SIGINT, &zig, NULL);
-	sigaction(SIGTERM, &zig, NULL);
-
-	/* set up process groups so that we can kill the
-	 * loop test and descendants easily */
-
-	if (use_max_failures) {
-		secs = atoi(argv[3]);
-	} else {
-		secs = atoi(argv[1]);
-	}
-	alarm(secs);
-
-	while (1) {
-		pounder_fprintf(out, "%s: %s loop #%d.\n", progname,
-				start_msg, revs++);
-		pid = fork();
-		if (pid == 0) {
-			if (setpgrp() < 0) {
-				perror("setpgid");
-			}
-			// run the program
-			if (use_max_failures) {
-				if (argc > 5) {
-					stat = execvp(argv[4], &argv[4]);
-				} else {
-					stat = execvp(argv[4], &argv[4]);
-				}
-
-				perror(argv[4]);
-			} else {
-				if (argc > 3) {
-					stat = execvp(argv[2], &argv[2]);
-				} else {
-					stat = execvp(argv[2], &argv[2]);
-				}
-
-				perror(argv[2]);
-			}
-
-			exit(-1);
-		}
-
-		/* save the pgrp of the spawned process */
-		test_pgrp = pid;
-
-		// wait for it to be done
-		if (waitpid(pid, &stat, 0) != pid) {
-			perror("waitpid");
-			exit(1);
-		}
-		// interrogate it
-		if (WIFSIGNALED(stat)) {
-			pounder_fprintf(out, "%s: %s on signal %d.\n",
-					progname, fail_msg, WTERMSIG(stat));
-			res = 255;
-		} else {
-			res = WEXITSTATUS(stat);
-			if (res == 0) {
-				pounder_fprintf(out, "%s: %s.\n", progname,
-						pass_msg);
-			} else if (res < 0 || res == 255) {
-				pounder_fprintf(out,
-						"CHECK %s: %s with code %d.\n",
-						progname, abort_msg, res);
-				exit(-1);
-				// FIXME: add test to blacklist
-			} else {
-				pounder_fprintf(out,
-						"%s: %s with code %d.\n",
-						progname, fail_msg, res);
-				if (max_failures > 0) {
-					if (++fail_counter > max_failures) {
-						exit(-1);
-					}
-				}
-			}
-		}
-	}
-}
-- 
2.18.0

