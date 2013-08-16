Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VAEBq-0002Z4-Pn
	for ltp-list@lists.sourceforge.net; Fri, 16 Aug 2013 07:11:18 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VAEBl-0007ib-9V
	for ltp-list@lists.sourceforge.net; Fri, 16 Aug 2013 07:11:18 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r7G7B6so020099
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 16 Aug 2013 07:11:07 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7G7B56g022167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 16 Aug 2013 07:11:06 GMT
Received: from abhmt117.oracle.com (abhmt117.oracle.com [141.146.116.69])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7G7B5Lh022142
	for <ltp-list@lists.sourceforge.net>; Fri, 16 Aug 2013 07:11:05 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 16 Aug 2013 11:10:57 +0400
Message-Id: <1376637057-1744-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] syscalls/setgroups: fix implicit SETGROUPS parameter
	casting
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

One of parameters to setgroups() syscall is (gid_t *) pointer.
If TST_USE_COMPAT16_VSYSCALL is defined a pointer to GID_T is passed
instead (and sizeof(GID_T) < sizeof(gid_t)). It's not safe and
can result in unaligned access (and SIGBUS) on several platforms.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/setgroups/compat_16.h   |   22 +++++++++++++++++++-
 testcases/kernel/syscalls/setgroups/setgroups04.c |    6 ++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/setgroups/compat_16.h b/testcases/kernel/syscalls/setgroups/compat_16.h
index 0de4e78..35723d6 100644
--- a/testcases/kernel/syscalls/setgroups/compat_16.h
+++ b/testcases/kernel/syscalls/setgroups/compat_16.h
@@ -32,9 +32,27 @@ extern void cleanup(void);
 #ifdef TST_USE_COMPAT16_SYSCALL
 
 long
-SETGROUPS(size_t gidsetsize, GID_T *list)
+SETGROUPS(size_t gidsetsize, GID_T *list16)
 {
-	return ltp_syscall(__NR_setgroups, gidsetsize, list);
+	int r;
+	int i;
+
+	gid_t *list32;
+
+	list32 = calloc(gidsetsize, sizeof(gid_t));
+	if (list32 == NULL)
+		tst_brkm(TBROK | TERRNO, NULL,
+			"calloc failed to allocate %zu bytes at %s:%d",
+			gidsetsize * sizeof(gid_t),
+			__FILE__, __LINE__);
+
+	for (i = 0; i < gidsetsize; i++)
+		list32[i] = list16[i];
+
+	r = ltp_syscall(__NR_setgroups, gidsetsize, list32);
+
+	free(list32);
+	return r;
 }
 
 int
diff --git a/testcases/kernel/syscalls/setgroups/setgroups04.c b/testcases/kernel/syscalls/setgroups/setgroups04.c
index 5932b4e..42ddda2 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups04.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups04.c
@@ -111,7 +111,11 @@ int main(int ac, char **av)
 		 * verify that it fails with -1 return value and
 		 * sets appropriate errno.
 		 */
-		TEST(SETGROUPS(gidsetsize, sbrk(0)));
+#ifdef TST_USE_COMPAT16_SYSCALL
+		TEST(ltp_syscall(__NR_setgroups, gidsetsize, sbrk(0)));
+#else
+		TEST(setgroups(gidsetsize, sbrk(0)));
+#endif
 
 		if (TEST_RETURN != -1) {
 			tst_resm(TFAIL, "setgroups() returned %ld, "
-- 
1.7.1


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
