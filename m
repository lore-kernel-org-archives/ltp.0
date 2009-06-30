Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MLema-0001Wl-4L
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:58:04 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLemT-0007I2-5V
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:57:59 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5UErHsQ011761
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 08:53:18 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UEvgsw076598
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 08:57:45 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5UEvfQt009840
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 08:57:41 -0600
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Tue, 30 Jun 2009 20:27:34 +0530
Message-Id: <20090630145734.11163.70468.sendpatchset@localhost.localdomain>
In-Reply-To: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
References: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 4/10]Reusable functions for consolidation test modified
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

[Patch 4/10]Reusable functions for consolidation test modified
This patch has fixes for sched_domian test failures in kernel version beyond 2.6.29.
Addtional new reusable functions and fixes for validation functions.

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp_orig/testcases/kernel/power_management/lib/sched_mc.py ltp_patched/testcases/kernel/power_management/lib/sched_mc.py
--- ltp_orig/testcases/kernel/power_management/lib/sched_mc.py	2009-06-30 15:04:19.000000000 +0530
+++ ltp_patched/testcases/kernel/power_management/lib/sched_mc.py	2009-06-30 15:14:37.000000000 +0530
@@ -4,15 +4,19 @@
 
 import os
 import sys
+import re
+from time import time
 
 __author__ = "Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>"
 __author__ = "Poornima Nayak <mpnayak@linux.vnet.ibm.com>"
 
+
 cpu_map = {}
 stats_start = {}
 stats_stop = {}
 stats_percentage = {}
 cpu_count = 0
+socket_count = 0
 
 def clear_dmesg():
     '''
@@ -24,30 +28,59 @@ def clear_dmesg():
         print 'Clearing dmesg failed', e
         sys.exit(1)
 
-def get_proc_data(stats_list):
-    ''' Read /proc/stat info and store in dictionary
+def count_num_cpu():
+    ''' Returns number of cpu's in system
     '''
     try:
-        file_procstat = open("/proc/stat", 'r')
-        for line in file_procstat:
-            if line.startswith('cpu'):
-                data = line.split()
-                stats_list[data[0]] = data
-        file_procstat.close()
-    except OSError, e:
-        print "Could not read statistics", e
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
         sys.exit(1)
 
 def is_hyper_threaded():
-    '''Return 1 is the system is hyper threaded else return 0
+    '''Return 1 if the system is hyper threaded else return 0
     '''
     try:
         file_cpuinfo = open("/proc/cpuinfo", 'r')
         for line in file_cpuinfo:
             if line.startswith('siblings'):
-                siblings = line.split(":") 
+                siblings = line.split(":")
             if line.startswith('cpu cores'):
-                cpu_cores = line.split(":")              
+                cpu_cores = line.split(":")
                 break
         if int( siblings[1] ) / int( cpu_cores[1] )> 1:
             file_cpuinfo.close()
@@ -58,42 +91,24 @@ def is_hyper_threaded():
         print "Failed to check if system is hyper-threaded"
         sys.exit(1)
 
-def set_sched_mc_power(sched_mc_level):
-    ''' Routine to set sched_mc_power_savings to required level
-    '''
-    try:
-        os.system('echo %s > \
-            /sys/devices/system/cpu/sched_mc_power_savings'
-            % sched_mc_level)
-    except OSError, e:
-        print "Could not set sched_mc_power_savings to", e
-        sys.exit(1)
-
-def set_sched_smt_power(sched_smt_level):
-    ''' Routine to set sched_smt_power_savings to required level
-    '''
-    try:
-        os.system('echo %s > \
-            /sys/devices/system/cpu/sched_smt_power_savings'
-            % sched_smt_level)
-    except OSError, e:
-        print "Could not set sched_smt_power_savings to", e
-        sys.exit(1)
-
-def count_num_cpu():
-    ''' Returns number of cpu's in system
+def get_hyper_thread_count():
+    ''' Return number of threads in CPU. For eg for x3950 this function
+        would return 2. In future if 4 threads are supported in CPU, this
+        routine would return 4
     '''
     try:
