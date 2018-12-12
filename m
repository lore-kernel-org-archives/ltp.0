From: Vaishnavi <vaishnavi.d@zilogic.com>
Date: Wed, 12 Dec 2018 12:23:31 -0000
Subject: [LTP] [PATCH v5] syscalls/statx: Add test for sync flags
Message-ID: <1544617411-9260-1-git-send-email-vaishnavi.d@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


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
 testcases/kernel/syscalls/statx/statx07.c  | 164 +++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+)
 create mode 100644 testcases/kernel/syscalls/statx/statx07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ac1d2d2..957b999 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1524,5 +1524,6 @@ statx03 statx03
 statx04 statx04
 statx05 statx05
 statx06 statx06
+statx07 statx07
 
 membarrier01 membarrier01
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index c1cedda..2f5457e 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -4,3 +4,4 @@
 /statx04
 /statx05
 /statx06
+/statx07
diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
new file mode 100644
index 0000000..e61ef69
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -0,0 +1,164 @@
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
+ */
+
+#include <netdb.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <linux/limits.h>
+#include <sys/mount.h>
+#include "tst_test.h"
+#include "lapi/stat.h"
+#include "old_tmpdir.h"
+
+#define MODE(X) (X & (~S_IFMT))
+#define FLAG_NAME(x) .flag = x, .flag_name = #x
+#define BUFF_SIZE PATH_MAX
+#define DEFAULT_MODE 0644
+#define CURRENT_MODE 0777
+
+#define CLI_PATH "client"
+#define SERV_PATH "server"
+#define CLI_FORCE_SYNC "client/force_sync_file"
+#define CLI_DONT_SYNC "client/dont_sync_file"
+#define SERV_FORCE_SYNC "server/force_sync_file"
+#define SERV_DONT_SYNC "server/dont_sync_file"
+
+static char *cwd;
+static char cmd[BUFF_SIZE];
+static int mounted;
+static int exported;
+
+static int get_mode(char *file_name, int flag_type, char *flag_name)
+{
+	struct statx buff;
+
+	TEST(statx(AT_FDCWD, file_name, flag_type, STATX_ALL, &buff));
+
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TST_ERR,
+			"statx(AT_FDCWD, %s, %s, STATX_ALL, &buff)",
+			file_name, flag_name);
+	else
+		tst_res(TINFO, "statx(AT_FDCWD, %s, %s, STATX_ALL, &buff)",
+			file_name, flag_name);
+
+	return buff.stx_mode;
+}
+
+const struct test_cases {
+	int flag;
+	char *flag_name;
+	char *server_file;
+	char *client_file;
+	unsigned int mode;
+} tcases[] = {
+	{FLAG_NAME(AT_STATX_DONT_SYNC), SERV_DONT_SYNC, CLI_DONT_SYNC, DEFAULT_MODE},
+	{FLAG_NAME(AT_STATX_FORCE_SYNC), SERV_FORCE_SYNC, CLI_FORCE_SYNC, CURRENT_MODE}
+};
+
+static void test_statx(unsigned int i)
+{
+	const struct test_cases *tc = &tcases[i];
+	unsigned int cur_mode;
+
+	if (tc->flag == AT_STATX_DONT_SYNC)
+		get_mode(tc->client_file, tc->flag, tc->flag_name);
+
+	SAFE_CHMOD(tc->server_file, CURRENT_MODE);
+	cur_mode = get_mode(tc->client_file, tc->flag, tc->flag_name);
+
+	if (MODE(cur_mode) == tc->mode)
+		tst_res(TPASS,
+			"statx() with %s for mode %o %o",
+			tc->flag_name, tc->mode, MODE(cur_mode));
+	else
+		tst_res(TFAIL,
+			"statx() with %s for mode %o %o",
+			tc->flag_name, tc->mode, MODE(cur_mode));
+}
+
+static void setup(void)
+{
+	int ret;
+	char server_path[BUFF_SIZE];
+
+	cwd = tst_get_tmpdir();
+
+	SAFE_MKDIR(SERV_PATH, DEFAULT_MODE);
+	SAFE_MKDIR(CLI_PATH, DEFAULT_MODE);
+	SAFE_CREAT(SERV_FORCE_SYNC, DEFAULT_MODE);
+	SAFE_CREAT(SERV_DONT_SYNC, DEFAULT_MODE);
+
+	snprintf(server_path, sizeof(server_path), ":%s/%s", cwd, SERV_PATH);
+
+	snprintf(cmd, sizeof(cmd),
+		 "exportfs -i -o no_root_squash,rw,sync,no_subtree_check *%.1024s",
+		 server_path);
+	exported = 1;
+
+	ret = tst_system(cmd);
+	if (WEXITSTATUS(ret) == 127)
+		tst_brk(TCONF | TST_ERR, "%s not found", cmd);
+	if (ret)
+		tst_brk(TBROK | TST_ERR, "failed to exportfs");
+
+	if (mount(server_path, CLI_PATH, "nfs", 0, "addr=127.0.0.1")) {
+		if (errno == EOPNOTSUPP)
+			tst_brk(TCONF | TERRNO, "nfs server not set up?");
+		tst_brk(TBROK | TERRNO, "mount() nfs failed");
+	}
+	mounted = 1;
+}
+
+static void cleanup(void)
+{
+	if (!exported)
+		return;
+	snprintf(cmd, sizeof(cmd),
+		 "exportfs -u *:%s/%s", cwd, SERV_PATH);
+
+	if (tst_system(cmd) == -1)
+		tst_res(TWARN | TST_ERR, "failed to clear exportfs");
+
+	if (mounted)
+		SAFE_UMOUNT(CLI_PATH);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = test_statx,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.16",
+	.needs_tmpdir = 1,
+	.dev_fs_type = "nfs",
+	.needs_root = 1,
+};
-- 
2.1.4

