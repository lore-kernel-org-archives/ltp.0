Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YXR23-0005iz-FD
	for ltp-list@lists.sourceforge.net; Mon, 16 Mar 2015 09:09:55 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YXR1w-0001Gd-3H
	for ltp-list@lists.sourceforge.net; Mon, 16 Mar 2015 09:09:55 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t2G98iYK000923
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Mar 2015 17:08:44 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Mon, 16 Mar 2015 17:05:07 +0800
Message-ID: <1426496710-11712-6-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1426496710-11712-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1426496710-11712-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v4 6/9] power_management: prefix files with "pm_"
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
To: ltp-list@lists.sourceforge.net

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 .../kernel/power_management/cpu_consolidation.py   | 145 ----
 .../kernel/power_management/get_sched_values.c     |  50 --
 testcases/kernel/power_management/ilb_test.py      |  59 --
 .../kernel/power_management/lib/pm_sched_mc.py     | 835 +++++++++++++++++++++
 testcases/kernel/power_management/lib/sched_mc.py  | 835 ---------------------
 .../power_management/pm_cpu_consolidation.py       | 145 ++++
 .../kernel/power_management/pm_get_sched_values.c  |  50 ++
 testcases/kernel/power_management/pm_ilb_test.py   |  59 ++
 .../kernel/power_management/pm_sched_domain.py     |  56 ++
 testcases/kernel/power_management/runpwtests05.sh  |   6 +-
 .../power_management/runpwtests_exclusive01.sh     |   4 +-
 .../power_management/runpwtests_exclusive02.sh     |   2 +-
 .../power_management/runpwtests_exclusive03.sh     |   4 +-
 .../power_management/runpwtests_exclusive04.sh     |   4 +-
 .../power_management/runpwtests_exclusive05.sh     |   4 +-
 testcases/kernel/power_management/sched_domain.py  |  56 --
 16 files changed, 1157 insertions(+), 1157 deletions(-)
 delete mode 100755 testcases/kernel/power_management/cpu_consolidation.py
 delete mode 100644 testcases/kernel/power_management/get_sched_values.c
 delete mode 100755 testcases/kernel/power_management/ilb_test.py
 create mode 100755 testcases/kernel/power_management/lib/pm_sched_mc.py
 delete mode 100755 testcases/kernel/power_management/lib/sched_mc.py
 create mode 100755 testcases/kernel/power_management/pm_cpu_consolidation.py
 create mode 100644 testcases/kernel/power_management/pm_get_sched_values.c
 create mode 100755 testcases/kernel/power_management/pm_ilb_test.py
 create mode 100755 testcases/kernel/power_management/pm_sched_domain.py
 delete mode 100755 testcases/kernel/power_management/sched_domain.py

