Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VEFgg-00017F-7u
	for ltp-list@lists.sourceforge.net; Tue, 27 Aug 2013 09:35:46 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VEFge-0002fj-8o
	for ltp-list@lists.sourceforge.net; Tue, 27 Aug 2013 09:35:46 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r7R9ZbIc027694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Aug 2013 09:35:38 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7R9ZaSr029130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Aug 2013 09:35:37 GMT
Received: from abhmt106.oracle.com (abhmt106.oracle.com [141.146.116.58])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7R9Zakr023932
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Aug 2013 09:35:36 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 27 Aug 2013 13:35:29 +0400
Message-Id: <1377596129-32367-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <521B6875.8010202@oracle.com>
References: <521B6875.8010202@oracle.com>
Subject: [LTP] [PATCH V2 2/2] syscalls/getgroups: added checks for 16-bit
	getgroups() syscall
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

getgroups01_16 and getgroups03_16 did not use 16-bit
version of getgroups() syscall. Fixed this in the same manner as
syscalls/setgroups.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/getgroups/compat_16.h   |   78 +++++++++++++++++++++
 testcases/kernel/syscalls/getgroups/getgroups01.c |   22 +++---
 testcases/kernel/syscalls/getgroups/getgroups03.c |   17 +++--
 3 files changed, 99 insertions(+), 18 deletions(-)
 create mode 100644 testcases/kernel/syscalls/getgroups/compat_16.h

diff --git a/testcases/kernel/syscalls/getgroups/compat_16.h b/testcases/kernel/syscalls/getgroups/compat_16.h
new file mode 100644
index 0000000..79d006e
--- /dev/null
+++ b/testcases/kernel/syscalls/getgroups/compat_16.h
@@ -0,0 +1,78 @@
+/*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
+ *
+ */
+
+#ifndef __GETGROUPS_COMPAT_16_H__
+#define __GETGROUPS_COMPAT_16_H__
+
+#include "compat_gid.h"
+#include "linux_syscall_numbers.h"
+
+#ifdef TST_USE_COMPAT16_SYSCALL
+
+int SETGROUPS(size_t size, const GID_T *list16)
+{
+	int r;
+	int i;
+
+	gid_t *list32;
+	list32 = calloc(size, sizeof(gid_t));
+	if (list32 == NULL)
+		tst_brkm(TBROK | TERRNO, NULL,
+			"calloc() failed to allocate %zu bytes",
+			size * sizeof(gid_t));
+
+	for (i = 0; i < size; i++)
+		list32[i] = list16[i];
+
+	r = setgroups(size, list32);
+
+	free(list32);
+
+	return r;
+}
+
+int GETGROUPS(int size, GID_T *list16)
+{
+# if (__NR_getgroups32 != __LTP__NR_INVALID_SYSCALL)
+	/* __NR_getgroups - 16-bit version of getgroups() syscall */
+	return ltp_syscall(__NR_getgroups, size, list16);
+# else
+	/* The platform has no 16-bit version of getgroups() syscall */
+	tst_brkm(TCONF, NULL,
+		"16-bit version of getgroups() is not supported on your arch");
+# endif /* __NR_getgroups32 */
+}
+
+#else
+
+int SETGROUPS(size_t size, const GID_T *list32)
+{
+	return setgroups(size, list32);
+}
+
+int GETGROUPS(int size, GID_T *list32)
+{
+	return getgroups(size, list32);
+}
+
+#endif /* TST_USE_COMPAT16_SYSCALL */
+
+#endif /* __GETGROUPS_COMPAT_16_H__ */
diff --git a/testcases/kernel/syscalls/getgroups/getgroups01.c b/testcases/kernel/syscalls/getgroups/getgroups01.c
index 1d58109..39157aa 100644
--- a/testcases/kernel/syscalls/getgroups/getgroups01.c
+++ b/testcases/kernel/syscalls/getgroups/getgroups01.c
@@ -52,8 +52,10 @@
 #include <grp.h>
 #include <sys/param.h>
 #include <sys/types.h>
+
 #include "test.h"
 #include "usctest.h"
+#include "compat_16.h"
 
 static void setup(void);
 static void cleanup(void);
@@ -61,14 +63,14 @@ static void cleanup(void);
 char *TCID = "getgroups01";
 int TST_TOTAL = 4;
 
