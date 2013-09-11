Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VJggY-0002Tz-FW
	for ltp-list@lists.sourceforge.net; Wed, 11 Sep 2013 09:26:06 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VJggW-0002ii-9n
	for ltp-list@lists.sourceforge.net; Wed, 11 Sep 2013 09:26:06 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r8B9PvCA003113
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Sep 2013 09:25:58 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8B9PuFi027868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Sep 2013 09:25:56 GMT
Received: from abhmt112.oracle.com (abhmt112.oracle.com [141.146.116.64])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8B9PtEp017425
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Sep 2013 09:25:55 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 11 Sep 2013 13:25:43 +0400
Message-Id: <1378891544-706-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1378891544-706-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1378891544-706-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 1/2] getuid, getgid, setuid,
	setgid: fixed 16-bit versions
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

Fixed 16-bit versions of testcases:
* getgid
* getuid
* setgid
* setuid
the way like setgroups.

Testcase getuid02 in fact tests geteuid() so renamed it to geteuid02.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 runtest/ltplite                               |    2 +-
 runtest/stress.part3                          |    2 +-
 runtest/syscalls                              |    4 +-
 testcases/kernel/syscalls/.gitignore          |    4 +-
 testcases/kernel/syscalls/geteuid/geteuid02.c |  112 +++++++++++++++++++++++++
 testcases/kernel/syscalls/getgid/compat_16.h  |   60 -------------
 testcases/kernel/syscalls/getgid/getgid01.c   |    3 +-
 testcases/kernel/syscalls/getgid/getgid03.c   |   29 +++----
 testcases/kernel/syscalls/getuid/compat_16.h  |   60 -------------
 testcases/kernel/syscalls/getuid/getuid01.c   |    3 +-
 testcases/kernel/syscalls/getuid/getuid02.c   |  112 -------------------------
 testcases/kernel/syscalls/getuid/getuid03.c   |   33 ++++----
 testcases/kernel/syscalls/setgid/compat_16.h  |   68 ---------------
 testcases/kernel/syscalls/setgid/setgid01.c   |   13 ++--
 testcases/kernel/syscalls/setgid/setgid02.c   |   32 ++-----
 testcases/kernel/syscalls/setgid/setgid03.c   |   23 ++----
 testcases/kernel/syscalls/setuid/setuid01.c   |    9 +-
 testcases/kernel/syscalls/setuid/setuid02.c   |   14 +--
 testcases/kernel/syscalls/setuid/setuid03.c   |   19 +++--
 testcases/kernel/syscalls/setuid/setuid04.c   |   18 +++--
 testcases/kernel/syscalls/utils/compat_16.h   |   39 +++++++++
 21 files changed, 243 insertions(+), 416 deletions(-)
 create mode 100644 testcases/kernel/syscalls/geteuid/geteuid02.c
 delete mode 100644 testcases/kernel/syscalls/getgid/compat_16.h
 delete mode 100644 testcases/kernel/syscalls/getuid/compat_16.h
 delete mode 100644 testcases/kernel/syscalls/getuid/getuid02.c
 delete mode 100644 testcases/kernel/syscalls/setgid/compat_16.h

diff --git a/runtest/ltplite b/runtest/ltplite
index 2a704db..8ff55ee 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -285,6 +285,7 @@ getdtablesize01 getdtablesize01
 getegid01 getegid01
 
 geteuid01 geteuid01
+geteuid02 geteuid02
 
 getgid01 getgid01
 getgid03 getgid03
@@ -341,7 +342,6 @@ gettimeofday01 gettimeofday01
 gettimeofday02 gettimeofday02
 
 getuid01 getuid01
-getuid02 getuid02
 getuid03 getuid03
 
 #Needs tty device.
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index b783b7f..0533d4d 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -224,6 +224,7 @@ getdtablesize01 getdtablesize01
 getegid01 getegid01
 
 geteuid01 geteuid01
+geteuid02 geteuid02
 
 getgid01 getgid01
 getgid03 getgid03
@@ -281,7 +282,6 @@ gettimeofday01 gettimeofday01
 gettimeofday02 gettimeofday02
 
 getuid01 getuid01
-getuid02 getuid02
 getuid03 getuid03
 
 ioperm01 ioperm01
diff --git a/runtest/syscalls b/runtest/syscalls
index b778b64..09e5f7f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -343,6 +343,8 @@ getegid02_16 getegid02_16
 
 geteuid01 geteuid01
 geteuid01_16 geteuid01_16
