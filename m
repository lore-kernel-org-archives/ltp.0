Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MgyUS-0001dF-Rt
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 10:15:28 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgyUH-0001Sx-Vl
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 10:15:23 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7SA9UYM018192
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:09:30 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7SAFAik227122
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:15:10 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7SAF9rb028601
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:15:10 -0600
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Fri, 28 Aug 2009 15:45:05 +0530
Message-Id: <20090828101505.12177.78037.sendpatchset@localhost.localdomain>
In-Reply-To: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
References: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 4/8] Addional new reusable functions for ILB testing
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
To: ltp-list@lists.sourceforge.net, arun@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, ego@in.ibm.com

Developed new functions to support ILB test execution and result verification.
Minimal changes has been done for exisitng function to support ILB
test execution.

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp_orig/testcases/kernel/power_management/lib/sched_mc.py ltp/testcases/kernel/power_management/lib/sched_mc.py
--- ltp_orig/testcases/kernel/power_management/lib/sched_mc.py	2009-08-28 10:54:59.000000000 +0530
+++ ltp/testcases/kernel/power_management/lib/sched_mc.py	2009-08-28 12:24:55.000000000 +0530
@@ -15,8 +15,12 @@ cpu_map = {}
 stats_start = {}
 stats_stop = {}
 stats_percentage = {}
+intr_start = []
+intr_stop = []
 cpu_count = 0
 socket_count = 0
+cpu1_max_intr = 0
+cpu2_max_intr = 0
 
 def clear_dmesg():
     '''
@@ -162,6 +166,23 @@ def get_proc_data(stats_list):
         print "Could not read statistics", e
         sys.exit(1)
 
+def get_proc_loc_count(loc_stats):
+    ''' Read /proc/stat info and store in dictionary
+    '''
+    try:
+        file_procstat = open("/proc/interrupts", 'r')
+        for line in file_procstat:
+            if line.startswith('LOC:'):
+                data = line.split()
+                for i in range(0, cpu_count):
+                    # To skip LOC
+                    loc_stats.append(data[i+1])
+        file_procstat.close()
+    except Exception, details:
+        print "Could not read interrupt statistics", details
+        sys.exit(1)
+
+
 def set_sched_mc_power(sched_mc_level):
     ''' Routine to set sched_mc_power_savings to required level
     '''
@@ -184,7 +205,23 @@ def set_sched_smt_power(sched_smt_level)
         print "Could not set sched_smt_power_savings to", sched_smt_level, e
 	sys.exit(1)
 
-def trigger_ebizzy (stress, duration, background):
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
+def start_cyclictest():
+    ''' Trigger cyclictest in background to increase
+        timer interrupts
+    '''
+    
+def trigger_ebizzy (stress, duration, background, pinned):
     ''' Triggers ebizzy workload for sched_mc=1
         testing
     '''
@@ -197,6 +234,9 @@ def trigger_ebizzy (stress, duration, ba
                 threads = threads / get_hyper_thread_count()
         if stress == "full":
 	    threads = cpu_count
+        if stress == "single_job":
+            threads = 1
+            duration = 180
 
         olddir = os.getcwd()
         path = '%s/utils/benchmark' % os.environ['LTPROOT']
@@ -220,7 +260,10 @@ def trigger_ebizzy (stress, duration, ba
                 if background == "yes":
                     succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null &' % (threads, duration))
                 else:
-                    succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null' % (threads, duration))
+                    if pinned == "yes":
+                        succ = os.system('taskset -c %s ./ebizzy -t%s -s4096 -S %s >/dev/null' % (cpu_count -1, threads, duration))
+                    else:
+                        succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null' % (threads, duration))
          
                 if succ == 0: 
                     print "INFO: ebizzy workload triggerd"
@@ -238,7 +281,7 @@ def trigger_ebizzy (stress, duration, ba
         print "Ebizzy workload trigger failed ", details
         sys.exit(1)   
 
-def trigger_kernbench (stress, background):
+def trigger_kernbench (stress, background, pinned):
     ''' Trigger load on system like kernbench.
         Copys existing copy of LTP into as LTP2 and then builds it
         with make -j
