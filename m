Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WG729-0001tI-8p
	for ltp-list@lists.sourceforge.net; Wed, 19 Feb 2014 13:17:53 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WG726-0003WB-O4
	for ltp-list@lists.sourceforge.net; Wed, 19 Feb 2014 13:17:52 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s1JDHhCB028716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Feb 2014 13:17:44 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1JDHhDe025379
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Feb 2014 13:17:43 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1JDHh4L008781
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Feb 2014 13:17:43 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 19 Feb 2014 17:17:30 +0400
Message-Id: <1392815850-14039-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] include/config.mk: add -Wold-style-definition
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
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

Make compiler warn about old-style prototypes which were commonly
used before ANSI C. Using old-style function definition could result
in bugs that are not tracked down at compile time.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/mk/config.mk.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index acdbdb5..c83d08c 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -66,7 +66,7 @@ DEBUG_CXXFLAGS		?= $(DEBUG_CFLAGS)
 OPT_CFLAGS		?= -O2 -fno-strict-aliasing -pipe
 OPT_CXXFLAGS		?= $(OPT_CFLAGS)
 
-WCFLAGS			?= -Wall -W
+WCFLAGS			?= -Wall -W -Wold-style-definition
 WCXXFLAGS		?= $(WCFLAGS)
 
 LDFLAGS			+= $(WLDFLAGS)
-- 
1.7.1


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
