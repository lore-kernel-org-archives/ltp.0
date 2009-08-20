Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MeAAX-0007Va-Kb
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:07:17 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MeAAW-00040j-OM
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:07:17 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7KG6oK6009378
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 12:06:50 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7KG7Axk214352
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 12:07:10 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7KG79jv019871
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 12:07:10 -0400
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Thu, 20 Aug 2009 21:37:05 +0530
Message-Id: <20090820160705.30926.960.sendpatchset@localhost.localdomain>
In-Reply-To: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
Subject: [LTP] Patch to fix make install issue in ebizzy
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

install: was missing in Makefile of ebizzy, hence make install was throwing error.
This patch will fix make install error.

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>


diff -uprN ltp-full-20090731_orig/utils/benchmark/ebizzy-0.3/Makefile ltp-full-20090731/utils/benchmark/ebizzy-0.3/Makefile
--- ltp-full-20090731_orig/utils/benchmark/ebizzy-0.3/Makefile	2009-08-20 19:59:13.000000000 +0530
+++ ltp-full-20090731/utils/benchmark/ebizzy-0.3/Makefile	2009-08-20 20:23:19.000000000 +0530
@@ -4,5 +4,7 @@ configure:
 	./configure
 ebizzy: configure
 	gcc -Wall -Wshadow -lpthread  -o ebizzy ebizzy.c
+install:
+	
 clean:
 	rm -f ebizzy *~

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
