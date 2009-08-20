Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MeAAP-0007qy-Cl
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:07:09 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MeAAM-0006RL-Vw
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:07:09 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7KG119E025086
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 12:01:01 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7KG71Kk201844
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 12:07:01 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7KG70VQ027581
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 12:07:00 -0400
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Thu, 20 Aug 2009 21:36:55 +0530
Message-Id: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
Subject: [LTP] Patch to fix kernbench integration issue
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

Kernbench script's mode was not getting modified to executable as 'utils install'
was missing in LTP Makefile. Hence this patch fixes this issue.

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp-full-20090731_orig/Makefile ltp-full-20090731/Makefile
--- ltp-full-20090731_orig/Makefile	2009-08-20 19:59:13.000000000 +0530
+++ ltp-full-20090731/Makefile	2009-08-20 20:19:09.000000000 +0530
@@ -40,6 +40,7 @@ install: all
 	@$(MAKE) -C m4 install
 	@$(MAKE) -C doc/man1 install
 	@$(MAKE) -C doc/man3 install
+	@$(MAKE) -C utils install
 ifneq ($(strip $(SKIP_IDCHECK)),1)
 	@./IDcheck.sh
 endif

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
