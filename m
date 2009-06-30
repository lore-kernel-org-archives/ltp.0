Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MLemj-0001Ye-7G
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:58:13 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLemh-00049M-C5
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:58:13 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5UEvOdK001484
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 08:57:24 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UEw4dU098754
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 08:58:06 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5UEvqtt027572
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 08:57:52 -0600
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Tue, 30 Jun 2009 20:27:46 +0530
Message-Id: <20090630145746.11163.57045.sendpatchset@localhost.localdomain>
In-Reply-To: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
References: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 5/10]CPU consolidation testcase updated to handle
	exceptions
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

[Patch 5/10]CPU consolidation testcase updated to handle exceptions

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp_orig/testcases/kernel/power_management/cpu_consolidation.py ltp_patched/testcases/kernel/power_management/cpu_consolidation.py
--- ltp_orig/testcases/kernel/power_management/cpu_consolidation.py	2009-06-30 15:04:19.000000000 +0530
+++ ltp_patched/testcases/kernel/power_management/cpu_consolidation.py	2009-06-30 15:21:42.000000000 +0530
@@ -12,42 +12,47 @@ from sched_mc import *
 
 __author__ = "Poornima Nayak <mpnayak@linux.vnet.ibm.com>"
 
-# Run test based on the command line arguments
-if __name__ == "__main__":
+class Usage(Exception):
+    def __init__(self, msg):
+        self.msg = msg
+
+def main(argv=None):
+    if argv is None:
+        argv = sys.argv
+
     usage = "-w"
     parser = OptionParser(usage)
     parser.add_option("-c", "--mc_level", dest="mc_level",
-        help="Sched mc power saving value 0/1/2")
+        default=0, help="Sched mc power saving value 0/1/2")
     parser.add_option("-t", "--smt_level", dest="smt_level",
         default=0, help="Sched smt power saving value 0/1/2")
+    parser.add_option("-w", "--workload", dest="work_ld",
+        default="ebizzy", help="Workload can be ebizzy/kernbench")
+    parser.add_option("-s", "--stress", dest="stress",
+        default="partial", help="Load on system is full/partial [i.e 50%]/thread")
     (options, args) = parser.parse_args()
-    test_thread_consld = 0
-    
 
     try:
-        set_sched_mc_power(options.mc_level)
         count_num_cpu()
+        count_num_sockets()
+        if is_multi_socket():
+            set_sched_mc_power(options.mc_level)
+        if is_hyper_threaded():
+            set_sched_smt_power(options.smt_level)
         map_cpuid_pkgid()
         print "INFO: Created table mapping cpu to package"
-        
-        if int(options.smt_level) == 1 or int(options.smt_level) == 2 :
-            if is_hyper_threaded():
-                set_sched_smt_power(options.smt_level)
-                # Trigger ebizzy with 2 threads only to verify logical CPU
-                # consolidation
-                test_thread_consld = 1
-                trigger_workld(options.mc_level, test_thread_consld)
-                generate_report()
-                validate_cpu_consolidation(options.mc_level, options.smt_level)
-                test_thread_consld = 0
-            else:
-                print "INFO: No Hyper-threading support in this machine"
-                sys.exit(0)
-    
-        trigger_workld(options.mc_level, test_thread_consld)
+        background="no"
+        duration=60
+        trigger_workld(options.work_ld, options.stress, duration, background)
         generate_report()
-        validate_cpu_consolidation(options.mc_level, options.smt_level)
-        sys.exit(0)
+        status = validate_cpu_consolidation(options.mc_level, options.smt_level)
+        reset_schedmc()
+        if is_hyper_threaded():
+            reset_schedsmt()
+        return(status)        
     except Exception, details:
-        print "INFO(: CPU consolidation failed", details
-        sys.exit(1)
+        print "INFO: CPU consolidation failed", details
+        return(1)
+
+if __name__ == "__main__":
+    sys.exit(main())

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
