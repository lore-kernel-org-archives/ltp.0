Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Md12W-0007T1-CC
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2009 12:10:16 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Md12Q-0007tm-4U
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2009 12:10:16 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7HC52q9006867
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2009 06:05:02 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7HCA0rf241222
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2009 06:10:00 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7HC9x5A020937
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2009 06:10:00 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Mon, 17 Aug 2009 17:39:44 +0530
Message-Id: <20090817120942.8902.85335.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090817120835.8902.4597.sendpatchset@subratamodak.linux.ibm.com>
References: <20090817120835.8902.4597.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH v2 03/05] Add Script so the kernel is restored back to
	its original pristine form
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
To: LTP Mailing List <ltp-list@lists.sourceforge.net>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, Mike Frysinger <vapier@gentoo.org>, Michael Reed <mreed10@us.ibm.com>, Nate Straz <nate@refried.org>, Paul Larson <paul.larson@ubuntu.com>, Manoj Iyer <manoj.iyer@ubuntu.com>, Balbir Singh <balbir@linux.vnet.ibm.com>

Once the faults has been injected and all the concerned tests have been run
completely, the kernel needs to be restored back to its original pristine
form so that it is stable again. This Script does just exactly that.

This again has changes regarding the debugfs mount point.

Signed-off-by: Subrata Modak<subrata@linux.vnet.ibm.com>
---

diff -uprN ltp-full-20090731.orig/tools/restore_kernel_faults_default.sh ltp-full-20090731/tools/restore_kernel_faults_default.sh
--- ltp-full-20090731.orig/tools/restore_kernel_faults_default.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/tools/restore_kernel_faults_default.sh	2009-08-17 11:11:59.000000000 +0530
@@ -0,0 +1,86 @@
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
+#                                                                             ##
+# File :        restore_kernel_faults_default.sh			      ##
+#                                                                             ##
+# Usage:        restore_kernel_faults_default.sh	                      ##
+#                                                                             ##
+# Description:  This is a simple script that will restore the /debugfs/fail*  ##
+#		entries to their default values				      ##
+#                                                                             ##
+# Author:       Subrata Modak <subrata@linux.vnet.ibm.com>                    ##
+#                                                                             ##
+# History:      Aug 11 2009 - Created - Subrata Modak.                        ##
+#		Aug 17 2009 - Changed debugfs mount point - Subrata Modak.    ##
+################################################################################
+
+echo  0 > /sys/kernel/debug/fail_io_timeout/reject-end
+echo  0 > /sys/kernel/debug/fail_io_timeout/reject-start
+echo  4294967295 > /sys/kernel/debug/fail_io_timeout/require-end
+echo  0 > /sys/kernel/debug/fail_io_timeout/require-start
+echo  32 > /sys/kernel/debug/fail_io_timeout/stacktrace-depth
+echo  N > /sys/kernel/debug/fail_io_timeout/task-filter
+echo  2 > /sys/kernel/debug/fail_io_timeout/verbose
+echo  0 > /sys/kernel/debug/fail_io_timeout/space
+echo  1 > /sys/kernel/debug/fail_io_timeout/times
+echo  1 > /sys/kernel/debug/fail_io_timeout/interval
+echo  0 > /sys/kernel/debug/fail_io_timeout/probability
+
+echo  0 > /sys/kernel/debug/fail_make_request/reject-end
+echo  0 > /sys/kernel/debug/fail_make_request/reject-start
+echo  4294967295 > /sys/kernel/debug/fail_make_request/require-end
+echo  0 > /sys/kernel/debug/fail_make_request/require-start
+echo  32 > /sys/kernel/debug/fail_make_request/stacktrace-depth
+echo  N > /sys/kernel/debug/fail_make_request/task-filter
+echo  2 > /sys/kernel/debug/fail_make_request/verbose
+echo  0 > /sys/kernel/debug/fail_make_request/space
+echo  1 > /sys/kernel/debug/fail_make_request/times
+echo  1 > /sys/kernel/debug/fail_make_request/interval
+echo  0 > /sys/kernel/debug/fail_make_request/probability
+
+echo  1 > /sys/kernel/debug/fail_page_alloc/min-order
+echo  Y > /sys/kernel/debug/fail_page_alloc/ignore-gfp-highmem
+echo  Y > /sys/kernel/debug/fail_page_alloc/ignore-gfp-wait
+echo  0 > /sys/kernel/debug/fail_page_alloc/reject-end
+echo  0 > /sys/kernel/debug/fail_page_alloc/reject-start
+echo  4294967295 > /sys/kernel/debug/fail_page_alloc/require-end
+echo  0 > /sys/kernel/debug/fail_page_alloc/require-start
+echo  32 > /sys/kernel/debug/fail_page_alloc/stacktrace-depth
+echo  N > /sys/kernel/debug/fail_page_alloc/task-filter
+echo  2 > /sys/kernel/debug/fail_page_alloc/verbose
+echo  0 > /sys/kernel/debug/fail_page_alloc/space
+echo  1 > /sys/kernel/debug/fail_page_alloc/times
+echo  1 > /sys/kernel/debug/fail_page_alloc/interval
+echo  0 > /sys/kernel/debug/fail_page_alloc/probability
+
+echo  Y > /sys/kernel/debug/failslab/ignore-gfp-wait
+echo  0 > /sys/kernel/debug/failslab/reject-end
+echo  0 > /sys/kernel/debug/failslab/reject-start
+echo  4294967295 > /sys/kernel/debug/failslab/require-end
+echo  0 > /sys/kernel/debug/failslab/require-start
+echo  32 > /sys/kernel/debug/failslab/stacktrace-depth
+echo  N > /sys/kernel/debug/failslab/task-filter
+echo  2 > /sys/kernel/debug/failslab/verbose
+echo  0 > /sys/kernel/debug/failslab/space
+echo  1 > /sys/kernel/debug/failslab/times
+echo  1 > /sys/kernel/debug/failslab/interval
+echo  0 > /sys/kernel/debug/failslab/probability
+

---
Regards--
Subrata


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