diff --git a/testcases/kernel/power_management/cpu_consolidation.py b/testcases/kernel/power_management/cpu_consolidation.py
deleted file mode 100755
index 992a745..0000000
--- a/testcases/kernel/power_management/cpu_consolidation.py
+++ /dev/null
@@ -1,145 +0,0 @@
-#!/usr/bin/python
-''' This Python script interprets various sched stats values.
-    Validates cpu consolidation for given sched_mc_power_saving value
-'''
-
-import os
-import sys
-import time
-LIB_DIR = "%s/lib" % os.path.dirname(__file__)
-sys.path.append(LIB_DIR)
-from optparse import OptionParser
-from sched_mc import *
-
-__author__ = "Poornima Nayak <mpnayak@linux.vnet.ibm.com>"
-
-class Usage(Exception):
-    def __init__(self, msg):
-        self.msg = msg
-
-def main(argv=None):
-    if argv is None:
-        argv = sys.argv
-
-    usage = "-w"
-    parser = OptionParser(usage)
-    parser.add_option("-v", "--variation_test", dest="vary_mc_smt",
-        default=False, action="store_true", help="Vary sched_mc & sched_smt. \
-            -c and -t inputs are initial value of sched_mc & sched_smt")
-    parser.add_option("-c", "--mc_value", dest="mc_value",
-        default=0, help="Sched mc power saving value 0/1/2")
-    parser.add_option("-t", "--smt_value", dest="smt_value",
-        default=0, help="Sched smt power saving value 0/1/2")
-    parser.add_option("-w", "--workload", dest="work_ld",
-        default="ebizzy", help="Workload can be ebizzy/kernbench")
-    parser.add_option("-s", "--stress", dest="stress",
-        default="partial", help="Load on system is full/partial [i.e 50%]/thread")
-    parser.add_option("-p", "--performance", dest="perf_test",
-        default=False, action="store_true", help="Enable performance test")
-    (options, args) = parser.parse_args()
-
-    try:
-        count_num_cpu()
-        count_num_sockets()
-        if is_hyper_threaded():
-            generate_sibling_list()
-
-        # User should set option -v to test cpu consolidation
-        # resets when sched_mc &(/) sched_smt is disabled when
-        # workload is already running in the system
-
-        if options.vary_mc_smt:
-
-            # Since same code is used for testing package consolidation and core
-            # consolidation is_multi_socket & is_hyper_threaded check is done
-            if is_multi_socket() and is_multi_core() and options.mc_value:
-                set_sched_mc_power(options.mc_value)
-
-            if is_hyper_threaded() and options.smt_value:
-                set_sched_smt_power(options.smt_value)
-
-            #Generate arguments for trigger workload, run workload in background
-            map_cpuid_pkgid()
-            background="yes"
-            duration=360
-            pinned="no"
-            if int(options.mc_value) < 2 and int(options.smt_value) < 2:
-                trigger_ebizzy (options.smt_value, "partial", duration, background, pinned)
-                work_ld="ebizzy"
-                #Wait for 120 seconds and then validate cpu consolidation works
-                #When sched_mc & sched_smt is set
-                import time
-                time.sleep(120)
-            else:
-                #Wait for 120 seconds and then validate cpu consolidation works
-                #When sched_mc & sched_smt is set
-                trigger_kernbench (options.smt_value, "partial", background, pinned, "no")
-                work_ld="kernbench"
-                import time
-                time.sleep(300)
-
-            generate_report()
-            status = validate_cpu_consolidation("partial", work_ld, options.mc_value, options.smt_value)
-            if status == 0:
-                print "INFO: Consolidation worked sched_smt &(/) sched_mc is set"
-                #Disable sched_smt & sched_mc interface values
-                if options.vary_mc_smt and options.mc_value > 0:
-                    set_sched_mc_power(0)
-                    mc_value = options.mc_value
-                else:
-                    mc_value = 0
-                if options.vary_mc_smt and options.smt_value > 0 and is_hyper_threaded():
-                    set_sched_smt_power(0)
-                    smt_value = options.smt_value
-                else:
-                    smt_value = 0
-
-                if work_ld == "kernbench":
-                    time.sleep(240)
-                else:
-                    time.sleep(120)
-
-                generate_report()
-                status = validate_cpu_consolidation("partial", work_ld, mc_value, smt_value)
-                if background == "yes":
-                    stop_wkld(work_ld)
-                #CPU consolidation should fail as sched_mc &(/) sched_smt is disabled
-                if status == 1:
-                    return(0)
-                else:
-                    return(1)
-            else:
-                print "INFO: CPU consolidation failed when sched_mc &(/) \
-sched_smt was enabled. This is pre-requisite to proceed"
-                return(status)
-        else:
-            #The else part of the code validates behaviour of sched_mc
-            # and sched_smt set to 0, 1 & 2
-            if is_multi_socket():
-                set_sched_mc_power(options.mc_value)
-            if is_hyper_threaded():
-                set_sched_smt_power(options.smt_value)
-            map_cpuid_pkgid()
-            print "INFO: Created table mapping cpu to package"
-            background="no"
-            duration=60
-            pinned ="no"
-
-            if options.perf_test:
-                perf_test="yes"
-            else:
-                perf_test="no"
-
-            trigger_workld( options.smt_value, options.work_ld, options.stress, duration, background, pinned, perf_test)
-            generate_report()
-            status = validate_cpu_consolidation(options.stress, options.work_ld,options.mc_value, options.smt_value)
-            reset_schedmc()
-            if is_hyper_threaded():
-                reset_schedsmt()
-            return(status)
-    except Exception, details:
-        print "INFO: CPU consolidation failed", details
-        return(1)
-
-if __name__ == "__main__":
-    sys.exit(main())
diff --git a/testcases/kernel/power_management/get_sched_values.c b/testcases/kernel/power_management/get_sched_values.c
deleted file mode 100644
index 328e682..0000000
--- a/testcases/kernel/power_management/get_sched_values.c
+++ /dev/null
@@ -1,50 +0,0 @@
-/************************************************************************
-* Copyright (c) International Business Machines Corp., 2008
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-* the GNU General Public License for more details.
-* You should have received a copy of the GNU General Public License
-* along with this program; if not, write to the Free Software
-* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-*
-***************************************************************************/
-#include <stdio.h>
-#include "test.h"
-
-const char *TCID = "get_sched_values";
-
-int get_supp_sched_mc(void)
-{
-	if (tst_kvercmp(2, 6, 29) < 0)
-		return 1;
-	else
-		return 2;
-}
-
-int get_supp_sched_smt(void)
-{
-	if (tst_kvercmp(2, 6, 29) < 0)
-		return 1;
-	else
-		return 2;
-}
-
-int main(int argc, char **argv)
-{
-	char *param;
-	if (argc == 0)
-		return 1;
-	else {
-		param = argv[1];
-		if (strcmp(param, "sched_mc") == 0)
-			return (get_supp_sched_mc());
-		if (strcmp(param, "sched_smt") == 0)
-			return (get_supp_sched_smt());
-	}
-}
diff --git a/testcases/kernel/power_management/ilb_test.py b/testcases/kernel/power_management/ilb_test.py
deleted file mode 100755
index cec0b29..0000000
--- a/testcases/kernel/power_management/ilb_test.py
+++ /dev/null
@@ -1,59 +0,0 @@
-#!/usr/bin/python
-''' This Python script interprets interrupt values.
-    Validates Ideal load balancer runs in same package where workload is running
-'''
-
-import os
-import sys
-LIB_DIR = "%s/lib" % os.path.dirname(__file__)
-sys.path.append(LIB_DIR)
-from optparse import OptionParser
-from sched_mc import *
-
-__author__ = "Poornima Nayak <mpnayak@linux.vnet.ibm.com>"
-
-class Usage(Exception):
-    def __init__(self, msg):
-        self.msg = msg
-
-def main(argv=None):
-    if argv is None:
-        argv = sys.argv
-
-    usage = "-w"
-    parser = OptionParser(usage)
-    parser.add_option("-c", "--mc_level", dest="mc_level",
-        default=0, help="Sched mc power saving value 0/1/2")
-    parser.add_option("-t", "--smt_level", dest="smt_level",
-        default=0, help="Sched smt power saving value 0/1/2")
-    parser.add_option("-w", "--workload", dest="work_ld",
-        default="ebizzy", help="Workload can be ebizzy/kernbench")
-    (options, args) = parser.parse_args()
-
-    try:
-        count_num_cpu()
-        count_num_sockets()
-        if is_multi_socket():
-            set_sched_mc_power(options.mc_level)
-        if is_hyper_threaded():
-            set_sched_smt_power(options.smt_level)
-        map_cpuid_pkgid()
-        print "INFO: Created table mapping cpu to package"
-        background="no"
-        duration=120
-        pinned="yes"
-
-        trigger_workld(options.smt_level,options.work_ld, "single_job", duration, background, pinned, "no")
-        generate_loc_intr_report()
-        status = validate_ilb(options.mc_level, options.smt_level)
-        reset_schedmc()
-        if is_hyper_threaded():
-            reset_schedsmt()
-        return(status)
-
-    except Exception, details:
-        print "INFO: Idle Load Balancer test failed", details
-        return(1)
-
-if __name__ == "__main__":
-    sys.exit(main())
diff --git a/testcases/kernel/power_management/lib/pm_sched_mc.py b/testcases/kernel/power_management/lib/pm_sched_mc.py
new file mode 100755
index 0000000..feb4b24
--- /dev/null
+++ b/testcases/kernel/power_management/lib/pm_sched_mc.py
@@ -0,0 +1,835 @@
+#!/usr/bin/python
+''' Reusable functions related to sched mc FVT are put together
+'''
+
+import os
+import sys
+import re
+from time import time
+
+__author__ = "Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>"
+__author__ = "Poornima Nayak <mpnayak@linux.vnet.ibm.com>"
+
+
+cpu_map = {}
+stats_start = {}
+stats_stop = {}
+stats_percentage = {}
+intr_start = []
+intr_stop = []
+cpu_count = 0
+socket_count = 0
+cpu1_max_intr = 0
+cpu2_max_intr = 0
+intr_stat_timer_0 = []
+siblings_list = []
+
+def clear_dmesg():
+    '''
+       Clears dmesg
+    '''
+    try:
+        os.system('dmesg -c >/dev/null')
+    except OSError, e:
+        print 'Clearing dmesg failed', e
+        sys.exit(1)
+
+def count_num_cpu():
+    ''' Returns number of cpu's in system
+    '''
+    try:
+        cpuinfo = open('/proc/cpuinfo', 'r')
+        global cpu_count
+        for line in cpuinfo:
+            if line.startswith('processor'):
+                cpu_count += 1
+        cpuinfo.close()
+    except IOError, e:
+        print "Could not get cpu count", e
+        sys.exit(1)
+
+def count_num_sockets():
+    ''' Returns number of cpu's in system
+    '''
+    socket_list = []
+    global socket_count
+    try:
+        for i in range(0, cpu_count):
+            phy_pkg_file = '/sys/devices/system/cpu/cpu%s' % i
+            phy_pkg_file += '/topology/physical_package_id'
+            socket_id = open(phy_pkg_file).read().rstrip()
+            if socket_id not in socket_list:
+                socket_list.append(socket_id)
+                socket_count = socket_count + 1
+    except Exception, details:
+        print "INFO: Failed to get number of sockets in system", details
+        sys.exit(1)
+
+def is_multi_socket():
+    '''Return 1 if the system is multi socket else return 0
+    '''
+    try:
+        if socket_count > 1:
+            return 1
+        else:
+            return 0
+    except Exception:
+        print "Failed to check if system is multi socket system"
+        sys.exit(1)
+
+def is_hyper_threaded():
+    '''Return 1 if the system is hyper threaded else return 0
+    '''
+    try:
+        file_cpuinfo = open("/proc/cpuinfo", 'r')
+        for line in file_cpuinfo:
+            if line.startswith('siblings'):
+                siblings = line.split(":")
+            if line.startswith('cpu cores'):
+                cpu_cores = line.split(":")
+                break
+        if int( siblings[1] ) / int( cpu_cores[1] )> 1:
+            file_cpuinfo.close()
+            return 1
+        else:
+            return 0
+    except Exception:
+        print "Failed to check if system is hyper-threaded"
+        sys.exit(1)
+
+def is_multi_core():
+    ''' Return true if system has sockets has multiple cores
+    '''
+
+    try:
+        file_cpuinfo = open("/proc/cpuinfo", 'r')
+        for line in file_cpuinfo:
+            if line.startswith('siblings'):
+                siblings = line.split(":")
+            if line.startswith('cpu cores'):
+                cpu_cores = line.split(":")
+                break
+
+        if int( siblings[1] ) == int( cpu_cores[1] ):
+            if int( cpu_cores[1] ) > 1:
+                multi_core = 1
+            else:
+                multi_core = 0
+        else:
+            num_of_cpus = int(siblings[1]) / int(cpu_cores[1])
+            if num_of_cpus > 1:
+                multi_core = 1
+            else:
+                multi_core = 0
+        file_cpuinfo.close()
+        return multi_core
+    except Exception:
+        print "Failed to check if system is multi core system"
+        sys.exit(1)
+
+def get_hyper_thread_count():
+    ''' Return number of threads in CPU. For eg for x3950 this function
+        would return 2. In future if 4 threads are supported in CPU, this
+        routine would return 4
+    '''
+    try:
+        file_cpuinfo = open("/proc/cpuinfo", 'r')
+        for line in file_cpuinfo:
+            if line.startswith('siblings'):
+                siblings = line.split(":")
+            if line.startswith('cpu cores'):
+                cpu_cores = line.split(":")
+                break
+        return( int( siblings[1] ) / int( cpu_cores[1] ) )
+    except Exception:
+        print "Failed to check if system is hyper-threaded"
+        sys.exit(1)
+
+def map_cpuid_pkgid():
+    ''' Routine to map physical package id to cpu id
+    '''
+    if is_hyper_threaded():
+        core_info = {}
+        try:
+            for i in range(0, cpu_count):
+                phy_pkg_file = '/sys/devices/system/cpu/cpu%s' % i
+                phy_pkg_file += '/topology/physical_package_id'
+                core_file = '/sys/devices/system/cpu/cpu%s' % i
+                core_file += '/topology/core_id'
+                core_id = open(core_file).read().rstrip()
+                cpu_phy_id = open(phy_pkg_file).read().rstrip()
+                if not cpu_phy_id in cpu_map.keys():
+                    core_info = {}
+                else:
+                    core_info = cpu_map[cpu_phy_id]
+                if not core_id in core_info.keys():
+                    core_info[core_id] = [i]
+                else:
+                    core_info[core_id].append(i)
+                cpu_map[cpu_phy_id] = core_info
+        except Exception, details:
+            print "Package, core & cpu map table creation failed", e
+            sys.exit(1)
+    else:
+        for i in range(0, cpu_count):
+            try:
+                phy_pkg_file = '/sys/devices/system/cpu/cpu%s' %i
+                phy_pkg_file += '/topology/physical_package_id'
+                cpu_phy_id = open(phy_pkg_file).read().rstrip()
+                if not cpu_phy_id in cpu_map.keys():
+                    cpu_map[cpu_phy_id] = [i]
+                else:
+                    cpu_map[cpu_phy_id].append(i)
+            except IOError, e:
+                print "Mapping of CPU to pkg id failed", e
+                sys.exit(1)
+
+
+def generate_sibling_list():
+    ''' Routine to generate siblings list
+    '''
+    try:
+        for i in range(0, cpu_count):
+            siblings_file = '/sys/devices/system/cpu/cpu%s' % i
+            siblings_file += '/topology/thread_siblings_list'
+            threads_sibs = open(siblings_file).read().rstrip()
+            thread_ids = threads_sibs.split("-")
+
+            if not thread_ids in siblings_list:
+                siblings_list.append(thread_ids)
+    except Exception, details:
+        print "Exception in generate_siblings_list", details
+        sys.exit(1)
+
+def get_siblings(cpu_id):
+    ''' Return siblings of cpu_id
+    '''
+    try:
+        cpus = ""
+        for i in range(0, len(siblings_list)):
+            for cpu in siblings_list[i]:
+                if cpu_id == cpu:
+                    for j in siblings_list[i]:
+                        # Exclude cpu_id in the list of siblings
+                        if j != cpu_id:
+                            cpus += j
+                    return cpus
+        return cpus
+    except Exception, details:
+        print "Exception in get_siblings", details
+        sys.exit(1)
+
+def get_proc_data(stats_list):
+    ''' Read /proc/stat info and store in dictionary
+    '''
+    try:
+        file_procstat = open("/proc/stat", 'r')
+        for line in file_procstat:
+            if line.startswith('cpu'):
+                data = line.split()
+                stats_list[data[0]] = data
+        file_procstat.close()
+    except OSError, e:
+        print "Could not read statistics", e
+        sys.exit(1)
+
+def get_proc_loc_count(loc_stats):
+    ''' Read /proc/interrupts info and store in list
+    '''
+    try:
+        file_procstat = open("/proc/interrupts", 'r')
+        for line in file_procstat:
+            if line.startswith(' LOC:') or line.startswith('LOC:'):
+                data = line.split()
+                for i in range(0, cpu_count):
+                    # To skip LOC
+                    loc_stats.append(data[i+1])
+                file_procstat.close()
+                return
+    except Exception, details:
+        print "Could not read interrupt statistics", details
+        sys.exit(1)
+
+
+def set_sched_mc_power(sched_mc_level):
+    ''' Routine to set sched_mc_power_savings to required level
+    '''
+    try:
+        os.system('echo %s > \
+            /sys/devices/system/cpu/sched_mc_power_savings 2>/dev/null'
+            % sched_mc_level)
+
+        get_proc_data(stats_start)
+    except OSError, e:
+        print "Could not set sched_mc_power_savings to", sched_mc_level, e
+	sys.exit(1)
+
+def set_sched_smt_power(sched_smt_level):
+    ''' Routine to set sched_smt_power_savings to required level
+    '''
+    try:
+        os.system('echo %s > \
+            /sys/devices/system/cpu/sched_smt_power_savings 2>/dev/null'
+            % sched_smt_level)
+
+        get_proc_data(stats_start)
+    except OSError, e:
+        print "Could not set sched_smt_power_savings to", sched_smt_level, e
+	sys.exit(1)
+
+def set_timer_migration_interface(value):
+    ''' Set value of timer migration interface to a value
+        passed as argument
+    '''
+    try:
+        os.system('echo %s > \
+            /proc/sys/kernel/timer_migration 2>/dev/null' % value)
+    except OSError, e:
+        print "Could not set timer_migration to ", value, e
+        sys.exit(1)
+
+def get_job_count(stress, workload, sched_smt):
+    ''' Returns number of jobs/threads to be triggered
+    '''
+
+    try:
+        if stress == "thread":
+            threads = get_hyper_thread_count()
+        if stress == "partial":
+            threads = cpu_count / socket_count
+            if is_hyper_threaded():
+                if workload == "ebizzy" and int(sched_smt) ==0:
+                    threads = threads / get_hyper_thread_count()
+                if workload == "kernbench" and int(sched_smt) < 2:
+                    threads = threads / get_hyper_thread_count()
+        if stress == "full":
+            threads = cpu_count
+        if stress == "single_job":
+            threads = 1
+            duration = 180
+        return threads
+    except Exception, details:
+        print "get job count failed ", details
+        sys.exit(1)
+
+def trigger_ebizzy (sched_smt, stress, duration, background, pinned):
+    ''' Triggers ebizzy workload for sched_mc=1
+        testing
+    '''
+    try:
+        threads = get_job_count(stress, "ebizzy", sched_smt)
+        workload = "ebizzy"
+        olddir = os.getcwd()
+        path = '%s/testcases/bin' % os.environ['LTPROOT']
+        os.chdir(path)
+        workload_file = ""
+        for file_name in os.listdir('.'):
+            if file_name == workload:
+                workload_file = file_name
+                break
+        if workload_file == "":
+            print "INFO: ebizzy benchmark not found"
+            os.chdir(olddir)
+            sys.exit(1)
+        get_proc_data(stats_start)
+        get_proc_loc_count(intr_start)
+        try:
+            if background == "yes":
+                succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null &'
+                    % (threads, duration))
+            else:
+                if pinned == "yes":
+                    succ = os.system('taskset -c %s ./ebizzy -t%s -s4096 -S %s >/dev/null'
+                        % (cpu_count -1, threads, duration))
+                else:
+                    succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null'
+                        % (threads, duration))
+
+            if succ == 0:
+                print "INFO: ebizzy workload triggerd"
+                os.chdir(olddir)
+                #Commented bcoz it doesnt make sense to capture it when workload triggered
+                #in background
+                #get_proc_loc_count(intr_stop)
+                #get_proc_data(stats_stop)
+            else:
+                print "INFO: ebizzy workload triggerd failed"
+                os.chdir(olddir)
+                sys.exit(1)
+        except Exception, details:
+            print "Ebizzy workload trigger failed ", details
+            sys.exit(1)
+    except Exception, details:
+        print "Ebizzy workload trigger failed ", details
+        sys.exit(1)
+
+def trigger_kernbench (sched_smt, stress, background, pinned, perf_test):
+    ''' Trigger load on system like kernbench.
+        Copys existing copy of LTP into as LTP2 and then builds it
+        with make -j
+    '''
+    olddir = os.getcwd()
+    try:
+        threads = get_job_count(stress, "kernbench", sched_smt)
+
+        dst_path = "/root"
+        workload = "kernbench"
+        olddir = os.getcwd()
+        path = '%s/testcases/bin' % os.environ['LTPROOT']
+        os.chdir(path)
+        workload_file = ""
+        for file_name in os.listdir('.'):
+            if file_name == workload:
+                workload_file = file_name
+                break
+        if workload_file != "":
+            benchmark_path = path
+        else:
+            print "INFO: kernbench benchmark not found"
+            os.chdir(olddir)
+            sys.exit(1)
+
+        os.chdir(dst_path)
+        linux_source_dir=""
+        for file_name in os.listdir('.'):
+            if file_name.find("linux-2.6") != -1 and os.path.isdir(file_name):
+                linux_source_dir=file_name
+                break
+        if linux_source_dir != "":
+            os.chdir(linux_source_dir)
+        else:
+            print "INFO: Linux kernel source not found in /root. Workload\
+               Kernbench cannot be executed"
+            sys.exit(1)
+
+        get_proc_data(stats_start)
+        get_proc_loc_count(intr_start)
+        if pinned == "yes":
+            os.system ( 'taskset -c %s %s/kernbench -o %s -M -H -n 1 \
+                >/dev/null 2>&1 &' % (cpu_count-1, benchmark_path, threads))
+
+            # We have to delete import in future
+            import time
+            time.sleep(240)
+            stop_wkld("kernbench")
+        else:
+            if background == "yes":
+                os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1 &' \
+                    % (benchmark_path, threads))
+            else:
+                if perf_test == "yes":
+                    os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1' \
+                        % (benchmark_path, threads))
+                else:
+                    os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1 &' \
+                        % (benchmark_path, threads))
+                    # We have to delete import in future
+                    import time
+                    time.sleep(240)
+                    stop_wkld("kernbench")
+
+        print "INFO: Workload kernbench triggerd"
+        os.chdir(olddir)
+    except Exception, details:
+        print "Workload kernbench trigger failed ", details
+        sys.exit(1)
+
+def trigger_workld(sched_smt, workload, stress, duration, background, pinned, perf_test):
+    ''' Triggers workload passed as argument. Number of threads
+        triggered is based on stress value.
+    '''
+    try:
+        if workload == "ebizzy":
+            trigger_ebizzy (sched_smt, stress, duration, background, pinned)
+        if workload == "kernbench":
+            trigger_kernbench (sched_smt, stress, background, pinned, perf_test)
+    except Exception, details:
+        print "INFO: Trigger workload failed", details
+        sys.exit(1)
+
+def generate_report():
+    ''' Generate report of CPU utilization
+    '''
+    cpu_labels = ('cpu', 'user', 'nice', 'system', 'idle', 'iowait', 'irq',
+	'softirq', 'x', 'y')
+    if (not os.path.exists('/procstat')):
+        os.mkdir('/procstat')
+
+    get_proc_data(stats_stop)
+
+    reportfile = open('/procstat/cpu-utilisation', 'a')
+    debugfile = open('/procstat/cpu-utilisation.debug', 'a')
+    for l in stats_stop:
+        percentage_list = []
+        total = 0
+        for i in range(1, len(stats_stop[l])):
+            stats_stop[l][i] =  int(stats_stop[l][i]) - int(stats_start[l][i])
+            total += stats_stop[l][i]
+        percentage_list.append(l)
+        for i in range(1, len(stats_stop[l])):
+            percentage_list.append(float(stats_stop[l][i])*100/total)
+
+        stats_percentage[l] = percentage_list
+
+    for i in range(0, len(cpu_labels)):
+        print >> debugfile, cpu_labels[i], '\t',
+    print >> debugfile
+    for l in sorted(stats_stop.keys()):
+        print >> debugfile, l, '\t',
+        for i in range(1, len(stats_stop[l])):
+            print >> debugfile, stats_stop[l][i], '\t',
+        print >> debugfile
+
+    for i in range(0, len(cpu_labels)):
+        print >> reportfile, cpu_labels[i], '\t',
+    print >> reportfile
+    for l in sorted(stats_percentage.keys()):
+        print >> reportfile, l, '\t',
+        for i in range(1, len(stats_percentage[l])):
+            print >> reportfile, " %3.4f" % stats_percentage[l][i],
+        print >> reportfile
+
+    #Now get the package ID information
+    try:
+        print >> debugfile, "cpu_map: ", cpu_map
+        keyvalfile = open('/procstat/keyval', 'a')
+        print >> keyvalfile, "nr_packages=%d" % len(cpu_map)
+        print >> keyvalfile, "system-idle=%3.4f" % (stats_percentage['cpu'][4])
+        for pkg in sorted(cpu_map.keys()):
+            if is_hyper_threaded():
+                for core in sorted(cpu_map[pkg].keys()):
+                    total_idle = 0
+                    total = 0
+                    for cpu in cpu_map[pkg][core]:
+                        total_idle += stats_stop["cpu%d" % cpu][4]
+                        for i in range(1, len(stats_stop["cpu%d" % cpu])):
+                            total += stats_stop["cpu%d" % cpu][i]
+            else:
+                total_idle = 0
+                total = 0
+                for cpu in cpu_map[pkg]:
+                    total_idle += stats_stop["cpu%d" % cpu][4]
+                    for i in range(1, len(stats_stop["cpu%d" % cpu])):
+                        total += stats_stop["cpu%d" % cpu][i]
+            print >> reportfile, "Package: ", pkg, "Idle %3.4f%%" \
+	        % (float(total_idle)*100/total)
+            print >> keyvalfile, "package-%s=%3.4f" % \
+		(pkg, (float(total_idle)*100/total))
+    except Exception, details:
+        print "Generating utilization report failed: ", details
+        sys.exit(1)
+
+    #Add record delimiter '\n' before closing these files
+    print >> debugfile
+    debugfile.close()
+    print >> reportfile
+    reportfile.close()
+    print >> keyvalfile
+    keyvalfile.close()
+
+def generate_loc_intr_report():
+    ''' Generate interrupt report of CPU's
+    '''
+    try:
+        if (not os.path.exists('/procstat')):
+            os.mkdir('/procstat')
+
+        get_proc_loc_count(intr_stop)
+
+        reportfile = open('/procstat/cpu-loc_interrupts', 'a')
+        print >> reportfile, "=============================================="
+        print >> reportfile, "     Local timer interrupt stats              "
+        print >> reportfile, "=============================================="
+
+        for i in range(0, cpu_count):
+            intr_stop[i] =  int(intr_stop[i]) - int(intr_start[i])
+            print >> reportfile, "CPU%s: %s" %(i, intr_stop[i])
+        print >> reportfile
+        reportfile.close()
+    except Exception, details:
+        print "Generating interrupt report failed: ", details
+        sys.exit(1)
+
+def record_loc_intr_count():
+    ''' Record Interrupt statistics when timer_migration
+        was disabled
+    '''
+    try:
+        global intr_start, intr_stop
+        for i in range(0, cpu_count):
+            intr_stat_timer_0.append(intr_stop[i])
+        intr_start = []
+        intr_stop = []
+    except Exception, details:
+        print "INFO: Record interrupt statistics when timer_migration=0",details
+
+def expand_range(range_val):
+    '''
+       Expand the range of value into actual numbers
+    '''
+    ids_list = list()
+    try:
+        sep_comma = range_val.split(",")
+        for i in range(0, len(sep_comma)):
+            hyphen_values = sep_comma[i].split("-")
+            if len(hyphen_values) == 1:
+                ids_list.append(int(hyphen_values[0]))
+            else:
+                for j in range(int(hyphen_values[0]), int(hyphen_values[1])+1):
+                    ids_list.append(j)
+        return(ids_list)
+    except Exception, details:
+        print "INFO: expand_pkg_grps failed ", details
+
+def is_quad_core():
+    '''
+       Read /proc/cpuinfo and check if system is Quad core
+    '''
+    try:
+        cpuinfo = open('/proc/cpuinfo', 'r')
+        for line in cpuinfo:
+            if line.startswith('cpu cores'):
+                cores = line.split("cpu cores")
+                num_cores = cores[1].split(":")
+                cpuinfo.close()
+                if int(num_cores[1]) == 4:
+                    return(1)
+                else:
+                    return(0)
+    except IOError, e:
+        print "Failed to get cpu core information", e
+        sys.exit(1)
+
+def validate_cpugrp_map(cpu_group, sched_mc_level, sched_smt_level):
+    '''
+       Verify if cpugrp belong to same package
+    '''
+    modi_cpu_grp = cpu_group[:]
+    try:
+        if is_hyper_threaded():
+            for pkg in sorted(cpu_map.keys()):
+                # if CPU utilized is across package this condition will be true
+                if len(modi_cpu_grp) != len(cpu_group):
+                    break
+                for core in sorted(cpu_map[pkg].keys()):
+                    core_cpus = cpu_map[pkg][core]
+                    if core_cpus == modi_cpu_grp:
+                        return 0
+                    else:
+                        #if CPUs used across the cores
+                        for i in range(0, len(core_cpus)):
+                            if core_cpus[i] in modi_cpu_grp:
+                                modi_cpu_grp.remove(core_cpus[i])
+                                if len(modi_cpu_grp) == 0:
+                                    return 0
+                            #This code has to be deleted
+                            #else:
+                                # If sched_smt == 0 then its oky if threads run
+                                # in different cores of same package
+                                #if sched_smt_level > 0 :
+                                    #return 1
+	else:
+            for pkg in sorted(cpu_map.keys()):
+                pkg_cpus = cpu_map[pkg]
+                if len(cpu_group) == len(pkg_cpus):
+                    if pkg_cpus == cpu_group:
+                        return(0)
+                else:
+                    if int(cpus_utilized[0]) in cpu_map[pkg] or int(cpus_utilized[1]) in cpu_map[pkg]:
+                        return(0)
+
+        return(1)
+
+    except Exception, details:
+        print "Exception in validate_cpugrp_map: ", details
+        sys.exit(1)
+
+
+def verify_sched_domain_dmesg(sched_mc_level, sched_smt_level):
+    '''
+       Read sched domain information from dmesg.
+    '''
+    cpu_group = list()
+    try:
+        dmesg_info = os.popen('dmesg').read()
+        if dmesg_info != "":
+            lines = dmesg_info.split('\n')
+            for i in range(0, len(lines)):
+                if lines[i].endswith('CPU'):
+                    groups = lines[i+1].split("groups:")
+                    group_info = groups[1]
+                    if group_info.find("(") != -1:
+                        openindex=group_info.index("(")
+                        closeindex=group_info.index(")")
+                        group_info=group_info.replace\
+                            (group_info[openindex:closeindex+1],"")
+
+                    subgroup = group_info.split(",")
+                    for j in range(0, len(subgroup)):
+                        cpu_group = expand_range(subgroup[j])
+                        status = validate_cpugrp_map(cpu_group, sched_mc_level,\
+                        sched_smt_level)
+                        if status == 1:
+                            if is_quad_core() == 1:
+                                if int(sched_mc_level) == 0:
+                                    return(0)
+                                else:
+                                    return(1)
+                            else:
+                                return(1)
+            return(0)
+        else:
+            return(1)
+    except Exception, details:
+        print "Reading dmesg failed", details
+        sys.exit(1)
+
+def get_cpu_utilization(cpu):
+    ''' Return cpu utilization of cpu_id
+    '''
+    try:
+        for l in sorted(stats_percentage.keys()):
+            if cpu == stats_percentage[l][0]:
+                return stats_percentage[l][1]
+        return -1
+    except Exception, details:
+        print "Exception in get_cpu_utilization", details
+        sys.exit(1)
+
+def validate_cpu_consolidation(stress, work_ld, sched_mc_level, sched_smt_level):
+    ''' Verify if cpu's on which threads executed belong to same
+    package
+    '''
+    cpus_utilized = list()
+    threads = get_job_count(stress, work_ld, sched_smt_level)
+    try:
+        for l in sorted(stats_percentage.keys()):
+            #modify threshold
+            cpu_id = stats_percentage[l][0].split("cpu")
+            if cpu_id[1] == '':
+                continue
+            if int(cpu_id[1]) in cpus_utilized:
+                continue
+            if is_hyper_threaded():
+                if work_ld == "kernbench" and sched_smt_level < sched_mc_level:
+                    siblings = get_siblings(cpu_id[1])
+                    if siblings != "":
+                        sib_list = siblings.split()
+                        utilization = int(stats_percentage[l][1])
+                        for i in range(0, len(sib_list)):
+                            utilization += int(get_cpu_utilization("cpu%s" %sib_list[i]))
+                    else:
+                        utilization = stats_percentage[l][1]
+                    if utilization > 40:
+                        cpus_utilized.append(int(cpu_id[1]))
+                        if siblings != "":
+                            for i in range(0, len(sib_list)):
+                                cpus_utilized.append(int(sib_list[i]))
+                else:
+                    # This threshold wuld be modified based on results
+                    if stats_percentage[l][1] > 40:
+                        cpus_utilized.append(int(cpu_id[1]))
+            else:
+                if work_ld == "kernbench" :
+                    if stats_percentage[l][1] > 50:
+                        cpus_utilized.append(int(cpu_id[1]))
+                else:
+                    if stats_percentage[l][1] > 70:
+                        cpus_utilized.append(int(cpu_id[1]))
+            cpus_utilized.sort()
+        print "INFO: CPU's utilized ", cpus_utilized
+
+        # If length of CPU's utilized is not = number of jobs exit with 1
+        if len(cpus_utilized) < threads:
+            return 1
+
+        status = validate_cpugrp_map(cpus_utilized, sched_mc_level, \
+            sched_smt_level)
+        if status == 1:
+            print "INFO: CPUs utilized is not in same package or core"
+
+        return(status)
+    except Exception, details:
+        print "Exception in validate_cpu_consolidation: ", details
+        sys.exit(1)
+
+def get_cpuid_max_intr_count():
+    '''Return the cpu id's of two cpu's with highest number of intr'''
+    try:
+        highest = 0
+        second_highest = 0
+        cpus_utilized = []
+
+        #Skipping CPU0 as it is generally high
+        for i in range(1, cpu_count):
+            if int(intr_stop[i]) > int(highest):
+                if highest != 0:
+                    second_highest = highest
+                    cpu2_max_intr = cpu1_max_intr
+                highest = int(intr_stop[i])
+                cpu1_max_intr = i
+            else:
+                if int(intr_stop[i]) > int(second_highest):
+                    second_highest = int(intr_stop[i])
+                    cpu2_max_intr = i
+        cpus_utilized.append(cpu1_max_intr)
+        cpus_utilized.append(cpu2_max_intr)
+
+        for i in range(1, cpu_count):
+            if i != cpu1_max_intr and i != cpu2_max_intr:
+                diff = second_highest - intr_stop[i]
+                ''' Threshold of difference has to be manipulated '''
+                if diff < 10000:
+                    print "INFO: Diff in interrupt count is below threshold"
+                    cpus_utilized = []
+                    return cpus_utilized
+        print "INFO: Interrupt count in other CPU's low as expected"
+        return cpus_utilized
+    except Exception, details:
+        print "Exception in get_cpuid_max_intr_count: ", details
+        sys.exit(1)
+
+def validate_ilb (sched_mc_level, sched_smt_level):
+    ''' Validate if ilb is running in same package where work load is running
+    '''
+    try:
+        cpus_utilized = get_cpuid_max_intr_count()
+        if not cpus_utilized:
+            return 1
+
+        status = validate_cpugrp_map(cpus_utilized, sched_mc_level, sched_smt_level)
+        return status
+    except Exception, details:
+        print "Exception in validate_ilb: ", details
+        sys.exit(1)
+
+def reset_schedmc():
+    ''' Routine to reset sched_mc_power_savings to Zero level
+    '''
+    try:
+        os.system('echo 0 > \
+            /sys/devices/system/cpu/sched_mc_power_savings 2>/dev/null')
+    except OSError, e:
+        print "Could not set sched_mc_power_savings to 0", e
+        sys.exit(1)
+
+def reset_schedsmt():
+    ''' Routine to reset sched_smt_power_savings to Zero level
+    '''
+    try:
+        os.system('echo 0 > \
+            /sys/devices/system/cpu/sched_smt_power_savings 2>/dev/null')
+    except OSError, e:
+        print "Could not set sched_smt_power_savings to 0", e
+        sys.exit(1)
+
+def stop_wkld(work_ld):
+    ''' Kill workload triggered in background
+    '''
+    try:
+        os.system('pkill %s 2>/dev/null' %work_ld)
+        if work_ld == "kernbench":
+            os.system('pkill make 2>/dev/null')
+    except OSError, e:
+        print "Exception in stop_wkld", e
+        sys.exit(1)
diff --git a/testcases/kernel/power_management/lib/sched_mc.py b/testcases/kernel/power_management/lib/sched_mc.py
deleted file mode 100755
index feb4b24..0000000
--- a/testcases/kernel/power_management/lib/sched_mc.py
+++ /dev/null
@@ -1,835 +0,0 @@
-#!/usr/bin/python
-''' Reusable functions related to sched mc FVT are put together
-'''
-
-import os
-import sys
-import re
-from time import time
-
-__author__ = "Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>"
-__author__ = "Poornima Nayak <mpnayak@linux.vnet.ibm.com>"
-
-
-cpu_map = {}
-stats_start = {}
-stats_stop = {}
-stats_percentage = {}
-intr_start = []
-intr_stop = []
-cpu_count = 0
-socket_count = 0
-cpu1_max_intr = 0
-cpu2_max_intr = 0
-intr_stat_timer_0 = []
-siblings_list = []
-
-def clear_dmesg():
-    '''
-       Clears dmesg
-    '''
-    try:
-        os.system('dmesg -c >/dev/null')
-    except OSError, e:
-        print 'Clearing dmesg failed', e
-        sys.exit(1)
-
-def count_num_cpu():
-    ''' Returns number of cpu's in system
-    '''
-    try:
-        cpuinfo = open('/proc/cpuinfo', 'r')
-        global cpu_count
-        for line in cpuinfo:
-            if line.startswith('processor'):
-                cpu_count += 1
-        cpuinfo.close()
-    except IOError, e:
-        print "Could not get cpu count", e
-        sys.exit(1)
-
-def count_num_sockets():
-    ''' Returns number of cpu's in system
-    '''
-    socket_list = []
-    global socket_count
-    try:
-        for i in range(0, cpu_count):
-            phy_pkg_file = '/sys/devices/system/cpu/cpu%s' % i
-            phy_pkg_file += '/topology/physical_package_id'
-            socket_id = open(phy_pkg_file).read().rstrip()
-            if socket_id not in socket_list:
-                socket_list.append(socket_id)
-                socket_count = socket_count + 1
-    except Exception, details:
-        print "INFO: Failed to get number of sockets in system", details
-        sys.exit(1)
-
-def is_multi_socket():
-    '''Return 1 if the system is multi socket else return 0
-    '''
-    try:
-        if socket_count > 1:
-            return 1
-        else:
-            return 0
-    except Exception:
-        print "Failed to check if system is multi socket system"
-        sys.exit(1)
-
-def is_hyper_threaded():
-    '''Return 1 if the system is hyper threaded else return 0
-    '''
-    try:
-        file_cpuinfo = open("/proc/cpuinfo", 'r')
-        for line in file_cpuinfo:
-            if line.startswith('siblings'):
-                siblings = line.split(":")
-            if line.startswith('cpu cores'):
-                cpu_cores = line.split(":")
-                break
-        if int( siblings[1] ) / int( cpu_cores[1] )> 1:
-            file_cpuinfo.close()
-            return 1
-        else:
-            return 0
-    except Exception:
-        print "Failed to check if system is hyper-threaded"
-        sys.exit(1)
-
-def is_multi_core():
-    ''' Return true if system has sockets has multiple cores
-    '''
-
-    try:
-        file_cpuinfo = open("/proc/cpuinfo", 'r')
-        for line in file_cpuinfo:
-            if line.startswith('siblings'):
-                siblings = line.split(":")
-            if line.startswith('cpu cores'):
-                cpu_cores = line.split(":")
-                break
-
-        if int( siblings[1] ) == int( cpu_cores[1] ):
-            if int( cpu_cores[1] ) > 1:
-                multi_core = 1
-            else:
-                multi_core = 0
-        else:
-            num_of_cpus = int(siblings[1]) / int(cpu_cores[1])
-            if num_of_cpus > 1:
-                multi_core = 1
-            else:
-                multi_core = 0
-        file_cpuinfo.close()
-        return multi_core
-    except Exception:
-        print "Failed to check if system is multi core system"
-        sys.exit(1)
-
-def get_hyper_thread_count():
-    ''' Return number of threads in CPU. For eg for x3950 this function
-        would return 2. In future if 4 threads are supported in CPU, this
-        routine would return 4
-    '''
-    try:
-        file_cpuinfo = open("/proc/cpuinfo", 'r')
-        for line in file_cpuinfo:
-            if line.startswith('siblings'):
-                siblings = line.split(":")
-            if line.startswith('cpu cores'):
-                cpu_cores = line.split(":")
-                break
-        return( int( siblings[1] ) / int( cpu_cores[1] ) )
-    except Exception:
-        print "Failed to check if system is hyper-threaded"
-        sys.exit(1)
-
-def map_cpuid_pkgid():
-    ''' Routine to map physical package id to cpu id
-    '''
-    if is_hyper_threaded():
-        core_info = {}
-        try:
-            for i in range(0, cpu_count):
-                phy_pkg_file = '/sys/devices/system/cpu/cpu%s' % i
-                phy_pkg_file += '/topology/physical_package_id'
-                core_file = '/sys/devices/system/cpu/cpu%s' % i
-                core_file += '/topology/core_id'
-                core_id = open(core_file).read().rstrip()
-                cpu_phy_id = open(phy_pkg_file).read().rstrip()
-                if not cpu_phy_id in cpu_map.keys():
-                    core_info = {}
-                else:
-                    core_info = cpu_map[cpu_phy_id]
-                if not core_id in core_info.keys():
-                    core_info[core_id] = [i]
-                else:
-                    core_info[core_id].append(i)
-                cpu_map[cpu_phy_id] = core_info
-        except Exception, details:
-            print "Package, core & cpu map table creation failed", e
-            sys.exit(1)
-    else:
-        for i in range(0, cpu_count):
-            try:
-                phy_pkg_file = '/sys/devices/system/cpu/cpu%s' %i
-                phy_pkg_file += '/topology/physical_package_id'
-                cpu_phy_id = open(phy_pkg_file).read().rstrip()
-                if not cpu_phy_id in cpu_map.keys():
-                    cpu_map[cpu_phy_id] = [i]
-                else:
-                    cpu_map[cpu_phy_id].append(i)
-            except IOError, e:
-                print "Mapping of CPU to pkg id failed", e
-                sys.exit(1)
-
-
-def generate_sibling_list():
-    ''' Routine to generate siblings list
-    '''
-    try:
-        for i in range(0, cpu_count):
-            siblings_file = '/sys/devices/system/cpu/cpu%s' % i
-            siblings_file += '/topology/thread_siblings_list'
-            threads_sibs = open(siblings_file).read().rstrip()
-            thread_ids = threads_sibs.split("-")
-
-            if not thread_ids in siblings_list:
-                siblings_list.append(thread_ids)
-    except Exception, details:
-        print "Exception in generate_siblings_list", details
-        sys.exit(1)
-
-def get_siblings(cpu_id):
-    ''' Return siblings of cpu_id
-    '''
-    try:
-        cpus = ""
-        for i in range(0, len(siblings_list)):
-            for cpu in siblings_list[i]:
-                if cpu_id == cpu:
-                    for j in siblings_list[i]:
-                        # Exclude cpu_id in the list of siblings
-                        if j != cpu_id:
-                            cpus += j
-                    return cpus
-        return cpus
-    except Exception, details:
-        print "Exception in get_siblings", details
-        sys.exit(1)
-
-def get_proc_data(stats_list):
-    ''' Read /proc/stat info and store in dictionary
-    '''
-    try:
-        file_procstat = open("/proc/stat", 'r')
-        for line in file_procstat:
-            if line.startswith('cpu'):
-                data = line.split()
-                stats_list[data[0]] = data
-        file_procstat.close()
-    except OSError, e:
-        print "Could not read statistics", e
-        sys.exit(1)
-
-def get_proc_loc_count(loc_stats):
-    ''' Read /proc/interrupts info and store in list
-    '''
-    try:
-        file_procstat = open("/proc/interrupts", 'r')
-        for line in file_procstat:
-            if line.startswith(' LOC:') or line.startswith('LOC:'):
-                data = line.split()
-                for i in range(0, cpu_count):
-                    # To skip LOC
-                    loc_stats.append(data[i+1])
-                file_procstat.close()
-                return
-    except Exception, details:
-        print "Could not read interrupt statistics", details
-        sys.exit(1)
-
-
-def set_sched_mc_power(sched_mc_level):
-    ''' Routine to set sched_mc_power_savings to required level
-    '''
-    try:
-        os.system('echo %s > \
-            /sys/devices/system/cpu/sched_mc_power_savings 2>/dev/null'
-            % sched_mc_level)
-
-        get_proc_data(stats_start)
-    except OSError, e:
-        print "Could not set sched_mc_power_savings to", sched_mc_level, e
-	sys.exit(1)
-
-def set_sched_smt_power(sched_smt_level):
-    ''' Routine to set sched_smt_power_savings to required level
-    '''
-    try:
-        os.system('echo %s > \
-            /sys/devices/system/cpu/sched_smt_power_savings 2>/dev/null'
-            % sched_smt_level)
-
-        get_proc_data(stats_start)
-    except OSError, e:
-        print "Could not set sched_smt_power_savings to", sched_smt_level, e
-	sys.exit(1)
-
-def set_timer_migration_interface(value):
-    ''' Set value of timer migration interface to a value
-        passed as argument
-    '''
-    try:
-        os.system('echo %s > \
-            /proc/sys/kernel/timer_migration 2>/dev/null' % value)
-    except OSError, e:
-        print "Could not set timer_migration to ", value, e
-        sys.exit(1)
-
-def get_job_count(stress, workload, sched_smt):
-    ''' Returns number of jobs/threads to be triggered
-    '''
-
-    try:
-        if stress == "thread":
-            threads = get_hyper_thread_count()
-        if stress == "partial":
-            threads = cpu_count / socket_count
-            if is_hyper_threaded():
-                if workload == "ebizzy" and int(sched_smt) ==0:
-                    threads = threads / get_hyper_thread_count()
-                if workload == "kernbench" and int(sched_smt) < 2:
-                    threads = threads / get_hyper_thread_count()
-        if stress == "full":
-            threads = cpu_count
-        if stress == "single_job":
-            threads = 1
-            duration = 180
-        return threads
-    except Exception, details:
-        print "get job count failed ", details
-        sys.exit(1)
-
-def trigger_ebizzy (sched_smt, stress, duration, background, pinned):
-    ''' Triggers ebizzy workload for sched_mc=1
-        testing
-    '''
-    try:
-        threads = get_job_count(stress, "ebizzy", sched_smt)
-        workload = "ebizzy"
-        olddir = os.getcwd()
-        path = '%s/testcases/bin' % os.environ['LTPROOT']
-        os.chdir(path)
-        workload_file = ""
-        for file_name in os.listdir('.'):
-            if file_name == workload:
-                workload_file = file_name
-                break
-        if workload_file == "":
-            print "INFO: ebizzy benchmark not found"
-            os.chdir(olddir)
-            sys.exit(1)
-        get_proc_data(stats_start)
-        get_proc_loc_count(intr_start)
-        try:
-            if background == "yes":
-                succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null &'
-                    % (threads, duration))
-            else:
-                if pinned == "yes":
-                    succ = os.system('taskset -c %s ./ebizzy -t%s -s4096 -S %s >/dev/null'
-                        % (cpu_count -1, threads, duration))
-                else:
-                    succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null'
-                        % (threads, duration))
-
-            if succ == 0:
-                print "INFO: ebizzy workload triggerd"
-                os.chdir(olddir)
-                #Commented bcoz it doesnt make sense to capture it when workload triggered
-                #in background
-                #get_proc_loc_count(intr_stop)
-                #get_proc_data(stats_stop)
-            else:
-                print "INFO: ebizzy workload triggerd failed"
-                os.chdir(olddir)
-                sys.exit(1)
-        except Exception, details:
-            print "Ebizzy workload trigger failed ", details
-            sys.exit(1)
-    except Exception, details:
-        print "Ebizzy workload trigger failed ", details
-        sys.exit(1)
-
-def trigger_kernbench (sched_smt, stress, background, pinned, perf_test):
-    ''' Trigger load on system like kernbench.
-        Copys existing copy of LTP into as LTP2 and then builds it
-        with make -j
-    '''
-    olddir = os.getcwd()
-    try:
-        threads = get_job_count(stress, "kernbench", sched_smt)
-
-        dst_path = "/root"
-        workload = "kernbench"
-        olddir = os.getcwd()
-        path = '%s/testcases/bin' % os.environ['LTPROOT']
-        os.chdir(path)
-        workload_file = ""
-        for file_name in os.listdir('.'):
-            if file_name == workload:
-                workload_file = file_name
-                break
-        if workload_file != "":
-            benchmark_path = path
-        else:
-            print "INFO: kernbench benchmark not found"
-            os.chdir(olddir)
-            sys.exit(1)
-
-        os.chdir(dst_path)
-        linux_source_dir=""
-        for file_name in os.listdir('.'):
-            if file_name.find("linux-2.6") != -1 and os.path.isdir(file_name):
-                linux_source_dir=file_name
-                break
-        if linux_source_dir != "":
-            os.chdir(linux_source_dir)
-        else:
-            print "INFO: Linux kernel source not found in /root. Workload\
-               Kernbench cannot be executed"
-            sys.exit(1)
-
-        get_proc_data(stats_start)
-        get_proc_loc_count(intr_start)
-        if pinned == "yes":
-            os.system ( 'taskset -c %s %s/kernbench -o %s -M -H -n 1 \
-                >/dev/null 2>&1 &' % (cpu_count-1, benchmark_path, threads))
-
-            # We have to delete import in future
-            import time
-            time.sleep(240)
-            stop_wkld("kernbench")
-        else:
-            if background == "yes":
-                os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1 &' \
-                    % (benchmark_path, threads))
-            else:
-                if perf_test == "yes":
-                    os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1' \
-                        % (benchmark_path, threads))
-                else:
-                    os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1 &' \
-                        % (benchmark_path, threads))
-                    # We have to delete import in future
-                    import time
-                    time.sleep(240)
-                    stop_wkld("kernbench")
-
-        print "INFO: Workload kernbench triggerd"
-        os.chdir(olddir)
-    except Exception, details:
-        print "Workload kernbench trigger failed ", details
-        sys.exit(1)
-
-def trigger_workld(sched_smt, workload, stress, duration, background, pinned, perf_test):
-    ''' Triggers workload passed as argument. Number of threads
-        triggered is based on stress value.
-    '''
-    try:
-        if workload == "ebizzy":
-            trigger_ebizzy (sched_smt, stress, duration, background, pinned)
-        if workload == "kernbench":
-            trigger_kernbench (sched_smt, stress, background, pinned, perf_test)
-    except Exception, details:
-        print "INFO: Trigger workload failed", details
-        sys.exit(1)
-
-def generate_report():
-    ''' Generate report of CPU utilization
-    '''
-    cpu_labels = ('cpu', 'user', 'nice', 'system', 'idle', 'iowait', 'irq',
-	'softirq', 'x', 'y')
-    if (not os.path.exists('/procstat')):
-        os.mkdir('/procstat')
-
-    get_proc_data(stats_stop)
-
-    reportfile = open('/procstat/cpu-utilisation', 'a')
-    debugfile = open('/procstat/cpu-utilisation.debug', 'a')
-    for l in stats_stop:
-        percentage_list = []
-        total = 0
-        for i in range(1, len(stats_stop[l])):
-            stats_stop[l][i] =  int(stats_stop[l][i]) - int(stats_start[l][i])
-            total += stats_stop[l][i]
-        percentage_list.append(l)
-        for i in range(1, len(stats_stop[l])):
-            percentage_list.append(float(stats_stop[l][i])*100/total)
-
-        stats_percentage[l] = percentage_list
-
-    for i in range(0, len(cpu_labels)):
-        print >> debugfile, cpu_labels[i], '\t',
-    print >> debugfile
-    for l in sorted(stats_stop.keys()):
-        print >> debugfile, l, '\t',
-        for i in range(1, len(stats_stop[l])):
-            print >> debugfile, stats_stop[l][i], '\t',
-        print >> debugfile
-
-    for i in range(0, len(cpu_labels)):
-        print >> reportfile, cpu_labels[i], '\t',
-    print >> reportfile
-    for l in sorted(stats_percentage.keys()):
-        print >> reportfile, l, '\t',
-        for i in range(1, len(stats_percentage[l])):
-            print >> reportfile, " %3.4f" % stats_percentage[l][i],
-        print >> reportfile
-
-    #Now get the package ID information
-    try:
-        print >> debugfile, "cpu_map: ", cpu_map
-        keyvalfile = open('/procstat/keyval', 'a')
-        print >> keyvalfile, "nr_packages=%d" % len(cpu_map)
-        print >> keyvalfile, "system-idle=%3.4f" % (stats_percentage['cpu'][4])
-        for pkg in sorted(cpu_map.keys()):
-            if is_hyper_threaded():
-                for core in sorted(cpu_map[pkg].keys()):
-                    total_idle = 0
-                    total = 0
-                    for cpu in cpu_map[pkg][core]:
-                        total_idle += stats_stop["cpu%d" % cpu][4]
-                        for i in range(1, len(stats_stop["cpu%d" % cpu])):
-                            total += stats_stop["cpu%d" % cpu][i]
-            else:
-                total_idle = 0
-                total = 0
-                for cpu in cpu_map[pkg]:
-                    total_idle += stats_stop["cpu%d" % cpu][4]
-                    for i in range(1, len(stats_stop["cpu%d" % cpu])):
-                        total += stats_stop["cpu%d" % cpu][i]
-            print >> reportfile, "Package: ", pkg, "Idle %3.4f%%" \
-	        % (float(total_idle)*100/total)
-            print >> keyvalfile, "package-%s=%3.4f" % \
-		(pkg, (float(total_idle)*100/total))
-    except Exception, details:
-        print "Generating utilization report failed: ", details
-        sys.exit(1)
-
-    #Add record delimiter '\n' before closing these files
-    print >> debugfile
-    debugfile.close()
-    print >> reportfile
-    reportfile.close()
-    print >> keyvalfile
-    keyvalfile.close()
-
-def generate_loc_intr_report():
-    ''' Generate interrupt report of CPU's
-    '''
-    try:
-        if (not os.path.exists('/procstat')):
-            os.mkdir('/procstat')
-
-        get_proc_loc_count(intr_stop)
-
-        reportfile = open('/procstat/cpu-loc_interrupts', 'a')
-        print >> reportfile, "=============================================="
-        print >> reportfile, "     Local timer interrupt stats              "
-        print >> reportfile, "=============================================="
-
-        for i in range(0, cpu_count):
-            intr_stop[i] =  int(intr_stop[i]) - int(intr_start[i])
-            print >> reportfile, "CPU%s: %s" %(i, intr_stop[i])
-        print >> reportfile
-        reportfile.close()
-    except Exception, details:
-        print "Generating interrupt report failed: ", details
-        sys.exit(1)
-
-def record_loc_intr_count():
-    ''' Record Interrupt statistics when timer_migration
-        was disabled
-    '''
-    try:
-        global intr_start, intr_stop
-        for i in range(0, cpu_count):
-            intr_stat_timer_0.append(intr_stop[i])
-        intr_start = []
-        intr_stop = []
-    except Exception, details:
-        print "INFO: Record interrupt statistics when timer_migration=0",details
-
-def expand_range(range_val):
-    '''
-       Expand the range of value into actual numbers
-    '''
-    ids_list = list()
-    try:
-        sep_comma = range_val.split(",")
-        for i in range(0, len(sep_comma)):
-            hyphen_values = sep_comma[i].split("-")
-            if len(hyphen_values) == 1:
-                ids_list.append(int(hyphen_values[0]))
-            else:
-                for j in range(int(hyphen_values[0]), int(hyphen_values[1])+1):
-                    ids_list.append(j)
-        return(ids_list)
-    except Exception, details:
-        print "INFO: expand_pkg_grps failed ", details
-
-def is_quad_core():
-    '''
-       Read /proc/cpuinfo and check if system is Quad core
-    '''
-    try:
-        cpuinfo = open('/proc/cpuinfo', 'r')
-        for line in cpuinfo:
-            if line.startswith('cpu cores'):
-                cores = line.split("cpu cores")
-                num_cores = cores[1].split(":")
-                cpuinfo.close()
-                if int(num_cores[1]) == 4:
-                    return(1)
-                else:
-                    return(0)
-    except IOError, e:
-        print "Failed to get cpu core information", e
-        sys.exit(1)
-
-def validate_cpugrp_map(cpu_group, sched_mc_level, sched_smt_level):
-    '''
-       Verify if cpugrp belong to same package
-    '''
-    modi_cpu_grp = cpu_group[:]
-    try:
-        if is_hyper_threaded():
-            for pkg in sorted(cpu_map.keys()):
-                # if CPU utilized is across package this condition will be true
-                if len(modi_cpu_grp) != len(cpu_group):
-                    break
-                for core in sorted(cpu_map[pkg].keys()):
-                    core_cpus = cpu_map[pkg][core]
-                    if core_cpus == modi_cpu_grp:
-                        return 0
-                    else:
-                        #if CPUs used across the cores
-                        for i in range(0, len(core_cpus)):
-                            if core_cpus[i] in modi_cpu_grp:
-                                modi_cpu_grp.remove(core_cpus[i])
-                                if len(modi_cpu_grp) == 0:
-                                    return 0
-                            #This code has to be deleted
-                            #else:
-                                # If sched_smt == 0 then its oky if threads run
-                                # in different cores of same package
-                                #if sched_smt_level > 0 :
-                                    #return 1
-	else:
-            for pkg in sorted(cpu_map.keys()):
-                pkg_cpus = cpu_map[pkg]
-                if len(cpu_group) == len(pkg_cpus):
-                    if pkg_cpus == cpu_group:
-                        return(0)
-                else:
-                    if int(cpus_utilized[0]) in cpu_map[pkg] or int(cpus_utilized[1]) in cpu_map[pkg]:
-                        return(0)
-
-        return(1)
-
-    except Exception, details:
-        print "Exception in validate_cpugrp_map: ", details
-        sys.exit(1)
-
-
-def verify_sched_domain_dmesg(sched_mc_level, sched_smt_level):
-    '''
-       Read sched domain information from dmesg.
-    '''
-    cpu_group = list()
-    try:
-        dmesg_info = os.popen('dmesg').read()
-        if dmesg_info != "":
-            lines = dmesg_info.split('\n')
-            for i in range(0, len(lines)):
-                if lines[i].endswith('CPU'):
-                    groups = lines[i+1].split("groups:")
-                    group_info = groups[1]
-                    if group_info.find("(") != -1:
-                        openindex=group_info.index("(")
-                        closeindex=group_info.index(")")
-                        group_info=group_info.replace\
-                            (group_info[openindex:closeindex+1],"")
-
-                    subgroup = group_info.split(",")
-                    for j in range(0, len(subgroup)):
-                        cpu_group = expand_range(subgroup[j])
-                        status = validate_cpugrp_map(cpu_group, sched_mc_level,\
-                        sched_smt_level)
-                        if status == 1:
-                            if is_quad_core() == 1:
-                                if int(sched_mc_level) == 0:
-                                    return(0)
-                                else:
-                                    return(1)
-                            else:
-                                return(1)
-            return(0)
-        else:
-            return(1)
-    except Exception, details:
-        print "Reading dmesg failed", details
-        sys.exit(1)
-
-def get_cpu_utilization(cpu):
-    ''' Return cpu utilization of cpu_id
-    '''
-    try:
-        for l in sorted(stats_percentage.keys()):
-            if cpu == stats_percentage[l][0]:
-                return stats_percentage[l][1]
-        return -1
-    except Exception, details:
-        print "Exception in get_cpu_utilization", details
-        sys.exit(1)
-
-def validate_cpu_consolidation(stress, work_ld, sched_mc_level, sched_smt_level):
-    ''' Verify if cpu's on which threads executed belong to same
-    package
-    '''
-    cpus_utilized = list()
-    threads = get_job_count(stress, work_ld, sched_smt_level)
-    try:
-        for l in sorted(stats_percentage.keys()):
-            #modify threshold
-            cpu_id = stats_percentage[l][0].split("cpu")
-            if cpu_id[1] == '':
-                continue
-            if int(cpu_id[1]) in cpus_utilized:
-                continue
-            if is_hyper_threaded():
-                if work_ld == "kernbench" and sched_smt_level < sched_mc_level:
-                    siblings = get_siblings(cpu_id[1])
-                    if siblings != "":
-                        sib_list = siblings.split()
-                        utilization = int(stats_percentage[l][1])
-                        for i in range(0, len(sib_list)):
-                            utilization += int(get_cpu_utilization("cpu%s" %sib_list[i]))
-                    else:
-                        utilization = stats_percentage[l][1]
-                    if utilization > 40:
-                        cpus_utilized.append(int(cpu_id[1]))
-                        if siblings != "":
-                            for i in range(0, len(sib_list)):
-                                cpus_utilized.append(int(sib_list[i]))
-                else:
-                    # This threshold wuld be modified based on results
-                    if stats_percentage[l][1] > 40:
-                        cpus_utilized.append(int(cpu_id[1]))
-            else:
-                if work_ld == "kernbench" :
-                    if stats_percentage[l][1] > 50:
-                        cpus_utilized.append(int(cpu_id[1]))
-                else:
-                    if stats_percentage[l][1] > 70:
-                        cpus_utilized.append(int(cpu_id[1]))
-            cpus_utilized.sort()
-        print "INFO: CPU's utilized ", cpus_utilized
-
-        # If length of CPU's utilized is not = number of jobs exit with 1
-        if len(cpus_utilized) < threads:
-            return 1
-
-        status = validate_cpugrp_map(cpus_utilized, sched_mc_level, \
-            sched_smt_level)
-        if status == 1:
-            print "INFO: CPUs utilized is not in same package or core"
-
-        return(status)
-    except Exception, details:
-        print "Exception in validate_cpu_consolidation: ", details
-        sys.exit(1)
-
-def get_cpuid_max_intr_count():
-    '''Return the cpu id's of two cpu's with highest number of intr'''
-    try:
-        highest = 0
-        second_highest = 0
-        cpus_utilized = []
-
-        #Skipping CPU0 as it is generally high
-        for i in range(1, cpu_count):
-            if int(intr_stop[i]) > int(highest):
-                if highest != 0:
-                    second_highest = highest
-                    cpu2_max_intr = cpu1_max_intr
-                highest = int(intr_stop[i])
-                cpu1_max_intr = i
-            else:
-                if int(intr_stop[i]) > int(second_highest):
-                    second_highest = int(intr_stop[i])
-                    cpu2_max_intr = i
-        cpus_utilized.append(cpu1_max_intr)
-        cpus_utilized.append(cpu2_max_intr)
-
-        for i in range(1, cpu_count):
-            if i != cpu1_max_intr and i != cpu2_max_intr:
-                diff = second_highest - intr_stop[i]
-                ''' Threshold of difference has to be manipulated '''
-                if diff < 10000:
-                    print "INFO: Diff in interrupt count is below threshold"
-                    cpus_utilized = []
-                    return cpus_utilized
-        print "INFO: Interrupt count in other CPU's low as expected"
-        return cpus_utilized
-    except Exception, details:
-        print "Exception in get_cpuid_max_intr_count: ", details
-        sys.exit(1)
-
-def validate_ilb (sched_mc_level, sched_smt_level):
-    ''' Validate if ilb is running in same package where work load is running
-    '''
-    try:
-        cpus_utilized = get_cpuid_max_intr_count()
-        if not cpus_utilized:
-            return 1
-
-        status = validate_cpugrp_map(cpus_utilized, sched_mc_level, sched_smt_level)
-        return status
-    except Exception, details:
-        print "Exception in validate_ilb: ", details
-        sys.exit(1)
-
-def reset_schedmc():
-    ''' Routine to reset sched_mc_power_savings to Zero level
-    '''
-    try:
-        os.system('echo 0 > \
-            /sys/devices/system/cpu/sched_mc_power_savings 2>/dev/null')
-    except OSError, e:
-        print "Could not set sched_mc_power_savings to 0", e
-        sys.exit(1)
-
-def reset_schedsmt():
-    ''' Routine to reset sched_smt_power_savings to Zero level
-    '''
-    try:
-        os.system('echo 0 > \
-            /sys/devices/system/cpu/sched_smt_power_savings 2>/dev/null')
-    except OSError, e:
-        print "Could not set sched_smt_power_savings to 0", e
-        sys.exit(1)
-
-def stop_wkld(work_ld):
-    ''' Kill workload triggered in background
-    '''
-    try:
-        os.system('pkill %s 2>/dev/null' %work_ld)
-        if work_ld == "kernbench":
-            os.system('pkill make 2>/dev/null')
-    except OSError, e:
-        print "Exception in stop_wkld", e
-        sys.exit(1)
diff --git a/testcases/kernel/power_management/pm_cpu_consolidation.py b/testcases/kernel/power_management/pm_cpu_consolidation.py
new file mode 100755
index 0000000..5aa3948
--- /dev/null
+++ b/testcases/kernel/power_management/pm_cpu_consolidation.py
@@ -0,0 +1,145 @@
+#!/usr/bin/python
+''' This Python script interprets various sched stats values.
+    Validates cpu consolidation for given sched_mc_power_saving value
+'''
+
+import os
+import sys
+import time
+LIB_DIR = "%s/lib" % os.path.dirname(__file__)
+sys.path.append(LIB_DIR)
+from optparse import OptionParser
+from pm_sched_mc import *
+
+__author__ = "Poornima Nayak <mpnayak@linux.vnet.ibm.com>"
+
+class Usage(Exception):
+    def __init__(self, msg):
+        self.msg = msg
+
+def main(argv=None):
+    if argv is None:
+        argv = sys.argv
+
+    usage = "-w"
+    parser = OptionParser(usage)
+    parser.add_option("-v", "--variation_test", dest="vary_mc_smt",
+        default=False, action="store_true", help="Vary sched_mc & sched_smt. \
+            -c and -t inputs are initial value of sched_mc & sched_smt")
+    parser.add_option("-c", "--mc_value", dest="mc_value",
+        default=0, help="Sched mc power saving value 0/1/2")
+    parser.add_option("-t", "--smt_value", dest="smt_value",
+        default=0, help="Sched smt power saving value 0/1/2")
+    parser.add_option("-w", "--workload", dest="work_ld",
+        default="ebizzy", help="Workload can be ebizzy/kernbench")
+    parser.add_option("-s", "--stress", dest="stress",
+        default="partial", help="Load on system is full/partial [i.e 50%]/thread")
+    parser.add_option("-p", "--performance", dest="perf_test",
+        default=False, action="store_true", help="Enable performance test")
+    (options, args) = parser.parse_args()
+
+    try:
+        count_num_cpu()
+        count_num_sockets()
+        if is_hyper_threaded():
+            generate_sibling_list()
+
+        # User should set option -v to test cpu consolidation
+        # resets when sched_mc &(/) sched_smt is disabled when
+        # workload is already running in the system
+
+        if options.vary_mc_smt:
+
+            # Since same code is used for testing package consolidation and core
+            # consolidation is_multi_socket & is_hyper_threaded check is done
+            if is_multi_socket() and is_multi_core() and options.mc_value:
+                set_sched_mc_power(options.mc_value)
+
+            if is_hyper_threaded() and options.smt_value:
+                set_sched_smt_power(options.smt_value)
+
+            #Generate arguments for trigger workload, run workload in background
+            map_cpuid_pkgid()
+            background="yes"
+            duration=360
+            pinned="no"
+            if int(options.mc_value) < 2 and int(options.smt_value) < 2:
+                trigger_ebizzy (options.smt_value, "partial", duration, background, pinned)
+                work_ld="ebizzy"
+                #Wait for 120 seconds and then validate cpu consolidation works
+                #When sched_mc & sched_smt is set
+                import time
+                time.sleep(120)
+            else:
+                #Wait for 120 seconds and then validate cpu consolidation works
+                #When sched_mc & sched_smt is set
+                trigger_kernbench (options.smt_value, "partial", background, pinned, "no")
+                work_ld="kernbench"
+                import time
+                time.sleep(300)
+
+            generate_report()
+            status = validate_cpu_consolidation("partial", work_ld, options.mc_value, options.smt_value)
+            if status == 0:
+                print "INFO: Consolidation worked sched_smt &(/) sched_mc is set"
+                #Disable sched_smt & sched_mc interface values
+                if options.vary_mc_smt and options.mc_value > 0:
+                    set_sched_mc_power(0)
+                    mc_value = options.mc_value
+                else:
+                    mc_value = 0
+                if options.vary_mc_smt and options.smt_value > 0 and is_hyper_threaded():
+                    set_sched_smt_power(0)
+                    smt_value = options.smt_value
+                else:
+                    smt_value = 0
+
+                if work_ld == "kernbench":
+                    time.sleep(240)
+                else:
+                    time.sleep(120)
+
+                generate_report()
+                status = validate_cpu_consolidation("partial", work_ld, mc_value, smt_value)
+                if background == "yes":
+                    stop_wkld(work_ld)
+                #CPU consolidation should fail as sched_mc &(/) sched_smt is disabled
+                if status == 1:
+                    return(0)
+                else:
+                    return(1)
+            else:
+                print "INFO: CPU consolidation failed when sched_mc &(/) \
+sched_smt was enabled. This is pre-requisite to proceed"
+                return(status)
+        else:
+            #The else part of the code validates behaviour of sched_mc
+            # and sched_smt set to 0, 1 & 2
+            if is_multi_socket():
+                set_sched_mc_power(options.mc_value)
+            if is_hyper_threaded():
+                set_sched_smt_power(options.smt_value)
+            map_cpuid_pkgid()
+            print "INFO: Created table mapping cpu to package"
+            background="no"
+            duration=60
+            pinned ="no"
+
+            if options.perf_test:
+                perf_test="yes"
+            else:
+                perf_test="no"
+
+            trigger_workld( options.smt_value, options.work_ld, options.stress, duration, background, pinned, perf_test)
+            generate_report()
+            status = validate_cpu_consolidation(options.stress, options.work_ld,options.mc_value, options.smt_value)
+            reset_schedmc()
+            if is_hyper_threaded():
+                reset_schedsmt()
+            return(status)
+    except Exception, details:
+        print "INFO: CPU consolidation failed", details
+        return(1)
+
+if __name__ == "__main__":
+    sys.exit(main())
diff --git a/testcases/kernel/power_management/pm_get_sched_values.c b/testcases/kernel/power_management/pm_get_sched_values.c
new file mode 100644
index 0000000..5409971
--- /dev/null
+++ b/testcases/kernel/power_management/pm_get_sched_values.c
@@ -0,0 +1,50 @@
+/************************************************************************
+* Copyright (c) International Business Machines Corp., 2008
+* This program is free software; you can redistribute it and/or modify
+* it under the terms of the GNU General Public License as published by
+* the Free Software Foundation; either version 2 of the License, or
+* (at your option) any later version.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+* the GNU General Public License for more details.
+* You should have received a copy of the GNU General Public License
+* along with this program; if not, write to the Free Software
+* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+*
+***************************************************************************/
+#include <stdio.h>
+#include "test.h"
+
+const char *TCID = "pm_get_sched_values";
+
+int get_supp_sched_mc(void)
+{
+	if (tst_kvercmp(2, 6, 29) < 0)
+		return 1;
+	else
+		return 2;
+}
+
+int get_supp_sched_smt(void)
+{
+	if (tst_kvercmp(2, 6, 29) < 0)
+		return 1;
+	else
+		return 2;
+}
+
+int main(int argc, char **argv)
+{
+	char *param;
+	if (argc == 0)
+		return 1;
+	else {
+		param = argv[1];
+		if (strcmp(param, "sched_mc") == 0)
+			return get_supp_sched_mc();
+		if (strcmp(param, "sched_smt") == 0)
+			return get_supp_sched_smt();
+	}
+}
diff --git a/testcases/kernel/power_management/pm_ilb_test.py b/testcases/kernel/power_management/pm_ilb_test.py
new file mode 100755
index 0000000..3f6ad46
--- /dev/null
+++ b/testcases/kernel/power_management/pm_ilb_test.py
@@ -0,0 +1,59 @@
+#!/usr/bin/python
+''' This Python script interprets interrupt values.
+    Validates Ideal load balancer runs in same package where workload is running
+'''
+
+import os
+import sys
+LIB_DIR = "%s/lib" % os.path.dirname(__file__)
+sys.path.append(LIB_DIR)
+from optparse import OptionParser
+from pm_sched_mc import *
+
+__author__ = "Poornima Nayak <mpnayak@linux.vnet.ibm.com>"
+
+class Usage(Exception):
+    def __init__(self, msg):
+        self.msg = msg
+
+def main(argv=None):
+    if argv is None:
+        argv = sys.argv
+
+    usage = "-w"
+    parser = OptionParser(usage)
+    parser.add_option("-c", "--mc_level", dest="mc_level",
+        default=0, help="Sched mc power saving value 0/1/2")
+    parser.add_option("-t", "--smt_level", dest="smt_level",
+        default=0, help="Sched smt power saving value 0/1/2")
+    parser.add_option("-w", "--workload", dest="work_ld",
+        default="ebizzy", help="Workload can be ebizzy/kernbench")
+    (options, args) = parser.parse_args()
+
+    try:
+        count_num_cpu()
+        count_num_sockets()
+        if is_multi_socket():
+            set_sched_mc_power(options.mc_level)
+        if is_hyper_threaded():
+            set_sched_smt_power(options.smt_level)
+        map_cpuid_pkgid()
+        print "INFO: Created table mapping cpu to package"
+        background="no"
+        duration=120
+        pinned="yes"
+
+        trigger_workld(options.smt_level,options.work_ld, "single_job", duration, background, pinned, "no")
+        generate_loc_intr_report()
+        status = validate_ilb(options.mc_level, options.smt_level)
+        reset_schedmc()
+        if is_hyper_threaded():
+            reset_schedsmt()
+        return(status)
+
+    except Exception, details:
+        print "INFO: Idle Load Balancer test failed", details
+        return(1)
+
+if __name__ == "__main__":
+    sys.exit(main())
diff --git a/testcases/kernel/power_management/pm_sched_domain.py b/testcases/kernel/power_management/pm_sched_domain.py
new file mode 100755
index 0000000..a636c48
--- /dev/null
+++ b/testcases/kernel/power_management/pm_sched_domain.py
@@ -0,0 +1,56 @@
+#!/usr/bin/python
+''' This Python script validates sched domain information in dmesg
+    with information in sysfs topology
+'''
+
+import os
+import sys
+LIB_DIR = "%s/lib" % os.path.dirname(__file__)
+sys.path.append(LIB_DIR)
+from pm_sched_mc import *
+from optparse import OptionParser
+
+__author__ = "Poornima Nayak <mpnayak@linux.vnet.ibm.com>"
+
+class Usage(Exception):
+    def __init__(self, msg):
+        self.msg = msg
+
+def main(argv=None):
+    if argv is None:
+        argv = sys.argv
+
+    usage = "-w"
+    parser = OptionParser(usage)
+    parser.add_option("-c", "--mc_level", dest="mc_level", default=-1,
+        help="Sched mc power saving value 0/1/2")
+    parser.add_option("-t", "--smt_level", dest="smt_level", default=-1,
+        help="Sched smt power saving value 0/1/2")
+    (options, args) = parser.parse_args()
+
+    try:
+        clear_dmesg()
+        count_num_cpu()
+        map_cpuid_pkgid()
+
+        if is_hyper_threaded() and int(options.smt_level) >= 0:
+            set_sched_smt_power(options.smt_level)
+
+        if int(options.mc_level) >= 0:
+            set_sched_mc_power(options.mc_level)
+        if int(options.smt_level) >= 0 or int(options.mc_level) >= 0:
+            status = verify_sched_domain_dmesg(options.mc_level, options.smt_level)
+            reset_schedmc()
+            if is_hyper_threaded():
+                reset_schedsmt()
+                return(status)
+        else:
+            print "INFO: Invalid arguments given"
+            return 1
+    except Exception, details:
+        print "INFO: sched domain test failed: ", details
+        return(1)
+
+# Run test based on the command line arguments
+if __name__ == "__main__":
+    sys.exit(main())
diff --git a/testcases/kernel/power_management/runpwtests05.sh b/testcases/kernel/power_management/runpwtests05.sh
index c086e3c..74c9f7c 100755
--- a/testcases/kernel/power_management/runpwtests05.sh
+++ b/testcases/kernel/power_management/runpwtests05.sh
@@ -55,7 +55,7 @@ fi
 echo "max sched mc $max_sched_mc"
 RC=0
 for sched_mc in `seq 0 $max_sched_mc`; do
