From: kewal <kewal@zilogic.com>
Date: Mon, 10 Sep 2018 12:05:13 -0000
Subject: [LTP] [PATCH v1] Test statx syscall for SYNC_FLAGS
Message-ID: <20180910120513.14069-1-kewal@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


* statx06.c :-

 Testcase 1: AT_STATX_DONT_SYNC
  With AT_STATX_DONT_SYNC server changes should not get sync with client.

 Testcase 2: AT_STATX_FORCE_SYNC
  With AT_STATX_FORCE_SYNC server changes should get sync with client.

Signed-off-by: Kewal Ukunde <kewal@zilogic.com>
Signed-off-by: Vaishnavi.d <vaishnavi.d@zilogic.com>
Signed-off-by: Tarun.T.U <tarun@zilogic.com>
---
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/statx/.gitignore |   1 +
 testcases/kernel/syscalls/statx/statx06.c  | 183 +++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 testcases/kernel/syscalls/statx/statx06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 0d0be7713..71b83b25c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1504,3 +1504,4 @@ statx02 statx02
 statx03 statx03
 statx04 statx04
 statx05 statx05
+statx06 statx06
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index 209fc3a33..c1ceddabf 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -3,3 +3,4 @@
 /statx03
 /statx04
 /statx05
+/statx06
diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
new file mode 100644
index 000000000..8b66bf832
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx06.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ *  Email : code@zilogic.com
+ */
+
+/*
+ * Test statx
+ *
+ * This code tests the following flags:
+ * 1) AT_STATX_FORCE_SYNC
+ * 2) AT_STATX_DONT_SYNC
+ *
+ * By exportfs cmd creating NFS setup.
+ *
+ * A test file is created in server folder and statx is being
+ * done in client folder.
+ *
+ * TESTCASE 1:
+ * BY AT_STATX_SYNC_AS_STAT getting predefined mode value.
+ * Then, by using AT_STATX_FORCE_SYNC getting new updated vaue
+ * from server file changes.
+ *
+ * TESTCASE 2:
+ * BY AT_STATX_SYNC_AS_STAT getting predefined mode value.
+ * AT_STATX_FORCE_SYNC is called to create cache data of the file. 
+ * Then, by using DONT_SYNC_FILE getting old cached data in client folder,
+ * but mode has been chaged in server file.
+ *
+ * Minimum kernel version required is 4.11.
+ */
+
+#include <netdb.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include "tst_test.h"
+#include "lapi/stat.h"
+
+#define MODE(X) (X & (~S_IFMT))
+#define BUFF_SIZE 512
+#define DEFAULT_MODE 0644
+#define CURRENT_MODE 0777
+
+#define CLIENT_PATH "client"
+#define SERVER_PATH "server"
+#define FORCE_SYNC_FILE  "force_sync_file"
+#define DONT_SYNC_FILE "dont_sync_file"
+
+static char cwd[BUFF_SIZE];
+static char cmd[BUFF_SIZE];
+
+static int get_mode(char *file_name, int flag_type, char *flag_name)
+{
+	char client_path[BUFF_SIZE];
+	struct statx buff;
+
+	sprintf(client_path, "%s/%s/%s", cwd, CLIENT_PATH, file_name);
+
+	TEST(statx(AT_FDCWD, client_path, flag_type, STATX_ALL, &buff));
+
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TST_ERR,
+				"statx(AT_FDCWD, %s, %s, STATX_ALL, &buff)",
+				file_name, flag_name);
+	else
+		tst_res(TINFO, "statx(AT_FDCWD, %s, %s, STATX_ALL, &buff)",
+				file_name, flag_name);
+
+	return buff.stx_mode;
+}
+
+static void test_for_dont_sync(void)
+{
+	unsigned int cur_mode;
+	char server_path[BUFF_SIZE];
+
+	sprintf(server_path, "%s/%s/%s", cwd, SERVER_PATH, DONT_SYNC_FILE);
+
+	get_mode(DONT_SYNC_FILE, AT_STATX_FORCE_SYNC,
+			"AT_STATX_FORCE_SYNC");
+
+	SAFE_CHMOD(server_path, CURRENT_MODE);
+	cur_mode = get_mode(DONT_SYNC_FILE, AT_STATX_DONT_SYNC,
+			"AT_STATX_DONT_SYNC");
+
+	if (DEFAULT_MODE == MODE(cur_mode))
+		tst_res(TPASS,
+				"statx() with AT_STATX_DONT_SYNC for mode %o %o",
+				DEFAULT_MODE, (cur_mode & ~S_IFMT));
+	else
+		tst_res(TFAIL,
+				"statx() with AT_STATX_DONT_SYNC for mode %o %o",
+				DEFAULT_MODE, (cur_mode & ~S_IFMT));
+}
+
+static void test_for_force_sync(void)
+{
+	unsigned int cur_mode;
+	char server_path[BUFF_SIZE];
+
+	sprintf(server_path, "%s/%s/%s", cwd, SERVER_PATH, FORCE_SYNC_FILE);
+
+	SAFE_CHMOD(server_path, CURRENT_MODE);
+	cur_mode = get_mode(FORCE_SYNC_FILE, AT_STATX_FORCE_SYNC,
+			"AT_STATX_FORCE_SYNC");
+
+	if (CURRENT_MODE == MODE(cur_mode))
+		tst_res(TPASS,
+				"statx() with AT_STATX_FORCE_SYNC for mode %o %o",
+				CURRENT_MODE, (cur_mode & ~S_IFMT));
+	else
+		tst_res(TFAIL,
+				"statx() with AT_STATX_FORCE_SYNC for mode %o %o",
+				CURRENT_MODE, (cur_mode & ~S_IFMT));
+}
+
+struct test_cases {
+	void (*func)(void);
+} tcases[] = {
+	{test_for_dont_sync},
+	{test_for_force_sync}
+};
+
+static void test_statx(unsigned int nr)
+{
+	struct test_cases *tc = &tcases[nr];
+
+	tc->func();
+}
+
+static void setup(void)
+{
+	char force_sync_file[BUFF_SIZE];
+	char dont_sync_file[BUFF_SIZE];
+	char server_path[BUFF_SIZE];
+	char client_path[BUFF_SIZE];
+	char mount_data[BUFF_SIZE];
+	char *ip = "127.0.0.1";
+
+	TESTPTR(getcwd(cwd, BUFF_SIZE));
+	if (TST_RET_PTR == NULL)
+		tst_brk(TBROK | TST_ERR, "Failed to get PWD");
+
+	sprintf(force_sync_file, "%s/%s", SERVER_PATH, FORCE_SYNC_FILE);
+	sprintf(dont_sync_file, "%s/%s", SERVER_PATH, DONT_SYNC_FILE);
+
+	SAFE_MKDIR(SERVER_PATH, DEFAULT_MODE);
+	SAFE_MKDIR(CLIENT_PATH, DEFAULT_MODE);
+	SAFE_CREAT(force_sync_file, DEFAULT_MODE);
+	SAFE_CREAT(dont_sync_file, DEFAULT_MODE);
+
+	sprintf(server_path, ":%s/%s", cwd, SERVER_PATH);
+	sprintf(client_path, "%s/%s", cwd, CLIENT_PATH);
+	sprintf(mount_data, "addr=%s", ip);
+
+	sprintf(cmd,
+			"exportfs -i -o no_root_squash,rw,sync,no_subtree_check *%s",
+			server_path);
+
+	if (WEXITSTATUS(tst_system(cmd)) == 127)
+		tst_brk(TBROK | TST_ERR, "%s not found", cmd);
+
+	SAFE_MOUNT(server_path, client_path, "nfs", 0, mount_data);
+}
+
+static void cleanup(void)
+{
+	if (WEXITSTATUS(tst_system("exportfs -ua")) == 127)
+		tst_brk(TBROK | TST_ERR, "%s", cmd);
+
+	SAFE_UMOUNT(CLIENT_PATH);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = test_statx,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.11",
+	.needs_tmpdir = 1,
+	.dev_fs_type = "nfs",
+	.needs_root = 1,
+};
-- 
2.11.0