+geteuid02 geteuid02
+geteuid02_16 geteuid02_16
 
 getgid01 getgid01
 getgid01_16 getgid01_16
@@ -413,8 +415,6 @@ gettimeofday02 gettimeofday02
 
 getuid01 getuid01
 getuid01_16 getuid01_16
-getuid02 getuid02
-getuid02_16 getuid02_16
 getuid03 getuid03
 getuid03_16 getuid03_16
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index f8f02d5..ad23c2e 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -286,6 +286,8 @@
 /getegid/getegid02_16
 /geteuid/geteuid01
 /geteuid/geteuid01_16
+/geteuid/geteuid02
+/geteuid/geteuid02_16
 /getgid/getgid01
 /getgid/getgid01_16
 /getgid/getgid03
@@ -336,8 +338,6 @@
 /gettimeofday/gettimeofday02
 /getuid/getuid01
 /getuid/getuid01_16
-/getuid/getuid02
-/getuid/getuid02_16
 /getuid/getuid03
 /getuid/getuid03_16
 /getxattr/getxattr01
diff --git a/testcases/kernel/syscalls/geteuid/geteuid02.c b/testcases/kernel/syscalls/geteuid/geteuid02.c
new file mode 100644
index 0000000..b62fc51
--- /dev/null
+++ b/testcases/kernel/syscalls/geteuid/geteuid02.c
@@ -0,0 +1,112 @@
+/*
+ *
+ *   Copyright (c) International Business Machines  Corp., 2001
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+/*
+ * NAME
+ * 	geteuid02.c
+ *
+ * DESCRIPTION
+ *	Testcase to check the basic functionality of the geteuid() system call.
+ *
+ * USAGE:  <for command-line>
+ *  geteuid02 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
+ *     where,  -c n : Run n copies concurrently.
+ *             -f   : Turn off functionality Testing.
+ *             -i n : Execute test n times.
+ *             -I x : Execute test for x seconds.
+ *             -P x : Pause for x seconds between iterations.
+ *             -t   : Turn on syscall timing.
+ *
+ * HISTORY
+ *	07/2001 Ported by Wayne Boyer
+ *
+ * RESTRICTIONS
+ * 	None
+ */
+
+#include <pwd.h>
+#include <errno.h>
+#include "test.h"
+#include "usctest.h"
+#include "compat_16.h"
+
+TCID_DEFINE(geteuid02);
+int TST_TOTAL = 1;
+
+void setup(void);
+void cleanup(void);
+
+int main(int ac, char **av)
+{
+	struct passwd *pwent;
+	int lc;
+	char *msg;		/* message returned by parse_opts */
+
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		TEST(GETEUID());
+
+		if (TEST_RETURN == -1)
+			tst_brkm(TBROK | TTERRNO, cleanup, "geteuid* failed");
+
+		if (STD_FUNCTIONAL_TEST) {
+
+			pwent = getpwuid(TEST_RETURN);
+			if (pwent == NULL)
+				tst_resm(TFAIL | TERRNO, "getpwuid failed");
+			else if (!UID_SIZE_CHECK(pwent->pw_uid))
+				tst_brkm(TBROK, cleanup,
+					 "uid = %ld is too large for testing "
+					 "via geteuid16", TEST_RETURN);
+			else {
+				if (pwent->pw_uid != TEST_RETURN)
+					tst_resm(TFAIL, "getpwuid value, %d, "
+						 "does not match geteuid "
+						 "value, %ld", pwent->pw_uid,
+						 TEST_RETURN);
+				else
+					tst_resm(TPASS, "values from geteuid "
+						 "and getpwuid match");
+			}
+		} else
+			tst_resm(TPASS, "call succeeded");
+	}
+	cleanup();
+	tst_exit();
+
+}
+
+void setup()
+{
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+}
+
+void cleanup()
+{
+	TEST_CLEANUP;
+}
diff --git a/testcases/kernel/syscalls/getgid/compat_16.h b/testcases/kernel/syscalls/getgid/compat_16.h
deleted file mode 100644
index 249e270..0000000
--- a/testcases/kernel/syscalls/getgid/compat_16.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- *
- *   Copyright (c) Red Hat Inc., 2008
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/* Author: Masatake YAMATO <yamato@redhat.com> */
-
-#ifndef __GETGID_COMPAT_16_H__
-#define __GETGID_COMPAT_16_H__
-
-
-#include "linux_syscall_numbers.h"
-#include "compat_gid.h"
-
-
-#ifdef TST_USE_COMPAT16_SYSCALL
-
-GID_T
-GETGID(void)
-{
-	return ltp_syscall(__NR_getgid);
-}
-
-GID_T
-GETEGID(void)
-{
-	return ltp_syscall(__NR_getegid);
-}
-
-#else
-
-GID_T
-GETGID(void)
-{
-	return getgid();
-}
-
-GID_T
-GETEGID(void)
-{
-	return getegid();
-}
-
-#endif
-
-#endif /* __GETGID_COMPAT_16_H__ */
diff --git a/testcases/kernel/syscalls/getgid/getgid01.c b/testcases/kernel/syscalls/getgid/getgid01.c
index 07b5bcd..0111a19 100644
--- a/testcases/kernel/syscalls/getgid/getgid01.c
+++ b/testcases/kernel/syscalls/getgid/getgid01.c
@@ -114,6 +114,7 @@
 #include <errno.h>
 #include <signal.h>
 #include <string.h>
