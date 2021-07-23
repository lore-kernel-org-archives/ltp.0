From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Fri, 23 Jul 2021 18:13:46 +0800
Subject: [LTP] [PATCH] syscalls/msgget*: Add docparse formatting
Message-ID: <1627035226-2220-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Additionally, for msgget04.c and msgget05.c, do some adjustements in description.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/ipc/msgget/msgget01.c      |  7 ++++---
 .../kernel/syscalls/ipc/msgget/msgget02.c      |  7 +++++--
 .../kernel/syscalls/ipc/msgget/msgget03.c      |  9 +++++----
 .../kernel/syscalls/ipc/msgget/msgget04.c      | 18 +++++++++++-------
 .../kernel/syscalls/ipc/msgget/msgget05.c      | 14 ++++++++------
 5 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget01.c b/testcases/kernel/syscalls/ipc/msgget/msgget01.c
index 5b7c6e3af..2ab34ff9d 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget01.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget01.c
@@ -3,9 +3,10 @@
  * Copyright (c) International Business Machines Corp., 2001
  */
 
-/*
- * DESCRIPTION
- * create a message queue, write a message to it and
+/*\
+ * [Description]
+ *
+ * Create a message queue, write a message to it and
  * read it back.
  */
 
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget02.c b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
index efd2636ca..ce59a8fb5 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget02.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
@@ -3,8 +3,11 @@
  * Copyright (c) International Business Machines Corp., 2001
  */
 
-/*
- * DESCRIPTION
+/*\
+ * [Description]
+ *
+ * Test for EEXIST, ENOENT, EACCES errors.
+ *
  * 1) msgget(2) fails if a message queue exists for key and msgflg
  *    specified both IPC_CREAT and IPC_EXCL.
  * 2) msgget(2) fails if no message queue exists for key and msgflg
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
index 76cf82cd3..ab5714cdc 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
@@ -3,11 +3,12 @@
  * Copyright (c) International Business Machines Corp., 2001
  */
 
-/*
- * DESCRIPTION
- * test for an ENOSPC error by using up all available
- * message queues.
+/*\
+ * [Description]
+ *
+ * Test for ENOSPC error.
  *
+ * ENOSPC -  All possible message queues have been taken (MSGMNI)
  */
 
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget04.c b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
index 72cd4497b..a01ecea85 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget04.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
@@ -1,14 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
- * Author: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
  *
- * It is a basic test about msg_next_id.
- * msg_next_id specifies desired id for next allocated IPC message. By default
- * they are equal to -1, which means generic allocation logic. Possible values
- * to set are in range {0..INT_MAX}.
- * Toggle with non-default value will be set back to -1 by kernel after
- * successful IPC object allocation.
+ * It is a basic test for msg_next_id.
+ * msg_next_id specifies desired id for next allocated IPC message. By
+ * default it's equal to -1, which means generic allocation logic.
+ * Possible values to set are in range {0..INT_MAX}.
+ * The value will be set back to -1 by kernel after successful IPC object
+ * allocation.
  */
 
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget05.c b/testcases/kernel/syscalls/ipc/msgget/msgget05.c
index d6177bbed..817c8486e 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget05.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget05.c
@@ -1,12 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
- * Author: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
  *
- * It is a basic test about msg_next_id.
- * When the message queue identifier that msg_next_id stored has existed,
+ * It is a basic test for msg_next_id.
+ * When the message queue identifier that msg_next_id stored is already in use,
  * call msgget with different key just use another unused value in range
- * [0,INT_MAX]. kernel doesn't guarantee the desired id.
+ * [0,INT_MAX]. Kernel doesn't guarantee the desired id.
  */
 
 #include <errno.h>
@@ -45,8 +49,6 @@ static void setup(void)
 	pid = getpid();
 	SAFE_FILE_PRINTF(NEXT_ID_PATH, "%d", pid);
 	queue_id[0] = SAFE_MSGGET(msgkey[0], IPC_CREAT | MSG_RW);
-	tst_res(TINFO, "Test msg_next_id effects on msgget(different key) "
-		"when this message queue identifier has existed");
 }
 
 static void cleanup(void)
-- 
2.23.0

