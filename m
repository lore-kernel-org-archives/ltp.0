Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1Mxc3J-0007tM-Sp
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 07:44:13 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mxc3C-00022f-0E
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 07:44:13 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9D7fANu020642
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 03:41:10 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9D7i0vl242858
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 03:44:00 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9D7hx1M018692
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 03:44:00 -0400
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Tue, 13 Oct 2009 13:13:56 +0530
Message-Id: <20091013074356.22414.15869.sendpatchset@localhost.localdomain>
In-Reply-To: <20091013074337.22414.20968.sendpatchset@localhost.localdomain>
References: <20091013074337.22414.20968.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 3/6] Modified ilb test to run with ebizzy as default
	workload.
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

Modified ilb test to run with ebizzy as default workload.
 
Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp-full-20090930/testcases/kernel/power_management/ilb_test.py ltp-full-20090930_patched/testcases/kernel/power_management/ilb_test.py
--- ltp-full-20090930/testcases/kernel/power_management/ilb_test.py	2009-10-05 02:10:56.000000000 -0400
+++ ltp-full-20090930_patched/testcases/kernel/power_management/ilb_test.py	2009-10-12 23:05:40.000000000 -0400
@@ -27,7 +27,7 @@ def main(argv=None):
     parser.add_option("-t", "--smt_level", dest="smt_level",
         default=0, help="Sched smt power saving value 0/1/2")
     parser.add_option("-w", "--workload", dest="work_ld",
-        default="kernbench", help="Workload can be ebizzy/kernbench")
+        default="ebizzy", help="Workload can be ebizzy/kernbench")
     (options, args) = parser.parse_args()
 
     try:
@@ -40,10 +40,10 @@ def main(argv=None):
         map_cpuid_pkgid()
         print "INFO: Created table mapping cpu to package"
         background="no"
-        duration=60
+        duration=120
         pinned="yes"
 
-        trigger_workld(options.smt_level,options.work_ld, "single_job", duration, background, pinned)
+        trigger_workld(options.smt_level,options.work_ld, "single_job", duration, background, pinned, "no")
         generate_loc_intr_report()
         status = validate_ilb(options.mc_level, options.smt_level)
         reset_schedmc()

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