+
 #include "test.h"
 #include "usctest.h"
 #include "compat_16.h"
@@ -142,7 +143,7 @@ int main(int ac, char **av)
 
 		tst_count = 0;
 
-		TEST(GETGID());
+		TEST(GETGID(cleanup));
 
 		if (TEST_RETURN == -1)
 			tst_resm(TFAIL, "getgid failed");
diff --git a/testcases/kernel/syscalls/getgid/getgid03.c b/testcases/kernel/syscalls/getgid/getgid03.c
index 35325d9..80224da 100644
--- a/testcases/kernel/syscalls/getgid/getgid03.c
+++ b/testcases/kernel/syscalls/getgid/getgid03.c
@@ -64,7 +64,6 @@
 
 #include "test.h"
 #include "usctest.h"
-
 #include "compat_16.h"
 
 void cleanup(void);
@@ -77,7 +76,7 @@ int main(int ac, char **av)
 {
 	int lc;
 	char *msg;
-	int uid;
+	uid_t uid;
 	struct passwd *pwent;
 
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
@@ -92,7 +91,7 @@ int main(int ac, char **av)
 		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		TEST(GETGID());
+		TEST(GETGID(cleanup));
 
 		if (TEST_RETURN < 0) {
 			tst_brkm(TBROK, cleanup, "This should never happen");
@@ -102,23 +101,19 @@ int main(int ac, char **av)
 			uid = getuid();
 			pwent = getpwuid(uid);
 
-			if (pwent == NULL) {
+			if (pwent == NULL)
 				tst_brkm(TBROK, cleanup, "getuid() returned "
 					 "unexpected value %d", uid);
-			} else if (!GID_SIZE_CHECK(pwent->pw_gid)) {
-				tst_brkm(TBROK,
-					 cleanup,
-					 "gid for uid %d is too large for testing getgid16",
-					 uid);
+
+			GID16_CHECK(pwent->pw_gid, getgid, cleanup);
+
+			if (pwent->pw_gid != TEST_RETURN) {
+				tst_resm(TFAIL, "getgid() return value "
+					 "%ld unexpected - expected %d",
+					 TEST_RETURN, pwent->pw_gid);
 			} else {
-				if (pwent->pw_gid != TEST_RETURN) {
-					tst_resm(TFAIL, "getgid() return value "
-						 "%ld unexpected - expected %d",
-						 TEST_RETURN, pwent->pw_gid);
-				} else {
-					tst_resm(TPASS, "group id %ld returned "
-						 "correctly", TEST_RETURN);
-				}
+				tst_resm(TPASS, "group id %ld returned "
+					 "correctly", TEST_RETURN);
 			}
 		} else {
 			tst_resm(TPASS, "call succeeded");
diff --git a/testcases/kernel/syscalls/getuid/compat_16.h b/testcases/kernel/syscalls/getuid/compat_16.h
deleted file mode 100644
index db6f332..0000000
--- a/testcases/kernel/syscalls/getuid/compat_16.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- *
- *   Copyright (c) Red Hat Inc., 2008
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/* Author: Masatake YAMATO <yamato@redhat.com> */
-
-#ifndef __GETUID_COMPAT_16_H__
-#define __GETUID_COMPAT_16_H__
-
-
-#include "linux_syscall_numbers.h"
-#include "compat_uid.h"
-
-
-#ifdef TST_USE_COMPAT16_SYSCALL
-
-UID_T
-GETUID(void)
-{
-	return ltp_syscall(__NR_getuid);
-}
-
-UID_T
-GETEUID(void)
-{
-	return ltp_syscall(__NR_geteuid);
-}
-
-#else
-
-UID_T
-GETUID(void)
-{
-	return getuid();
-}
-
-UID_T
-GETEUID(void)
-{
-	return geteuid();
-}
-
-#endif
-
-#endif /* __GETUID_COMPAT_16_H__ */
diff --git a/testcases/kernel/syscalls/getuid/getuid01.c b/testcases/kernel/syscalls/getuid/getuid01.c
index 4c2d65c..433ad7b 100644
--- a/testcases/kernel/syscalls/getuid/getuid01.c
+++ b/testcases/kernel/syscalls/getuid/getuid01.c
@@ -114,6 +114,7 @@
 #include <errno.h>
 #include <string.h>
 #include <signal.h>
+
 #include "test.h"
 #include "usctest.h"
 #include "compat_16.h"
@@ -142,7 +143,7 @@ int main(int ac, char **av)
 
 		tst_count = 0;
 
-		TEST(GETUID());
+		TEST(GETUID(cleanup));
 
 		if (TEST_RETURN == -1)
 			tst_resm(TFAIL | TTERRNO, "getuid failed");
diff --git a/testcases/kernel/syscalls/getuid/getuid02.c b/testcases/kernel/syscalls/getuid/getuid02.c
deleted file mode 100644
index 27a24e0..0000000
--- a/testcases/kernel/syscalls/getuid/getuid02.c
+++ /dev/null
@@ -1,112 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * NAME
- * 	getuid02.c
- *
- * DESCRIPTION
- *	Testcase to check the basic functionality of the geteuid() system call.
- *
- * USAGE:  <for command-line>
- *  getuid02 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- * 	None
- */
-
-#include <pwd.h>
-#include <errno.h>
-#include "test.h"
-#include "usctest.h"
-#include "compat_16.h"
-
-TCID_DEFINE(getuid02);
-int TST_TOTAL = 1;
-
-void setup(void);
-void cleanup(void);
-
-int main(int ac, char **av)
-{
-	struct passwd *pwent;
-	int lc;
-	char *msg;		/* message returned by parse_opts */
-
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(GETEUID());
-
-		if (TEST_RETURN == -1)
-			tst_brkm(TBROK | TTERRNO, cleanup, "geteuid* failed");
-
-		if (STD_FUNCTIONAL_TEST) {
-
-			pwent = getpwuid(TEST_RETURN);
-			if (pwent == NULL)
-				tst_resm(TFAIL | TERRNO, "getpwuid failed");
-			else if (!UID_SIZE_CHECK(pwent->pw_uid))
-				tst_brkm(TBROK, cleanup,
-					 "uid = %ld is too large for testing "
-					 "via geteuid16", TEST_RETURN);
-			else {
-				if (pwent->pw_uid != TEST_RETURN)
-					tst_resm(TFAIL, "getpwuid value, %d, "
-						 "does not match geteuid "
-						 "value, %ld", pwent->pw_uid,
-						 TEST_RETURN);
-				else
-					tst_resm(TPASS, "values from geteuid "
-						 "and getpwuid match");
-			}
-		} else
-			tst_resm(TPASS, "call succeeded");
-	}
-	cleanup();
-	tst_exit();
-
-}
-
-void setup()
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-void cleanup()
-{
-	TEST_CLEANUP;
-}
diff --git a/testcases/kernel/syscalls/getuid/getuid03.c b/testcases/kernel/syscalls/getuid/getuid03.c
index a5fd7f1..8ee4ada 100644
--- a/testcases/kernel/syscalls/getuid/getuid03.c
+++ b/testcases/kernel/syscalls/getuid/getuid03.c
@@ -42,6 +42,7 @@
 
 #include <pwd.h>
 #include <errno.h>
+
 #include "test.h"
 #include "usctest.h"
 #include "compat_16.h"
@@ -57,6 +58,7 @@ int main(int ac, char **av)
 	struct passwd *pwent;
 	int lc;
 	char *msg;		/* message returned by parse_opts */
+	uid_t uid;
 
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
@@ -67,29 +69,28 @@ int main(int ac, char **av)
 
 		tst_count = 0;
 
-		TEST(GETUID());
+		TEST(GETUID(cleanup));
 
 		if (TEST_RETURN == -1)
 			tst_brkm(TBROK | TTERRNO, cleanup, "getuid failed");
 
 		if (STD_FUNCTIONAL_TEST) {
-			pwent = getpwuid(TEST_RETURN);
+			uid = getuid();
+			pwent = getpwuid(uid);
+
 			if (pwent == NULL)
 				tst_resm(TFAIL | TERRNO, "getpwuid failed");
-			else if (!UID_SIZE_CHECK(pwent->pw_uid))
-				tst_brkm(TBROK, cleanup,
-					 "uid = %ld is too large for testing "
-					 "getuid16", TEST_RETURN);
-			else {
-				if (pwent->pw_uid != TEST_RETURN)
-					tst_resm(TFAIL, "getpwuid value, %d, "
-						 "does not match getuid "
-						 "value, %ld", pwent->pw_uid,
-						 TEST_RETURN);
-				else
-					tst_resm(TPASS, "values from getuid "
-						 "and getpwuid match");
-			}
+
+			UID16_CHECK(pwent->pw_uid, getuid, cleanup);
+
+			if (pwent->pw_uid != TEST_RETURN)
+				tst_resm(TFAIL, "getpwuid value, %d, "
+					 "does not match getuid "
+					 "value, %ld", pwent->pw_uid,
+					 TEST_RETURN);
+			else
+				tst_resm(TPASS, "values from getuid "
+					 "and getpwuid match");
 		} else
 			tst_resm(TPASS, "call succeeded");
 	}
diff --git a/testcases/kernel/syscalls/setgid/compat_16.h b/testcases/kernel/syscalls/setgid/compat_16.h
deleted file mode 100644
index 9d1d15c..0000000
--- a/testcases/kernel/syscalls/setgid/compat_16.h
+++ /dev/null
@@ -1,68 +0,0 @@
-/*
- *
- *   Copyright (c) Red Hat Inc., 2008
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/* Author: Masatake YAMATO <yamato@redhat.com> */
-
-#ifndef __SETGID_COMPAT_16_H__
-#define __SETGID_COMPAT_16_H__
-
-
-#include "linux_syscall_numbers.h"
-#include "compat_gid.h"
-
-
-#ifdef TST_USE_COMPAT16_SYSCALL
-
-int
-SETGID(GID_T gid)
-{
-	return ltp_syscall(__NR_setgid, gid);
-}
-
-GID_T
-GETGID(void)
-{
-	gid_t gid;
-
-	gid = getgid();
-	if (!GID_SIZE_CHECK(gid))
-	  tst_brkm(TBROK,
-		   cleanup,
-		   "gid for the current process is too large for testing setgid16");
-
-	return (GID_T)gid;
-}
-
-#else
-
-int
-SETGID(GID_T gid)
-{
-	return setgid(gid);
-}
-
-GID_T
-GETGID(void)
-{
-	return getgid();
-}
-
-#endif
-
-#endif /* __SETGID_COMPAT_16_H__ */
diff --git a/testcases/kernel/syscalls/setgid/setgid01.c b/testcases/kernel/syscalls/setgid/setgid01.c
index 9121e47..849057b 100644
--- a/testcases/kernel/syscalls/setgid/setgid01.c
+++ b/testcases/kernel/syscalls/setgid/setgid01.c
@@ -112,20 +112,20 @@
 #include <errno.h>
 #include <string.h>
 #include <signal.h>
+
 #include "test.h"
 #include "usctest.h"
+#include "compat_16.h"
 
 static void setup();
 static void cleanup();
 
-#include "compat_16.h"
-
 TCID_DEFINE(setgid01);
 int TST_TOTAL = 1;
 
 int exp_enos[] = { 0, 0 };
 
-GID_T gid;
+gid_t gid;
 
 int main(int ac, char **av)
 {
@@ -156,7 +156,7 @@ int main(int ac, char **av)
 		/*
 		 * Call setgid(2)
 		 */
-		TEST(SETGID(gid));
+		TEST(SETGID(cleanup, gid));
 
 		/* check return code */
 		if (TEST_RETURN == -1) {
@@ -181,8 +181,6 @@ int main(int ac, char **av)
      ***************************************************************/
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
 /***************************************************************
@@ -195,7 +193,8 @@ void setup()
 
 	TEST_PAUSE;
 
-	gid = GETGID();
+	gid = getgid();
+	GID16_CHECK(gid, setgid, cleanup);
 }
 
 /***************************************************************
diff --git a/testcases/kernel/syscalls/setgid/setgid02.c b/testcases/kernel/syscalls/setgid/setgid02.c
index f3894b1..548591e 100644
--- a/testcases/kernel/syscalls/setgid/setgid02.c
+++ b/testcases/kernel/syscalls/setgid/setgid02.c
@@ -45,8 +45,10 @@
  */
 #include <pwd.h>
 #include <errno.h>
+
 #include "test.h"
 #include "usctest.h"
+#include "compat_16.h"
 
 TCID_DEFINE(setgid02);
 int TST_TOTAL = 1;
@@ -59,8 +61,6 @@ struct passwd *ltpuser;
 static void setup(void);
 static void cleanup(void);
 
-#include "compat_16.h"
-
 int exp_enos[] = { EPERM, 0 };
 
 int main(int ac, char **av)
@@ -87,14 +87,9 @@ int main(int ac, char **av)
 				 "%s", root);
 		}
 
-		if (!GID_SIZE_CHECK(rootpwent->pw_gid)) {
-			tst_brkm(TBROK,
-				 cleanup,
-				 "gid for `%s' is too large for testing setgid16",
-				 root);
-		}
+		GID16_CHECK(rootpwent->pw_gid, setgid, cleanup);
 
-		TEST(SETGID(rootpwent->pw_gid));
+		TEST(SETGID(cleanup, rootpwent->pw_gid));
 
 		if (TEST_RETURN != -1) {
 			tst_resm(TFAIL, "call succeeded unexpectedly");
@@ -112,8 +107,6 @@ int main(int ac, char **av)
 	}
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
 /*
@@ -121,18 +114,13 @@ int main(int ac, char **av)
  */
 void setup()
 {
-/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
-	ltpuser = getpwnam(nobody_uid);
+	tst_require_root(NULL);
 
-	if (!GID_SIZE_CHECK(ltpuser->pw_gid)) {
-		tst_brkm(TBROK,
-			 cleanup,
-			 "gid for `%s' is too large for testing setgid16",
-			 nobody_gid);
-	}
+	/* Switch to nobody user for correct error code collection */
+	ltpuser = getpwnam(nobody_uid);
+	if (ltpuser == NULL)
+		tst_brkm(TBROK, cleanup, "getpwnam failed for user id %s",
+			nobody_uid);
 
 	if (setgid(ltpuser->pw_gid) == -1) {
 		tst_resm(TINFO, "setgid failed to "
diff --git a/testcases/kernel/syscalls/setgid/setgid03.c b/testcases/kernel/syscalls/setgid/setgid03.c
index 261f2ae..ea2e89e 100644
--- a/testcases/kernel/syscalls/setgid/setgid03.c
+++ b/testcases/kernel/syscalls/setgid/setgid03.c
@@ -44,8 +44,10 @@
  */
 #include <pwd.h>
 #include <errno.h>
+
 #include "test.h"
 #include "usctest.h"
+#include <compat_16.h>
 
 TCID_DEFINE(setgid03);
 int TST_TOTAL = 1;
@@ -53,13 +55,11 @@ int TST_TOTAL = 1;
 char ltpuser1[] = "nobody";
 char root[] = "root";
 struct passwd *getpwnam(), *ltpuser1pwent, *rootpwent;
-int mygid;
+gid_t mygid;
 
 static void setup(void);
 static void cleanup(void);
 
-#include "compat_16.h"
-
 int main(int ac, char **av)
 {
 	int lc;
@@ -77,7 +77,7 @@ int main(int ac, char **av)
 		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		TEST(setgid(ltpuser1pwent->pw_gid));
+		TEST(SETGID(cleanup, ltpuser1pwent->pw_gid));
 
 		if (TEST_RETURN == -1) {
 			tst_resm(TFAIL, "call failed unexpectedly");
@@ -98,8 +98,6 @@ int main(int ac, char **av)
 	}
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
 /*
@@ -107,10 +105,7 @@ int main(int ac, char **av)
  */
 void setup()
 {
-	/* test must be run as root */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
@@ -132,13 +127,7 @@ void setup()
 			 "id %s", ltpuser1);
 	}
 
-	if (!(GID_SIZE_CHECK(rootpwent->pw_gid))) {
-		tst_brkm(TBROK,
-			 cleanup,
-			 "gid for `%s' is too large for testing setgid16",
-			 root);
-	}
-
+	GID16_CHECK(ltpuser1pwent->pw_gid, setgid, cleanup);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/setuid/setuid01.c b/testcases/kernel/syscalls/setuid/setuid01.c
index c51e72b..5bbae07 100644
--- a/testcases/kernel/syscalls/setuid/setuid01.c
+++ b/testcases/kernel/syscalls/setuid/setuid01.c
@@ -112,11 +112,11 @@
 #include <errno.h>
 #include <string.h>
 #include <signal.h>
-
 #include <sys/types.h>
 
 #include "test.h"
 #include "usctest.h"
+#include "compat_16.h"
 
 void setup();
 void cleanup();
@@ -124,7 +124,7 @@ void cleanup();
 char *TCID = "setuid01";
 int TST_TOTAL = 1;
 
-int uid;			/* current user id */
+uid_t uid;			/* current user id */
 
 int main(int ac, char **av)
 {
@@ -156,9 +156,10 @@ int main(int ac, char **av)
 		 *  Set the effective user ID to the current real uid
 		 */
 		uid = getuid();
+		UID16_CHECK(uid, setuid, cleanup);
 
 		/* Call setuid(2) */
-		TEST(setuid(uid));
+		TEST(SETUID(cleanup, uid));
 
 		/* check return code */
 		if (TEST_RETURN == -1) {
@@ -185,8 +186,6 @@ int main(int ac, char **av)
      ***************************************************************/
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
 /***************************************************************
diff --git a/testcases/kernel/syscalls/setuid/setuid02.c b/testcases/kernel/syscalls/setuid/setuid02.c
index 08a7c91..4e3af36 100644
--- a/testcases/kernel/syscalls/setuid/setuid02.c
+++ b/testcases/kernel/syscalls/setuid/setuid02.c
@@ -112,11 +112,11 @@
 #include <errno.h>
 #include <string.h>
 #include <signal.h>
-
 #include <sys/types.h>
 
 #include "test.h"
 #include "usctest.h"
+#include "compat_16.h"
 
 void setup();
 void cleanup();
@@ -126,7 +126,7 @@ int TST_TOTAL = 1;
 
 int exp_enos[] = { 0, 0 };
 
-int uid;			/* current user id */
+uid_t uid;			/* current user id */
 
 int main(int ac, char **av)
 {
@@ -151,6 +151,7 @@ int main(int ac, char **av)
      * check looping state if -c option given
      ***************************************************************/
 	uid = getuid();
+	UID16_CHECK(uid, setuid, cleanup);
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		tst_count = 0;
@@ -161,7 +162,7 @@ int main(int ac, char **av)
 		 */
 
 		/* Call setuid(2) */
-		TEST(setuid(uid));
+		TEST(SETUID(cleanup, uid));
 
 		/* check return code */
 		if (TEST_RETURN == -1) {
@@ -188,8 +189,6 @@ int main(int ac, char **av)
      ***************************************************************/
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
 /***************************************************************
@@ -197,6 +196,7 @@ int main(int ac, char **av)
  ***************************************************************/
 void setup()
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
@@ -204,10 +204,6 @@ void setup()
 
 	/* make a temp dir and cd to it */
 	tst_tmpdir();
-
-	/* must be root */
-	if (geteuid() != 0)
-		tst_brkm(TBROK, cleanup, "Must be root for this test!");
 }
 
 /***************************************************************
diff --git a/testcases/kernel/syscalls/setuid/setuid03.c b/testcases/kernel/syscalls/setuid/setuid03.c
index e39ca7e..b836873 100644
--- a/testcases/kernel/syscalls/setuid/setuid03.c
+++ b/testcases/kernel/syscalls/setuid/setuid03.c
@@ -37,15 +37,17 @@
  *	07/2001 Ported by Wayne Boyer
  *
  * RESTRICTIONS
- * 	Must be ran as non-root.
+ *     Must be ran as root.
  */
 #include <errno.h>
+#include <pwd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
+
 #include "test.h"
 #include "usctest.h"
-#include <pwd.h>
+#include "compat_16.h"
 
 #define ROOT_USER	0
 
@@ -80,7 +82,7 @@ int main(int ac, char **av)
 		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		TEST(setuid(ROOT_USER));
+		TEST(SETUID(cleanup, ROOT_USER));
 
 		if (TEST_RETURN != -1) {
 			tst_resm(TFAIL, "call succeeded unexpectedly");
@@ -98,8 +100,6 @@ int main(int ac, char **av)
 	}
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
 /*
@@ -107,11 +107,14 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
+
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
+	if (ltpuser == NULL)
+		tst_brkm(TBROK, cleanup, "getpwnam failed for user id %s",
+			nobody_uid);
+
 	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setuid failed to "
 			 "to set the effective uid to %d", ltpuser->pw_uid);
diff --git a/testcases/kernel/syscalls/setuid/setuid04.c b/testcases/kernel/syscalls/setuid/setuid04.c
index c2241fb..1610d90 100644
--- a/testcases/kernel/syscalls/setuid/setuid04.c
+++ b/testcases/kernel/syscalls/setuid/setuid04.c
@@ -46,14 +46,16 @@
  * 	Must be run as root.
  */
 #include <errno.h>
+#include <pwd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
 #include <fcntl.h>
 #include <unistd.h>
+
 #include "test.h"
 #include "usctest.h"
-#include <pwd.h>
+#include "compat_16.h"
 
 char *TCID = "setuid04";
 int TST_TOTAL = 1;
@@ -101,8 +103,6 @@ int main(int ac, char **av)
 
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
 /*
@@ -114,7 +114,7 @@ void do_master_child()
 	int pid;
 	int status;
 
-	if (setuid(ltpuser->pw_uid) == -1) {
+	if (SETUID(cleanup, ltpuser->pw_uid) == -1) {
 		tst_brkm(TBROK, NULL,
 			 "setuid failed to set the effective uid to %d",
 			 ltpuser->pw_uid);
@@ -181,12 +181,16 @@ void do_master_child()
  */
 void setup(void)
 {
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
+	tst_require_root(NULL);
 
 	ltpuser = getpwnam(nobody_uid);
 
+	if (ltpuser == NULL)
+		tst_brkm(TBROK, cleanup, "getpwnam failed for user id %s",
+			nobody_uid);
+
+	UID16_CHECK(ltpuser->pw_uid, setuid, cleanup);
+
 	sprintf(testfile, "setuid04file%d.tst", getpid());
 
 	/* Create test file */
diff --git a/testcases/kernel/syscalls/utils/compat_16.h b/testcases/kernel/syscalls/utils/compat_16.h
index 52b808c..b65a8f9 100644
--- a/testcases/kernel/syscalls/utils/compat_16.h
+++ b/testcases/kernel/syscalls/utils/compat_16.h
@@ -23,7 +23,12 @@
 #define __LTP_COMPAT_16_H__
 
 #include <errno.h>
+#include <grp.h>
+#include <sys/types.h>
+#include <unistd.h>
+
 #include "compat_gid.h"
+#include "compat_uid.h"
 #include "linux_syscall_numbers.h"
 
 /* If the platform has __NR_sys_name32 defined it
@@ -44,6 +49,21 @@
 	return sys_name(__VA_ARGS__)
 #endif
 
+#define UID16_CHECK(uid, sys_name, cleanup) \
+if (!UID_SIZE_CHECK(uid)) { \
+	tst_brkm(TBROK, cleanup, \
+		"uid %d of %s is too large for testing 16-bit version " \
+		"of %s()", uid, #uid, #sys_name); \
+}
+
+#define GID16_CHECK(gid, sys_name, cleanup) \
+if (!GID_SIZE_CHECK(gid)) { \
+	tst_brkm(TBROK, cleanup, \
+		"gid %d of %s is too large for testing 16-bit version " \
+		"of %s()", gid, #gid, #sys_name); \
+}
+
+
 int SETGROUPS(void (cleanup)(void), size_t gidsetsize, GID_T *list)
 {
 	LTP_CREATE_SYSCALL(setgroups, cleanup, gidsetsize, list);
@@ -54,4 +74,23 @@ int GETGROUPS(void (cleanup)(void), size_t gidsetsize, GID_T *list)
 	LTP_CREATE_SYSCALL(getgroups, cleanup, gidsetsize, list);
 }
 
+int SETUID(void (cleanup)(void), UID_T uid)
+{
+	LTP_CREATE_SYSCALL(setuid, cleanup, uid);
+}
+
+UID_T GETUID(void (cleanup)(void))
+{
+	LTP_CREATE_SYSCALL(getuid, cleanup);
+}
+
+int SETGID(void (cleanup)(void), GID_T gid)
+{
+	LTP_CREATE_SYSCALL(setgid, cleanup, gid);
+}
+
+GID_T GETGID(void (cleanup)(void))
+{
+	LTP_CREATE_SYSCALL(getgid, cleanup);
+}
 #endif /* __LTP_COMPAT_16_H__ */
-- 
1.7.1


------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. Consolidate legacy IT systems to a single system of record for IT
2. Standardize and globalize service processes across IT
3. Implement zero-touch automation to replace manual, redundant tasks
http://pubads.g.doubleclick.net/gampad/clk?id=51271111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
