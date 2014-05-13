Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Wk650-0002jT-OA
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 06:20:46 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wk64y-0003Ar-O1
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 06:20:46 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s4D6KcLF024857
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 13 May 2014 06:20:38 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s4D6Kcjp028100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 13 May 2014 06:20:38 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s4D6KaQZ028067
	for <ltp-list@lists.sourceforge.net>; Tue, 13 May 2014 06:20:37 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 13 May 2014 10:20:23 +0400
Message-Id: <1399962023-23105-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20140512125913.GA4741@rei>
References: <20140512125913.GA4741@rei>
Subject: [LTP] [PATCH 2/2] msg_common.h: corrected __sparc64__ definition
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

__sparc64__ is not defined by cpp. We should use
'__sparc__' and '__arch64__' instead.

Author: Jose E. Marchesi <jose.marchesi@oracle.com>

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/utils/msg_common.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/utils/msg_common.h b/testcases/kernel/syscalls/utils/msg_common.h
index 0471291..2ecd27e 100644
--- a/testcases/kernel/syscalls/utils/msg_common.h
+++ b/testcases/kernel/syscalls/utils/msg_common.h
@@ -26,7 +26,8 @@
 #ifndef MSG_CMSG_COMPAT
 
 #if defined(__powerpc64__) || defined(__mips64) || defined(__x86_64__) || \
-	defined(__sparc64__) || defined(__ia64__) || defined(__s390x__)
+	defined(__ia64__) || defined(__s390x__) || \
+	defined(__sparc__) && defined(__arch64__)
 #define MSG_CMSG_COMPAT 0x80000000
 #else
 #define MSG_CMSG_COMPAT 0
-- 
1.7.1


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