-	sched_domain.py -c $sched_mc; ret=$?
+	pm_sched_domain.py -c $sched_mc; ret=$?
 	analyze_sched_domain_result $sched_mc $ret; RC=$?
 done
 if [ $RC -eq 0 ]; then
@@ -67,9 +67,9 @@ fi
 # Testcase to validate sched_domain tree
 RC=0
 for sched_mc in `seq 0 $max_sched_mc`; do
-	get_sched_values sched_smt; max_sched_smt=$?
+	pm_get_sched_values sched_smt; max_sched_smt=$?
 	for sched_smt in `seq 0 $max_sched_smt`; do
-		sched_domain.py -c $sched_mc -t $sched_smt; ret=$?
+		pm_sched_domain.py -c $sched_mc -t $sched_smt; ret=$?
 		analyze_sched_domain_result $sched_mc $ret $sched_smt; RC=$?
 	done
 done
diff --git a/testcases/kernel/power_management/runpwtests_exclusive01.sh b/testcases/kernel/power_management/runpwtests_exclusive01.sh
index 27876bf..a805273 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive01.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive01.sh
@@ -58,7 +58,7 @@ for sched_mc in `seq 0  $max_sched_mc`; do
 	fi
 	for repeat_test in `seq 1  10`; do
 		#Testcase to validate CPU consolidation for sched_mc
