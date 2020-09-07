From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  7 Sep 2020 17:01:56 +0200
Subject: [LTP] [PATCH v2 09/10] syscalls/ipc: Add shmctl IPC_SET test
In-Reply-To: <20200907150157.23886-1-chrubis@suse.cz>
References: <20200907150157.23886-1-chrubis@suse.cz>
Message-ID: <20200907150157.23886-10-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                              |   1 +
 runtest/syscalls-ipc                          |   1 +
 .../kernel/syscalls/ipc/shmctl/.gitignore     |   1 +
 .../kernel/syscalls/ipc/shmctl/shmctl07.c     |   6 +-
 .../kernel/syscalls/ipc/shmctl/shmctl08.c     | 103 ++++++++++++++++++
 5 files changed, 110 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ipc/shmctl/shmctl08.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 448b893ea..9f1c9ee0c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1360,6 +1360,7 @@ shmctl04 shmctl04
 shmctl05 shmctl05
 shmctl06 shmctl06
 shmctl07 shmctl07
+shmctl08 shmctl08
 
 shmdt01 shmdt01
 shmdt02 shmdt02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index 5b50820d2..4eb71e3cb 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -56,6 +56,7 @@ shmctl04 shmctl04
 shmctl05 shmctl05
 shmctl06 shmctl06
 shmctl07 shmctl07
+shmctl08 shmctl08
 
 shmdt01 shmdt01
 shmdt02 shmdt02
diff --git a/testcases/kernel/syscalls/ipc/shmctl/.gitignore b/testcases/kernel/syscalls/ipc/shmctl/.gitignore
index 4322d03b7..f3f88ee17 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/.gitignore
+++ b/testcases/kernel/syscalls/ipc/shmctl/.gitignore
@@ -5,3 +5,4 @@
 /shmctl05
 /shmctl06
 /shmctl07
+/shmctl08
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
index 409203db7..39b9ad78a 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
@@ -42,10 +42,12 @@ static void verify_shmlock(void)
 	else
 		tst_res(TPASS, "shmctl(%i, SHM_UNLOCK, NULL)", shm_id);
 
+	SAFE_SHMCTL(shm_id, IPC_STAT, &ds);
+
 	if (ds.shm_perm.mode & SHM_LOCKED)
-		tst_res(TPASS, "SHM_LOCKED bit is off in shm_perm.mode");
-	else
 		tst_res(TFAIL, "SMH_LOCKED bit is on in shm_perm.mode");
+	else
+		tst_res(TPASS, "SHM_LOCKED bit is off in shm_perm.mode");
 }
 
 static void setup(void)
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
new file mode 100644
index 000000000..157ced608
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Cyril Hrubis <chrubis@suse.cz>
+ */
+/*
+ * Test for a SHM_SET.
+ *
+ * The test clears the group and others bits from the shm_perm.mode and checks
+ * the result as well as if the ctime was updated correctly.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
+
+#define SHM_SIZE 2048
+
+static int shm_id = -1;
+
+static int test_ipc_set(struct shmid_ds *ds)
+{
+	TEST(shmctl(shm_id, IPC_SET, ds));
+
+	if (TST_RET != 0) {
+		tst_res(TFAIL, "shmctl(%i, IPC_SET, ...)", shm_id);
+		return 1;
+	}
+
+	tst_res(TPASS, "shmctl(%i, IPC_SET, {shm_perm.mode=%04o})",
+		shm_id, ds->shm_perm.mode);
+	return 0;
+}
+
+static void check_mode(struct shmid_ds *ds, short exp_mode)
+{
+	if (ds->shm_perm.mode == exp_mode) {
+		tst_res(TPASS, "shm_perm.mode=%04o", exp_mode);
+		return;
+	}
+
+	tst_res(TFAIL, "shm_perm.mode=%04o, expected %i",
+	        ds->shm_perm.mode, exp_mode);
+}
+
+static void verify_shmset(void)
+{
+	struct shmid_ds ds;
+	unsigned short old_mode;
+	time_t old_ctime;
+
+	SAFE_SHMCTL(shm_id, IPC_STAT, &ds);
+
+	old_mode = ds.shm_perm.mode;
+	old_ctime = ds.shm_ctime;
+
+	check_mode(&ds, 0666);
+
+	sleep(1);
+
+	ds.shm_perm.mode &= ~0066;
+
+	if (test_ipc_set(&ds))
+		return;
+
+	memset(&ds, 0, sizeof(ds));
+	SAFE_SHMCTL(shm_id, IPC_STAT, &ds);
+	check_mode(&ds, old_mode & ~0066);
+
+	if (ds.shm_ctime <= old_ctime || ds.shm_ctime > old_ctime + 10) {
+		tst_res(TFAIL, "shm_ctime not updated old %li new %li",
+		        (long)old_ctime, (long)ds.shm_ctime);
+	} else {
+		tst_res(TPASS, "shm_ctime updated correctly diff=%li",
+		        (long)(ds.shm_ctime - old_ctime));
+	}
+
+	ds.shm_perm.mode = old_mode;
+	if (test_ipc_set(&ds))
+		return;
+
+	memset(&ds, 0, sizeof(ds));
+	SAFE_SHMCTL(shm_id, IPC_STAT, &ds);
+	check_mode(&ds, old_mode & MODE_MASK);
+}
+
+static void setup(void)
+{
+	shm_id = SAFE_SHMGET(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | 0666);
+}
+
+static void cleanup(void)
+{
+	if (shm_id >= 0)
+		SAFE_SHMCTL(shm_id, IPC_RMID, NULL);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_shmset,
+};
-- 
2.26.2

