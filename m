Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MeABB-0007wM-5n
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:07:57 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MeABA-0006aa-2Y
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:07:57 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7KG2DVl017880
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 10:02:13 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7KG7kvI038080
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 10:07:46 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7KG7jYx018359
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 10:07:46 -0600
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Thu, 20 Aug 2009 21:37:41 +0530
Message-Id: <20090820160741.30926.293.sendpatchset@localhost.localdomain>
In-Reply-To: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
Subject: [LTP] Patch for PM makefile for new testcases & fix test_sched_smt
	integration issue
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

Patch to integrate test_sched_smt and timer_migration testcase to LTP.
Also intergrates the new file get_sched_value to LTP.

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp-full-20090731_orig/testcases/kernel/power_management/Makefile ltp-full-20090731/testcases/kernel/power_management/Makefile
--- ltp-full-20090731_orig/testcases/kernel/power_management/Makefile	2009-08-20 19:59:11.000000000 +0530
+++ ltp-full-20090731/testcases/kernel/power_management/Makefile	2009-08-20 20:26:39.000000000 +0530
@@ -23,12 +23,16 @@ SUBDIRS := 
 all: 
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
 	$(MAKE) check_kv_arch ;
+	$(MAKE) get_sched_values ;
 
-check_kv_arch: check_kv_arch.c
+check_kv_arch: check_kv_arch.c 
+	$(CC) -o $@ $< ../../../lib/tst_kvercmp.c -I../../../include
+get_sched_values: get_sched_values.c
 	$(CC) -o $@ $< ../../../lib/tst_kvercmp.c -I../../../include
 
 install:
 	@set -e; ln -f check_kv_arch ../../bin/check_kv_arch; \
+	ln -f get_sched_values ../../bin/get_sched_values; \
 	ln -f  change_freq.sh ../../bin/change_freq.sh; \
 	ln -f  change_govr.sh ../../bin/change_govr.sh; \
 	ln -f  check_cpufreq_sysfs_files.sh ../../bin/check_cpufreq_sysfs_files.sh; \
@@ -37,6 +41,8 @@ install:
 	ln -f  pm_include.sh ../../bin/pm_include.sh; \
 	ln -f  runpwtests.sh ../../bin/runpwtests.sh; \
 	ln -f  test_sched_mc.sh ../../bin/test_sched_mc.sh; \
+	ln -f  test_sched_mc.sh ../../bin/test_sched_smt.sh; \
+	ln -f  test_sched_mc.sh ../../bin/test_timer_migration.sh; \
 	ln -f  config_cpu_freq ../../bin/config_cpu_freq; \
 	ln -f  config_cpu_idle ../../bin/config_cpu_idle; \
 	ln -f  config_sched_mc ../../bin/config_sched_mc;
@@ -47,4 +53,4 @@ install:
 clean:
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@ ; done
 	rm -f check_kv_arch
-
+	rm -f get_sched_values

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
