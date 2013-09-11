Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VJggX-00066v-FH
	for ltp-list@lists.sourceforge.net; Wed, 11 Sep 2013 09:26:05 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VJggW-0002ik-Br
	for ltp-list@lists.sourceforge.net; Wed, 11 Sep 2013 09:26:05 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r8B9PvCt019982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Sep 2013 09:25:58 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8B9Pvom017477
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Sep 2013 09:25:57 GMT
Received: from abhmt112.oracle.com (abhmt112.oracle.com [141.146.116.64])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8B9Pui2027815
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Sep 2013 09:25:56 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 11 Sep 2013 13:25:44 +0400
Message-Id: <1378891544-706-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1378891544-706-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1378891544-706-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 2/2] getegid, geteuid: fixed 16-bit versions
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
 testcases/kernel/syscalls/getegid/compat_16.h |   48 -------------------------
 testcases/kernel/syscalls/getegid/getegid01.c |    3 +-
 testcases/kernel/syscalls/getegid/getegid02.c |   32 +++++++----------
 testcases/kernel/syscalls/geteuid/compat_16.h |   48 -------------------------
 testcases/kernel/syscalls/geteuid/geteuid01.c |    3 +-
 testcases/kernel/syscalls/geteuid/geteuid02.c |   31 ++++++++--------
 testcases/kernel/syscalls/utils/compat_16.h   |   10 +++++
 7 files changed, 40 insertions(+), 135 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/getegid/compat_16.h
 delete mode 100644 testcases/kernel/syscalls/geteuid/compat_16.h

diff --git a/testcases/kernel/syscalls/getegid/compat_16.h b/testcases/kernel/syscalls/getegid/compat_16.h
deleted file mode 100644
index a28289b..0000000
--- a/testcases/kernel/syscalls/getegid/compat_16.h
+++ /dev/null
@@ -1,48 +0,0 @@
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
-#ifndef __GETEGID_COMPAT_16_H__
-#define __GETEGID_COMPAT_16_H__
-
-
-#include "linux_syscall_numbers.h"
-#include "compat_gid.h"
-
-
-#ifdef TST_USE_COMPAT16_SYSCALL
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
-GETEGID(void)
-{
-	return getegid();
-}
-
-#endif
-
-#endif /* __GETEGID_COMPAT_16_H__ */
diff --git a/testcases/kernel/syscalls/getegid/getegid01.c b/testcases/kernel/syscalls/getegid/getegid01.c
index 3b4f17e..5206db7 100644
--- a/testcases/kernel/syscalls/getegid/getegid01.c
+++ b/testcases/kernel/syscalls/getegid/getegid01.c
@@ -114,7 +114,6 @@
 
 #include "test.h"
 #include "usctest.h"
-
 #include "compat_16.h"
 
 void setup();
@@ -141,7 +140,7 @@ int main(int ac, char **av)
 
 		tst_count = 0;
 
