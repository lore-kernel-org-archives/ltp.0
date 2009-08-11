Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MavBa-0007IR-5i
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2009 17:30:58 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MavBV-0007tk-Mb
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2009 17:30:58 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7BHU334029342
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Aug 2009 13:30:03 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7BHUhu31806542
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Aug 2009 13:30:44 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7BHUhXU031536
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Aug 2009 11:30:43 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Tue, 11 Aug 2009 23:00:35 +0530
Message-Id: <20090811173035.7074.95239.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090811172957.7074.62874.sendpatchset@subratamodak.linux.ibm.com>
References: <20090811172957.7074.62874.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 03/05] Add Script so the kernel is restored back to
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

Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
---

diff -uprN ltp-full-20090731.orig/tools/restore_kernel_faults_default.sh ltp-full-20090731/tools/restore_kernel_faults_default.sh
--- ltp-full-20090731.orig/tools/restore_kernel_faults_default.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/tools/restore_kernel_faults_default.sh	2009-08-11 18:45:38.000000000 +0530
@@ -0,0 +1,85 @@
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
+################################################################################
+
+echo  0 > /debug/fail_io_timeout/reject-end
+echo  0 > /debug/fail_io_timeout/reject-start
+echo  4294967295 > /debug/fail_io_timeout/require-end
+echo  0 > /debug/fail_io_timeout/require-start
+echo  32 > /debug/fail_io_timeout/stacktrace-depth
+echo  N > /debug/fail_io_timeout/task-filter
+echo  2 > /debug/fail_io_timeout/verbose
+echo  0 > /debug/fail_io_timeout/space
+echo  1 > /debug/fail_io_timeout/times
+echo  1 > /debug/fail_io_timeout/interval
+echo  0 > /debug/fail_io_timeout/probability
+
+echo  0 > /debug/fail_make_request/reject-end
+echo  0 > /debug/fail_make_request/reject-start
+echo  4294967295 > /debug/fail_make_request/require-end
+echo  0 > /debug/fail_make_request/require-start
+echo  32 > /debug/fail_make_request/stacktrace-depth
+echo  N > /debug/fail_make_request/task-filter
+echo  2 > /debug/fail_make_request/verbose
+echo  0 > /debug/fail_make_request/space
+echo  1 > /debug/fail_make_request/times
+echo  1 > /debug/fail_make_request/interval
+echo  0 > /debug/fail_make_request/probability
+
+echo  1 > /debug/fail_page_alloc/min-order
+echo  Y > /debug/fail_page_alloc/ignore-gfp-highmem
+echo  Y > /debug/fail_page_alloc/ignore-gfp-wait
+echo  0 > /debug/fail_page_alloc/reject-end
+echo  0 > /debug/fail_page_alloc/reject-start
+echo  4294967295 > /debug/fail_page_alloc/require-end
+echo  0 > /debug/fail_page_alloc/require-start
+echo  32 > /debug/fail_page_alloc/stacktrace-depth
+echo  N > /debug/fail_page_alloc/task-filter
+echo  2 > /debug/fail_page_alloc/verbose
+echo  0 > /debug/fail_page_alloc/space
+echo  1 > /debug/fail_page_alloc/times
+echo  1 > /debug/fail_page_alloc/interval
+echo  0 > /debug/fail_page_alloc/probability
+
+echo  Y > /debug/failslab/ignore-gfp-wait
+echo  0 > /debug/failslab/reject-end
+echo  0 > /debug/failslab/reject-start
+echo  4294967295 > /debug/failslab/require-end
+echo  0 > /debug/failslab/require-start
+echo  32 > /debug/failslab/stacktrace-depth
+echo  N > /debug/failslab/task-filter
+echo  2 > /debug/failslab/verbose
+echo  0 > /debug/failslab/space
+echo  1 > /debug/failslab/times
+echo  1 > /debug/failslab/interval
+echo  0 > /debug/failslab/probability
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
