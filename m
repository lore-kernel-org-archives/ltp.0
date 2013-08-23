Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VCmhv-0002AO-C8
	for ltp-list@lists.sourceforge.net; Fri, 23 Aug 2013 08:26:59 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VCmhs-0003XU-0u
	for ltp-list@lists.sourceforge.net; Fri, 23 Aug 2013 08:26:59 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 23 Aug 2013 12:26:41 +0400
Message-Id: <1377246401-17449-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <893330423.2949965.1377244649561.JavaMail.root@redhat.com>
References: <893330423.2949965.1377244649561.JavaMail.root@redhat.com>
Subject: [LTP] [PATCH V3.1 1/3] Added ALIGN, __ALIGN_MASK macros
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
Cc: vasily.isaenko@oracle.com

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/test.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/test.h b/include/test.h
index d9eba31..a517ff9 100644
--- a/include/test.h
+++ b/include/test.h
@@ -105,6 +105,12 @@
 #define MAP_PRIVATE_EXCEPT_UCLINUX	MAP_PRIVATE
 #endif
 
+/* Round x to the next multiple of a.
+ * a should be a power of 2.
+ */
+#define ALIGN(x, a)	__ALIGN_MASK(x, (typeof(x))(a) - 1)
+#define __ALIGN_MASK(x, mask)	(((x) + (mask)) & ~(mask))
+
 /*
  * lib/forker.c
  */
-- 
1.7.1


------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
