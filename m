Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri2Eb-00010b-97
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 11:08:49 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri2Ea-0001pK-FW
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 11:08:49 +0000
Message-ID: <4F02E1B9.2090603@imgtec.com>
Date: Tue, 3 Jan 2012 11:08:41 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050604060605040806040601"
Subject: [LTP] [PATCH 09/21] realtime/lib/Makefile: Fix path for config.mk
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--------------050604060605040806040601
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch

-- 
markos

--------------050604060605040806040601
Content-Type: text/plain;
	name="0009-realtime-lib-Makefile-Fix-path-for-config.mk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0009-realtime-lib-Makefile-Fix-path-for-config.mk.patch"

From 34eab5207f365db3ed43614bb499a8863ca2ca82 Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 15 Dec 2011 12:14:47 +0000
Subject: [PATCH 09/21] realtime/lib/Makefile: Fix path for config.mk

The autotools in realtime subfolders overwrites the top level autotools
variables. To avoid this problem, we use relative
paths instead of using variables that may or may not be have been
overwritten  by another autotools build.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 testcases/realtime/lib/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/realtime/lib/Makefile b/testcases/realtime/lib/Makefile
index 8860549..ecf4b5c 100644
--- a/testcases/realtime/lib/Makefile
+++ b/testcases/realtime/lib/Makefile
@@ -22,7 +22,7 @@
 
 top_srcdir		?= ../../..
 
-include $(top_srcdir)/../config.mk
+include ../config.mk
 
 CFLAGS			+= -D_GNU_SOURCE
 
-- 
1.7.1


--------------050604060605040806040601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--------------050604060605040806040601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050604060605040806040601--


