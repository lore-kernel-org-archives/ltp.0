Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1X1Z8a-0007JU-Lh
	for ltp-list@lists.sourceforge.net; Mon, 30 Jun 2014 10:48:40 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X1Z8Y-0002B1-US
	for ltp-list@lists.sourceforge.net; Mon, 30 Jun 2014 10:48:40 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s5UAmWx8001683
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Jun 2014 10:48:33 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s5UAmVr7023790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Jun 2014 10:48:32 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s5UAmVxc023775
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Jun 2014 10:48:31 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 30 Jun 2014 14:48:22 +0400
Message-Id: <1404125304-28650-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1404125304-28650-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1404125304-28650-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 1/3] system_specific_process_info changes
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

For consistency:
* removed the content of system_specific_process_info.h to test.h and
  renamed its functions to start with 'tst_'

* renamed system_specific_process_info.c to tst_pid.c

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/system_specific_process_info.h          |   29 --------
 include/test.h                                  |   15 ++++
 lib/system_specific_process_info.c              |   85 -----------------------
 lib/tst_pid.c                                   |   85 +++++++++++++++++++++++
 testcases/kernel/syscalls/ipc/msgctl/msgctl11.c |    3 +-
 5 files changed, 101 insertions(+), 116 deletions(-)
 delete mode 100644 include/system_specific_process_info.h
 delete mode 100644 lib/system_specific_process_info.c
 create mode 100644 lib/tst_pid.c

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
index a4a23e3..909dbdb 100644
--- a/include/test.h
+++ b/include/test.h
@@ -375,6 +375,21 @@ int tst_fs_fill_hardlinks(void (*cleanup) (void), const char *dir);
  */
 int tst_fs_fill_subdirs(void (*cleanup) (void), const char *dir);
 
+/*
+ * lib/tst_pid.c
+ *
+ * Returns max pid count obtained from reading /proc/sys/kernel/pid_max
+ */
+int tst_get_max_pids(void);
+
+/*
+ * lib/tst_pid.c
+ *
+ * Returns number of free pids by substarction the number of pid
+ * currently used ('ps -eT') from max_pids
+ */
+int tst_get_free_pids(void);
+
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
 #elif  TST_USE_NEWER64_SYSCALL
diff --git a/lib/system_specific_process_info.c b/lib/system_specific_process_info.c
deleted file mode 100644
index bc47d49..0000000
--- a/lib/system_specific_process_info.c
+++ /dev/null
@@ -1,85 +0,0 @@
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
-/*
- *   DESCRIPTION
- *	get_max_pids(): Return the maximum number of pids for this system by
- *			reading /proc/sys/kernel/pid_max
- *
- *	get_free_pids(): Return number of free pids by subtracting the number
- *			 of pids currently used ('ps -eT') from max_pids
- */
-
-#include <fcntl.h>
-#include <limits.h>
-#include <sys/types.h>
-#include "test.h"
-
-#define BUFSIZE 512
-
-int get_max_pids(void)
-{
-#ifdef __linux__
-
-	FILE *f;
-	char buf[BUFSIZE];
-
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
-}
-
-int get_free_pids(void)
-{
-	FILE *f;
-	int rc, used_pids, max_pids;
-
-	f = popen("ps -eT | wc -l", "r");
-	if (!f) {
-		tst_resm(TBROK, "Could not run 'ps' to calculate used " "pids");
-		return -1;
-	}
-	rc = fscanf(f, "%i", &used_pids);
-	pclose(f);
-
-	if (rc != 1 || used_pids < 0) {
-		tst_resm(TBROK, "Could not read output of 'ps' to "
-			 "calculate used pids");
-		return -1;
-	}
-
-	max_pids = get_max_pids();
-
-	if (max_pids < 0)
-		return -1;
-
-	return max_pids - used_pids;
-}
diff --git a/lib/tst_pid.c b/lib/tst_pid.c
new file mode 100644
index 0000000..2485501
--- /dev/null
+++ b/lib/tst_pid.c
@@ -0,0 +1,85 @@
+/*
+ *
+ *   Copyright (c) International Business Machines  Corp., 2009
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
+ *   DESCRIPTION
+ *	get_max_pids(): Return the maximum number of pids for this system by
+ *			reading /proc/sys/kernel/pid_max
+ *
+ *	get_free_pids(): Return number of free pids by subtracting the number
+ *			 of pids currently used ('ps -eT') from max_pids
+ */
+
+#include <fcntl.h>
+#include <limits.h>
+#include <sys/types.h>
+#include "test.h"
+
+#define BUFSIZE 512
+
+int tst_get_max_pids(void)
+{
+#ifdef __linux__
+
+	FILE *f;
+	char buf[BUFSIZE];
+
+	f = fopen("/proc/sys/kernel/pid_max", "r");
+	if (!f) {
+		tst_resm(TBROK, "Could not open /proc/sys/kernel/pid_max");
+		return -1;
+	}
+	if (!fgets(buf, BUFSIZE, f)) {
+		fclose(f);
+		tst_resm(TBROK, "Could not read /proc/sys/kernel/pid_max");
+		return -1;
+	}
+	fclose(f);
+	return atoi(buf);
+#else
+	return SHRT_MAX;
+#endif
+}
+
+int tst_get_free_pids(void)
+{
+	FILE *f;
+	int rc, used_pids, max_pids;
+
+	f = popen("ps -eT | wc -l", "r");
+	if (!f) {
+		tst_resm(TBROK, "Could not run 'ps' to calculate used " "pids");
+		return -1;
+	}
+	rc = fscanf(f, "%i", &used_pids);
+	pclose(f);
+
+	if (rc != 1 || used_pids < 0) {
+		tst_resm(TBROK, "Could not read output of 'ps' to "
+			 "calculate used pids");
+		return -1;
+	}
+
+	max_pids = tst_get_max_pids();
+
+	if (max_pids < 0)
+		return -1;
+
+	return max_pids - used_pids;
+}
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
index 75d8bde..8373414 100644
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
+	free_pids = tst_get_free_pids();
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
