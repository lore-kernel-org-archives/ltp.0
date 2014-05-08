Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WiKIC-0000kG-2r
	for ltp-list@lists.sourceforge.net; Thu, 08 May 2014 09:07:04 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WiKIB-00007S-5z
	for ltp-list@lists.sourceforge.net; Thu, 08 May 2014 09:07:04 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s4896uVc028252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 8 May 2014 09:06:57 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s4896ugr027265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 8 May 2014 09:06:56 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4896uWL001909
	for <ltp-list@lists.sourceforge.net>; Thu, 8 May 2014 09:06:56 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu,  8 May 2014 13:06:43 +0400
Message-Id: <1399540004-14742-4-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1399540004-14742-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1399540004-14742-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 3/4] syscalls: corrected the rest of __sparc64__
	defines
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

'__sparc64__' is not defined by cpp. We should use
'__sparc__' and '__arch64__' instead.

Author: Jose E. Marchesi <jose.marchesi@oracle.com>
Author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/recvmsg/recvmsg01.c |    3 ++-
 testcases/kernel/syscalls/sendmsg/sendmsg01.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
index bc84a23..102a268 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
@@ -45,7 +45,8 @@
 /* and this test to function correctly.                        */
 #ifndef MSG_CMSG_COMPAT
 
-#if defined (__powerpc64__) || defined (__mips64) || defined (__x86_64__) || defined (__sparc64__)
+#if defined(__powerpc64__) || defined(__mips64) || defined(__x86_64__) || \
+	defined(__sparc__) && defined(__arch64__)
 #define MSG_CMSG_COMPAT 0x80000000
 #else
 #define MSG_CMSG_COMPAT 0
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
index 58d3364..9e5d4f2 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
@@ -37,7 +37,8 @@
  */
 #ifndef MSG_CMSG_COMPAT
 #if defined(__powerpc64__) || defined(__mips64) || defined(__x86_64__) || \
-     defined(__sparc64__) || defined(__ia64__) || defined(__s390x__)
+	defined(__sparc__) && defined(__arch64__) || defined(__ia64__) || \
+	defined(__s390x__)
 #define MSG_CMSG_COMPAT 0x80000000
 #else
 #define MSG_CMSG_COMPAT 0
-- 
1.7.1


------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