-        cpuinfo = open('/proc/cpuinfo', 'r')
-        global cpu_count
-        for line in cpuinfo:
-            if line.startswith('processor'):
-                cpu_count += 1
-        cpuinfo.close()
-    except IOError, e:
-        print "Could not get cpu count", e
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
         sys.exit(1)
-
+         
 def map_cpuid_pkgid():
     ''' Routine to map physical package id to cpu id
     '''
@@ -114,7 +129,7 @@ def map_cpuid_pkgid():
                 else:
                     core_info[core_id].append(i)
                 if not cpu_phy_id in cpu_map.keys():
-                    cpu_map[cpu_phy_id]= core_info 
+                    cpu_map[cpu_phy_id]= core_info
         except Exception, details:
             print "Package, core & cpu map table creation failed", e
             sys.exit(1)
@@ -122,7 +137,7 @@ def map_cpuid_pkgid():
         for i in range(0, cpu_count):
             try:
                 phy_pkg_file = '/sys/devices/system/cpu/cpu%s' %i
-                phy_pkg_file += '/topology/physical_package_id' 
+                phy_pkg_file += '/topology/physical_package_id'
                 cpu_phy_id = open(phy_pkg_file).read().rstrip()
                 if not cpu_phy_id in cpu_map.keys():
                     cpu_map[cpu_phy_id] = [i]
@@ -132,86 +147,160 @@ def map_cpuid_pkgid():
                 print "Mapping of CPU to pkg id failed", e
                 sys.exit(1)
 
-def trigger_ebizzy (test_thread_consld):
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
+def set_sched_mc_power(sched_mc_level):
+    ''' Routine to set sched_mc_power_savings to required level
+    '''
+    try:
+        os.system('echo %s > \
+            /sys/devices/system/cpu/sched_mc_power_savings 2>/dev/null'
+            % sched_mc_level)
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
+    except OSError, e:
+        print "Could not set sched_smt_power_savings to", sched_smt_level, e
+	sys.exit(1)
+
+def trigger_ebizzy (stress, duration, background):
     ''' Triggers ebizzy workload for sched_mc=1
         testing
     '''
-    if test_thread_consld != 0:
-        threads = 2
-    else:
-        threads = cpu_count / len(cpu_map)
-
-    duration = 60 # let the test run for 1 minute
-    olddir = os.getcwd()
-    path = '%s/utils/benchmark' % os.environ['LTPROOT']
-    os.chdir(path)
-    wklds_avlbl = list()
-    workload = "ebizzy"
-    workload_dir = ""
+    try:
+        if stress == "thread":
+            threads = get_hyper_thread_count()
+        if stress == "partial":
+            threads = cpu_count / socket_count
+        if stress == "full":
+	    threads = cpu_count
+
+        olddir = os.getcwd()
+        path = '%s/utils/benchmark' % os.environ['LTPROOT']
+        os.chdir(path)
+        wklds_avlbl = list()
+        workload = "ebizzy"
+        workload_dir = ""
     
-    # Use the latest version of similar workload available
-    for file_name in os.listdir('.'):
-        if file_name.find(workload) != -1:
-            wklds_avlbl.append(file_name)
-
-    wklds_avlbl.sort()
-    workload_dir = wklds_avlbl[len(wklds_avlbl)-1]
-    if workload_dir != "":
-        new_path = os.path.join(path,"%s" % workload_dir)
-        get_proc_data(stats_start)
-        try:
-            os.chdir(new_path)
-            os.system('./ebizzy -t%s -s4096 -S %s >/dev/null'
-            % (threads, duration))
-            print "INFO: ebizzy workload triggerd"
-            os.chdir(olddir)
-            get_proc_data(stats_stop)
-        except Exception, details:
-            print "Ebizzy workload trigger failed ", details
-            sys.exit(1)
+        # Use the latest version of similar workload available
+        for file_name in os.listdir('.'):
+            if file_name.find(workload) != -1:
+                wklds_avlbl.append(file_name)
+
+        wklds_avlbl.sort()
+        workload_dir = wklds_avlbl[len(wklds_avlbl)-1]
+        if workload_dir != "":
+            new_path = os.path.join(path,"%s" % workload_dir)
+            get_proc_data(stats_start)
+            try:
+                os.chdir(new_path)
+                if background == "yes":
+                    succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null &' % (threads, duration))
+                else:
+                    succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null' % (threads, duration))
+         
+                if succ == 0: 
+                    print "INFO: ebizzy workload triggerd"
+                    os.chdir(olddir)
+                    get_proc_data(stats_stop)
+		else:
+                    print "INFO: ebizzy workload triggerd failed"
+                    os.chdir(olddir)
+                    get_proc_data(stats_stop)
+                    sys.exit(1)
+            except Exception, details:
+                print "Ebizzy workload trigger failed ", details
+                sys.exit(1)
+    except Exception, details:
+        print "Ebizzy workload trigger failed ", details
+        sys.exit(1)   
 
