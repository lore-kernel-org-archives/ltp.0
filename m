Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YDT5n-0003Yw-Km
	for ltp-list@lists.sourceforge.net; Tue, 20 Jan 2015 07:19:15 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YDT5e-0006xd-0P
	for ltp-list@lists.sourceforge.net; Tue, 20 Jan 2015 07:19:15 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t0K7IElm004747
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Jan 2015 15:18:15 +0800
Message-ID: <54BE0079.60504@cn.fujitsu.com>
Date: Tue, 20 Jan 2015 15:15:05 +0800
From: "gux.fnst" <gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1418377899-10697-1-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1418377899-10697-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] power_management: add it into default
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

Ping. Thanks!

Regards,
Xing Gu

On 12/12/2014 05:51 PM, Xing Gu wrote:
> * Modify Makefile.
>
> * Split runpwtests.sh into separate testcases,
>    eg. runpwtests01.sh.
>
> * Use functions in test.sh, eg. tst_brkm.
>
> * Fix error of change_govr.sh, change_freq.sh, etc.
>
> * Since I don't have suitable machines and can't test
>    some testcases' correctness, currently these cases
>    are disabled.
>
> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
> ---
>   configure.ac                                       |  14 -
>   include/mk/features.mk.default                     |   7 -
>   include/mk/features.mk.in                          |   7 -
>   runtest/Makefile                                   |   4 -
>   runtest/power_management_tests                     |   8 +-
>   runtest/power_management_tests_exclusive           |  13 +-
>   scenario_groups/default                            |   1 +
>   testcases/kernel/Makefile                          |   6 +-
>   testcases/kernel/power_management/Makefile         |  10 +-
>   testcases/kernel/power_management/change_freq.sh   |   2 +-
>   testcases/kernel/power_management/change_govr.sh   |   2 +-
>   .../power_management/check_cpufreq_sysfs_files.sh  |   2 +-
>   .../kernel/power_management/cpu_consolidation.py   |   6 +-
>   testcases/kernel/power_management/ilb_test.py      |   2 -
>   testcases/kernel/power_management/lib/Makefile     |  25 ++
>   testcases/kernel/power_management/lib/sched_mc.py  |  50 ++-
>   testcases/kernel/power_management/pm_include.sh    | 121 ++++---
>   testcases/kernel/power_management/runpwtests.sh    | 380 ---------------------
>   testcases/kernel/power_management/runpwtests01.sh  |  60 ++++
>   testcases/kernel/power_management/runpwtests02.sh  |  58 ++++
>   testcases/kernel/power_management/runpwtests03.sh  |  75 ++++
>   testcases/kernel/power_management/runpwtests04.sh  |  48 +++
>   testcases/kernel/power_management/runpwtests05.sh  |  93 +++++
>   testcases/kernel/power_management/runpwtests06.sh  |  62 ++++
>   .../power_management/runpwtests_exclusive01.sh     | 112 ++++++
>   .../power_management/runpwtests_exclusive02.sh     |  82 +++++
>   .../power_management/runpwtests_exclusive03.sh     | 110 ++++++
>   .../power_management/runpwtests_exclusive04.sh     |  67 ++++
>   .../power_management/runpwtests_exclusive05.sh     | 112 ++++++
>   testcases/kernel/power_management/sched_domain.py  |   2 -
>   30 files changed, 1034 insertions(+), 507 deletions(-)
>   create mode 100644 testcases/kernel/power_management/lib/Makefile
>   delete mode 100755 testcases/kernel/power_management/runpwtests.sh
>   create mode 100755 testcases/kernel/power_management/runpwtests01.sh
>   create mode 100755 testcases/kernel/power_management/runpwtests02.sh
>   create mode 100755 testcases/kernel/power_management/runpwtests03.sh
>   create mode 100755 testcases/kernel/power_management/runpwtests04.sh
>   create mode 100755 testcases/kernel/power_management/runpwtests05.sh
>   create mode 100755 testcases/kernel/power_management/runpwtests06.sh
>   create mode 100755 testcases/kernel/power_management/runpwtests_exclusive01.sh
>   create mode 100755 testcases/kernel/power_management/runpwtests_exclusive02.sh
>   create mode 100755 testcases/kernel/power_management/runpwtests_exclusive03.sh
>   create mode 100755 testcases/kernel/power_management/runpwtests_exclusive04.sh
>   create mode 100755 testcases/kernel/power_management/runpwtests_exclusive05.sh
>
> diff --git a/configure.ac b/configure.ac
> index 794059c..0ca21a6 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -102,20 +102,6 @@ fi
>
>   # Testsuites knobs
>
> -# testcases/kernel/power_management requires python.
> -if test "x$with_python" = xyes; then
> -    AC_ARG_WITH([power-management-testsuite],
> -      [AC_HELP_STRING([--with-power-management-testsuite],
> -        [compile and install the x86 power management testsuite (default=no)])],
> -      [with_power_management_testsuite=yes],
> -    )
> -fi
> -if test "x$with_power_management_testsuite" = xyes; then
> -    AC_SUBST([WITH_POWER_MANAGEMENT_TESTSUITE],["yes"])
> -else
> -    AC_SUBST([WITH_POWER_MANAGEMENT_TESTSUITE],["no"])
> -fi
> -
>   AC_ARG_WITH([open-posix-testsuite],
>     [AC_HELP_STRING([--with-open-posix-testsuite],
>       [compile and install the open posix testsuite (default=no)])],
> diff --git a/include/mk/features.mk.default b/include/mk/features.mk.default
> index c9edc1c..69425ca 100644
> --- a/include/mk/features.mk.default
> +++ b/include/mk/features.mk.default
> @@ -34,13 +34,6 @@ HAVE_SECUREBITS			:= no
>
>   # Test suite knobs
>
> -# Enable testcases/kernel/power_management's compile and install?
> -ifeq ($(UCLINUX),1)
> -WITH_POWER_MANAGEMENT_TESTSUITE	:= no
> -else
> -WITH_POWER_MANAGEMENT_TESTSUITE	:=
> -endif
> -
>   # Enable testcases/open_posix_testsuite's compile and install?
>   WITH_OPEN_POSIX_TESTSUITE	:= no
>
> diff --git a/include/mk/features.mk.in b/include/mk/features.mk.in
> index 1fd28f8..49471fd 100644
> --- a/include/mk/features.mk.in
> +++ b/include/mk/features.mk.in
> @@ -34,13 +34,6 @@ HAVE_SECUREBITS			:= @HAVE_SECUREBITS@
>
>   # Test suite knobs
>
> -# Enable testcases/kernel/power_management's compile and install?
> -ifeq ($(UCLINUX),1)
> -WITH_POWER_MANAGEMENT_TESTSUITE	:= no
> -else
> -WITH_POWER_MANAGEMENT_TESTSUITE	:= @WITH_POWER_MANAGEMENT_TESTSUITE@
> -endif
> -
>   # Enable testcases/open_posix_testsuite's compile and install?
>   WITH_OPEN_POSIX_TESTSUITE	:= @WITH_OPEN_POSIX_TESTSUITE@
>
> diff --git a/runtest/Makefile b/runtest/Makefile
> index 8702559..0907ef6 100644
> --- a/runtest/Makefile
> +++ b/runtest/Makefile
> @@ -32,10 +32,6 @@ UNWANTED_FILES		:= Makefile CVS STAX
>
>   INSTALL_MODE		:= 00644
>
> -ifneq ($(WITH_POWER_MANAGEMENT_TESTSUITE),yes)
> -UNWANTED_FILES		+= power_management_tests
> -endif
> -
>   INSTALL_TARGETS		:= $(filter-out $(UNWANTED_FILES),$(notdir $(patsubst $(abs_srcdir)/%,%,$(wildcard $(abs_srcdir)/*))))
>
>   MAKE_TARGETS		:=
> diff --git a/runtest/power_management_tests b/runtest/power_management_tests
> index 5aa18bf..884e615 100644
> --- a/runtest/power_management_tests
> +++ b/runtest/power_management_tests
> @@ -1 +1,7 @@
> -POWER_MANAGEMENT runpwtests.sh
> +#POWER_MANAGEMENT
> +runpwtests01 runpwtests01.sh
> +runpwtests02 runpwtests02.sh
> +runpwtests03 runpwtests03.sh
> +runpwtests04 runpwtests04.sh
> +#runpwtests05 runpwtests05.sh
> +runpwtests06 runpwtests06.sh
> diff --git a/runtest/power_management_tests_exclusive b/runtest/power_management_tests_exclusive
> index a1692df..26176e2 100644
> --- a/runtest/power_management_tests_exclusive
> +++ b/runtest/power_management_tests_exclusive
> @@ -1 +1,12 @@
> -POWER_MANAGEMENT runpwtests.sh -exclusive
> +#POWER_MANAGEMENT exclusive
> +runpwtests01 runpwtests01.sh
> +runpwtests02 runpwtests02.sh
> +runpwtests03 runpwtests03.sh
> +runpwtests04 runpwtests04.sh
> +#runpwtests05 runpwtests05.sh
> +runpwtests06 runpwtests06.sh
> +#runpwtests_exclusive01 runpwtests_exclusive01.sh
> +#runpwtests_exclusive02 runpwtests_exclusive02.sh
> +#runpwtests_exclusive03 runpwtests_exclusive03.sh
> +#runpwtests_exclusive04 runpwtests_exclusive04.sh
> +#runpwtests_exclusive05 runpwtests_exclusive05.sh
> diff --git a/scenario_groups/default b/scenario_groups/default
> index 3a55702..0c2505f 100644
> --- a/scenario_groups/default
> +++ b/scenario_groups/default
> @@ -20,6 +20,7 @@ connectors
>   admin_tools
>   timers
>   power_management_tests
> +power_management_tests_exclusive
>   numa
>   hugetlb
>   commands
> diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
> index 50a12fa..689350b 100644
> --- a/testcases/kernel/Makefile
> +++ b/testcases/kernel/Makefile
> @@ -53,11 +53,7 @@ SUBDIRS			+= connectors \
>   			   timers \
>   			   tracing \
>   			   module \
> -
> -ifeq ($(WITH_POWER_MANAGEMENT_TESTSUITE),yes)
> -SUBDIRS			+= power_management
> -endif
> -
> +			   power_management
>   endif
>
>   MAKE_DEPS		:= include/linux_syscall_numbers.h
> diff --git a/testcases/kernel/power_management/Makefile b/testcases/kernel/power_management/Makefile
> index 24f75f8..bc189b9 100644
> --- a/testcases/kernel/power_management/Makefile
> +++ b/testcases/kernel/power_management/Makefile
> @@ -13,8 +13,8 @@
>   ## for more details.                                                          ##
>   ##                                                                            ##
>   ## You should have received a copy of the GNU General Public License          ##
> -## along with this program;  if not, write to the Free Software               ##
> -## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
> +## along with this program;  if not, write to the Free Software Foundation,   ##
> +## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
>   ##                                                                            ##
>   ################################################################################
>
> @@ -22,10 +22,8 @@ top_srcdir		?= ../../..
>
>   include $(top_srcdir)/include/mk/testcases.mk
>
> -vpath %.c $(srcdir):$(top_srcdir)/lib
> -
> -INSTALL_TARGETS		:= lib/*.py *.py *.sh
> +INSTALL_TARGETS		:= *.py *.sh
>
>   MAKE_DEPS		+= $(APICMDS_DIR)/tst_kvercmp
>
> -include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/kernel/power_management/change_freq.sh b/testcases/kernel/power_management/change_freq.sh
> index 204e21f..3a971d2 100755
> --- a/testcases/kernel/power_management/change_freq.sh
> +++ b/testcases/kernel/power_management/change_freq.sh
> @@ -5,7 +5,7 @@ available_freq=$(get_supporting_freq)
>   available_govr=$(get_supporting_govr)
>   RC=0
>
> -total_cpus=$(no_of_cpus)
> +total_cpus=$(tst_ncpus)
>   (( total_cpus-=1 ))
>
>   if ( echo ${available_govr} | grep -i "userspace" 2>&1 >/dev/null ) ; then
> diff --git a/testcases/kernel/power_management/change_govr.sh b/testcases/kernel/power_management/change_govr.sh
> index 4c2546e..bfe6c5b 100755
> --- a/testcases/kernel/power_management/change_govr.sh
> +++ b/testcases/kernel/power_management/change_govr.sh
> @@ -3,7 +3,7 @@
>   . pm_include.sh
>   available_govr=$(get_supporting_govr)
>
> -total_cpus=$(no_of_cpus)
> +total_cpus=$(tst_ncpus)
>   (( total_cpus-=1 ))
>   RC=0
>
> diff --git a/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh b/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh
> index cb51aa0..dcf8a1d 100755
> --- a/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh
> +++ b/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh
> @@ -2,7 +2,7 @@
>
>   . pm_include.sh
>
> -total_cpus=$(no_of_cpus)
> +total_cpus=$(tst_ncpus)
>   (( total_cpus-=1 ))
>   RC=0
>
> diff --git a/testcases/kernel/power_management/cpu_consolidation.py b/testcases/kernel/power_management/cpu_consolidation.py
> index 992a745..b15bb9b 100755
> --- a/testcases/kernel/power_management/cpu_consolidation.py
> +++ b/testcases/kernel/power_management/cpu_consolidation.py
> @@ -6,8 +6,6 @@
>   import os
>   import sys
>   import time
> -LIB_DIR = "%s/lib" % os.path.dirname(__file__)
> -sys.path.append(LIB_DIR)
>   from optparse import OptionParser
>   from sched_mc import *
>
> @@ -80,6 +78,8 @@ def main(argv=None):
>
>               generate_report()
>               status = validate_cpu_consolidation("partial", work_ld, options.mc_value, options.smt_value)
> +            if background == "yes":
> +                stop_wkld(work_ld)
>               if status == 0:
>                   print "INFO: Consolidation worked sched_smt &(/) sched_mc is set"
>                   #Disable sched_smt & sched_mc interface values
> @@ -95,8 +95,10 @@ def main(argv=None):
>                       smt_value = 0
>
>                   if work_ld == "kernbench":
> +                    trigger_kernbench (smt_value, "partial", background, pinned, "no")
>                       time.sleep(240)
>                   else:
> +                    trigger_ebizzy (smt_value, "partial", duration, background, pinned)
>                       time.sleep(120)
>
>                   generate_report()
> diff --git a/testcases/kernel/power_management/ilb_test.py b/testcases/kernel/power_management/ilb_test.py
> index cec0b29..ec990bc 100755
> --- a/testcases/kernel/power_management/ilb_test.py
> +++ b/testcases/kernel/power_management/ilb_test.py
> @@ -5,8 +5,6 @@
>
>   import os
>   import sys
> -LIB_DIR = "%s/lib" % os.path.dirname(__file__)
> -sys.path.append(LIB_DIR)
>   from optparse import OptionParser
>   from sched_mc import *
>
> diff --git a/testcases/kernel/power_management/lib/Makefile b/testcases/kernel/power_management/lib/Makefile
> new file mode 100644
> index 0000000..cf7f079
> --- /dev/null
> +++ b/testcases/kernel/power_management/lib/Makefile
> @@ -0,0 +1,25 @@
> +#
> +# Copyright (c) 2014 Fujitsu Ltd.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License along
> +# with this program; if not, write to the Free Software Foundation, Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +
> +top_srcdir                      ?= ../../../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +INSTALL_TARGETS		:= *.py
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/power_management/lib/sched_mc.py b/testcases/kernel/power_management/lib/sched_mc.py
> index cb78b55..1687f6f 100755
> --- a/testcases/kernel/power_management/lib/sched_mc.py
> +++ b/testcases/kernel/power_management/lib/sched_mc.py
> @@ -319,25 +319,17 @@ def trigger_ebizzy (sched_smt, stress, duration, background, pinned):
>       try:
>           threads = get_job_count(stress, "ebizzy", sched_smt)
>           olddir = os.getcwd()
> -        path = '%s/utils/benchmark' % os.environ['LTPROOT']
> +        path = '%s/testcases/bin' % os.environ['LTPROOT']
>           os.chdir(path)
> -        wklds_avlbl = list()
> -        workload = "ebizzy"
> -        workload_dir = ""
> -
> -        # Use the latest version of similar workload available
> +        workload_file = ""
>           for file_name in os.listdir('.'):
> -            if file_name.find(workload) != -1:
> -                wklds_avlbl.append(file_name)
> -
> -        wklds_avlbl.sort()
> -        workload_dir = wklds_avlbl[len(wklds_avlbl)-1]
> -        if workload_dir != "":
> -            new_path = os.path.join(path,"%s" % workload_dir)
> +            if file_name == "ebizzy":
> +                workload_file = file_name
> +                break
> +        if workload_file != "":
>               get_proc_data(stats_start)
>               get_proc_loc_count(intr_start)
>               try:
> -                os.chdir(new_path)
>                   if background == "yes":
>                       succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null &'
>                           % (threads, duration))
> @@ -356,13 +348,16 @@ def trigger_ebizzy (sched_smt, stress, duration, background, pinned):
>                       #in background
>                       #get_proc_loc_count(intr_stop)
>                       #get_proc_data(stats_stop)
> -		else:
> +                else:
>                       print "INFO: ebizzy workload triggerd failed"
>                       os.chdir(olddir)
>                       sys.exit(1)
>               except Exception, details:
>                   print "Ebizzy workload trigger failed ", details
>                   sys.exit(1)
> +        else:
> +            print "INFO: ebizzy benchmark not found"
> +            sys.exit(1)
>       except Exception, details:
>           print "Ebizzy workload trigger failed ", details
>           sys.exit(1)
> @@ -378,21 +373,18 @@ def trigger_kernbench (sched_smt, stress, background, pinned, perf_test):
>
>           dst_path = "/root"
>           olddir = os.getcwd()
> -        path = '%s/utils/benchmark' % os.environ['LTPROOT']
> +        path = '%s/testcases/bin' % os.environ['LTPROOT']
>           os.chdir(path)
> -        wklds_avlbl = list()
> +        workload_file = ""
>           for file_name in os.listdir('.'):
> -            if file_name.find("kernbench") != -1:
> -                wklds_avlbl.append(file_name)
> -        if len(wklds_avlbl):
> -            wklds_avlbl.sort()
> -            workload_dir = wklds_avlbl[len(wklds_avlbl)-1]
> -            if workload_dir != "":
> -                benchmark_path = os.path.join(path,"%s" % workload_dir)
> -            else:
> -                print "INFO: kernbench benchmark not found"
> -                sys.exit(1)
> -        os.chdir(olddir)
> +            if file_name == "kernbench":
> +                workload_file = file_name
> +                break
> +        if workload_file != "":
> +            benchmark_path = path
> +        else:
> +            print "INFO: kernbench benchmark not found"
> +            sys.exit(1)
>
>           os.chdir(dst_path)
>           linux_source_dir=""
> @@ -405,7 +397,7 @@ def trigger_kernbench (sched_smt, stress, background, pinned, perf_test):
>           else:
>               print "INFO: Linux kernel source not found in /root. Workload\
>                  Kernbench cannot be executed"
> -	    sys.exit(1)
> +            sys.exit(1)
>
>           get_proc_data(stats_start)
>           get_proc_loc_count(intr_start)
> diff --git a/testcases/kernel/power_management/pm_include.sh b/testcases/kernel/power_management/pm_include.sh
> index b1867e6..70ea4d2 100755
> --- a/testcases/kernel/power_management/pm_include.sh
> +++ b/testcases/kernel/power_management/pm_include.sh
> @@ -30,7 +30,8 @@ get_topology() {
>   	for cpu in $(seq 0 "${total_cpus}" )
>   	do
>   		cpus[$cpu]=cpu${cpu}
> -		phyid[$cpu]=$(cat /sys/devices/system/cpu/cpu${cpu}/topology/physical_package_id)
> +		phyid[$cpu]=$(cat \
> +		/sys/devices/system/cpu/cpu${cpu}/topology/physical_package_id)
>   	done
>   	j=0
>   	while [ "${j}" -lt "${total_cpus}" ]
> @@ -50,18 +51,22 @@ check_cpufreq() {
>   	for cpu in $(seq 0 "${total_cpus}" )
>   	do
>   		if [ ! -d /sys/devices/system/cpu/cpu${cpu}/cpufreq ] ; then
> -			echo "NOSUPPORT: cpufreq support not found please check Kernel configuration or BIOS settings"
> +			echo "NOSUPPORT: cpufreq support not" \
> +				"found please check Kernel configuration" \
> +				"or BIOS settings"
>   			exit $NOSUPPORT
>   		fi
>   	done
>   }
>
>   get_supporting_freq() {
> -	cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_frequencies | uniq
> +	cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_frequencies \
> +		| uniq
>   }
>
>   get_supporting_govr() {
> -	cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_governors | uniq
> +	cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_governors \
> +		| uniq
>   }
>
>   is_hyper_threaded() {
> @@ -102,7 +107,9 @@ check_input() {
>   }
>
>   is_multi_socket() {
> -	no_of_sockets=`cat /sys/devices/system/cpu/cpu?/topology/physical_package_id | uniq | wc -l`
> +	no_of_sockets=`cat \
> +		/sys/devices/system/cpu/cpu?/topology/physical_package_id \
> +		| uniq | wc -l`
>   	[ $no_of_sockets -gt 1 ] ; return $?
>   }
>
> @@ -119,7 +126,8 @@ is_multi_core() {
>
>   is_dual_core() {
>   	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
> -        cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
> +        cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq \
> +			| cut -f2 -d':'`
>           if [ $siblings -eq $cpu_cores ]; then
>                   [ $cpu_cores -eq 2 ]; return $?
>           else
> @@ -130,7 +138,8 @@ is_dual_core() {
>
>   get_kernel_version() {
>   	# Get kernel minor version
> -	export kernel_version=`uname -r | awk -F. '{print $1"."$2"."$3}' | cut -f1 -d'-'`
> +	export kernel_version=`uname -r | awk -F. '{print $1"."$2"."$3}' \
> +		| cut -f1 -d'-'`
>   }
>
>   get_valid_input() {
> @@ -146,42 +155,46 @@ analyze_result_hyperthreaded() {
>   	sched_mc=$1
>       pass_count=$2
>       sched_smt=$3
> +	PASS="Test PASS"
> +	FAIL="Test FAIL"
>
> +	RC=0
>   	case "$sched_mc" in
>   	0)
>   		case "$sched_smt" in
>   		0)
>   			if [ $pass_count -lt 5 ]; then
> -				tst_resm TPASS "cpu consolidation failed for sched_mc=\
> -$sched_mc & sched_smt=$sched_smt"
> +				echo "${PASS}: cpu consolidation failed for" \
> +					"sched_mc=$sched_mc & sched_smt=$sched_smt"
>   			else
>   				RC=1
> -				tst_resm TFAIL "cpu consolidation passed for sched_mc=\
> -$sched_mc & sched_smt=$sched_smt"
> +				echo "${FAIL}: cpu consolidation passed for" \
> +					"sched_mc=$sched_mc & sched_smt=$sched_smt"
>   			fi
>   			;;
>   		*)
>   			if [ $pass_count -lt 5 ]; then
> -               	tst_resm TFAIL "cpu consolidation for sched_mc=\
> -$sched_mc & sched_smt=$sched_smt"
> -           	else
>   				RC=1
> -				tst_resm TPASS "cpu consolidation for sched_mc=\
> -$sched_mc & sched_smt=$sched_smt"
> +				echo "${FAIL}: cpu consolidation for" \
> +					"sched_mc=$sched_mc & sched_smt=$sched_smt"
> +			else
> +				echo "${PASS}: cpu consolidation for" \
> +					"sched_mc=$sched_mc & sched_smt=$sched_smt"
>   			fi
>   			;;
>   		esac ;;
>   	*)
>   		if [ $pass_count -lt 5 ]; then
> -			tst_resm TFAIL "cpu consolidation for sched_mc=\
> -$sched_mc & sched_smt=$sched_smt"
> -		else
>   			RC=1
> -			tst_resm TPASS "cpu consolidation for sched_mc=\
> -$sched_mc & sched_smt=$sched_smt"
> +			echo "${FAIL}: cpu consolidation for" \
> +				"sched_mc=$sched_mc & sched_smt=$sched_smt"
> +		else
> +			echo "${PASS}: cpu consolidation for" \
> +				"sched_mc=$sched_mc & sched_smt=$sched_smt"
>   		fi
>   		;;
>   	esac
> +	return $RC
>   }
>
>   analyze_package_consolidation_result() {
> @@ -195,84 +208,104 @@ analyze_package_consolidation_result() {
>   		sched_smt=-1
>   	fi
>
> +	PASS="Test PASS"
> +	FAIL="Test FAIL"
> +
> +	RC=0
>   	if [ $hyper_threaded -eq $YES -a $sched_smt -gt -1 ]; then
>   		analyze_result_hyperthreaded $sched_mc $pass_count $sched_smt
>   	else
>   		case "$sched_mc" in
>   	    0)
>       	    if [ $pass_count -lt 5 ]; then
> -        	    tst_resm TPASS "cpu consolidation failed for sched_mc=\
> -$sched_mc"
> +				echo "${PASS}: cpu consolidation failed for" \
> +					"sched_mc=$sched_mc"
>           	else
>   				RC=1
> -            	tst_resm TFAIL "cpu consolidation passed for sched_mc=\
> -$sched_mc"
> -        	fi ;;
> +				echo "${FAIL}: cpu consolidation passed for" \
> +					"sched_mc=$sched_mc"
> +			fi
> +			;;
>       	*)
>   			if [ $pass_count -lt 5 ]; then
> -				tst_resm TFAIL "Consolidation at package level failed for \
> -sched_mc=$sched_mc"
> +				RC=1
> +				echo "${FAIL}: consolidation at package level" \
> +					"failed for sched_mc=$sched_mc"
>   			else
> -				tst_resm TPASS "Consolidation at package level passed for \
> -sched_mc=$sched_mc"
> +				echo "${PASS}: consolidation at package level" \
> +					"passed for sched_mc=$sched_mc"
>   			fi
>           	;;
>       	esac
>   	fi
> +	return $RC
>   }
>
>   analyze_core_consolidation_result() {
>   	sched_smt=$1
>   	pass_count=$2
> +	PASS="Test PASS"
> +	FAIL="Test FAIL"
>
> +	RC=0
>   	case "$sched_smt" in
>   	0)
>   		if [ $pass_count -lt 5 ]; then
> -			tst_resm TPASS "Consolidation at core level failed \
> -when sched_smt=$sched_smt"
> +			echo "${PASS}: consolidation at core level failed" \
> +				"when sched_smt=$sched_smt"
>   		else
> -			tst_resm TFAIL "Consolidation at core level passed for \
> -sched_smt=$sched_smt"
> +			RC=1
> +			echo "${FAIL}: consolidation at core level passed for" \
> +				"sched_smt=$sched_smt"
>   		fi ;;
>   	*)
>   		if [ $pass_count -lt 5 ]; then
>   			RC=1
> -			tst_resm TFAIL "Consolidation at core level failed for \
> -sched_smt=$sched_smt"
> +			echo "${FAIL}: consolidation at core level failed for" \
> +				"sched_smt=$sched_smt"
>   		else
> -			tst_resm TPASS "Consolidation at core level passed for \
> -sched_smt=$sched_smt"
> +			echo "${PASS}: consolidation at core level passed for" \
> +				"sched_smt=$sched_smt"
>   		fi ;;
>   	esac
> +	return $RC
>   }
>
>   analyze_sched_domain_result(){
>   	sched_mc=$1
>   	result=$2
>   	sched_smt=$3
> +	PASS="Test PASS"
> +	FAIL="Test FAIL"
>
> +	RC=0
>   	if [ $hyper_threaded -eq $YES ]; then
>   		if [ $sched_smt ]; then
>   			if [ "$result" = 0 ];then
> -				tst_resm TPASS "sched domain test for sched_mc=$sched_mc & sched_smt=$sched_smt"
> +				echo "${PASS}: sched domain test for" \
> +					"sched_mc=$sched_mc & sched_smt=$sched_smt"
>   			else
>   				RC=1
> -				tst_resm TFAIL "sched domain test sched_mc=$sched_mc & sched_smt=$sched_smt"
> +				echo "${FAIL}: sched domain test for" \
> +					"sched_mc=$sched_mc & sched_smt=$sched_smt"
>   			fi
>   		else
>   			if [ "$result" = 0 ];then
> -				tst_resm TPASS "sched domain test for sched_mc=$sched_mc"
> +				echo "${PASS}: sched domain test for" \
> +					"sched_mc=$sched_mc"
>   			else
>   				RC=1
> -				tst_resm TFAIL "sched domain test for sched_mc=$sched_mc"
> +				echo "${FAIL}: sched domain test for" \
> +					"sched_mc=$sched_mc"
>   			fi
>   		fi
>   	else
>   		if [ "$result" = 0 ];then
> -			tst_resm TPASS "sched domain test for sched_mc=$sched_mc"
> +			echo "${PASS}: sched domain test for sched_mc=$sched_mc"
>   		else
>   			RC=1
> -			tst_resm TFAIL "sched domain test sched_mc=$sched_mc"
> +			echo "${FAIL}: sched domain test for sched_mc=$sched_mc"
>   		fi
>   	fi
> +	return $RC
>   }
> diff --git a/testcases/kernel/power_management/runpwtests.sh b/testcases/kernel/power_management/runpwtests.sh
> deleted file mode 100755
> index 9055964..0000000
> --- a/testcases/kernel/power_management/runpwtests.sh
> +++ /dev/null
> @@ -1,380 +0,0 @@
> -#! /bin/sh
> -################################################################################
> -##                                                                            ##
> -## Copyright (c) International Business Machines  Corp., 2001                 ##
> -##                                                                            ##
> -## This program is free software;  you can redistribute it and#or modify      ##
> -## it under the terms of the GNU General Public License as published by       ##
> -## the Free Software Foundation; either version 2 of the License, or          ##
> -## (at your option) any later version.                                        ##
> -##                                                                            ##
> -## This program is distributed in the hope that it will be useful, but        ##
> -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> -## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> -## for more details.                                                          ##
> -##                                                                            ##
> -## You should have received a copy of the GNU General Public License          ##
> -## along with this program;  if not, write to the Free Software               ##
> -## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
> -##                                                                            ##
> -################################################################################
> -#
> -# File :        runpwtests.sh
> -#
> -# Description:
> -#
> -# Author:       Nageswara R Sastry <nasastry@in.ibm.com>
> -#
> -# History:      26 Aug 2008 - Created this file
> -# 03 Nov 2008 - Added CPUIDLE sysfs testcase
> -#
> -
> -# Exporting Required variables
> -export TST_TOTAL=1
> -#LTPTMP=${TMP}
> -export PATH=${PATH}:.
> -export TCID="Power_Management"
> -export TST_COUNT=0
> -export contacts="mpnayak@linux.vnet.ibm.com"
> -export analysis="/proctstat"
> -
> -YES=0
> -NO=1
> -#List of reusable functions defined in pm_include.sh
> -. pm_include.sh
> -
> -# Function:     main
> -#
> -# Description:  - Execute all tests, exit with test status.
> -#
> -# Exit:         - zero on success
> -#               - non-zero on failure.
> -#
> -RC=0		#Return status
> -
> -# Checking required kernel version and architecture
> -tst_kvercmp 2 6 21; rc=$?
> -if [ $rc -ne 1 -a $rc -ne 2 ] ; then
> -	tst_resm TCONF "Kernel version not supported; not running testcases"
> -	exit 0
> -else
> -	case "$(uname -m)" in
> -	i[4-6]86|x86_64)
> -		;;
> -	*)
> -		tst_resm TCONF "Arch not supported; not running testcases"
> -		exit 0
> -		;;
> -	esac
> -fi
> -
> -tst_kvercmp 2 6 29; rc=$?
> -if [ $rc -eq 2 ] ; then
> -	max_sched_mc=2
> -	max_sched_smt=2
> -else
> -	max_sched_mc=1
> -	max_sched_smt=1
> -fi
> -
> -tst_kvercmp 2 6 31; rc=$?
> -if [ $rc -eq 1 -o $rc -eq 2 ] ; then
> -	timer_migr_support_compatible=1
> -else
> -	timer_migr_support_compatible=0
> -fi
> -
> -is_hyper_threaded; hyper_threaded=$?
> -is_multi_socket; multi_socket=$?
> -is_multi_core; multi_core=$?
> -is_dual_core; dual_core=$?
> -
> -#Checking sched_mc sysfs interface
> -#check_config.sh config_sched_mc || RC=$?
> -TST_COUNT=1
> -if [ $multi_socket -eq $YES -a $multi_core -eq $YES ] ; then
> -	if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
> -		if test_sched_mc.sh ; then
> -			tst_resm TPASS "SCHED_MC sysfs tests"
> -		else
> -			RC=$?
> -			tst_resm TFAIL "SCHED_MC sysfs tests"
> -		fi
> -	else
> -    	tst_resm TCONF "Required kernel configuration for SCHED_MC NOT set"
> -	fi
> -else
> -	if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
> -		tst_resm TFAIL "sched_mc_power_savings interface in system which is not a multi socket &(/) multi core"
> -	else
> -		tst_resm TCONF "Not a suitable architecture for SCHED_MC test"
> -	fi
> -fi
> -
> -# Test sched_smt_power_savings interface on HT machines
> -: $(( TST_COUNT += 1 ))
> -if [ $hyper_threaded -eq $YES ]; then
> -	if [ -f /sys/devices/system/cpu/sched_smt_power_savings ] ; then
> -    	if test_sched_smt.sh; then
> -			tst_resm TPASS "SCHED_SMT sysfs test"
> -		else
> -			RC=$?
> -        	tst_resm TFAIL "SCHED_SMT sysfs test"
> -    	fi
> -	else
> -		RC=$?
> -		tst_resm TFAIL "Required kernel configuration for SCHED_SMT NOT set"
> -	fi
> -else
> -	if [ -f /sys/devices/system/cpu/sched_smt_power_savings ] ; then
> -		RC=$?
> -        tst_resm TFAIL "sched_smt_power_saving interface in system not hyper-threaded"
> -    else
> -        tst_resm TCONF "Required Hyper Threading support for SCHED_SMT test"
> -    fi
> -fi
> -
> -# Checking cpufreq sysfs interface files
> -#check_config.sh config_cpu_freq || RC=$?
> -: $(( TST_COUNT += 1 ))
> -if [ -d /sys/devices/system/cpu/cpu0/cpufreq ] ; then
> -    if check_cpufreq_sysfs_files.sh; then
> -		tst_resm TPASS "CPUFREQ sysfs tests"
> -	else
> -		RC=$?
> -		tst_resm TFAIL "CPUFREQ sysfs tests "
> -	fi
> -
> -    # Changing governors
> -	: $(( TST_COUNT += 1 ))
> -	if change_govr.sh; then
> -		tst_resm TPASS "Changing governors "
> -	else
> -		RC=$?
> -		tst_resm TFAIL "Changing governors "
> -	fi
> -
> -    # Changing frequencies
> -	: $(( TST_COUNT += 1 ))
> -    if change_freq.sh ; then
> -		tst_resm TPASS "Changing frequncies "
> -	else
> -		RC=$?
> -        tst_resm TFAIL "Changing frequncies "
> -    fi
> -
> -    # Loading and Unloading governor related kernel modules
> -	: $(( TST_COUNT += 1 ))
> -    if pwkm_load_unload.sh ; then
> -		tst_resm TPASS "Loading and Unloading of governor kernel \
> -modules"
> -	else
> -		RC=$?
> -        tst_resm TFAIL "Loading and Unloading of governor kernel \
> -        modules got failed"
> -    fi
> -else
> -    tst_resm TCONF "Required kernel configuration for CPU_FREQ NOT set"
> -fi
> -
> -# Checking cpuidle sysfs interface files
> -: $(( TST_COUNT+=1))
> -if check_cpuidle_sysfs_files.sh ; then
> -	tst_resm TPASS "CPUIDLE sysfs tests passed"
> -else
> -	RC=$?
> -    tst_resm TFAIL "CPUIDLE sysfs tests failed"
> -fi
> -
> -# sched_domain test
> -if ! type python > /dev/null ; then
> -	tst_resm TCONF "Python is not installed, CPU Consolidation\
> -test cannot run"
> -elif ! grep sched_debug -qw /proc/cmdline ; then
> -	tst_resm TCONF "Kernel cmdline parameter 'sched_debug' needed,\
> -CPU Consolidation test cannot run"
> -else
> -	if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
> -    		echo "max sched mc $max_sched_mc"
> -		for sched_mc in `seq 0 $max_sched_mc`; do
> -			: $(( TST_COUNT+=1))
> -			sched_domain.py -c $sched_mc; RC=$?
> -			analyze_sched_domain_result $sched_mc $RC
> -			if [ $hyper_threaded -eq $YES -a -f /sys/devices/system/cpu/sched_smt_power_savings ]; then
> -				get_sched_values sched_smt; max_sched_smt=$?
> -				for sched_smt in `seq 0 $max_sched_smt`; do
> -					# Testcase to validate sched_domain tree
> -					: $(( TST_COUNT+=1))
> -					sched_domain.py -c $sched_mc -t $sched_smt; RC=$?
> -					analyze_sched_domain_result $sched_mc $RC $sched_smt ;
> -				done
> -			fi
> -		done
> -	fi
> -fi
> -
> -: $(( TST_COUNT+=1))
> -if [ -f /proc/sys/kernel/timer_migration ]; then
> -	if [ $timer_migr_support_compatible -eq $YES ]; then
> -		if test_timer_migration.sh; then
> -        	tst_resm TPASS "Timer Migration interface test"
> -    	else
> -        	RC=$?
> -        	tst_resm TFAIL "Timer migration interface test"
> -		fi
> -	fi
> -else
> -	if [ $timer_migr_support_compatible -eq $YES ]; then
> -		RC=$?
> -		tst_resm TFAIL "Timer migration interface missing"
> -	else
> -		tst_resm TCONF "Kernel version does not support Timer migration"
> -	fi
> -fi
> -
> -if [ $# -gt 0 -a "$1" = "-exclusive" ]; then
> -	# Test CPU consolidation
> -	if [ $multi_socket -eq $YES -a $multi_core -eq $YES ]; then
> -		for sched_mc in `seq 0  $max_sched_mc`; do
> -			: $(( TST_COUNT += 1 ))
> -			sched_mc_pass_cnt=0
> -			if [ $sched_mc -eq 2 ]; then
> -				work_load="kernbench"
> -			else
> -				work_load="ebizzy"
> -			fi
> -			for repeat_test in `seq 1  10`; do
> -				#Testcase to validate CPU consolidation for sched_mc
> -				if cpu_consolidation.py -c $sched_mc -w $work_load ; then
> -					: $(( sched_mc_pass_cnt += 1 ))
> -				fi
> -			done
> -			analyze_package_consolidation_result $sched_mc $sched_mc_pass_cnt
> -
> -			if [ $hyper_threaded -eq $YES ]; then
> -				for sched_smt in `seq 0 $max_sched_smt`; do
> -					: $(( TST_COUNT += 1 ))
> -					sched_mc_smt_pass_cnt=0
> -					for repeat_test in `seq 1  10`; do
> -						# Testcase to validate CPU consolidation for
> -						# for sched_mc & sched_smt with stress=50%
> -						if cpu_consolidation.py -c $sched_mc -t $sched_smt -w $work_load; then
> -							: $(( sched_mc_smt_pass_cnt += 1 ))
> -						fi
> -					done
> -					analyze_package_consolidation_result $sched_mc $sched_mc_smt_pass_cnt $sched_smt
> -				done
> -			fi
> -		done
> -
> -	fi
> -
> -	if [ $hyper_threaded -eq $YES -a $multi_socket -eq $YES -a $multi_core -eq $NO ]; then
> -			#Testcase to validate consolidation at core level
> -			for sched_smt in `seq 0 $max_sched_smt`; do
> -				if [ $sched_smt -eq 2 ]; then
> -				 	work_load="kernbench"
> -				else
> -					work_load="ebizzy"
> -				fi
> -				sched_smt_pass_cnt=0
> -				: $(( TST_COUNT += 1 ))
> -				stress="thread"
> -				for repeat_test in `seq 1  10`; do
> -					if cpu_consolidation.py -t $sched_smt -w $work_load -s $stress; then
> -						: $(( sched_smt_pass_cnt += 1 ))
> -					fi
> -				done
> -				analyze_core_consolidation_result $sched_smt $sched_smt_pass_cnt
> -			done
> -	fi
> -
> -	# Verify threads consolidation stops when sched_mc &(/) sched_smt is disabled
> -    if [ $multi_socket -eq $YES -a $multi_core -eq $YES ]; then
> -        for sched_mc in `seq 1  $max_sched_mc`; do
> -			: $(( TST_COUNT += 1 ))
> -
> -			# Vary sched_mc from 1/2 to 0 when workload is running and ensure that
> -			# tasks do not consolidate to single package when sched_mc is set to 0
> -			if cpu_consolidation.py -v -c $sched_mc; then
> -            	tst_resm TPASS "CPU consolidation test by varying sched_mc $sched_mc to 0"
> -        	else
> -            	tst_resm TFAIL "CPU consolidation test by varying sched_mc $sched_mc to 0"
> -        	fi
> -
> -			if [ $hyper_threaded -eq $YES ]; then
> -				for sched_smt in `seq 1  $max_sched_smt`; do
> -					if [ $sched_smt -eq $sched_mc ]; then
> -						# Vary sched_mc & sched_smt from 1 to 0 & 2 to 0 when workload is running and ensure that
> -            			# tasks do not consolidate to single package when sched_mc is set to 0
> -            			: $(( TST_COUNT += 1 ))
> -						if cpu_consolidation.py -v -c $sched_mc -t $sched_smt; then
> -							tst_resm TPASS "CPU consolidation test by varying sched_mc \
> -& sched_smt from $sched_mc to 0"
> -						else
> -							tst_resm TFAIL "CPU consolidation test by varying sched_mc \
> -& sched_smt from $sched_mc to 0"
> -						fi
> -					fi
> -				done
> -			fi
> -		done
> -	fi
> -
> -    # Verify threads consolidation stops when sched_smt is disabled in HT systems
> -	if [ $hyper_threaded -eq $YES -a $multi_socket -eq $YES ]; then
> -		# Vary only sched_smt from 1 to 0 when workload is running and ensure that
> -		# tasks do not consolidate to single core when sched_smt is set to 0
> -		: $(( TST_COUNT += 1 ))
> -		if cpu_consolidation.py -v -t 1; then
> -			tst_resm TPASS "CPU consolidation test by varying sched_smt from 1 to 0"
> -		else
> -			tst_resm TFAIL "CPU consolidation test by varying sched_smt from 1 to 0"
> -		fi
> -
> -        # Vary only sched_smt from 2 to 0 when workload is running and ensure that
> -        # tasks do not consolidate to single core when sched_smt is set to 0
> -        : $(( TST_COUNT += 1 ))
> -        if cpu_consolidation.py -v -t 2; then
> -            tst_resm TPASS "CPU consolidation test by varying sched_smt 2 to 0"
> -        else
> -            tst_resm TFAIL "CPU consolidation test by varying sched_smt 2 to 0"
> -        fi
> -
> -	fi
> -
> -	# Verify ILB runs in same package as workload
> -    if [ $multi_socket -eq $YES -a $multi_core -eq $YES ]; then
> -		for sched_mc in `seq 1 $max_sched_mc`; do
> -			: $(( TST_COUNT += 1 ))
> -            if [ $sched_mc -eq 2 ]; then
> -                work_load="kernbench"
> -            else
> -                work_load="ebizzy"
> -            fi
> -
> -            ilb_test.py -c $sched_mc -w $work_load; RC=$?
> -			if [ $RC -eq 0 ]; then
> -				tst_resm TPASS "ILB & workload in same package for sched_mc=$sched_mc"
> -			else
> -				tst_resm TFAIL "ILB & workload did not run in same package for sched_mc=$sched_mc\
> -. Ensure CONFIG_NO_HZ is set"
> -			fi
> -			if [ $hyper_threaded -eq $YES ]; then
> -				for sched_smt in `seq 1 $max_sched_smt`; do
> -					: $(( TST_COUNT += 1 ))
> -					ilb_test.py -c $sched_mc -t sched_smt -w $work_load; RC=$?
> - 					if [ $RC -eq 0 ]; then
> -						tst_resm TPASS "ILB & workload in same package for sched_mc=$sched_mc \
> -& sched_smt=$sched_smt"
> -					else
> -						tst_resm TFAIL "ILB & workload did not execute in same package for \
> -sched_mc=$sched_mc & sched_smt=$sched_smt. Ensure CONFIG_NO_HZ is set"
> -					fi
> -				done
> -			fi
> -		done
> -	fi
> -fi
> -
> -exit $RC
> diff --git a/testcases/kernel/power_management/runpwtests01.sh b/testcases/kernel/power_management/runpwtests01.sh
> new file mode 100755
> index 0000000..0e5dd1c
> --- /dev/null
> +++ b/testcases/kernel/power_management/runpwtests01.sh
> @@ -0,0 +1,60 @@
> +#! /bin/sh
> +#
> +# Copyright (c) International Business Machines  Corp., 2001
> +# Author: Nageswara R Sastry <nasastry@in.ibm.com>
> +#
> +# This program is free software;  you can redistribute it and#or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful, but
> +# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> +# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +# for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program;  if not, write to the Free Software Foundation,
> +# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +#
> +
> +export TCID="Power_Management01"
> +export TST_TOTAL=1
> +
> +. test.sh
> +. pm_include.sh
> +
> +# Checking required kernel version and architecture
> +tst_kvercmp 2 6 21; rc=$?
> +if [ $rc -ne 1 -a $rc -ne 2 ] ; then
> +	tst_brkm TCONF "Kernel version not supported; not running testcases"
> +else
> +	case "$(uname -m)" in
> +	i[4-6]86|x86_64)
> +		;;
> +	*)
> +		tst_brkm TCONF "Arch not supported; not running testcases"
> +		;;
> +	esac
> +fi
> +
> +# Checking sched_mc sysfs interface
> +is_multi_socket; multi_socket=$?
> +is_multi_core; multi_core=$?
> +if [ ! -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
> +	tst_brkm TCONF "Required kernel configuration for SCHED_MC" \
> +		"NOT set"
> +else
> +	if [ $multi_socket -ne 0 -a $multi_core -ne 0 ] ; then
> +		tst_brkm TCONF "sched_mc_power_savings interface in system" \
> +			"which is not a multi socket &(/) multi core"
> +	fi
> +fi
> +
> +if test_sched_mc.sh ; then
> +	tst_resm TPASS "SCHED_MC sysfs tests"
> +else
> +	tst_resm TFAIL "SCHED_MC sysfs tests"
> +fi
> +
> +tst_exit
> diff --git a/testcases/kernel/power_management/runpwtests02.sh b/testcases/kernel/power_management/runpwtests02.sh
> new file mode 100755
> index 0000000..84f6f98
> --- /dev/null
> +++ b/testcases/kernel/power_management/runpwtests02.sh
> @@ -0,0 +1,58 @@
> +#! /bin/sh
> +#
> +# Copyright (c) International Business Machines  Corp., 2001
> +# Author: Nageswara R Sastry <nasastry@in.ibm.com>
> +#
> +# This program is free software;  you can redistribute it and#or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful, but
> +# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> +# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +# for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program;  if not, write to the Free Software Foundation,
> +# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +#
> +
> +export TCID="Power_Management02"
> +export TST_TOTAL=1
> +
> +. test.sh
> +. pm_include.sh
> +
> +# Checking required kernel version and architecture
> +tst_kvercmp 2 6 21; rc=$?
> +if [ $rc -ne 1 -a $rc -ne 2 ] ; then
> +	tst_brkm TCONF "Kernel version not supported; not running testcases"
> +else
> +	case "$(uname -m)" in
> +	i[4-6]86|x86_64)
> +		;;
> +	*)
> +		tst_brkm TCONF "Arch not supported; not running testcases"
> +		;;
> +	esac
> +fi
> +
> +# Check sched_smt_power_savings interface on HT machines
> +is_hyper_threaded; hyper_threaded=$?
> +if [ ! -f /sys/devices/system/cpu/sched_smt_power_savings ] ; then
> +	tst_brkm TCONF "Required kernel configuration for SCHED_SMT NOT set"
> +else
> +	if [ $hyper_threaded -ne 0 ]; then
> +		tst_brkm TCONF "sched_smt_power_saving interface in system" \
> +			"not hyper-threaded"
> +	fi
> +fi
> +
> +if test_sched_smt.sh ; then
> +	tst_resm TPASS "SCHED_SMT sysfs test"
> +else
> +	tst_resm TFAIL "SCHED_SMT sysfs test"
> +fi
> +
> +tst_exit
> diff --git a/testcases/kernel/power_management/runpwtests03.sh b/testcases/kernel/power_management/runpwtests03.sh
> new file mode 100755
> index 0000000..844006d
> --- /dev/null
> +++ b/testcases/kernel/power_management/runpwtests03.sh
> @@ -0,0 +1,75 @@
> +#! /bin/sh
> +#
> +# Copyright (c) International Business Machines  Corp., 2001
> +# Author: Nageswara R Sastry <nasastry@in.ibm.com>
> +#
> +# This program is free software;  you can redistribute it and#or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful, but
> +# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> +# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +# for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program;  if not, write to the Free Software Foundation,
> +# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +#
> +
> +export TCID="Power_Management03"
> +export TST_TOTAL=4
> +
> +. test.sh
> +. pm_include.sh
> +
> +# Checking required kernel version and architecture
> +tst_kvercmp 2 6 21; rc=$?
> +if [ $rc -ne 1 -a $rc -ne 2 ] ; then
> +	tst_brkm TCONF "Kernel version not supported; not running testcases"
> +else
> +	case "$(uname -m)" in
> +	i[4-6]86|x86_64)
> +		;;
> +	*)
> +		tst_brkm TCONF "Arch not supported; not running testcases"
> +		;;
> +	esac
> +fi
> +
> +# Checking cpufreq sysfs interface files
> +if [ ! -d /sys/devices/system/cpu/cpu0/cpufreq ] ; then
> +	tst_brkm TCONF "Required kernel configuration for CPU_FREQ NOT set"
> +fi
> +
> +if check_cpufreq_sysfs_files.sh ; then
> +	tst_resm TPASS "CPUFREQ sysfs tests"
> +else
> +	tst_resm TFAIL "CPUFREQ sysfs tests"
> +fi
> +
> +# Changing governors
> +if change_govr.sh ; then
> +	tst_resm TPASS "Changing governors"
> +else
> +	tst_resm TFAIL "Changing governors"
> +fi
> +
> +# Changing frequencies
> +if change_freq.sh ; then
> +	tst_resm TPASS "Changing frequncies"
> +else
> +    tst_resm TFAIL "Changing frequncies"
> +fi
> +
> +# Loading and Unloading governor related kernel modules
> +if pwkm_load_unload.sh ; then
> +	tst_resm TPASS "Loading and Unloading of governor kernel" \
> +		"modules"
> +else
> +	tst_resm TFAIL "Loading and Unloading of governor kernel" \
> +		"modules got failed"
> +fi
> +
> +tst_exit
> diff --git a/testcases/kernel/power_management/runpwtests04.sh b/testcases/kernel/power_management/runpwtests04.sh
> new file mode 100755
> index 0000000..5b70f39
> --- /dev/null
> +++ b/testcases/kernel/power_management/runpwtests04.sh
> @@ -0,0 +1,48 @@
> +#! /bin/sh
> +#
> +# Copyright (c) International Business Machines  Corp., 2001
> +# Author: Nageswara R Sastry <nasastry@in.ibm.com>
> +#
> +# This program is free software;  you can redistribute it and#or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful, but
> +# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> +# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +# for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program;  if not, write to the Free Software Foundation,
> +# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +#
> +
> +export TCID="Power_Management04"
> +export TST_TOTAL=1
> +
> +. test.sh
> +. pm_include.sh
> +
> +# Checking required kernel version and architecture
> +tst_kvercmp 2 6 21; rc=$?
> +if [ $rc -ne 1 -a $rc -ne 2 ] ; then
> +	tst_brkm TCONF "Kernel version not supported; not running testcases"
> +else
> +	case "$(uname -m)" in
> +	i[4-6]86|x86_64)
> +		;;
> +	*)
> +		tst_brkm TCONF "Arch not supported; not running testcases"
> +		;;
> +	esac
> +fi
> +
> +# Checking cpuidle sysfs interface files
> +if check_cpuidle_sysfs_files.sh ; then
> +	tst_resm TPASS "CPUIDLE sysfs tests passed"
> +else
> +    tst_resm TFAIL "CPUIDLE sysfs tests failed"
> +fi
> +
> +tst_exit
> diff --git a/testcases/kernel/power_management/runpwtests05.sh b/testcases/kernel/power_management/runpwtests05.sh
> new file mode 100755
> index 0000000..0867a3c
> --- /dev/null
> +++ b/testcases/kernel/power_management/runpwtests05.sh
> @@ -0,0 +1,93 @@
> +#! /bin/sh
> +#
> +# Copyright (c) International Business Machines  Corp., 2001
> +# Author: Nageswara R Sastry <nasastry@in.ibm.com>
> +#
> +# This program is free software;  you can redistribute it and#or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful, but
> +# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> +# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +# for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program;  if not, write to the Free Software Foundation,
> +# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +#
> +
> +export TCID="Power_Management05"
> +export TST_TOTAL=2
> +
> +. test.sh
> +. pm_include.sh
> +
> +# Checking required kernel version and architecture
> +tst_kvercmp 2 6 21; rc=$?
> +if [ $rc -ne 1 -a $rc -ne 2 ] ; then
> +	tst_brkm TCONF "Kernel version not supported; not running testcases"
> +else
> +	case "$(uname -m)" in
> +	i[4-6]86|x86_64)
> +		;;
> +	*)
> +		tst_brkm TCONF "Arch not supported; not running testcases"
> +		;;
> +	esac
> +fi
> +
> +tst_kvercmp 2 6 29; rc=$?
> +if [ $rc -eq 2 ] ; then
> +	max_sched_mc=2
> +	max_sched_smt=2
> +else
> +	max_sched_mc=1
> +	max_sched_smt=1
> +fi
> +
> +tst_check_cmds python
> +
> +if ! grep sched_debug -qw /proc/cmdline ; then
> +	tst_brkm TCONF "Kernel cmdline parameter 'sched_debug' needed," \
> +		"CPU Consolidation test cannot run"
> +fi
> +
> +is_hyper_threaded; hyper_threaded=$?
> +if [ ! -f /sys/devices/system/cpu/sched_mc_power_savings \
> +	-o $hyper_threaded -ne 0 ] ; then
> +	tst_brkm TCONF "Required kernel configuration for SCHED_MC" \
> +		"NOT set, or sched_mc_power_savings interface in system" \
> +		"which is not hyper-threaded"
> +fi
> +
> +# sched_domain test
> +echo "max sched mc $max_sched_mc"
> +RC=0
> +for sched_mc in `seq 0 $max_sched_mc`; do
> +	sched_domain.py -c $sched_mc; ret=$?
> +	analyze_sched_domain_result $sched_mc $ret; RC=$?
> +done
> +if [ $RC -eq 0 ]; then
> +	tst_resm TPASS "Sched_domain test for sched_mc"
> +else
> +	tst_resm TFAIL "Sched_domain test for sched_mc"
> +fi
> +
> +# Testcase to validate sched_domain tree
> +RC=0
> +for sched_mc in `seq 0 $max_sched_mc`; do
> +	get_sched_values sched_smt; max_sched_smt=$?
> +	for sched_smt in `seq 0 $max_sched_smt`; do
> +		sched_domain.py -c $sched_mc -t $sched_smt; ret=$?
> +		analyze_sched_domain_result $sched_mc $ret $sched_smt; RC=$?
> +	done
> +done
> +if [ $RC -eq 0 ]; then
> +	tst_resm TPASS "Sched_domain test for sched_mc & sched_smt"
> +else
> +	tst_resm TFAIL "Sched_domain test for sched_mc & sched_smt"
> +fi
> +
> +tst_exit
> diff --git a/testcases/kernel/power_management/runpwtests06.sh b/testcases/kernel/power_management/runpwtests06.sh
> new file mode 100755
> index 0000000..384362f
> --- /dev/null
> +++ b/testcases/kernel/power_management/runpwtests06.sh
> @@ -0,0 +1,62 @@
> +#! /bin/sh
> +#
> +# Copyright (c) International Business Machines  Corp., 2001
> +# Author: Nageswara R Sastry <nasastry@in.ibm.com>
> +#
> +# This program is free software;  you can redistribute it and#or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful, but
> +# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> +# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +# for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program;  if not, write to the Free Software Foundation,
> +# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +#
> +
> +export TCID="Power_Management06"
> +export TST_TOTAL=1
> +
> +. test.sh
> +. pm_include.sh
> +
> +# Checking required kernel version and architecture
> +tst_kvercmp 2 6 21; rc=$?
> +if [ $rc -ne 1 -a $rc -ne 2 ] ; then
> +	tst_brkm TCONF "Kernel version not supported; not running testcases"
> +else
> +	case "$(uname -m)" in
> +	i[4-6]86|x86_64)
> +		;;
> +	*)
> +		tst_brkm TCONF "Arch not supported; not running testcases"
> +		;;
> +	esac
> +fi
> +
> +tst_kvercmp 2 6 31; rc=$?
> +if [ $rc -eq 1 -o $rc -eq 2 ] ; then
> +	timer_migr_support_compatible=0
> +else
> +	timer_migr_support_compatible=1
> +fi
> +
> +if [ $timer_migr_support_compatible -eq 1 ]; then
> +	tst_brkm TCONF "Kernel version does not support Timer migration"
> +else
> +	if [ ! -f /proc/sys/kernel/timer_migration ]; then
> +		tst_brkm TBROK "Timer migration interface missing"
> +	fi
> +fi
> +
> +if test_timer_migration.sh; then
> +	tst_resm TPASS "Timer Migration interface test"
> +else
> +	tst_resm TFAIL "Timer migration interface test"
> +fi
> +
> +tst_exit
> diff --git a/testcases/kernel/power_management/runpwtests_exclusive01.sh b/testcases/kernel/power_management/runpwtests_exclusive01.sh
> new file mode 100755
> index 0000000..02b974f
> --- /dev/null
> +++ b/testcases/kernel/power_management/runpwtests_exclusive01.sh
> @@ -0,0 +1,112 @@
> +#! /bin/sh
> +#
> +# Copyright (c) International Business Machines  Corp., 2001
> +# Author: Nageswara R Sastry <nasastry@in.ibm.com>
> +#
> +# This program is free software;  you can redistribute it and#or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful, but
> +# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> +# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +# for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program;  if not, write to the Free Software Foundation,
> +# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +#
> +
> +export TCID="Power_Management_exclusive01"
> +export TST_TOTAL=2
> +
> +. test.sh
> +. pm_include.sh
> +
> +# Checking required kernel version and architecture
> +tst_kvercmp 2 6 21; rc=$?
> +if [ $rc -ne 1 -a $rc -ne 2 ] ; then
> +	tst_brkm TCONF "Kernel version not supported; not running testcases"
> +else
> +	case "$(uname -m)" in
> +	i[4-6]86|x86_64)
> +		;;
> +	*)
> +		tst_brkm TCONF "Arch not supported; not running testcases"
> +		;;
> +	esac
> +fi
> +
> +tst_kvercmp 2 6 29; rc=$?
> +if [ $rc -eq 2 ] ; then
> +	max_sched_mc=2
> +	max_sched_smt=2
> +else
> +	max_sched_mc=1
> +	max_sched_smt=1
> +fi
> +
> +is_hyper_threaded; hyper_threaded=$?
> +is_multi_socket; multi_socket=$?
> +is_multi_core; multi_core=$?
> +if [ $multi_socket -ne 0 -o $multi_core -ne 0 -o \
> +	$hyper_threaded -ne 0 ]; then
> +	tst_brkm TCONF "System is not a multi socket & multi core" \
> +		"& hyper-threaded"
> +fi
> +
> +# Test CPU consolidation
> +RC=0
> +for sched_mc in `seq 0  $max_sched_mc`; do
> +	sched_mc_pass_cnt=0
> +	if [ $sched_mc -eq 2 ]; then
> +		work_load="kernbench"
> +	else
> +		work_load="ebizzy"
> +	fi
> +	for repeat_test in `seq 1  10`; do
> +		#Testcase to validate CPU consolidation for sched_mc
> +		if cpu_consolidation.py -c $sched_mc -w $work_load ; then
> +		: $(( sched_mc_pass_cnt += 1 ))
> +		fi
> +	done
> +	analyze_package_consolidation_result $sched_mc \
> +		$sched_mc_pass_cnt; RC=$?
> +done
> +if [ $RC -eq 0 ]; then
> +	tst_resm TPASS "CPU consolidation test for sched_mc"
> +else
> +	tst_resm TFAIL "CPU consolidation test for sched_mc"
> +fi
> +
> +RC=0
> +for sched_mc in `seq 0  $max_sched_mc`; do
> +	if [ $sched_mc -eq 2 ]; then
> +		work_load="kernbench"
> +	else
> +		work_load="ebizzy"
> +	fi
> +	for sched_smt in `seq 0 $max_sched_smt`; do
> +		sched_mc_smt_pass_cnt=0
> +		for repeat_test in `seq 1  10`; do
> +			# Testcase to validate CPU consolidation for
> +			# for sched_mc & sched_smt with stress=50%
> +			if cpu_consolidation.py -c $sched_mc -t $sched_smt \
> +				-w $work_load ; then
> +				: $(( sched_mc_smt_pass_cnt += 1 ))
> +			fi
> +		done
> +		analyze_package_consolidation_result $sched_mc \
> +			$sched_mc_smt_pass_cnt $sched_smt; RC=$?
> +	done
> +done
> +if [ $RC -eq 0 ]; then
> +	tst_resm TPASS "CPU consolidation test for sched_mc &" \
> +		"sched_smt with stress=50%"
> +else
> +	tst_resm TFAIL "CPU consolidation test for sched_mc &" \
> +		"sched_smt with stress=50%"
> +fi
> +
> +tst_exit
> diff --git a/testcases/kernel/power_management/runpwtests_exclusive02.sh b/testcases/kernel/power_management/runpwtests_exclusive02.sh
> new file mode 100755
> index 0000000..61f10e1
> --- /dev/null
> +++ b/testcases/kernel/power_management/runpwtests_exclusive02.sh
> @@ -0,0 +1,82 @@
> +#! /bin/sh
> +#
> +# Copyright (c) International Business Machines  Corp., 2001
> +# Author: Nageswara R Sastry <nasastry@in.ibm.com>
> +#
> +# This program is free software;  you can redistribute it and#or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful, but
> +# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> +# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +# for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program;  if not, write to the Free Software Foundation,
> +# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +#
> +
> +export TCID="Power_Management_exclusive02"
> +export TST_TOTAL=1
> +
> +. test.sh
> +. pm_include.sh
> +
> +# Checking required kernel version and architecture
> +tst_kvercmp 2 6 21; rc=$?
> +if [ $rc -ne 1 -a $rc -ne 2 ] ; then
> +	tst_brkm TCONF "Kernel version not supported; not running testcases"
> +else
> +	case "$(uname -m)" in
> +	i[4-6]86|x86_64)
> +		;;
> +	*)
> +		tst_brkm TCONF "Arch not supported; not running testcases"
> +		;;
> +	esac
> +fi
> +
> +tst_kvercmp 2 6 29; rc=$?
> +if [ $rc -eq 2 ] ; then
> +	max_sched_smt=2
> +else
> +	max_sched_smt=1
> +fi
> +
> +is_hyper_threaded; hyper_threaded=$?
> +is_multi_socket; multi_socket=$?
> +is_multi_core; multi_core=$?
> +if [ $hyper_threaded -ne 0 -o $multi_socket -ne 0 \
> +	-o $multi_core -eq 0 ]; then
> +	tst_brkm TCONF "System is a multi core but not multi" \
> +		"socket & hyper-threaded"
> +fi
> +
> +#Testcase to validate consolidation at core level
> +RC=0
> +for sched_smt in `seq 0 $max_sched_smt`; do
> +	if [ $sched_smt -eq 2 ]; then
> +		work_load="kernbench"
> +	else
> +		work_load="ebizzy"
> +	fi
> +	sched_smt_pass_cnt=0
> +	stress="thread"
> +	for repeat_test in `seq 1  10`; do
> +		if cpu_consolidation.py -t $sched_smt -w $work_load \
> +			-s $stress; then
> +			: $(( sched_smt_pass_cnt += 1 ))
> +		fi
> +	done
> +	analyze_core_consolidation_result $sched_smt \
> +		$sched_smt_pass_cnt; RC=$?
> +done
> +if [ $RC -eq 0 ]; then
> +    tst_resm TPASS "Consolidation test at core level for sched_smt"
> +else
> +    tst_resm TFAIL "Consolidation test at core level for sched_smt"
> +fi
> +
> +tst_exit
> diff --git a/testcases/kernel/power_management/runpwtests_exclusive03.sh b/testcases/kernel/power_management/runpwtests_exclusive03.sh
> new file mode 100755
> index 0000000..c85312b
> --- /dev/null
> +++ b/testcases/kernel/power_management/runpwtests_exclusive03.sh
> @@ -0,0 +1,110 @@
> +#! /bin/sh
> +#
> +# Copyright (c) International Business Machines  Corp., 2001
> +# Author: Nageswara R Sastry <nasastry@in.ibm.com>
> +#
> +# This program is free software;  you can redistribute it and#or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful, but
> +# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> +# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +# for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program;  if not, write to the Free Software Foundation,
> +# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +#
> +
> +export TCID="Power_Management_exclusive03"
> +export TST_TOTAL=2
> +
> +. test.sh
> +. pm_include.sh
> +
> +# Checking required kernel version and architecture
> +tst_kvercmp 2 6 21; rc=$?
> +if [ $rc -ne 1 -a $rc -ne 2 ] ; then
> +	tst_brkm TCONF "Kernel version not supported; not running testcases"
> +else
> +	case "$(uname -m)" in
> +	i[4-6]86|x86_64)
> +		;;
> +	*)
> +		tst_brkm TCONF "Arch not supported; not running testcases"
> +		;;
> +	esac
> +fi
> +
> +tst_kvercmp 2 6 29; rc=$?
> +if [ $rc -eq 2 ] ; then
> +	max_sched_mc=2
> +	max_sched_smt=2
> +else
> +	max_sched_mc=1
> +	max_sched_smt=1
> +fi
> +
> +is_hyper_threaded; hyper_threaded=$?
> +is_multi_socket; multi_socket=$?
> +is_multi_core; multi_core=$?
> +if [ $multi_socket -ne 0 -o $multi_core -ne 0 -o \
> +	$hyper_threaded -ne 0 ]; then
> +	tst_brkm TCONF "System is not a multi socket & multi core" \
> +		"& hyper-threaded"
> +fi
> +
> +# Verify threads consolidation stops when sched_mc &(/) sched_smt
> +# is disabled.
> +# Vary sched_mc from 1/2 to 0 when workload is running and
> +# ensure that tasks do not consolidate to single package when
> +# sched_mc is set to 0.
> +RC=0
> +for sched_mc in `seq 1  $max_sched_mc`; do
> +	if cpu_consolidation.py -v -c $sched_mc; then
> +		echo "Test PASS: CPU consolidation test by varying" \
> +			"sched_mc $sched_mc to 0"
> +	else
> +		RC=1
> +		echo "Test FAIL: CPU consolidation test by varying" \
> +			"sched_mc $sched_mc to 0"
> +	fi
> +done
> +if [ $RC -eq 0 ]; then
> +	tst_resm TPASS "CPU consolidation test by varying sched_mc"
> +else
> +	tst_resm TFAIL "CPU consolidation test by varying sched_mc"
> +fi
> +
> +# Vary sched_mc & sched_smt from 1 to 0 & 2 to 0 when workload
> +# is running and ensure that tasks do not consolidate to single
> +# package when sched_mc is set to 0.
> +RC=0
> +for sched_mc in `seq 1  $max_sched_mc`; do
> +	for sched_smt in `seq 1  $max_sched_smt`; do
> +		if [ $sched_smt -eq $sched_mc ]; then
> +			if cpu_consolidation.py -v -c $sched_mc \
> +				-t $sched_smt; then
> +				echo "Test PASS: CPU consolidation test by" \
> +					"varying sched_mc & sched_smt from" \
> +					"$sched_mc to 0"
> +			else
> +				RC=1
> +				echo "Test FAIL: CPU consolidation test by" \
> +					"varying sched_mc & sched_smt from" \
> +					"$sched_mc to 0"
> +			fi
> +		fi
> +	done
> +done
> +if [ $RC -eq 0 ]; then
> +	tst_resm TPASS "CPU consolidation test by varying" \
> +		"sched_mc & sched_smt"
> +else
> +	tst_resm TFAIL "CPU consolidation test by varying" \
> +		"sched_mc & sched_smt"
> +fi
> +
> +tst_exit
> diff --git a/testcases/kernel/power_management/runpwtests_exclusive04.sh b/testcases/kernel/power_management/runpwtests_exclusive04.sh
> new file mode 100755
> index 0000000..6bb27f8
> --- /dev/null
> +++ b/testcases/kernel/power_management/runpwtests_exclusive04.sh
> @@ -0,0 +1,67 @@
> +#! /bin/sh
> +#
> +# Copyright (c) International Business Machines  Corp., 2001
> +# Author: Nageswara R Sastry <nasastry@in.ibm.com>
> +#
> +# This program is free software;  you can redistribute it and#or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful, but
> +# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> +# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +# for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program;  if not, write to the Free Software Foundation,
> +# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +#
> +
> +export TCID="Power_Management_exclusive04"
> +export TST_TOTAL=2
> +
> +. test.sh
> +. pm_include.sh
> +
> +# Checking required kernel version and architecture
> +tst_kvercmp 2 6 21; rc=$?
> +if [ $rc -ne 1 -a $rc -ne 2 ] ; then
> +	tst_brkm TCONF "Kernel version not supported; not running testcases"
> +else
> +	case "$(uname -m)" in
> +	i[4-6]86|x86_64)
> +		;;
> +	*)
> +		tst_brkm TCONF "Arch not supported; not running testcases"
> +		;;
> +	esac
> +fi
> +
> +is_hyper_threaded; hyper_threaded=$?
> +is_multi_socket; multi_socket=$?
> +if [ $hyper_threaded -ne 0 -o $multi_socket -ne 0 ]; then
> +	tst_brkm TCONF "System is not a multi socket & hyper-threaded"
> +fi
> +
> +# Verify threads consolidation stops when sched_smt is
> +# disabled in HT systems.
> +# Vary only sched_smt from 1 to 0 when workload is running
> +# and ensure that tasks do not consolidate to single core
> +# when sched_smt is set to 0.
> +if cpu_consolidation.py -v -t 1; then
> +	tst_resm TPASS "CPU consolidation test by varying sched_smt from 1 to 0"
> +else
> +	tst_resm TFAIL "CPU consolidation test by varying sched_smt from 1 to 0"
> +fi
> +
> +# Vary only sched_smt from 2 to 0 when workload is running
> +# and ensure that tasks do not consolidate to single core
> +# when sched_smt is set to 0.
> +if cpu_consolidation.py -v -t 2; then
> +	tst_resm TPASS "CPU consolidation test by varying sched_smt from 2 to 0"
> +else
> +	tst_resm TFAIL "CPU consolidation test by varying sched_smt from 2 to 0"
> +fi
> +
> +tst_exit
> diff --git a/testcases/kernel/power_management/runpwtests_exclusive05.sh b/testcases/kernel/power_management/runpwtests_exclusive05.sh
> new file mode 100755
> index 0000000..f916c92
> --- /dev/null
> +++ b/testcases/kernel/power_management/runpwtests_exclusive05.sh
> @@ -0,0 +1,112 @@
> +#! /bin/sh
> +#
> +# Copyright (c) International Business Machines  Corp., 2001
> +# Author: Nageswara R Sastry <nasastry@in.ibm.com>
> +#
> +# This program is free software;  you can redistribute it and#or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful, but
> +# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> +# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +# for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program;  if not, write to the Free Software Foundation,
> +# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +#
> +
> +export TCID="Power_Management_exclusive05"
> +export TST_TOTAL=2
> +
> +. test.sh
> +. pm_include.sh
> +
> +# Checking required kernel version and architecture
> +tst_kvercmp 2 6 21; rc=$?
> +if [ $rc -ne 1 -a $rc -ne 2 ] ; then
> +	tst_brkm TCONF "Kernel version not supported; not running testcases"
> +else
> +	case "$(uname -m)" in
> +	i[4-6]86|x86_64)
> +		;;
> +	*)
> +		tst_brkm TCONF "Arch not supported; not running testcases"
> +		;;
> +	esac
> +fi
> +
> +tst_kvercmp 2 6 29; rc=$?
> +if [ $rc -eq 2 ] ; then
> +	max_sched_mc=2
> +	max_sched_smt=2
> +else
> +	max_sched_mc=1
> +	max_sched_smt=1
> +fi
> +
> +is_hyper_threaded; hyper_threaded=$?
> +is_multi_socket; multi_socket=$?
> +is_multi_core; multi_core=$?
> +if [ $multi_socket -ne 0 -o $multi_core -ne 0 -o \
> +	$hyper_threaded -ne 0 ]; then
> +	tst_brkm TCONF "System is not a multi socket & multi core" \
> +		"& hyper-threaded"
> +fi
> +
> +# Verify ILB runs in same package as workload.
> +RC=0
> +for sched_mc in `seq 1 $max_sched_mc`; do
> +	if [ $sched_mc -eq 2 ]; then
> +		work_load="kernbench"
> +	else
> +		work_load="ebizzy"
> +	fi
> +
> +	ilb_test.py -c $sched_mc -w $work_load
> +	if [ $? -eq 0 ]; then
> +		echo "Test PASS: ILB & workload in same package for" \
> +			"sched_mc=$sched_mc"
> +	else
> +		RC=1
> +		echo "Test FAIL: ILB & workload did not run in same package" \
> +			"for sched_mc=$sched_mc. Ensure CONFIG_NO_HZ is set"
> +	fi
> +done
> +if [ $RC -eq 0 ]; then
> +	tst_resm TPASS "ILB & workload test in same package for sched_mc"
> +else
> +	tst_resm TFAIL "ILB & workload test in same package for sched_mc"
> +fi
> +
> +RC=0
> +for sched_mc in `seq 1 $max_sched_mc`; do
> +	if [ $sched_mc -eq 2 ]; then
> +		work_load="kernbench"
> +	else
> +		work_load="ebizzy"
> +	fi
> +	for sched_smt in `seq 1 $max_sched_smt`; do
> +		ilb_test.py -c $sched_mc -t sched_smt -w $work_load
> +		if [ $? -eq 0 ]; then
> +			echo "Test PASS: ILB & workload in same package for" \
> +				"sched_mc=$sched_mc & sched_smt=$sched_smt"
> +		else
> +			RC=1
> +			echo "Test FAIL: ILB & workload did not execute in" \
> +				"same package for sched_mc=$sched_mc &" \
> +				"sched_smt=$sched_smt. Ensure CONFIG_NO_HZ is set"
> +		fi
> +	done
> +done
> +if [ $RC -eq 0 ]; then
> +	tst_resm TPASS "ILB & workload test in same package for" \
> +		"sched_mc & sched_smt"
> +else
> +	tst_resm TFAIL "ILB & workload test in same package for" \
> +		"sched_mc & sched_smt"
> +fi
> +
> +tst_exit
> diff --git a/testcases/kernel/power_management/sched_domain.py b/testcases/kernel/power_management/sched_domain.py
> index 3d19ac0..1ff38b1 100755
> --- a/testcases/kernel/power_management/sched_domain.py
> +++ b/testcases/kernel/power_management/sched_domain.py
> @@ -5,8 +5,6 @@
>
>   import os
>   import sys
> -LIB_DIR = "%s/lib" % os.path.dirname(__file__)
> -sys.path.append(LIB_DIR)
>   from sched_mc import *
>   from optparse import OptionParser
>
>

------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