-		if cpu_consolidation.py -c $sched_mc -w $work_load ; then
+		if pm_cpu_consolidation.py -c $sched_mc -w $work_load ; then
 		: $(( sched_mc_pass_cnt += 1 ))
 		fi
 	done
@@ -83,7 +83,7 @@ for sched_mc in `seq 0  $max_sched_mc`; do
 		for repeat_test in `seq 1  10`; do
 			# Testcase to validate CPU consolidation for
 			# for sched_mc & sched_smt with stress=50%
-			if cpu_consolidation.py -c $sched_mc -t $sched_smt \
+			if pm_cpu_consolidation.py -c $sched_mc -t $sched_smt \
 				-w $work_load ; then
 				: $(( sched_mc_smt_pass_cnt += 1 ))
 			fi
diff --git a/testcases/kernel/power_management/runpwtests_exclusive02.sh b/testcases/kernel/power_management/runpwtests_exclusive02.sh
index 7d12662..a0e00df 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive02.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive02.sh
@@ -56,7 +56,7 @@ for sched_smt in `seq 0 $max_sched_smt`; do
 	sched_smt_pass_cnt=0
 	stress="thread"
 	for repeat_test in `seq 1  10`; do
-		if cpu_consolidation.py -t $sched_smt -w $work_load \
+		if pm_cpu_consolidation.py -t $sched_smt -w $work_load \
 			-s $stress; then
 			: $(( sched_smt_pass_cnt += 1 ))
 		fi
