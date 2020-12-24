From: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Date: Thu, 24 Dec 2020 04:58:14 -0500
Subject: [LTP] [PATCH v2 1/3] lapi/sem.h: Add SEM_STAT_ANY
Message-ID: <1608803896-17634-1-git-send-email-zhufy.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Rename semun.h to sem.h and apply it
2) Add SEM_STAT_ANY

Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 include/ipcsem.h                                |  2 +-
 include/lapi/sem.h                              | 28 +++++++++++++++++++++++++
 include/lapi/semun.h                            | 22 -------------------
 testcases/kernel/containers/sysvipc/sem_comm.c  |  3 +--
 testcases/kernel/ipc/pipeio/pipeio.c            |  3 +--
 testcases/kernel/ipc/semaphore/sem01.c          |  3 +--
 testcases/kernel/ipc/semaphore/sem02.c          |  3 +--
 testcases/kernel/sched/process_stress/process.c |  3 +--
 testcases/kernel/syscalls/ipc/semctl/semctl08.c |  2 +-
 testcases/kernel/syscalls/ipc/semop/semop01.c   |  3 +--
 testcases/kernel/syscalls/ipc/semop/semop02.c   |  3 +--
 testcases/kernel/syscalls/ipc/semop/semop03.c   |  3 +--
 testcases/kernel/syscalls/sendmsg/sendmsg02.c   |  3 +--
 13 files changed, 39 insertions(+), 42 deletions(-)
 create mode 100644 include/lapi/sem.h
 delete mode 100644 include/lapi/semun.h

diff --git a/include/ipcsem.h b/include/ipcsem.h
index 6a37672..09a0b3c 100644
--- a/include/ipcsem.h
+++ b/include/ipcsem.h
@@ -29,7 +29,7 @@
 #include <sys/sem.h>
 
 #include "test.h"
-#include "lapi/semun.h"
+#include "lapi/sem.h"
 
 void cleanup(void);
 void setup(void);
diff --git a/include/lapi/sem.h b/include/lapi/sem.h
new file mode 100644
index 0000000..7cef3d5
--- /dev/null
+++ b/include/lapi/sem.h
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2015 Linux Test Project
+ */
+
+#include <sys/sem.h>
+
+#ifndef LAPI_SEM_H
+#define LAPI_SEM_H
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
+#ifndef SEM_STAT_ANY
+# define SEM_STAT_ANY 20
+#endif
+
+#endif /* LAPI_SEM_H */
diff --git a/include/lapi/semun.h b/include/lapi/semun.h
deleted file mode 100644
index 1a9dc98..0000000
--- a/include/lapi/semun.h
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2015 Linux Test Project
- */
-
-#ifndef SEMUN_H__
-#define SEMUN_H__
-
-#if defined(__GNU_LIBRARY__) && !defined(_SEM_SEMUN_UNDEFINED)
-/* union semun is defined by including <sys/sem.h> */
-#else
-/* according to X/OPEN we have to define it ourselves */
-union semun {
-	int val;                /* value for SETVAL */
-	struct semid_ds *buf;   /* buffer for IPC_STAT, IPC_SET */
-	unsigned short *array;  /* array for GETALL, SETALL */
-	/* Linux specific part: */
-	struct seminfo *__buf;  /* buffer for IPC_INFO */
-};
-#endif
-
-#endif /* SEMUN_H__ */
diff --git a/testcases/kernel/containers/sysvipc/sem_comm.c b/testcases/kernel/containers/sysvipc/sem_comm.c
index 09cc163..a2c354a 100644
--- a/testcases/kernel/containers/sysvipc/sem_comm.c
+++ b/testcases/kernel/containers/sysvipc/sem_comm.c
@@ -27,7 +27,6 @@
 
 #define _GNU_SOURCE
 #include <sys/ipc.h>
-#include <sys/sem.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <stdio.h>
@@ -35,7 +34,7 @@
 #include "ipcns_helper.h"
 #include "test.h"
 #include "safe_macros.h"
-#include "lapi/semun.h"
+#include "lapi/sem.h"
 
 #define TESTKEY 124426L
 char *TCID	= "sem_comm";
diff --git a/testcases/kernel/ipc/pipeio/pipeio.c b/testcases/kernel/ipc/pipeio/pipeio.c
index b9421cb..ab5c2cf 100644
--- a/testcases/kernel/ipc/pipeio/pipeio.c
+++ b/testcases/kernel/ipc/pipeio/pipeio.c
@@ -47,13 +47,12 @@
 #include <string.h>
 #include <signal.h>
 #include <sys/stat.h>
