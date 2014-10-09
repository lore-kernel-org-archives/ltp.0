Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Xc6lo-0002B9-LH
	for ltp-list@lists.sourceforge.net; Thu, 09 Oct 2014 06:00:13 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xc6ln-0001Uv-HC
	for ltp-list@lists.sourceforge.net; Thu, 09 Oct 2014 06:00:12 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s9954aNX016024
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Oct 2014 13:04:37 +0800
Message-ID: <1412831035.28284.29.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 9 Oct 2014 13:03:55 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] sigaddset: fix ARRAY_SIZE undefined
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
To: ltp-list <ltp-list@lists.sourceforge.net>

open_posix_testsuite/conformance/interfaces/sigaddset/4-1.c compiles failed
since b863a0bd, because of ARRAY_SIZE is undefined in open_posix_testsuite.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/open_posix_testsuite/include/posixtest.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/open_posix_testsuite/include/posixtest.h b/testcases/open_posix_testsuite/include/posixtest.h
index 4980011..df40f56 100644
--- a/testcases/open_posix_testsuite/include/posixtest.h
+++ b/testcases/open_posix_testsuite/include/posixtest.h
@@ -36,3 +36,6 @@
 #define PTS_UNSUPPORTED 4
 #define PTS_UNTESTED    5
 
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
+#endif
-- 
1.9.3




------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
