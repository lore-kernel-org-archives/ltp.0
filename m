Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1NNsEW-0005R4-It
	for ltp-list@lists.sourceforge.net; Thu, 24 Dec 2009 18:16:20 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NNsES-0006lB-06
	for ltp-list@lists.sourceforge.net; Thu, 24 Dec 2009 18:16:20 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBOIAVPo022699
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Dec 2009 11:10:31 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	nBOIFxZw133374
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Dec 2009 11:16:01 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nBOIFtfo009847
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Dec 2009 11:15:56 -0700
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Thu, 24 Dec 2009 23:45:51 +0530
Message-Id: <20091224181551.12571.4910.sendpatchset@localhost.localdomain>
In-Reply-To: <20091224181532.12571.74576.sendpatchset@localhost.localdomain>
References: <20091224181532.12571.74576.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 3/4]Python functions modified to run on Power platform
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
To: ltp-list@lists.sourceforge.net, svaidy@linux.vnet.ibm.com, ego@in.ibm.com, arun@linux.vnet.ibm.com

Patch to learn topology information from sysfs. 
Incorporated Gautham's comments to improve maintainence of the code.

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp-intermediate-20091209.orig/testcases/kernel/power_management/lib/sched_mc.py ltp-intermediate-20091209.fixes/testcases/kernel/power_management/lib/sched_mc.py
--- ltp-intermediate-20091209.orig/testcases/kernel/power_management/lib/sched_mc.py	2009-12-09 13:18:25.000000000 +0530
+++ ltp-intermediate-20091209.fixes/testcases/kernel/power_management/lib/sched_mc.py	2009-12-24 23:14:23.712098662 +0530
@@ -24,6 +24,12 @@ cpu2_max_intr = 0
 intr_stat_timer_0 = []
 siblings_list = []
 
+# Define thresholds for CPU consolidation
+THRES_HT_KERNBENCH=40
+THRES_HT=40
+THRES_KERNBENCH=50
+THRES_EBIZZY=70
+
 def clear_dmesg():
     '''
        Clears dmesg
@@ -65,6 +71,42 @@ def count_num_sockets():
         print "INFO: Failed to get number of sockets in system", details
         sys.exit(1)
 
+def get_hyper_thread_count():
+    ''' Return number of threads in cpu0
+    '''
+    try:
+        file_cpuinfo = open("/sys/devices/system/cpu/cpu0/topology/thread_siblings", 'r')
+        threads_count = 0
+        for line in file_cpuinfo:
+            core_grps = line.split(",")
+            for i in range(0, len(core_grps)):
+                cpumask=int(core_grps[i])
+                while cpumask > 0:
+                    threads_count = threads_count + 1
+                    cpumask = cpumask >> 1
+        return threads_count
+    except Exception, details:
+        print "INFO: Failed to get threaded siblings count", details
+        sys.exit(1)
+
+def get_core_sibling_count():
+    ''' Return number of threads in cpu0
+    '''
+    try:
+        file_cpuinfo = open("/sys/devices/system/cpu/cpu0/topology/core_siblings", 'r')
+        cores_count = 0
+        for line in file_cpuinfo:
+            core_grps = line.split(",")
+            for i in range(0, len(core_grps)):
+                cpumask=int(core_grps[i])
+                while cpumask > 0:
+                    cores_count = cores_count + 1
+                    cpumask = cpumask >> 1
+        return cores_count
+    except Exception, details:
+        print "INFO: Failed to get core siblings count", details
+        sys.exit(1)
+
 def is_multi_socket():
     '''Return 1 if the system is multi socket else return 0
     '''
@@ -81,15 +123,8 @@ def is_hyper_threaded():
     '''Return 1 if the system is hyper threaded else return 0
     '''
     try:
-        file_cpuinfo = open("/proc/cpuinfo", 'r')
-        for line in file_cpuinfo:
-            if line.startswith('siblings'):
-                siblings = line.split(":")
-            if line.startswith('cpu cores'):
-                cpu_cores = line.split(":")
-                break
-        if int( siblings[1] ) / int( cpu_cores[1] )> 1:
-            file_cpuinfo.close()
+        threads_count = get_hyper_thread_count()
+        if threads_count > 1:
             return 1
         else:
             return 0
@@ -98,53 +133,33 @@ def is_hyper_threaded():
         sys.exit(1)
 
 def is_multi_core():
-    ''' Return true if system has sockets has multiple cores
+    ''' Return true if system has sockets with multiple cores
     '''
   
     try:
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
+        cores_count = get_core_sibling_count()
+        if cores_count > 1:
+            return 1
         else:
