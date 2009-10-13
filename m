Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1Mxc3z-0000Pp-Av
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 07:44:55 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mxc3s-0003p1-1y
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 07:44:55 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9D7bwMQ012620
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 01:37:58 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9D7iRGj219036
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 01:44:27 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9D7iR2U013480
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 01:44:27 -0600
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Tue, 13 Oct 2009 13:14:23 +0530
Message-Id: <20091013074423.22414.52234.sendpatchset@localhost.localdomain>
In-Reply-To: <20091013074337.22414.20968.sendpatchset@localhost.localdomain>
References: <20091013074337.22414.20968.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 6/6] Patch to fix workload installation issue
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

Patch to fix workload installation issue

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp-full-20090930/utils/Makefile ltp-full-20090930_patched/utils/Makefile
--- ltp-full-20090930/utils/Makefile	2009-10-05 02:10:46.000000000 -0400
+++ ltp-full-20090930_patched/utils/Makefile	2009-10-12 22:48:30.000000000 -0400
@@ -27,6 +27,6 @@ all: configure
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
 
 install:
-
+	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
 clean:
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;

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
