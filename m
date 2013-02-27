Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UAXpU-0008K8-E9
	for ltp-list@lists.sourceforge.net; Wed, 27 Feb 2013 03:37:16 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UAXpS-000176-93
	for ltp-list@lists.sourceforge.net; Wed, 27 Feb 2013 03:37:16 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r1R3aXRV027434
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Feb 2013 11:36:34 +0800
Message-ID: <512D7ECF.6020007@cn.fujitsu.com>
Date: Wed, 27 Feb 2013 11:34:39 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] testfrmw/testfrmw.c : include head file
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>


Include stdarg.h, since va_start & va_end are called in this src file.

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 .../open_posix_testsuite/conformance/interfaces/testfrmw/testfrmw.c      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/testfrmw.c
b/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/testfrmw.c
index b78115e..18cb636 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/testfrmw.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/testfrmw.c
@@ -29,6 +29,7 @@
 #include <time.h>
 #include <sys/types.h>
 #include <pthread.h>
+#include <stdarg.h>

 /* We use a mutex to avoid conflicts in traces */
 static pthread_mutex_t m_trace = PTHREAD_MUTEX_INITIALIZER;
-- 
1.7.12

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