-def trigger_mc2_workld (test_thread_consld):
+def trigger_kernbench (stress, background):
     ''' Trigger load on system like kernbench.
         Copys existing copy of LTP into as LTP2 and then builds it
         with make -j
     '''
     olddir = os.getcwd()
     try:
-        if test_thread_consld != 0:
-            threads = 2
-        else:
-            threads = cpu_count / len(cpu_map)
-        src_path = os.environ['LTPROOT']
-        dst_path = src_path + '2'
-        os.system ('cp -r %s/ %s/ >/dev/null' %(src_path, dst_path))
+        if stress == "thread":
+	        threads = 2
+        if stress == "partial":
+	        threads = cpu_count / socket_count
+        if stress == "full":
+            threads = cpu_count
+
+        dst_path = "/root"
+        olddir = os.getcwd()      
+        path = '%s/utils/benchmark' % os.environ['LTPROOT']
+        os.chdir(path)
+        wklds_avlbl = list()
+        for file_name in os.listdir('.'):
+            if file_name.find("kernbench") != -1:
+                wklds_avlbl.append(file_name)
+        if len(wklds_avlbl):
+            wklds_avlbl.sort()
+            workload_dir = wklds_avlbl[len(wklds_avlbl)-1]
+            if workload_dir != "":
+                benchmark_path = os.path.join(path,"%s" % workload_dir)
+            else:
+                print "INFO: kernbench benchmark not found"
+                sys.exit(1)
+        os.chdir(olddir)
+        
         os.chdir(dst_path)
-        os.system ( 'make clean >/dev/null')
+        linux_source_dir=""
+        for file_name in os.listdir('.'):
+            if file_name.find("linux-2.6") != -1 and os.path.isdir(file_name):
+                linux_source_dir=file_name
+                break
+        if linux_source_dir != "":
+            os.chdir(linux_source_dir)
+        else:
+            print "INFO: Linux kernel source not found. Kernbench cannot be executed"
+	    sys.exit(1)
+   
         get_proc_data(stats_start)
-        os.system('make -j %s >/dev/null 2>&1' % threads)
-        print "INFO: Workload for sched_mc=2 triggerd"
+        os.system ( '%s/kernbench -o 2 -M -H -n 1 >/dev/null 2>&1' % benchmark_path)
+        
+        print "INFO: Workload kernbench triggerd"
         os.chdir(olddir)
-        os.system ('rm -rf %s >/dev/null' % dst_path)
         get_proc_data(stats_stop)
     except Exception, details:
-        print "Workload trigger using make -j failed ", details
+        print "Workload trigger kernbench failed ", details
         sys.exit(1)
    
