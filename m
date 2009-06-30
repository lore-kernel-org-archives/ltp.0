Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MLelw-00054b-UX
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:57:24 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLelt-000776-LG
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:57:24 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e9.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5UEj02r022211
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:45:00 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UEvK5v191552
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:57:20 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5UEvKZv001977
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:57:20 -0400
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Tue, 30 Jun 2009 20:27:16 +0530
Message-Id: <20090630145716.11163.65234.sendpatchset@localhost.localdomain>
In-Reply-To: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
References: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 2/10]Makefile patch to integrate to LTP
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

[Patch 2/10]Makefile patch to integrate to LTP

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp_orig/utils/benchmark/Makefile ltp_patched/utils/benchmark/Makefile
--- ltp_orig/utils/benchmark/Makefile	2009-06-30 15:04:20.000000000 +0530
+++ ltp_patched/utils/benchmark/Makefile	2009-06-30 15:12:52.000000000 +0530
@@ -18,7 +18,7 @@
 ####
 ################################################################################
 
-SUBDIRS := ebizzy-0.3
+SUBDIRS := ebizzy-0.3 kernbench-0.42
 
 configure:
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
@@ -27,6 +27,6 @@ all: configure
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
 
 install:
-
+	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
 clean:
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
