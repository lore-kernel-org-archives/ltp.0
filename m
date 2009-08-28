Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MgyUj-0005oJ-Vq
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 10:15:45 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgyUX-0000mS-1i
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 10:15:40 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7SA8uGG031574
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 06:08:56 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7SAFRaX238326
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 06:15:27 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7SAFQo5014575
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 06:15:27 -0400
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Fri, 28 Aug 2009 15:45:22 +0530
Message-Id: <20090828101522.12177.4630.sendpatchset@localhost.localdomain>
In-Reply-To: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
References: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 6/8] Included new function to check feature versus
	kernel version
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

Included new function to check feature versus kernel version

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp_orig/testcases/kernel/power_management/check_kv_arch.c ltp/testcases/kernel/power_management/check_kv_arch.c
--- ltp_orig/testcases/kernel/power_management/check_kv_arch.c	2009-08-28 10:54:59.000000000 +0530
+++ ltp/testcases/kernel/power_management/check_kv_arch.c	2009-08-28 12:36:07.000000000 +0530
@@ -23,6 +23,12 @@ int kernel_is_too_old(void) {
 	return 0;
 }
 
+int check_timer_migr_supp(void) {
+	if (tst_kvercmp(2,6,31) < 0)
+		return 1;
+	return 0;
+}
+
 /*
  * yeah, to make the makefile coding easier, do_check returns
  * 1 if unshare is not supported, 0 if it is
@@ -35,7 +41,17 @@ int do_check(void) { return kernel_is_to
 int do_check(void) { return 1; }
 #endif
 
-int main() {
-	return do_check();
+int main(int argc, char *argv[]) {
+	char feature[20];
+	if (argc == 1) 
+		return do_check();
+	else
+	{
+		printf("argument is %s", argv[1]);
+		if (strcmp(argv[1], "timer_migration")==0)
+			if (check_timer_migr_supp() == 0)
+				return 0;
+			else
+				return 1;
+	} 
 }
-

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
