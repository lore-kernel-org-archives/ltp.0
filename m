Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MpdGr-0007pc-N6
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 07:25:13 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MpdGj-0000KV-9E
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 07:25:13 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8L7Fxvs002991
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 03:15:59 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8L7OvFq241422
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 03:24:57 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8L7OvSQ003403
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 03:24:57 -0400
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Mon, 21 Sep 2009 12:54:53 +0530
Message-Id: <20090921072453.7307.96056.sendpatchset@localhost.localdomain>
In-Reply-To: <20090921072444.7307.84825.sendpatchset@localhost.localdomain>
References: <20090921072444.7307.84825.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 2/6] To fix issue in get_sched_values
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

get_sched_values was returning 1 & 0 instead of max sched_mc & max sched_smt.
This patch fixes the issue in the first version of this file.

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp-full-20090831/testcases/kernel/power_management/get_sched_values.c ltp-full-20090831_patched/testcases/kernel/power_management/get_sched_values.c
--- ltp-full-20090831/testcases/kernel/power_management/get_sched_values.c	2009-08-31 10:45:45.000000000 +0530
+++ ltp-full-20090831_patched/testcases/kernel/power_management/get_sched_values.c	2009-09-21 12:27:01.528978103 +0530
@@ -40,14 +40,8 @@ int main(int argc, char **argv)
 	{
 		param = argv[1];
 		if (strcmp(param, "sched_mc")==0)
-			if (get_supp_sched_mc() == 0)
-				return 0;
-			else
-				return 1;
+			return (get_supp_sched_mc());
 		if (strcmp(param, "sched_smt")==0)
-                        if (get_supp_sched_smt() == 0)
-                                return 0;
-                        else
-                                return 1;
+                        return (get_supp_sched_smt());
 	}
 }

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