-static gid_t gidset[NGROUPS];
-static gid_t cmpset[NGROUPS];
+static GID_T gidset[NGROUPS];
+static GID_T cmpset[NGROUPS];
 
 int main(int ac, char **av)
 {
 	int lc;
 	char *msg;
-	gid_t group;
+	GID_T group;
 	int i;
 	int entries;
 
@@ -83,7 +85,7 @@ int main(int ac, char **av)
 
 		tst_count = 0;
 
-		TEST(getgroups(-1, gidset));
+		TEST(GETGROUPS(-1, gidset));
 
 		if (TEST_RETURN == 0) {
 			tst_resm(TFAIL, "getgroups succeeded unexpectedly");
@@ -101,14 +103,14 @@ int main(int ac, char **av)
 		 * return and the the gidset array is not modified.
 		 * This is a POSIX special case.
 		 */
-		memset(gidset, 052, NGROUPS * sizeof(gid_t));
-		memset(cmpset, 052, NGROUPS * sizeof(gid_t));
+		memset(gidset, 052, NGROUPS * sizeof(GID_T));
+		memset(cmpset, 052, NGROUPS * sizeof(GID_T));
 
-		TEST(getgroups(0, gidset));
+		TEST(GETGROUPS(0, gidset));
 		if (TEST_RETURN == -1) {
 			tst_resm(TFAIL | TTERRNO, "getgroups failed unexpectedly");
 		} else if (STD_FUNCTIONAL_TEST) {
-			if (memcmp(cmpset, gidset, NGROUPS * sizeof(gid_t)) != 0)
+			if (memcmp(cmpset, gidset, NGROUPS * sizeof(GID_T)) != 0)
 				tst_resm(TFAIL,
 					 "getgroups modified the gidset array");
 			else
@@ -126,7 +128,7 @@ int main(int ac, char **av)
 				 "getgroups returned %ld; unable to test that using ngrps >=1 but less than number of grps",
 				 TEST_RETURN);
 		} else {
-			TEST(getgroups(TEST_RETURN - 1, gidset));
+			TEST(GETGROUPS(TEST_RETURN - 1, gidset));
 			if (TEST_RETURN == -1) {
 				if (STD_FUNCTIONAL_TEST) {
 					if (errno == EINVAL)
@@ -145,7 +147,7 @@ int main(int ac, char **av)
 			}
 		}
 
-		TEST(getgroups(NGROUPS, gidset));
+		TEST(GETGROUPS(NGROUPS, gidset));
 		if ((entries = TEST_RETURN) == -1) {
 			tst_resm(TFAIL | TTERRNO,
 				 "getgroups failed unexpectedly");
diff --git a/testcases/kernel/syscalls/getgroups/getgroups03.c b/testcases/kernel/syscalls/getgroups/getgroups03.c
index 1e25756..3a0ac0c 100644
--- a/testcases/kernel/syscalls/getgroups/getgroups03.c
+++ b/testcases/kernel/syscalls/getgroups/getgroups03.c
@@ -41,6 +41,7 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "compat_16.h"
 
 #define TESTUSER "root"
 
@@ -48,8 +49,8 @@ char *TCID = "getgroups03";
 int TST_TOTAL = 1;
 
 static int ngroups;
-static gid_t groups_list[NGROUPS];
-static gid_t groups[NGROUPS];
+static GID_T groups_list[NGROUPS];
+static GID_T groups[NGROUPS];
 
 static void verify_groups(int ret_ngroups);
 static void setup(void);
@@ -70,7 +71,7 @@ int main(int ac, char **av)
 
 		tst_count = 0;
 
-		TEST(getgroups(gidsetsize, groups_list));
+		TEST(GETGROUPS(gidsetsize, groups_list));
 
 		if (TEST_RETURN == -1) {
 			tst_resm(TFAIL | TTERRNO, "getgroups failed");
@@ -88,18 +89,18 @@ int main(int ac, char **av)
 }
 
 /*
- * readgroups(gid_t *)  - Read supplimentary group ids of "root" user
+ * readgroups(GID_T *)  - Read supplimentary group ids of "root" user
  * Scans the /etc/group file to get IDs of all the groups to which TESTUSER
  * belongs and puts them into the array passed.
  * Returns the no of gids read.
  */
-static int readgroups(gid_t groups[NGROUPS])
+static int readgroups(GID_T groups[NGROUPS])
 {
 	struct group *grp;
 	int ngrps = 0;
 	int i;
 	int found;
-	gid_t g;
+	GID_T g;
 
 	setgrent();
 
@@ -151,7 +152,7 @@ static void setup(void)
 	 * testcase will fail. So execute setgroups() before executing
 	 * getgroups()
 	 */
-	if (setgroups(ngroups, groups) == -1)
+	if (SETGROUPS(ngroups, groups) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "setgroups failed");
 }
 
@@ -165,7 +166,7 @@ static void setup(void)
 static void verify_groups(int ret_ngroups)
 {
 	int i, j;
-	gid_t egid;
+	GID_T egid;
 	int egid_flag = 1;
 	int fflag = 1;
 
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
