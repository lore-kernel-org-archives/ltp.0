Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1ZRcOF-0003rs-06
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2015 08:37:03 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZRcOD-0002wC-3L
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2015 08:37:02 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id F2ED496EF
	for <ltp-list@lists.sourceforge.net>;
	Tue, 18 Aug 2015 08:36:54 +0000 (UTC)
Received: from dhcp-13-206.nay.redhat.com (dhcp12-104.nay.redhat.com
	[10.66.12.104] (may be forged))
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t7I8amir026359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Aug 2015 04:36:52 -0400
From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Aug 2015 16:36:44 +0800
Message-Id: <1439887006-17985-1-git-send-email-liwang@redhat.com>
Subject: [LTP] [PATCH 1/3] ltp/tools: remove the scripts/numa_test.sh file
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

Not only ltp/Makefile cancel the calling of the numa_test.sh, but
there are no any other testcases using it.

per: ef77253961f909f87e82e6d2b620e87af33e9665

ltp also has another copy of it: /testcases/kernel/numa/test.sh

Signed-off-by: Li Wang <liwang@redhat.com>
---
 tools/scripts/numa_test.sh | 53 ----------------------------------------------
 1 file changed, 53 deletions(-)
 delete mode 100755 tools/scripts/numa_test.sh

diff --git a/tools/scripts/numa_test.sh b/tools/scripts/numa_test.sh
deleted file mode 100755
index 1b46149..0000000
--- a/tools/scripts/numa_test.sh
+++ /dev/null
@@ -1,53 +0,0 @@
-#############################################################################
-##
-## Copyright (c) International Business Machines  Corp., 2007
-##
-## This program is free software;  you can redistribute it and#or modify
-## it under the terms of the GNU General Public License as published by
-## the Free Software Foundation; either version 2 of the License, or
-## (at your option) any later version.
-##
-## This program is distributed in the hope that it will be useful, but
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-## for more details.
-##
-## You should have received a copy of the GNU General Public License
-## along with this program;  if not, write to the Free Software
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-##
-#############################################################################
-#
-# Author         Pradeep Kumar Surisetty, pradeepkumars@in.ibm.com
-#
-# History        Nov 27 2007 -created- pradeep kumar surisetty
-#! /bin/sh
-#
-# File :         numa_test.sh
-
-
-#!/bin/sh
-x=0
-chk_ifexist()
-{
-if [ ! -d /sys/devices/system/node ]
-then
-x=0
-else
-x=$(ls /sys/devices/system/node | wc -l)
-fi
-if [ $x -gt 1 ]
-then
-	if [ ! -f /usr/include/numa.h ]
-	then
-		echo no;
- 	else
-		echo yes;
-	fi
-else
-        echo no;     #numa is not present
-
-fi
-}
-chk_ifexist
-
-- 
1.8.3.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