-#include <sys/sem.h>
 
 #include "tlibio.h"
 
 #include "test.h"
 #include "safe_macros.h"
-#include "lapi/semun.h"
+#include "lapi/sem.h"
 
 char *TCID = "pipeio";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/ipc/semaphore/sem01.c b/testcases/kernel/ipc/semaphore/sem01.c
index 5a45238..582624d 100644
--- a/testcases/kernel/ipc/semaphore/sem01.c
+++ b/testcases/kernel/ipc/semaphore/sem01.c
@@ -40,8 +40,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/ipc.h>
-#include <sys/sem.h>
-#include "lapi/semun.h"
+#include "lapi/sem.h"
 
 int verbose = 0;
 int loops = 100;
diff --git a/testcases/kernel/ipc/semaphore/sem02.c b/testcases/kernel/ipc/semaphore/sem02.c
index 81e77d6..34b714b 100644
--- a/testcases/kernel/ipc/semaphore/sem02.c
+++ b/testcases/kernel/ipc/semaphore/sem02.c
@@ -45,12 +45,11 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include <sys/sem.h>
 #include <errno.h>
 #include <pthread.h>
 #include <sys/types.h>
 #include <sys/ipc.h>
-#include "lapi/semun.h"
+#include "lapi/sem.h"
 #include "test.h"
 
 #define KEY IPC_PRIVATE
diff --git a/testcases/kernel/sched/process_stress/process.c b/testcases/kernel/sched/process_stress/process.c
index f23dcbb..a5ff809 100644
--- a/testcases/kernel/sched/process_stress/process.c
+++ b/testcases/kernel/sched/process_stress/process.c
@@ -40,11 +40,10 @@
 #include <sys/msg.h>
 #include <sys/resource.h>
 #include <sys/select.h>
-#include <sys/sem.h>
 #include <sys/shm.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include "lapi/semun.h"
+#include "lapi/sem.h"
 
 /* indexes into environment variable array */
 #define ADBG 0
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl08.c b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
index 40c2e17..1878bd4 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl08.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
@@ -6,7 +6,7 @@
  * Cross verify the _high fields being set to 0 by the kernel.
  */
 #include "lapi/sembuf.h"
-#include "lapi/semun.h"
+#include "lapi/sem.h"
 #include "tst_test.h"
 #include "libnewipc.h"
 
diff --git a/testcases/kernel/syscalls/ipc/semop/semop01.c b/testcases/kernel/syscalls/ipc/semop/semop01.c
index b20eef4..2072635 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop01.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop01.c
@@ -8,10 +8,9 @@
  */
 
 #include <stdlib.h>
-#include <sys/sem.h>
 #include "tst_test.h"
 #include "libnewipc.h"
-#include "lapi/semun.h"
+#include "lapi/sem.h"
 #include "semop.h"
 
 #define NSEMS 4
diff --git a/testcases/kernel/syscalls/ipc/semop/semop02.c b/testcases/kernel/syscalls/ipc/semop/semop02.c
index 2c3ec2c..d8181db 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop02.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop02.c
@@ -22,10 +22,9 @@
 #define _GNU_SOURCE
 #include <pwd.h>
 #include <sys/ipc.h>
-#include <sys/sem.h>
 #include "tst_test.h"
 #include "libnewipc.h"
-#include "lapi/semun.h"
+#include "lapi/sem.h"
 #include "semop.h"
 
 static int valid_sem_id = -1;
diff --git a/testcases/kernel/syscalls/ipc/semop/semop03.c b/testcases/kernel/syscalls/ipc/semop/semop03.c
index 3a79ed3..636b715 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop03.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop03.c
@@ -11,10 +11,9 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include <sys/sem.h>
 #include "tst_test.h"
 #include "libnewipc.h"
-#include "lapi/semun.h"
+#include "lapi/sem.h"
 #include "semop.h"
 
 static key_t semkey;
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg02.c b/testcases/kernel/syscalls/sendmsg/sendmsg02.c
index aa3c88d..f72e9db 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg02.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg02.c
@@ -34,7 +34,6 @@
 #define _GNU_SOURCE
 #include <sys/ipc.h>
 #include <sys/stat.h>
-#include <sys/sem.h>
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/un.h>
@@ -45,7 +44,7 @@
 #include "config.h"
 #include "test.h"
 #include "safe_macros.h"
-#include "lapi/semun.h"
+#include "lapi/sem.h"
 
 char *TCID = "sendmsg02";
 
-- 
1.8.3.1



