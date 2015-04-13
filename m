Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Yhavm-00068J-2A
	for ltp-list@lists.sourceforge.net; Mon, 13 Apr 2015 09:45:26 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Yhavk-0004zm-8D
	for ltp-list@lists.sourceforge.net; Mon, 13 Apr 2015 09:45:26 +0000
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t3D9jHBq005741
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Apr 2015 09:45:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t3D9jHU3009085
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Apr 2015 09:45:17 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t3D9jHgf027332
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Apr 2015 09:45:17 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 13 Apr 2015 12:45:09 +0300
Message-Id: <1428918310-5180-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 1/2] Keep the definition of union semun in one place
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
 include/lapi/semun.h                               |   35 ++++++++++++++++++++
 .../kernel/ipc/ipc_stress/semaphore_test_01.c      |   13 +-------
 .../kernel/ipc/ipc_stress/semaphore_test_02.c      |    7 +---
 .../kernel/ipc/ipc_stress/semaphore_test_03.c      |    7 +---
 testcases/kernel/ipc/ipc_stress/shmem_test_03.c    |    7 +---
 testcases/kernel/ipc/pipeio/pipeio.c               |    7 +---
 testcases/kernel/ipc/semaphore/sem01.c             |    7 +---
 testcases/kernel/ipc/semaphore/sem02.c             |    8 +----
 testcases/kernel/sched/process_stress/process.c    |    8 +---
 testcases/kernel/syscalls/cma/process_vm.h         |    7 +---
 testcases/kernel/syscalls/ipc/lib/ipcsem.h         |    8 +----
 testcases/kernel/syscalls/ipc/semctl/semctl07.c    |    6 ---
 testcases/kernel/syscalls/ipc/semop/semop02.c      |    2 +-
 testcases/kernel/syscalls/sendmsg/sendmsg02.c      |    7 +---
 14 files changed, 52 insertions(+), 77 deletions(-)
 create mode 100644 include/lapi/semun.h

diff --git a/include/lapi/semun.h b/include/lapi/semun.h
new file mode 100644
index 0000000..a2e695a
--- /dev/null
+++ b/include/lapi/semun.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2015 Linux Test Project
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
+ */
+
+#ifndef SEMUN_H__
+#define SEMUN_H__
+
+#if defined(__GNU_LIBRARY__) && !defined(_SEM_SEMUN_UNDEFINED)
+/* union semun is defined by including <sys/sem.h> */
+#else
+/* according to X/OPEN we have to define it ourselves */
+union semun {
+	int val;                /* value for SETVAL */
+	struct semid_ds *buf;   /* buffer for IPC_STAT, IPC_SET */
+	unsigned short *array;  /* array for GETALL, SETALL */
+	/* Linux specific part: */
+	struct seminfo *__buf;  /* buffer for IPC_INFO */
+};
+#endif
+
+#endif /* SEMUN_H__ */
diff --git a/testcases/kernel/ipc/ipc_stress/semaphore_test_01.c b/testcases/kernel/ipc/ipc_stress/semaphore_test_01.c
index 72218ff..7d55481 100644
--- a/testcases/kernel/ipc/ipc_stress/semaphore_test_01.c
+++ b/testcases/kernel/ipc/ipc_stress/semaphore_test_01.c
@@ -72,18 +72,7 @@
 #include <sys/stat.h>
 #endif
 