diff --git a/testcases/kernel/power_management/runpwtests_exclusive03.sh b/testcases/kernel/power_management/runpwtests_exclusive03.sh
index 99c1391..8083adb 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive03.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive03.sh
@@ -54,7 +54,7 @@ fi
 # sched_mc is set to 0.
 RC=0
 for sched_mc in `seq 1  $max_sched_mc`; do
-	if cpu_consolidation.py -v -c $sched_mc; then
+	if pm_cpu_consolidation.py -v -c $sched_mc; then
 		echo "Test PASS: CPU consolidation test by varying" \
 			"sched_mc $sched_mc to 0"
 	else
@@ -76,7 +76,7 @@ RC=0
 for sched_mc in `seq 1  $max_sched_mc`; do
 	for sched_smt in `seq 1  $max_sched_smt`; do
 		if [ $sched_smt -eq $sched_mc ]; then
-			if cpu_consolidation.py -v -c $sched_mc \
+			if pm_cpu_consolidation.py -v -c $sched_mc \
 				-t $sched_smt; then
 				echo "Test PASS: CPU consolidation test by" \
 					"varying sched_mc & sched_smt from" \
diff --git a/testcases/kernel/power_management/runpwtests_exclusive04.sh b/testcases/kernel/power_management/runpwtests_exclusive04.sh
index 094bb22..8c7d23b 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive04.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive04.sh
@@ -40,7 +40,7 @@ fi
 # Vary only sched_smt from 1 to 0 when workload is running
 # and ensure that tasks do not consolidate to single core
 # when sched_smt is set to 0.
