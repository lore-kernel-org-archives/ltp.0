Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MeABX-0004q5-RQ
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:08:19 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MeABW-0002wG-UB
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:08:19 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7KGC8B4026778
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 12:12:08 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7KG85QE249284
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 12:08:05 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7KG5AE5026834
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 12:05:10 -0400
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Thu, 20 Aug 2009 21:38:00 +0530
Message-Id: <20090820160800.30926.41644.sendpatchset@localhost.localdomain>
In-Reply-To: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
Subject: [LTP] Patch to fix cpu consolidation failure for kernbench on HT
	system
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
To: vaidy <svaidy@linux.vnet.ibm.com>, ltp-list@lists.sourceforge.net, gautham <ego@in.ibm.com>, arun@linux.vnet.ibm.com

Threshold and validation functions modified for testcases run on HT systems. 

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp-full-20090731_orig/testcases/kernel/power_management/lib/sched_mc.py ltp-full-20090731/testcases/kernel/power_management/lib/sched_mc.py
--- ltp-full-20090731_orig/testcases/kernel/power_management/lib/sched_mc.py	2009-08-20 19:59:11.000000000 +0530
+++ ltp-full-20090731/testcases/kernel/power_management/lib/sched_mc.py	2009-08-20 20:33:21.000000000 +0530
@@ -193,6 +193,8 @@ def trigger_ebizzy (stress, duration, ba
             threads = get_hyper_thread_count()
         if stress == "partial":
             threads = cpu_count / socket_count
+            if is_hyper_threaded():
+                threads = threads / get_hyper_thread_count()
         if stress == "full":
 	    threads = cpu_count
 
@@ -244,9 +246,11 @@ def trigger_kernbench (stress, backgroun
     olddir = os.getcwd()
     try:
         if stress == "thread":
-	        threads = 2
+	    threads = 2
         if stress == "partial":
-	        threads = cpu_count / socket_count
+	    threads = cpu_count / socket_count
+            if is_hyper_threaded():
+                threads = threads / get_hyper_thread_count()
         if stress == "full":
             threads = cpu_count
 
@@ -281,7 +285,8 @@ def trigger_kernbench (stress, backgroun
 	    sys.exit(1)
    
         get_proc_data(stats_start)
-        os.system ( '%s/kernbench -o 2 -M -H -n 1 >/dev/null 2>&1' % benchmark_path)
+        os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1' % (benchmark_path, threads))
+        print threads
         
         print "INFO: Workload kernbench triggerd"
         os.chdir(olddir)
@@ -438,6 +443,8 @@ def validate_cpugrp_map(cpu_group, sched
                         for i in range(0, len(core_cpus)):
                             if core_cpus[i] in modi_cpu_grp:
                                 modi_cpu_grp.remove(core_cpus[i]) 
+                                if len(modi_cpu_grp) == 0:
+                                    return 0
                             else:
                                 # If sched_smt == 0 then its oky if threads run
                                 # in different cores of same package 
@@ -499,24 +506,35 @@ def verify_sched_domain_dmesg(sched_mc_l
         print "Reading dmesg failed", details
         sys.exit(1)
 
-def validate_cpu_consolidation(sched_mc_level, sched_smt_level):
+def validate_cpu_consolidation(work_ld, sched_mc_level, sched_smt_level):
     ''' Verify if cpu's on which threads executed belong to same
     package
     '''
     cpus_utilized = list()
     try:
         for l in sorted(stats_percentage.keys()):
-	    #modify threshold
-            if stats_percentage[l][1] > 50:
-                cpu_id = stats_percentage[l][0].split("cpu")
-                if cpu_id[1] != '':
-                    cpus_utilized.append(int(cpu_id[1]))
-        cpus_utilized.sort()
+            #modify threshold
+            if is_hyper_threaded():
+                if stats_percentage[l][1] > 25 and work_ld == "kernbench":
+                    cpu_id = stats_percentage[l][0].split("cpu")
+                    if cpu_id[1] != '':
+                        cpus_utilized.append(int(cpu_id[1]))
+                else:
+                    if stats_percentage[l][1] > 50:
+                        cpu_id = stats_percentage[l][0].split("cpu")
+                        if cpu_id[1] != '':
+                            cpus_utilized.append(int(cpu_id[1]))
+            else:
+                if stats_percentage[l][1] > 50:
+                    cpu_id = stats_percentage[l][0].split("cpu")
+                    if cpu_id[1] != '':
+                        cpus_utilized.append(int(cpu_id[1]))
+                    cpus_utilized.sort()
         print "INFO: CPU's utilized ", cpus_utilized
 
         status = validate_cpugrp_map(cpus_utilized, sched_mc_level, sched_smt_level)
-	if status == 1:
-	    print "INFO: CPUs utilized is not in same package or core"
+        if status == 1:
+            print "INFO: CPUs utilized is not in same package or core"
         return(status)
     except Exception, details:
         print "Exception in validate_cpu_consolidation: ", details

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