-            num_of_cpus = int(siblings[1]) / int(cpu_cores[1])
-            if num_of_cpus > 1:
-                multi_core = 1
-            else:
-                multi_core = 0
-        file_cpuinfo.close()
-        return multi_core
+            return 0
     except Exception:
         print "Failed to check if system is multi core system"
         sys.exit(1)
 
-def get_hyper_thread_count():
-    ''' Return number of threads in CPU. For eg for x3950 this function
-        would return 2. In future if 4 threads are supported in CPU, this
-        routine would return 4
+def is_quad_core():
+    '''
+       Read sys topology info and check if system is Quad core
     '''
     try:
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
+        cpu_cores = get_core_sibling_count()
+        if cpu_cores == 4:
+            return(1)
+        else:
+            return(0)
+    except IOError, e:
+        print "Failed in function to check if system is quad core", e
         sys.exit(1)
-         
+
 def map_cpuid_pkgid():
     ''' Routine to map physical package id to cpu id
     '''
@@ -190,10 +205,21 @@ def generate_sibling_list():
     try:
         for i in range(0, cpu_count):
             siblings_file = '/sys/devices/system/cpu/cpu%s' % i
-            siblings_file += '/topology/thread_siblings_list'
-            threads_sibs = open(siblings_file).read().rstrip()
-            thread_ids = threads_sibs.split("-")
-    
+            siblings_file += '/topology/thread_siblings'
+            threads_sibs = open(siblings_file).read().split(",")
+            thread_ids = []
+            cpu_id=0
+            mask=1
+            
+            for j in range(len(threads_sibs)-1, 0, -1):
+                for k in range(0, 8):
+                    mask_bit_set=mask & int(threads_sibs[j],16)
+                    if mask_bit_set != 0:
+                        if not cpu_id in thread_ids:
+                            thread_ids.append(cpu_id)
+                    mask = mask << 1
+                    cpu_id += 1
+
             if not thread_ids in siblings_list:
                 siblings_list.append(thread_ids)
     except Exception, details:
@@ -211,7 +237,7 @@ def get_siblings(cpu_id):
                     for j in siblings_list[i]:
                         # Exclude cpu_id in the list of siblings
                         if j != cpu_id:
-                            cpus += j
+                            cpus += str(j)
                     return cpus
         return cpus
     except Exception, details:
@@ -276,17 +302,6 @@ def set_sched_smt_power(sched_smt_level)
         print "Could not set sched_smt_power_savings to", sched_smt_level, e
 	sys.exit(1)
 
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
 def get_job_count(stress, workload, sched_smt):
     ''' Returns number of jobs/threads to be triggered
     '''
@@ -585,25 +600,6 @@ def expand_range(range_val):
     except Exception, details:
         print "INFO: expand_pkg_grps failed ", details
 
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
 def validate_cpugrp_map(cpu_group, sched_mc_level, sched_smt_level):
     '''
        Verify if cpugrp belong to same package
@@ -612,7 +608,7 @@ def validate_cpugrp_map(cpu_group, sched
     try:
         if is_hyper_threaded():
             for pkg in sorted(cpu_map.keys()):
-                # if CPU utilized is across package this condition will be true
+            # if CPU utilized is across package this condition will be true
                 if len(modi_cpu_grp) != len(cpu_group):
                     break
                 for core in sorted(cpu_map[pkg].keys()):
@@ -724,21 +720,21 @@ def validate_cpu_consolidation(stress, w
                             utilization += int(get_cpu_utilization("cpu%s" %sib_list[i])) 
                     else:
                         utilization = stats_percentage[l][1]
-                    if utilization > 40:
+                    if utilization > THRES_HT_KERNBENCH:
                         cpus_utilized.append(int(cpu_id[1]))
                         if siblings != "":
                             for i in range(0, len(sib_list)):
                                 cpus_utilized.append(int(sib_list[i]))
                 else:
                     # This threshold wuld be modified based on results
-                    if stats_percentage[l][1] > 40:
+                    if stats_percentage[l][1] > THRES_HT:
                         cpus_utilized.append(int(cpu_id[1]))
             else:
                 if work_ld == "kernbench" :
-                    if stats_percentage[l][1] > 50:
+                    if stats_percentage[l][1] > THRES_KERNBENCH:
                         cpus_utilized.append(int(cpu_id[1]))
                 else:
-                    if stats_percentage[l][1] > 70:
+                    if stats_percentage[l][1] > THRES_EBIZZY:
                         cpus_utilized.append(int(cpu_id[1]))
             cpus_utilized.sort()
         print "INFO: CPU's utilized ", cpus_utilized

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