-if cpu_consolidation.py -v -t 1; then
+if pm_cpu_consolidation.py -v -t 1; then
 	tst_resm TPASS "CPU consolidation test by varying sched_smt from 1 to 0"
 else
 	tst_resm TFAIL "CPU consolidation test by varying sched_smt from 1 to 0"
@@ -49,7 +49,7 @@ fi
 # Vary only sched_smt from 2 to 0 when workload is running
 # and ensure that tasks do not consolidate to single core
 # when sched_smt is set to 0.
-if cpu_consolidation.py -v -t 2; then
+if pm_cpu_consolidation.py -v -t 2; then
 	tst_resm TPASS "CPU consolidation test by varying sched_smt from 2 to 0"
 else
 	tst_resm TFAIL "CPU consolidation test by varying sched_smt from 2 to 0"
diff --git a/testcases/kernel/power_management/runpwtests_exclusive05.sh b/testcases/kernel/power_management/runpwtests_exclusive05.sh
index 1f40dc6..dc8112e 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive05.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive05.sh
@@ -56,7 +56,7 @@ for sched_mc in `seq 1 $max_sched_mc`; do
 		work_load="ebizzy"
 	fi
 
-	ilb_test.py -c $sched_mc -w $work_load
+	pm_ilb_test.py -c $sched_mc -w $work_load
 	if [ $? -eq 0 ]; then
 		echo "Test PASS: ILB & workload in same package for" \
 			"sched_mc=$sched_mc"
