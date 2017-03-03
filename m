From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Fri, 3 Mar 2017 16:07:35 +0800
Subject: [LTP] [PATCH v2] syscalls/keyctl02: Add new regression test
In-Reply-To: <58B90A1A.7070509@cn.fujitsu.com>
References: <58B90A1A.7070509@cn.fujitsu.com>
Message-ID: <1488528455-28888-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixed by:
commit b4a1b4f5047e4f54e194681125c74c0aa64d637d
Author: David Howells <dhowells@redhat.com>
Date:   Fri Dec 18 01:34:26 2015 +0000

    KEYS: Fix race between read and revoke

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/.gitignore        |   1 +
 testcases/kernel/syscalls/keyctl/Makefile   |   2 +
 testcases/kernel/syscalls/keyctl/keyctl02.c | 108 ++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index dc03c4c..cf29854 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -483,6 +483,7 @@ io_setup01 io_setup01
 io_submit01 io_submit01
 
 keyctl01 keyctl01
+keyctl02 keyctl02
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 91dccef..e26acff 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -448,6 +448,7 @@
 /ipc/shmget/shmget04
 /ipc/shmget/shmget05
 /keyctl/keyctl01
+/keyctl/keyctl02
 /kcmp/kcmp01
 /kcmp/kcmp02
 /kcmp/kcmp03
diff --git a/testcases/kernel/syscalls/keyctl/Makefile b/testcases/kernel/syscalls/keyctl/Makefile
index 2ef86f0..8f732cb 100644
--- a/testcases/kernel/syscalls/keyctl/Makefile
+++ b/testcases/kernel/syscalls/keyctl/Makefile
@@ -18,6 +18,8 @@
 
 top_srcdir		?= ../../../..
 
+keyctl02: LDLIBS	+=-lpthread -lkeyutils
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
new file mode 100644
index 0000000..704dc69
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
@@ -0,0 +1,108 @@
+/*
+ * Copyright (c) 2017 Fujitsu Ltd.
+ *  Ported: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program, if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * This is a regression test for the race between keyctl_read() and
+ * keyctl_revoke(), if the revoke happens between keyctl_read()
+ * checking the validity of a key and the key's semaphore being taken,
+ * then the key type read method will see a revoked key.
+ *
+ * This causes a problem for the user-defined key type because it
+ * assumes in its read method that there will always be a payload
+ * in a non-revoked key and doesn't check for a NULL pointer.
+ *
+ * This test can crash the buggy kernel, and the bug was fixed in:
+ *
+ *  commit b4a1b4f5047e4f54e194681125c74c0aa64d637d
+ *  Author: David Howells <dhowells@redhat.com>
+ *  Date:   Fri Dec 18 01:34:26 2015 +0000
+ *
+ *  KEYS: Fix race between read and revoke
+ */
+
+#include "config.h"
+#include <errno.h>
+#include <pthread.h>
+#include <sys/types.h>
+#ifdef HAVE_KEYUTILS_H
+#include <keyutils.h>
+#endif
+#include "tst_safe_pthread.h"
+#include "tst_test.h"
+
+#ifdef HAVE_KEYUTILS_H
+
+#define LOOPS	20000
+
+static void *do_read(void *arg)
+{
+	key_serial_t key = (unsigned long)arg;
+	char buffer[4] = { 0 };
+
+	keyctl(KEYCTL_READ, key, buffer, 4);
+
+	return NULL;
+}
+
+static void *do_revoke(void *arg)
+{
+	key_serial_t key = (unsigned long)arg;
+
+	keyctl(KEYCTL_REVOKE, key);
+
+	return NULL;
+}
+
+static void do_test(void)
+{
+	int i;
+	key_serial_t key;
+	pthread_t pth[4];
+
+	for (i = 0; i < LOOPS; i++) {
+		key = add_key("user", "ltptestkey", "foo", 3,
+			KEY_SPEC_PROCESS_KEYRING);
+		if (key == -1)
+			tst_brk(TBROK, "Failed to add key");
+
+		SAFE_PTHREAD_CREATE(&pth[0], NULL, do_read,
+			(void *)(unsigned long)key);
+		SAFE_PTHREAD_CREATE(&pth[1], NULL, do_revoke,
+			(void *)(unsigned long)key);
+		SAFE_PTHREAD_CREATE(&pth[2], NULL, do_read,
+			(void *)(unsigned long)key);
+		SAFE_PTHREAD_CREATE(&pth[3], NULL, do_revoke,
+			(void *)(unsigned long)key);
+
+		SAFE_PTHREAD_JOIN(pth[0], NULL);
+		SAFE_PTHREAD_JOIN(pth[1], NULL);
+		SAFE_PTHREAD_JOIN(pth[2], NULL);
+		SAFE_PTHREAD_JOIN(pth[3], NULL);
+	}
+
+	tst_res(TPASS, "Bug not reproduced");
+}
+
+static struct tst_test test = {
+	.tid = "keyctl02",
+	.test_all = do_test,
+};
+
+#else
+	TST_TEST_TCONF("keyutils.h does not exist");
+#endif /* HAVE_KEYUTILS_H */
-- 
1.8.4.2



