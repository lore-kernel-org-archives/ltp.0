From: Li Wang <liwang@redhat.com>
Date: Fri, 21 Jun 2019 18:26:28 +0800
Subject: [LTP] [PATCH v2 3/3] pkey: add pkey02 test
Message-ID: <20190621102628.4800-4-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/pkeys/.gitignore |   1 +
 testcases/kernel/syscalls/pkeys/pkey02.c   | 134 +++++++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pkeys/pkey02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6ea991f12..fddf071f9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -722,6 +722,7 @@ mprotect03 mprotect03
 mprotect04 mprotect04
 
 pkey01 pkey01
+pkey02 pkey02
 
 mq_notify01 mq_notify01
 mq_notify02 mq_notify02
diff --git a/testcases/kernel/syscalls/pkeys/.gitignore b/testcases/kernel/syscalls/pkeys/.gitignore
index 6fd5addb8..2f9ea0a1f 100644
--- a/testcases/kernel/syscalls/pkeys/.gitignore
+++ b/testcases/kernel/syscalls/pkeys/.gitignore
@@ -1 +1,2 @@
 /pkey01
+/pkey02
diff --git a/testcases/kernel/syscalls/pkeys/pkey02.c b/testcases/kernel/syscalls/pkeys/pkey02.c
new file mode 100644
index 000000000..ed6ea3c9d
--- /dev/null
+++ b/testcases/kernel/syscalls/pkeys/pkey02.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * Test for Memory Protection Keys on different memory area.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/syscall.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+
+#include "pkey.h"
+
+#define TMP_DIR "tmp_pkey"
+#define TEST_FILE TMP_DIR"/testfile"
+#define STR "abcdefghijklmnopqrstuvwxyz12345\n"
+
+static int psize;
+
+static struct tcase {
+	unsigned long flags;
+	unsigned long access_rights;
+} tcases[] = {
+	{0, 0x0},
+	{0, PKEY_DISABLE_ACCESS},
+	{0, PKEY_DISABLE_WRITE},
+};
+
+static void setup(void)
+{
+	int i, fd;
+
+	psize = getpagesize();
+	SAFE_MKDIR(TMP_DIR, 0664);
+	SAFE_MOUNT(TMP_DIR, TMP_DIR, "tmpfs", 0, NULL);
+
+	check_pkey_support();
+
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0664);
+	for (i = 0; i < 128; i++)
+		SAFE_WRITE(1, fd, STR, strlen(STR));
+
+	SAFE_CLOSE(fd);
+}
+
+static void cleanup(void)
+{
+	SAFE_UMOUNT(TMP_DIR);
+	SAFE_RMDIR(TMP_DIR);
+}
+
+static struct mmap_param {
+	int prot;
+	int flags;
+	int fd;
+} mmap_params[] = {
+	{PROT_READ,  MAP_ANONYMOUS | MAP_PRIVATE, -1},
+	{PROT_READ,  MAP_ANONYMOUS | MAP_SHARED, -1},
+	{PROT_READ, MAP_PRIVATE, 0},
+	{PROT_READ, MAP_SHARED, 0},
+	{PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1},
+	{PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, -1},
+	{PROT_WRITE, MAP_PRIVATE, 0},
+	{PROT_WRITE, MAP_SHARED, 0},
+	{PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, -1},
+	{PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED, -1},
+	{PROT_EXEC, MAP_PRIVATE, 0},
+	{PROT_EXEC, MAP_SHARED, 0},
+	{PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1},
+	{PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, -1},
+	{PROT_READ | PROT_WRITE, MAP_PRIVATE, 0},
+	{PROT_READ | PROT_WRITE, MAP_SHARED, 0},
+	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, -1},
+	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED, -1},
+	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE, 0},
+	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_SHARED, 0},
+};
+
+static void pkey_tests(int pkey, int prot, int flags, int fd)
+{
+	char *buffer;
+
+	if (fd == 0) {
+		fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0664);
+	}
+
+	buffer = SAFE_MMAP(NULL, psize, prot, flags, fd, 0);
+
+	if (pkey_mprotect(buffer, psize, prot, pkey) == -1)
+		tst_brk(TBROK, "pkey_mprotect failed");
+
+	tst_res(TPASS, "apply pkey to the buffer area success");
+
+	if (fd > 0) {
+		SAFE_CLOSE(fd);
+	}
+
+	SAFE_MUNMAP(buffer, psize);
+}
+
+static void verify_pkey(unsigned int i)
+{
+	int pkey;
+	long unsigned int j;
+
+	struct tcase *tc = &tcases[i];
+	struct mmap_param *mpa;
+
+	for (j = 0; j < ARRAY_SIZE(mmap_params); j++) {
+		mpa = &mmap_params[j];
+
+		pkey = pkey_alloc(tc->flags, tc->access_rights);
+		if (pkey == -1)
+			tst_brk(TBROK, "pkey_alloc failed");
+
+		pkey_tests(pkey, mpa->prot, mpa->flags, mpa->fd);
+
+		if (pkey_free(pkey) == -1)
+			tst_brk(TBROK, "pkey_free failed");
+	}
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.forks_child = 1,
+	.test = verify_pkey,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.20.1

