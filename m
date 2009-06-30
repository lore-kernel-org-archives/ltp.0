Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MLemo-0001fc-T3
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:58:18 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLeml-0007PB-6s
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:58:18 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5UEt0v7026020
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 08:55:00 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UEw483259046
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 08:58:06 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5UEw1PU031684
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 08:58:01 -0600
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Tue, 30 Jun 2009 20:27:57 +0530
Message-Id: <20090630145757.11163.2115.sendpatchset@localhost.localdomain>
In-Reply-To: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
References: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 6/10]sched domian testcase updated to handle exceptions
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

[Patch 6/10]sched domian testcase updated to handle exceptions

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp_orig/testcases/kernel/power_management/sched_domain.py ltp_patched/testcases/kernel/power_management/sched_domain.py
--- ltp_orig/testcases/kernel/power_management/sched_domain.py	2009-06-30 15:04:19.000000000 +0530
+++ ltp_patched/testcases/kernel/power_management/sched_domain.py	2009-06-30 15:22:38.000000000 +0530
@@ -12,18 +12,19 @@ from optparse import OptionParser
 
 __author__ = "Poornima Nayak <mpnayak@linux.vnet.ibm.com>"
 
-# Run test based on the command line arguments
-if __name__ == "__main__":
-    sched_smt = 0
-    sched_mc = 0
+class Usage(Exception):
+    def __init__(self, msg):
+        self.msg = msg
+
+def main(argv=None):
+    if argv is None:
+        argv = sys.argv
 
     usage = "-w"
     parser = OptionParser(usage)
-    parser.add_option("-w", "--workload", dest="workload",
-        help="Test name that has be triggered")
-    parser.add_option("-c", "--mc_level", dest="mc_level",
+    parser.add_option("-c", "--mc_level", dest="mc_level", default=-1,
         help="Sched mc power saving value 0/1/2")
-    parser.add_option("-t", "--smt_level", dest="smt_level", default=0,
+    parser.add_option("-t", "--smt_level", dest="smt_level", default=-1,
         help="Sched smt power saving value 0/1/2")
     (options, args) = parser.parse_args()
 
@@ -32,18 +33,24 @@ if __name__ == "__main__":
         count_num_cpu()
         map_cpuid_pkgid()
        
-        if int(options.smt_level) == 1 or int(options.smt_level) == 2:
+        if is_hyper_threaded() and int(options.smt_level) >= 0:
+            set_sched_smt_power(options.smt_level)
+
+        if int(options.mc_level) >= 0:
+            set_sched_mc_power(options.mc_level) 
+        if int(options.smt_level) >= 0 or int(options.mc_level) >= 0:
+            status = verify_sched_domain_dmesg(options.mc_level, options.smt_level)
+            reset_schedmc()
             if is_hyper_threaded():
-                sched_smt_level = options.smt_level
-                set_sched_smt_power(sched_smt_level)
-            else:
-                print "INFO: No Hyper-threading support in this machine"
-                sys.exit(0)
- 
-        # Validate sched domain for sched_mc = 1, sched_smt = 0
-        set_sched_mc_power(options.mc_level) 
-        verify_sched_domain_dmesg(options.mc_level, options.smt_level)
-        sys.exit(0)
+                reset_schedsmt()
+        	return(status)
+        else:
+            print "INFO: Invalid arguments given"
+            return 1
     except Exception, details:
         print "INFO: sched domain test failed: ", details
-        sys.exit(1)
+        return(1)
+
+# Run test based on the command line arguments
+if __name__ == "__main__":
+    sys.exit(main())

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