-		TEST(GETEGID());
+		TEST(GETEGID(cleanup));
 
 		if (TEST_RETURN == -1) {
 			tst_resm(TFAIL | TTERRNO, "getegid failed");
diff --git a/testcases/kernel/syscalls/getegid/getegid02.c b/testcases/kernel/syscalls/getegid/getegid02.c
index e8b4022..6eebc91 100644
--- a/testcases/kernel/syscalls/getegid/getegid02.c
+++ b/testcases/kernel/syscalls/getegid/getegid02.c
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
-	int euid;
+	uid_t euid;
 	struct passwd *pwent;
 
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
@@ -91,7 +90,7 @@ int main(int ac, char **av)
 		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		TEST(GETEGID());
+		TEST(GETEGID(cleanup));
 
 		if (TEST_RETURN < 0) {
 			tst_brkm(TBROK, cleanup, "This should never happen");
@@ -99,27 +98,22 @@ int main(int ac, char **av)
 
 		if (STD_FUNCTIONAL_TEST) {
 			euid = geteuid();
-
 			pwent = getpwuid(euid);
 
-			if (pwent == NULL) {
+			if (pwent == NULL)
 				tst_brkm(TBROK, cleanup, "geteuid() returned "
 					 "unexpected value %d", euid);
-			} else if (!GID_SIZE_CHECK(pwent->pw_gid)) {
-				tst_brkm(TBROK,
-					 cleanup,
-					 "gid for euid %d is too large for testing getegid16",
-					 euid);
+
+			GID16_CHECK(pwent->pw_gid, getegid, cleanup);
+
+			if (pwent->pw_gid != TEST_RETURN) {
+				tst_resm(TFAIL, "getegid() return value"
+					 " %ld unexpected - expected %d",
+					 TEST_RETURN, pwent->pw_gid);
 			} else {
-				if (pwent->pw_gid != TEST_RETURN) {
-					tst_resm(TFAIL, "getegid() return value"
-						 " %ld unexpected - expected %d",
-						 TEST_RETURN, pwent->pw_gid);
-				} else {
-					tst_resm(TPASS,
-						 "effective group id %ld "
-						 "is correct", TEST_RETURN);
-				}
+				tst_resm(TPASS,
+					 "effective group id %ld "
+					 "is correct", TEST_RETURN);
 			}
 		} else {
 			tst_resm(TPASS, "call succeeded");
diff --git a/testcases/kernel/syscalls/geteuid/compat_16.h b/testcases/kernel/syscalls/geteuid/compat_16.h
deleted file mode 100644
index 9436cd5..0000000
--- a/testcases/kernel/syscalls/geteuid/compat_16.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- *
- *   Copyright (c) Red Hat Inc., 2009
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
-GETEUID(void)
-{
-	return ltp_syscall(__NR_geteuid);
-}
-
-#else
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
diff --git a/testcases/kernel/syscalls/geteuid/geteuid01.c b/testcases/kernel/syscalls/geteuid/geteuid01.c
index 15d9a32..8213625 100644
--- a/testcases/kernel/syscalls/geteuid/geteuid01.c
+++ b/testcases/kernel/syscalls/geteuid/geteuid01.c
@@ -114,7 +114,6 @@
 
 #include "test.h"
 #include "usctest.h"
-
 #include "compat_16.h"
 
 void setup();
@@ -141,7 +140,7 @@ int main(int ac, char **av)
 
 		tst_count = 0;
 
-		TEST(GETEUID());
+		TEST(GETEUID(cleanup));
 
 		if (TEST_RETURN < 0) {
 			tst_resm(TFAIL | TTERRNO, "geteuid failed");
diff --git a/testcases/kernel/syscalls/geteuid/geteuid02.c b/testcases/kernel/syscalls/geteuid/geteuid02.c
index b62fc51..cf97368 100644
--- a/testcases/kernel/syscalls/geteuid/geteuid02.c
+++ b/testcases/kernel/syscalls/geteuid/geteuid02.c
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
@@ -66,30 +68,27 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		TEST(GETEUID());
+		TEST(GETEUID(cleanup));
 
 		if (TEST_RETURN == -1)
 			tst_brkm(TBROK | TTERRNO, cleanup, "geteuid* failed");
 
 		if (STD_FUNCTIONAL_TEST) {
+			uid = geteuid();
+			pwent = getpwuid(uid);
 
-			pwent = getpwuid(TEST_RETURN);
 			if (pwent == NULL)
 				tst_resm(TFAIL | TERRNO, "getpwuid failed");
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
+
+			UID16_CHECK(pwent->pw_uid, geteuid, cleanup);
+			if (pwent->pw_uid != TEST_RETURN)
+				tst_resm(TFAIL, "getpwuid value, %d, "
+					 "does not match geteuid "
+					 "value, %ld", pwent->pw_uid,
+					 TEST_RETURN);
+			else
+				tst_resm(TPASS, "values from geteuid "
+					 "and getpwuid match");
 		} else
 			tst_resm(TPASS, "call succeeded");
 	}
diff --git a/testcases/kernel/syscalls/utils/compat_16.h b/testcases/kernel/syscalls/utils/compat_16.h
index b65a8f9..2fdb6dc 100644
--- a/testcases/kernel/syscalls/utils/compat_16.h
+++ b/testcases/kernel/syscalls/utils/compat_16.h
@@ -93,4 +93,14 @@ GID_T GETGID(void (cleanup)(void))
 {
 	LTP_CREATE_SYSCALL(getgid, cleanup);
 }
+
+UID_T GETEUID(void (cleanup)(void))
+{
+	LTP_CREATE_SYSCALL(geteuid, cleanup);
+}
+
+GID_T GETEGID(void (cleanup)(void))
+{
+	LTP_CREATE_SYSCALL(getegid, cleanup);
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
