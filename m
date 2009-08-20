Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MeAB3-0007X8-7A
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:07:49 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MeAB2-000479-G3
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:07:49 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7KFwWip013457
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 09:58:32 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7KG7Ubc184048
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 10:07:34 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7KG7QsM002400
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 10:07:27 -0600
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Thu, 20 Aug 2009 21:37:23 +0530
Message-Id: <20090820160723.30926.96672.sendpatchset@localhost.localdomain>
In-Reply-To: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
Subject: [LTP] Patch to get max sched mc & smt values based on kernel version
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

Replaces shell function with C functions to get max sched_mc & sched_smt value.
Since this uses LTP libraray function to analyze kernel version maintenence of the 
code will be easier.

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>


diff -uprN ltp-full-20090731_orig/testcases/kernel/power_management/get_sched_values.c ltp-full-20090731/testcases/kernel/power_management/get_sched_values.c
--- ltp-full-20090731_orig/testcases/kernel/power_management/get_sched_values.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/kernel/power_management/get_sched_values.c	2009-08-20 20:38:13.000000000 +0530
@@ -0,0 +1,53 @@
+/************************************************************************
+* Copyright (c) International Business Machines Corp., 2008
+* This program is free software; you can redistribute it and/or modify
+* it under the terms of the GNU General Public License as published by
+* the Free Software Foundation; either version 2 of the License, or
+* (at your option) any later version.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+* the GNU General Public License for more details.
+* You should have received a copy of the GNU General Public License
+* along with this program; if not, write to the Free Software
+* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+*
+***************************************************************************/
+#include <stdio.h>
+#include <test.h>
+
+int get_supp_sched_mc(void) {
+	if (tst_kvercmp(2,6,29) < 0 )
+		return 1;
+	else
+		return 2;
+}
+
+int get_supp_sched_smt(void) {
+	if (tst_kvercmp(2,6,29) < 0 )
+		return 1;
+	else
+		return 2;
+}
+
+int main(int argc, char **argv)
+{
+	char *param;
+	if (argc == 0)
+		return 1;
+	else
+	{
+		param = argv[1];
+		if (strcmp(param, "sched_mc")==0)
+			if (get_supp_sched_mc() == 0)
+				return 0;
+			else
+				return 1;
+		if (strcmp(param, "sched_smt")==0)
+                        if (get_supp_sched_smt() == 0)
+                                return 0;
+                        else
+                                return 1;
+	}
+}

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