-def trigger_workld(sched_mc, test_thread_consld):
-    ''' Based on sched_mc value invokes workload triggering function.
+def trigger_workld(workload, stress, duration, background):
+    ''' Triggers workload passed as argument. Number of threads 
+        triggered is based on stress value.
     '''
-    if test_thread_consld != 0:
-        threads = 2
-    else:
-        threads = cpu_count / len(cpu_map)
-    duration = 60 # let the test run for 1 minute 
-    path = '%s/utils/benchmark' % os.environ['LTPROOT']
-    try:
-        if int (sched_mc) == 1:
-            trigger_ebizzy (test_thread_consld)
-        if int (sched_mc) == 2:
-            trigger_mc2_workld (test_thread_consld)
+    try:
+        if workload == "ebizzy":
+            trigger_ebizzy (stress, duration, background)
+        if workload == "kernbench":
+            trigger_kernbench (stress, background)
     except Exception, details:
-        print "INFO: CPU consolidation failed", details
+        print "INFO: Trigger workload failed", details
         sys.exit(1)
 
 def generate_report():
@@ -297,15 +386,18 @@ def expand_range(range_val):
        Expand the range of value into actual numbers
     '''
     ids_list = list()
-    sep_comma = range_val.split(",")
-    for i in range(0, len(sep_comma)):
-        hyphen_values = sep_comma[i].split("-")
-        if len(hyphen_values) == 1:
-            ids_list.append(int(hyphen_values[0]))
-        else:
-            for j in range(int(hyphen_values[0]), int(hyphen_values[1])+1):
-                ids_list.append(j)
-    return(ids_list)
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
 
 def is_quad_core():
     '''
@@ -357,20 +449,17 @@ def validate_cpugrp_map(cpu_group, sched
                                         print "INFO:CPUs utilized not in a core"
                                         return 0                                        
             print "INFO: CPUs utilized is not in same package or core"
-            sys.exit(1)
+            return(1)
 	else:
             for pkg in sorted(cpu_map.keys()):
                 pkg_cpus = cpu_map[pkg]
                 if pkg_cpus == cpu_group:
                     return(0)
-                else:
-                    if is_quad_core() and sched_mc_level == 0:
-                        return(0)
-            print "INFO: CPUs utilized is not in same package"
-            sys.exit(1) 
+            return(1) 
     except Exception, details:
         print "Exception in validate_cpugrp_map: ", details
         sys.exit(1)
+    
  
 def verify_sched_domain_dmesg(sched_mc_level, sched_smt_level):
     '''
@@ -378,20 +467,37 @@ def verify_sched_domain_dmesg(sched_mc_l
     '''
     cpu_group = list()
     try:
-        dmesg_info = os.popen('dmesg -c').read()
-        lines = dmesg_info.split('\n')
-        for i in range(0, len(lines)):
-            if lines[i].endswith('CPU'):
-                groups = lines[i+1].split("groups:")
-                subgroup = groups[1].split()
-                for j in range(0, len(subgroup)):
-                    cpu_group = expand_range(subgroup[j])
-                    validate_cpugrp_map(cpu_group, sched_mc_level,\
-                        sched_smt_level) 
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
+                        group_info=group_info.replace(group_info[openindex:closeindex+1],"")
+
+                    subgroup = group_info.split()
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
     except Exception, details:
         print "Reading dmesg failed", details
         sys.exit(1)
-    return(0)
 
 def validate_cpu_consolidation(sched_mc_level, sched_smt_level):
     ''' Verify if cpu's on which threads executed belong to same
@@ -400,15 +506,38 @@ def validate_cpu_consolidation(sched_mc_
     cpus_utilized = list()
     try:
         for l in sorted(stats_percentage.keys()):
-            if stats_percentage[l][1] > 20:
+	    #modify threshold
+            if stats_percentage[l][1] > 50:
                 cpu_id = stats_percentage[l][0].split("cpu")
                 if cpu_id[1] != '':
                     cpus_utilized.append(int(cpu_id[1]))
         cpus_utilized.sort()
         print "INFO: CPU's utilized ", cpus_utilized
 
-        validate_cpugrp_map(cpus_utilized, sched_mc_level, sched_smt_level)
+        status = validate_cpugrp_map(cpus_utilized, sched_mc_level, sched_smt_level)
+	if status == 1:
+	    print "INFO: CPUs utilized is not in same package or core"
+        return(status)
     except Exception, details:
         print "Exception in validate_cpu_consolidation: ", details
         sys.exit(1)
-    return(0)
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

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
