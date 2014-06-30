Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1X1Z8a-0002kJ-Le
	for ltp-list@lists.sourceforge.net; Mon, 30 Jun 2014 10:48:40 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X1Z8Y-0006Ui-Vd
	for ltp-list@lists.sourceforge.net; Mon, 30 Jun 2014 10:48:40 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s5UAmWbx001709
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Jun 2014 10:48:33 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s5UAmWpc024952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Jun 2014 10:48:32 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s5UAmWkM013392
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Jun 2014 10:48:32 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 30 Jun 2014 14:48:23 +0400
Message-Id: <1404125304-28650-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1404125304-28650-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1404125304-28650-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 2/3] Implementation of tst_get_unused_pid()
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

There are many testcases which require an unused pid value.

tst_get_unused_pid() is the function to address this problem.

I also removed tst_get_max_pids() because it's used only in one place (tst_get_free_pids())
and can be subsituted with
  SAFE_FILE_SCANF(cleanup_fn, PID_MAX_PATH, "%d", &pid);

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/test.h                                  |    8 ++--
 lib/tst_pid.c                                   |   46 ++++++-----------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl11.c |    2 +-
 3 files changed, 17 insertions(+), 39 deletions(-)

diff --git a/include/test.h b/include/test.h
index 909dbdb..011866d 100644
--- a/include/test.h
+++ b/include/test.h
@@ -378,17 +378,17 @@ int tst_fs_fill_subdirs(void (*cleanup) (void), const char *dir);
 /*
  * lib/tst_pid.c
  *
- * Returns max pid count obtained from reading /proc/sys/kernel/pid_max
+ * Get a pid value not used by the OS
  */
-int tst_get_max_pids(void);
+pid_t tst_get_unused_pid(void (*cleanup_fn) (void));
 
 /*
  * lib/tst_pid.c
  *
- * Returns number of free pids by substarction the number of pid
+ * Returns number of free pids by substarction of the number of pids
  * currently used ('ps -eT') from max_pids
  */
-int tst_get_free_pids(void);
+int tst_get_free_pids(void (*cleanup_fn) (void));
 
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
diff --git a/lib/tst_pid.c b/lib/tst_pid.c
index 2485501..95ac456 100644
--- a/lib/tst_pid.c
+++ b/lib/tst_pid.c
@@ -1,6 +1,7 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2009
+ *   Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -17,47 +18,24 @@
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
 
-int tst_get_max_pids(void)
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
 
-int tst_get_free_pids(void)
+int tst_get_free_pids(void (*cleanup_fn) (void))
 {
 	FILE *f;
 	int rc, used_pids, max_pids;
@@ -76,10 +54,10 @@ int tst_get_free_pids(void)
 		return -1;
 	}
 
-	max_pids = tst_get_max_pids();
-
-	if (max_pids < 0)
-		return -1;
+	SAFE_FILE_SCANF(cleanup_fn, PID_MAX_PATH, "%d", &max_pids);
 
+	/* max_pids contains the maximum PID + 1,
+	 * used_pids contains used PIDs + 1,
+	 * so this additional '1' is eliminated by the substraction */
 	return max_pids - used_pids;
 }
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
index 8373414..cffabf5 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
@@ -474,7 +474,7 @@ void setup(void)
 
 	tst_resm(TINFO, "Found %d available message queues", MSGMNI);
 
-	free_pids = tst_get_free_pids();
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