@@ -253,6 +296,8 @@ def trigger_kernbench (stress, backgroun
                 threads = threads / get_hyper_thread_count()
         if stress == "full":
             threads = cpu_count
+        if stress == "single_job":
+            threads = 1
 
         dst_path = "/root"
         olddir = os.getcwd()      
@@ -283,27 +328,31 @@ def trigger_kernbench (stress, backgroun
         else:
             print "INFO: Linux kernel source not found. Kernbench cannot be executed"
 	    sys.exit(1)
-   
+  
         get_proc_data(stats_start)
-        os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1' % (benchmark_path, threads))
-        print threads
+        get_proc_loc_count(intr_start)
+        if pinned == "yes":
+            os.system ( 'taskset -c %s %s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1' % (cpu_count-1, benchmark_path, threads))
+        else:
+            os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1' % (benchmark_path, threads))
         
         print "INFO: Workload kernbench triggerd"
         os.chdir(olddir)
         get_proc_data(stats_stop)
+        get_proc_loc_count(intr_stop)
     except Exception, details:
-        print "Workload trigger kernbench failed ", details
+        print "Workload kernbench trigger failed ", details
         sys.exit(1)
    
-def trigger_workld(workload, stress, duration, background):
+def trigger_workld(workload, stress, duration, background, pinned):
     ''' Triggers workload passed as argument. Number of threads 
         triggered is based on stress value.
     '''
     try:
         if workload == "ebizzy":
-            trigger_ebizzy (stress, duration, background)
+            trigger_ebizzy (stress, duration, background, pinned)
         if workload == "kernbench":
-            trigger_kernbench (stress, background)
+            trigger_kernbench (stress, background, pinned)
     except Exception, details:
         print "INFO: Trigger workload failed", details
         sys.exit(1)
@@ -386,6 +435,22 @@ def generate_report():
     print >> keyvalfile
     keyvalfile.close()
 
+def generate_loc_intr_report():
+    ''' Generate interrupt report of CPU's
+    '''
+    if (not os.path.exists('/procstat')):
+        os.mkdir('/procstat')
+
+    reportfile = open('/procstat/cpu-loc_interrupts', 'a')
+    print >> reportfile, "=============================================================="
+    print >> reportfile, "                Local timer interrupt stats                   "
+    print >> reportfile, "=============================================================="
+    for i in range(0, cpu_count):
+        intr_stop[i] =  int(intr_stop[i]) - int(intr_start[i])
+        print >> reportfile, "CPU%s: %s" %(i, intr_stop[i])
+    print >> reportfile
+    reportfile.close()
+
 def expand_range(range_val):
     '''
        Expand the range of value into actual numbers
@@ -462,6 +527,7 @@ def validate_cpugrp_map(cpu_group, sched
                 pkg_cpus = cpu_map[pkg]
                 if pkg_cpus == cpu_group:
                     return(0)
+                 
             return(1) 
     except Exception, details:
         print "Exception in validate_cpugrp_map: ", details
@@ -540,6 +606,53 @@ def validate_cpu_consolidation(work_ld, 
         print "Exception in validate_cpu_consolidation: ", details
         sys.exit(1)
 
+def get_cpuid_max_intr_count():
+    '''Return the cpu id's of two cpu's with highest number of intr'''
+    try:
+        highest = 0
+        second_highest = 0
+        global cpu1_max_intr, cpu2_max_intr
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
+        for i in range(1, cpu_count):
+            if i != cpu1_max_intr and i != cpu2_max_intr:
+                diff = second_highest - intr_stop[i]
+                ''' Threshold of difference has to be manipulated with multiple test'''
+                if diff < 10000:
+                    print "INFO: Difference in interrupt count is below threshold"
+                    return 1
+        print "INFO: Interrupt count in other CPU's low as expected"
+        return 0 
+    except Exception, details:
+        print "Exception in get_cpuid_max_intr_count: ", details
+        sys.exit(1)
+  
+def validate_ilb (sched_mc_level, sched_smt_level):
+    ''' Validate if ilb is running in same package where work load is running
+    '''
+    try:
+        status = get_cpuid_max_intr_count()
+        if status == 1:
+            return 1
+        for pkg in sorted(cpu_map.keys()):
+            if cpu1_max_intr in cpu_map[pkg] and cpu2_max_intr in cpu_map[pkg]:
+                return 0
+        print "INFO: CPUs with higher interrupt count is not in same package"
+        return 1
+    except Exception, details:
+        print "Exception in validate_ilb: ", details
+        sys.exit(1)
+    
 def reset_schedmc():
     ''' Routine to reset sched_mc_power_savings to Zero level
     '''

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
