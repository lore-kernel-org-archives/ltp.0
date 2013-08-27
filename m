Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VEFgg-00019r-9L
	for ltp-list@lists.sourceforge.net; Tue, 27 Aug 2013 09:35:46 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VEFgc-0003vG-IJ
	for ltp-list@lists.sourceforge.net; Tue, 27 Aug 2013 09:35:46 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r7R9Zam0027663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Aug 2013 09:35:36 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7R9ZZAG021314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Aug 2013 09:35:36 GMT
Received: from abhmt106.oracle.com (abhmt106.oracle.com [141.146.116.58])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7R9ZZKu021301
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Aug 2013 09:35:35 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 27 Aug 2013 13:35:28 +0400
Message-Id: <1377596129-32367-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <521B6875.8010202@oracle.com>
References: <521B6875.8010202@oracle.com>
Subject: [LTP] [PATCH V2 1/2] syscalls/setgroups: fix 16-bit versions of the
	testcases
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

Now 16-bit testcases are executed only if platform
has corresponding 16-bit version of setgroups() syscall.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/setgroups/compat_16.h |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/setgroups/compat_16.h b/testcases/kernel/syscalls/setgroups/compat_16.h
index 0de4e78..8f46da9 100644
--- a/testcases/kernel/syscalls/setgroups/compat_16.h
+++ b/testcases/kernel/syscalls/setgroups/compat_16.h
@@ -32,9 +32,16 @@ extern void cleanup(void);
 #ifdef TST_USE_COMPAT16_SYSCALL
 
 long
-SETGROUPS(size_t gidsetsize, GID_T *list)
+SETGROUPS(size_t gidsetsize, GID_T *list16)
 {
-	return ltp_syscall(__NR_setgroups, gidsetsize, list);
+# if (__NR_setgroups32 != __LTP__NR_INVALID_SYSCALL)
+	/* __NR_setgroups - 16-bit version of setgroups() syscall */
+	return ltp_syscall(__NR_setgroups, gidsetsize, list16);
+# else
+	/* The platform has no 16-bit version of setgroups() syscall */
+	tst_brkm(TCONF, NULL,
+		"16-bit version of setgroups() is not supported on your arch");
+# endif /* __NR_setgroups32 */
 }
 
 int
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
