Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Md127-00039w-BE
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2009 12:09:51 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Md11z-0007qW-Se
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2009 12:09:51 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7HC3ftK027419
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2009 08:03:41 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7HC9cto179634
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2009 08:09:38 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7HC9bQQ021047
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2009 08:09:37 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Mon, 17 Aug 2009 17:39:22 +0530
Message-Id: <20090817120920.8902.89815.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090817120835.8902.4597.sendpatchset@subratamodak.linux.ibm.com>
References: <20090817120835.8902.4597.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH v2 02/05] Add Script which would actually do the job
	of injecting faults
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6461955475153135586=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP Mailing List <ltp-list@lists.sourceforge.net>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, Mike Frysinger <vapier@gentoo.org>, Michael Reed <mreed10@us.ibm.com>, Nate Straz <nate@refried.org>, Paul Larson <paul.larson@ubuntu.com>, Manoj Iyer <manoj.iyer@ubuntu.com>, Balbir Singh <balbir@linux.vnet.ibm.com>

--===============6461955475153135586==

Script which would actually do the job of injecting faults by changing various
parametrs available under /debug/fail*. This would be done dynamically during
LTP run, and, is capable of taking parameters from 0 to 100 to vary the
probability of Fault the user wants to inject in the running kernel.

Incorporated Mike�� & Garrets comments and concerns.

Signed-off-by: Subrata Modak<subrata@linux.vnet.ibm.com>
---

--- ltp-full-20090731.orig/tools/insert_kernel_faults.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/tools/insert_kernel_faults.sh	2009-08-17 12:17:31.000000000 +0530
@@ -0,0 +1,53 @@
+#!/bin/sh
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2009                 ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and/or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+################################################################################
+#									      ##
+# File :        insert_kernel_faults.sh					      ##
+#									      ##
+# Usage:	insert_kernel_faults.sh <fault_percentage>		      ##
+#									      ##
+# Description:  This is a simple script that inserts faults at various	      ##
+#		subsystems of the kernel. Please refer to the ltp/README      ##
+#		for the various kernel CONFIG options needed to exploit	      ##
+#		all those features					      ##
+#									      ##
+# Author:	Subrata Modak <subrata@linux.vnet.ibm.com>		      ##
+#									      ##
+# History:      Aug 11 2009 - Created - Subrata Modak.			      ##
+#		Aug 17 2009 - Changed the debugfs mount point - Subrata Modak.##
+################################################################################
+
+if [ -z $1 ]
+	then
+	#Check if Useage has been proper
+	echo "Usage: $0 <fault_percentage>"
+	exit 1
+fi
+
+#These are the types of Subsystems where fault will be injected
+#Make sure debugfs has been mounted
+for FAILTYPE in fail_io_timeout fail_make_request fail_page_alloc failslab
+do
+	echo $1 > /sys/kernel/debug/$FAILTYPE/probability
+	echo 100 > /sys/kernel/debug/$FAILTYPE/interval
+	echo -1 > /sys/kernel/debug/$FAILTYPE/times
+	echo 0 > /sys/kernel/debug/$FAILTYPE/space
+done
+

---
Regards--
Subrata



--===============6461955475153135586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============6461955475153135586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6461955475153135586==--