-#if defined(__GNU_LIBRARY__) && !defined(_SEM_SEMUN_UNDEFINED)
-/* union semun is defined by including <sys/sem.h> */
-#else
-/* according to X/OPEN we have to define it ourselves */
-union semun {
-	int val;		/* value for SETVAL */
-	struct semid_ds *buf;	/* buffer for IPC_STAT, IPC_SET */
-	unsigned short *array;	/* array for GETALL, SETALL */
-	/* Linux specific part: */
-	struct seminfo *__buf;	/* buffer for IPC_INFO */
-};
-#endif
+#include "lapi/semun.h"
 
 /* Defines
  *
diff --git a/testcases/kernel/ipc/ipc_stress/semaphore_test_02.c b/testcases/kernel/ipc/ipc_stress/semaphore_test_02.c
index f733389..fc8d2d9 100644
--- a/testcases/kernel/ipc/ipc_stress/semaphore_test_02.c
+++ b/testcases/kernel/ipc/ipc_stress/semaphore_test_02.c
@@ -77,6 +77,7 @@
 #include <sys/wait.h>
 #include <stdlib.h>
 #include <string.h>
+#include "lapi/semun.h"
 
 /*
  * Defines
@@ -120,11 +121,7 @@ int childpid[MAX_CHILDREN];
 int errors = 0;
 pid_t parent_pid;
 
-union semun {
-	int val;
-	struct semid_ds *buf;
-	unsigned short *array;
-} arg;
+union semun arg;
 
 /*---------------------------------------------------------------------+
 |                               main                                   |
diff --git a/testcases/kernel/ipc/ipc_stress/semaphore_test_03.c b/testcases/kernel/ipc/ipc_stress/semaphore_test_03.c
index 8955e02..d82e217 100644
--- a/testcases/kernel/ipc/ipc_stress/semaphore_test_03.c
+++ b/testcases/kernel/ipc/ipc_stress/semaphore_test_03.c
@@ -71,6 +71,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
+#include "lapi/semun.h"
 
 /*
  * Defines
@@ -136,11 +137,7 @@ pid_t childpid[MAX_CHILDREN];
 pid_t parent_pid;
 pid_t errpid;
 
-union semun {
-	int val;
-	struct semid_ds *buf;
-	unsigned short *array;
-} arg;
+union semun arg;
 
 /*---------------------------------------------------------------------+
 |                               main                                   |
diff --git a/testcases/kernel/ipc/ipc_stress/shmem_test_03.c b/testcases/kernel/ipc/ipc_stress/shmem_test_03.c
index 845d3e6..c1b11fd 100644
--- a/testcases/kernel/ipc/ipc_stress/shmem_test_03.c
+++ b/testcases/kernel/ipc/ipc_stress/shmem_test_03.c
@@ -79,6 +79,7 @@
 #include <sys/signal.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include "lapi/semun.h"
 
 /* Defines
  *
@@ -140,11 +141,7 @@ int semid;			/* semaphore id */
 int num_children = DEFAULT_NUM_CHILDREN;
 int buffer_size = DEFAULT_SHMEM_SIZE;
 
-union semun {
-	int val;
-	struct semid_ds *buf;
-	unsigned short *array;
-} arg;
+union semun arg;
 
 /*---------------------------------------------------------------------+
 |                               main                                   |
diff --git a/testcases/kernel/ipc/pipeio/pipeio.c b/testcases/kernel/ipc/pipeio/pipeio.c
index da6a397..89c6cfb 100644
--- a/testcases/kernel/ipc/pipeio/pipeio.c
+++ b/testcases/kernel/ipc/pipeio/pipeio.c
@@ -53,6 +53,7 @@
 
 #include "test.h"
 #include "safe_macros.h"
+#include "lapi/semun.h"
 
 char *TCID = "pipeio";
 int TST_TOTAL = 1;
@@ -123,11 +124,7 @@ static int write_fd;
 static int empty_read;
 static int sem_id;
 
-static union semun {
-	int val;
-	struct semid_ds *buf;
-	unsigned short int *array;
-} u;
+static union semun u;
 
 int main(int ac, char *av[])
 {
diff --git a/testcases/kernel/ipc/semaphore/sem01.c b/testcases/kernel/ipc/semaphore/sem01.c
index d6fb8fb..5a45238 100644
--- a/testcases/kernel/ipc/semaphore/sem01.c
+++ b/testcases/kernel/ipc/semaphore/sem01.c
@@ -41,12 +41,7 @@
 #include <sys/wait.h>
 #include <sys/ipc.h>
 #include <sys/sem.h>
-
-union semun {
-	int val;
-	struct semid_ds *buf;
-	unsigned short *array;
-};
+#include "lapi/semun.h"
 
 int verbose = 0;
 int loops = 100;
diff --git a/testcases/kernel/ipc/semaphore/sem02.c b/testcases/kernel/ipc/semaphore/sem02.c
index 6d25569..7db142b 100644
--- a/testcases/kernel/ipc/semaphore/sem02.c
+++ b/testcases/kernel/ipc/semaphore/sem02.c
@@ -51,6 +51,7 @@
 #include <pthread.h>
 #include <sys/types.h>
 #include <sys/ipc.h>
+#include "lapi/semun.h"
 
 #define KEY IPC_PRIVATE
 
@@ -67,13 +68,6 @@ int TST_TOTAL = 1;
 struct sembuf Psembuf = { 0, -1, SEM_UNDO };
 struct sembuf Vsembuf = { 0, 1, SEM_UNDO };
 
-union semun {
-	int val;		/* value for SETVAL */
-	struct semid_ds *buf;	/* buffer for IPC_STAT & IPC_SET */
-	unsigned short *array;	/* array for GETALL & SETALL */
-	struct seminfo *ipc_buf;	/* buffer for IPC_INFO */
-};
-
 int sem_id;
 int err_ret;			/* This is used to determine PASS/FAIL status */
 int main(int argc, char **argv)
