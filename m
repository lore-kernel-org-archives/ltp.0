Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1Vdwg3-0006G5-Co
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 06:33:19 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vdwg2-0002dC-NA
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 06:33:19 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA66XCKi019588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 06:33:13 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA66XBgs021786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 06:33:12 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA66XBtM005352
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 06:33:11 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Wed,  6 Nov 2013 14:33:05 +0800
Message-Id: <1383719585-692-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP] [PATCH] sendfile: add SF_Server into INSTALL_TARGETS in
	Makefile
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

sendfile01 always fails because SF_Server file is not installed.

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testcases/network/tcp_cmds/sendfile/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/tcp_cmds/sendfile/Makefile b/testcases/network/tcp_cmds/sendfile/Makefile
index 124ce5d..17a985a 100644
--- a/testcases/network/tcp_cmds/sendfile/Makefile
+++ b/testcases/network/tcp_cmds/sendfile/Makefile
@@ -27,7 +27,7 @@ include $(abs_srcdir)/../Makefile.inc
 
 CPPFLAGS		+= -I$(abs_srcdir)/../include
 
-INSTALL_TARGETS		:= sendfile01
+INSTALL_TARGETS		:= sendfile01 SF_Server
 
 MAKE_TARGETS		+= testsf_c testsf_s testsf_c6 testsf_s6
 
-- 
1.8.4.2


------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
