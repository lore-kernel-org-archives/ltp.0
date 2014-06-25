Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Wzk0Y-00083u-C7
	for ltp-list@lists.sourceforge.net; Wed, 25 Jun 2014 10:00:50 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wzk0W-00042S-IK
	for ltp-list@lists.sourceforge.net; Wed, 25 Jun 2014 10:00:50 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s5PA0gdr029886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Jun 2014 10:00:42 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s5PA0flC017071
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Jun 2014 10:00:42 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s5PA0fka003655
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Jun 2014 10:00:41 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 25 Jun 2014 14:00:35 +0400
Message-Id: <1403690435-18626-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [RFC PATCH] tst_get_unused_pid and
	system_specific_process_info
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

Hi!

1. We remove get_max_pids(), because it's used only in one place (get_free_pids())
   and can be subsituted with
   SAFE_FILE_SCANF(cleanup_fn, PID_MAX_PATH, "%d", &pid);

2. We rename get_free_pids() to tst_get_free_pids() for consistency. And changing a bit its
   declaration to use SAFE_FILE_SCANF().

3. system_specific_process_info.h is used only in one place - msgctl11.
   I think it's not a problem if I move its content to test.h. For consistency.

4. And add tst_get_unused_pid() to system_specific_process_info.c. To not
   create a new source file. And this funcion looks logically coupled with tst_get_free_pids().

I'm going to present pp. 1-3 in one patch, and p. 4 - in a separate patch.

What do you think about the general idea?

Thanks.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/system_specific_process_info.h          |   29 -------------
 include/test.h                                  |   15 +++++++
 lib/system_specific_process_info.c              |   49 ++++++----------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl11.c |    3 +-
 4 files changed, 30 insertions(+), 66 deletions(-)
 delete mode 100644 include/system_specific_process_info.h

diff --git a/include/system_specific_process_info.h b/include/system_specific_process_info.h
deleted file mode 100644
index ba8cc9d..0000000
--- a/include/system_specific_process_info.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2009
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
-#ifndef _SYS_SPECIFIC_PROCESS_INFO_H_
-#define _SYS_SPECIFIC_PROCESS_INFO_H_
-
-/* Returns max pid count obtained from reading /proc/sys/kernel/pid_max */
-int get_max_pids(void);
-
-/* Returns number of free pids */
-int get_free_pids(void);
-
-#endif
diff --git a/include/test.h b/include/test.h
index 97ce0f0..bf6deed 100644
--- a/include/test.h
+++ b/include/test.h
@@ -390,6 +390,21 @@ int tst_fs_fill_hardlinks(void (*cleanup) (void), const char *dir);
  */
 int tst_fs_fill_subdirs(void (*cleanup) (void), const char *dir);
 
+/*
+ * lib/system_specific_process_info.c
+ *
+ * Get a pid value not used by the OS
+ */
+pid_t tst_get_unused_pid(void (*cleanup_fn) (void));
+
+/*
+ * lib/system_specific_process_info.c
+ *
+ * Return a number of free pids by substracting the number
+ * of pid currently used ('ps -eT') from max_pids
+ */
+pid_t tst_get_free_pids(void (*cleanup_fn) (void));
+
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
 #elif  TST_USE_NEWER64_SYSCALL
diff --git a/lib/system_specific_process_info.c b/lib/system_specific_process_info.c
index bc47d49..105d806 100644
--- a/lib/system_specific_process_info.c
+++ b/lib/system_specific_process_info.c
@@ -1,6 +1,7 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2009
+ *   Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -17,50 +18,28 @@
  *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
-/*
- *   DESCRIPTION
- *	get_max_pids(): Return the maximum number of pids for this system by
- *			reading /proc/sys/kernel/pid_max
- *
- *	get_free_pids(): Return number of free pids by subtracting the number
- *			 of pids currently used ('ps -eT') from max_pids
- */
-
 #include <fcntl.h>
 #include <limits.h>
 #include <sys/types.h>
 #include "test.h"
+#include "safe_file_ops.h"
 
-#define BUFSIZE 512
+#define PID_MAX_PATH "/proc/sys/kernel/pid_max"
 
-int get_max_pids(void)
+pid_t tst_get_unused_pid(void (*cleanup_fn) (void))
 {
-#ifdef __linux__
+	pid_t pid;
 
-	FILE *f;
-	char buf[BUFSIZE];
+	SAFE_FILE_SCANF(cleanup_fn, PID_MAX_PATH, "%d", &pid);
 
-	f = fopen("/proc/sys/kernel/pid_max", "r");
-	if (!f) {
-		tst_resm(TBROK, "Could not open /proc/sys/kernel/pid_max");
-		return -1;
-	}
-	if (!fgets(buf, BUFSIZE, f)) {
-		fclose(f);
-		tst_resm(TBROK, "Could not read /proc/sys/kernel/pid_max");
-		return -1;
-	}
-	fclose(f);
-	return atoi(buf);
-#else
-	return SHRT_MAX;
-#endif
+	return pid;
 }
 
-int get_free_pids(void)
+pid_t tst_get_free_pids(void (*cleanup_fn) (void))
 {
 	FILE *f;
-	int rc, used_pids, max_pids;
+	int rc;
+	pid_t used_pids, max_pids;
 
 	f = popen("ps -eT | wc -l", "r");
 	if (!f) {
@@ -76,10 +55,10 @@ int get_free_pids(void)
 		return -1;
 	}
 
-	max_pids = get_max_pids();
-
-	if (max_pids < 0)
-		return -1;
+	SAFE_FILE_SCANF(cleanup_fn, PID_MAX_PATH, "%d", &max_pids);
 
+	/* max_pids contains the maximum PID + 1,
+	 * used_pids contains used PIDs + 1,
+	 * so this additional '1' is eliminated by substraction*/
 	return max_pids - used_pids;
 }
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
index 75d8bde..cffabf5 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
@@ -40,7 +40,6 @@
 #include "usctest.h"
 #include "ipcmsg.h"
 #include "../lib/libmsgctl.h"
-#include "system_specific_process_info.h"
 
 char *TCID = "msgctl11";
 int TST_TOTAL = 1;
@@ -475,7 +474,7 @@ void setup(void)
 
 	tst_resm(TINFO, "Found %d available message queues", MSGMNI);
 
-	free_pids = get_free_pids();
+	free_pids = tst_get_free_pids(cleanup);
 	if (free_pids < 0) {
 		tst_brkm(TBROK, cleanup, "Can't obtain free_pid count");
 	} else if (!free_pids) {
-- 
1.7.1


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