@@ -80,7 +80,7 @@ for sched_mc in `seq 1 $max_sched_mc`; do
 		work_load="ebizzy"
 	fi
 	for sched_smt in `seq 1 $max_sched_smt`; do
-		ilb_test.py -c $sched_mc -t sched_smt -w $work_load
+		pm_ilb_test.py -c $sched_mc -t sched_smt -w $work_load
 		if [ $? -eq 0 ]; then
 			echo "Test PASS: ILB & workload in same package for" \
 				"sched_mc=$sched_mc & sched_smt=$sched_smt"
diff --git a/testcases/kernel/power_management/sched_domain.py b/testcases/kernel/power_management/sched_domain.py
deleted file mode 100755
index 3d19ac0..0000000
--- a/testcases/kernel/power_management/sched_domain.py
+++ /dev/null
@@ -1,56 +0,0 @@
-#!/usr/bin/python
-''' This Python script validates sched domain information in dmesg
-    with information in sysfs topology
-'''
-
-import os
-import sys
-LIB_DIR = "%s/lib" % os.path.dirname(__file__)
-sys.path.append(LIB_DIR)
-from sched_mc import *
-from optparse import OptionParser
-
-__author__ = "Poornima Nayak <mpnayak@linux.vnet.ibm.com>"
-
-class Usage(Exception):
-    def __init__(self, msg):
-        self.msg = msg
-
-def main(argv=None):
-    if argv is None:
-        argv = sys.argv
-
-    usage = "-w"
-    parser = OptionParser(usage)
-    parser.add_option("-c", "--mc_level", dest="mc_level", default=-1,
-        help="Sched mc power saving value 0/1/2")
-    parser.add_option("-t", "--smt_level", dest="smt_level", default=-1,
-        help="Sched smt power saving value 0/1/2")
-    (options, args) = parser.parse_args()
-
-    try:
-        clear_dmesg()
-        count_num_cpu()
-        map_cpuid_pkgid()
-
-        if is_hyper_threaded() and int(options.smt_level) >= 0:
-            set_sched_smt_power(options.smt_level)
-
-        if int(options.mc_level) >= 0:
-            set_sched_mc_power(options.mc_level)
-        if int(options.smt_level) >= 0 or int(options.mc_level) >= 0:
-            status = verify_sched_domain_dmesg(options.mc_level, options.smt_level)
-            reset_schedmc()
-            if is_hyper_threaded():
-                reset_schedsmt()
-        	return(status)
-        else:
-            print "INFO: Invalid arguments given"
-            return 1
-    except Exception, details:
-        print "INFO: sched domain test failed: ", details
-        return(1)
-
-# Run test based on the command line arguments
-if __name__ == "__main__":
-    sys.exit(main())
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

