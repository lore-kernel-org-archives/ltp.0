Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1W2dvl-0000DV-Qb
	for ltp-list@lists.sourceforge.net; Mon, 13 Jan 2014 09:35:37 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1W2dvk-0006q4-Tf
	for ltp-list@lists.sourceforge.net; Mon, 13 Jan 2014 09:35:37 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id s0D9ZUoB025926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Jan 2014 09:35:31 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s0D9ZUXa004335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Jan 2014 09:35:30 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s0D9ZUbr021389
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Jan 2014 09:35:30 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 13 Jan 2014 13:35:23 +0400
Message-Id: <1389605723-17937-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <52CFC6D1.4060006@oracle.com>
References: <52CFC6D1.4060006@oracle.com>
Subject: [LTP] [PATCH 2/2] setregid02, setresuid03: inval_user fix
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

Since there is no guarantee that (USHRT_MAX - 2) uid/gid is free
on the platform it would be better to use special functions:

 * tst_get_unused_uid
 * tst_get_unused_gid

wrapped for 16-bit compatibility: if on the host there is no free uid/gid
in between [0; 0xFFFE] the 16-bit test case should return TBROK.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/setregid/setregid02.c   |    6 +++++-
 testcases/kernel/syscalls/setresuid/setresuid03.c |    8 +++++++-
 testcases/kernel/syscalls/utils/compat_gid.h      |   20 ++++++++++++++++++++
 testcases/kernel/syscalls/utils/compat_uid.h      |   20 ++++++++++++++++++++
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/setregid/setregid02.c b/testcases/kernel/syscalls/setregid/setregid02.c
index ccbaa3e..a730a5e 100644
--- a/testcases/kernel/syscalls/setregid/setregid02.c
+++ b/testcases/kernel/syscalls/setregid/setregid02.c
@@ -39,7 +39,7 @@ TCID_DEFINE(setregid02);
 
 static gid_t neg_one = -1;
 
-static gid_t inval_user = USHRT_MAX - 2;
+static gid_t inval_user;
 static struct passwd *ltpuser;
 
 static struct group nobody, root, bin;
@@ -177,6 +177,10 @@ static void setup(void)
 	GET_GID(nobody);
 	GET_GID(bin);
 
+	inval_user = GET_UNUSED_GID();
+	if (inval_user == -1)
+		tst_brkm(TBROK, NULL, "No free gid found");
+
 	TEST_PAUSE;
 }
 
diff --git a/testcases/kernel/syscalls/setresuid/setresuid03.c b/testcases/kernel/syscalls/setresuid/setresuid03.c
index 9bb0abd..085ed7b 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid03.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid03.c
@@ -70,10 +70,12 @@
 #include <errno.h>
 #include <sys/wait.h>
 
+#include <compat_16.h>
+
 char *TCID = "setresuid03";
 
 uid_t neg_one = -1;
-uid_t inval_user = (USHRT_MAX - 2);
+uid_t inval_user;
 
 /* flag to tell parent if child passed or failed. */
 int flag = 0;
@@ -232,6 +234,10 @@ void setup(void)
 	bin = *(getpwnam("bin"));
 	bin_pw_uid = bin.pw_uid;
 
+	inval_user = GET_UNUSED_UID();
+	if (inval_user == -1)
+		tst_brkm(TBROK, NULL, "No free uid found");
+
 	/* Pause if that option was specified
 	 * TEST_PAUSE contains the code to fork the test with the -i option.
 	 * You want to make sure you do this before you create your temporary
diff --git a/testcases/kernel/syscalls/utils/compat_gid.h b/testcases/kernel/syscalls/utils/compat_gid.h
index 82f8d84..1ce713b 100644
--- a/testcases/kernel/syscalls/utils/compat_gid.h
+++ b/testcases/kernel/syscalls/utils/compat_gid.h
@@ -48,4 +48,24 @@ GID_SIZE_CHECK(gid_t gid)
 
 #endif
 
+/* for 16-bit syscalls testing we can only
+ * use gids <= 0xFFFE */
+gid_t GET_UNUSED_GID(void)
+{
+	gid_t r;
+	r = tst_get_unused_gid();
+
+#ifdef TST_USE_COMPAT16_SYSCALL
+	if (!GID_SIZE_CHECK(r))
+		return -1;
+
+	/* kernel low2highgid() converts
+	 * 0xFFFF to (gid_t)-1 */
+	if (r == (GID_T)-1)
+		return -1;
+#endif
+
+	return r;
+}
+
 #endif /* __SETGID_COMPAT_16_H__ */
diff --git a/testcases/kernel/syscalls/utils/compat_uid.h b/testcases/kernel/syscalls/utils/compat_uid.h
index 8200698..68896f4 100644
--- a/testcases/kernel/syscalls/utils/compat_uid.h
+++ b/testcases/kernel/syscalls/utils/compat_uid.h
@@ -48,4 +48,24 @@ UID_SIZE_CHECK(uid_t uid)
 
 #endif
 
+/* for 16-bit syscalls testing we can only
+ * use uids <= 0xFFFE */
+uid_t GET_UNUSED_UID(void)
+{
+	uid_t r;
+	r = tst_get_unused_uid();
+
+#ifdef TST_USE_COMPAT16_SYSCALL
+	if (!UID_SIZE_CHECK(r))
+		return -1;
+
+	/* kernel low2highuid() converts
+	 * 0xFFFF to (uid_t)-1 */
+	if (r == (UID_T)-1)
+		return -1;
+#endif
+
+	return r;
+}
+
 #endif /* __SETUID_COMPAT_16_H__ */
-- 
1.7.1


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