diff --git a/testcases/kernel/sched/process_stress/process.c b/testcases/kernel/sched/process_stress/process.c
index 8ed9e23..e0a1e38 100644
--- a/testcases/kernel/sched/process_stress/process.c
+++ b/testcases/kernel/sched/process_stress/process.c
@@ -45,6 +45,7 @@
 #include <sys/shm.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include "lapi/semun.h"
 
 /* indexes into environment variable array */
 #define ADBG 0
@@ -103,12 +104,7 @@ typedef struct messagebuf {
 	char mtext[80];		/* message text */
 } Msgbuf;
 
-union semun {			/* to fix problem with 4th arg of semctl in 64 bits MARIOG */
-	int val;
-	struct semid_ds *buf;
-	unsigned short *array;
-} semarg = {
-0};
+union semun semarg;
 
 /* structure of all environment variable used by program */
 struct envstruct {
diff --git a/testcases/kernel/syscalls/cma/process_vm.h b/testcases/kernel/syscalls/cma/process_vm.h
index 5241fa1..7df9aac 100644
--- a/testcases/kernel/syscalls/cma/process_vm.h
+++ b/testcases/kernel/syscalls/cma/process_vm.h
@@ -31,12 +31,7 @@
 #include <sys/syscall.h>
 #include <sys/uio.h>
 #include <unistd.h>
-
-union semun {
-	int val;
-	struct semid_ds *buf;
-	unsigned short int *array;
-};
+#include "lapi/semun.h"
 
 static inline ssize_t test_process_vm_readv(pid_t pid,
 		const struct iovec *lvec, unsigned long liovcnt,
diff --git a/testcases/kernel/syscalls/ipc/lib/ipcsem.h b/testcases/kernel/syscalls/ipc/lib/ipcsem.h
index 9324e69..6a37672 100644
--- a/testcases/kernel/syscalls/ipc/lib/ipcsem.h
+++ b/testcases/kernel/syscalls/ipc/lib/ipcsem.h
@@ -29,6 +29,7 @@
 #include <sys/sem.h>
 
 #include "test.h"
+#include "lapi/semun.h"
 
 void cleanup(void);
 void setup(void);
@@ -46,13 +47,6 @@ key_t semkey;			/* an IPC key generated by ftok() */
 extern key_t semkey;	 	 /* an IPC key generated by ftok() */
 #endif
 
-union semun {
-	int val;			/* value for SETVAL */
-	struct semid_ds *buf;		/* buffer for IPC_STAT & IPC_SET */
-	unsigned short *array;		/* array for GETALL & SETALL */
-	struct seminfo *ipc_buf;	/* buffer for IPC_INFO */
-};
-
 void rm_sema(int sem_id);
 
 int getipckey();
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl07.c b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
index f51099b..3cc1eff 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl07.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
@@ -62,12 +62,6 @@ int main(int argc, char *argv[])
 	int status;
 	struct semid_ds buf_ds;
 
-	union semun {
-		int val;
-		struct semid_ds *buf;
-		short *array;
-	};
-
 	union semun arg;
 
 	setup();
diff --git a/testcases/kernel/syscalls/ipc/semop/semop02.c b/testcases/kernel/syscalls/ipc/semop/semop02.c
index 6d3b3ec..cf6d1ab 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop02.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop02.c
@@ -124,7 +124,7 @@ void setup(void)
 			 "couldn't create semaphore in setup");
 	}
 
-	arr.ipc_buf = &ipc_buf;
+	arr.__buf = &ipc_buf;
 	if (semctl(sem_id_1, 0, IPC_INFO, arr) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "semctl() IPC_INFO failed");
 
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg02.c b/testcases/kernel/syscalls/sendmsg/sendmsg02.c
index 06f8163..bc71e9d 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg02.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg02.c
@@ -44,12 +44,7 @@
 #include "config.h"
 #include "test.h"
 #include "safe_macros.h"
-
-union semun {
-	int val;
-	struct semid_ds *buf;
-	unsigned short int *array;
-};
+#include "lapi/semun.h"
 
 char *TCID = "sendmsg02";
 
-- 
1.7.1


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
