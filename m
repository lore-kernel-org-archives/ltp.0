From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 26 Aug 2021 13:22:12 +0200
Subject: [LTP] [PATCH v2 4/4] Add test for CVE 2018-13405
In-Reply-To: <20210826112212.26394-1-mdoucha@suse.cz>
References: <20210826112212.26394-1-mdoucha@suse.cz>
Message-ID: <20210826112212.26394-4-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Run the test under nobody's primary group
- Set WORKDIR group owner to any unassigned gid
- Remove unnecessary parameter from file_test()
- Don't switch users in cleanup()

 runtest/cve                                |   1 +
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/creat/.gitignore |   1 +
 testcases/kernel/syscalls/creat/creat09.c  | 110 +++++++++++++++++++++
 4 files changed, 113 insertions(+)
 create mode 100644 testcases/kernel/syscalls/creat/creat09.c

diff --git a/runtest/cve b/runtest/cve
index c27f58d8d..42c8eedbe 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -55,6 +55,7 @@ cve-2018-1000001 realpath01
 cve-2018-1000199 ptrace08
 cve-2018-1000204 ioctl_sg01
 cve-2018-12896 timer_settime03
+cve-2018-13405 creat09
 cve-2018-18445 bpf_prog04
 cve-2018-18559 bind06
 cve-2018-18955 userns08
diff --git a/runtest/syscalls b/runtest/syscalls
index 6762a234c..81c3a381b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -134,6 +134,7 @@ creat05 creat05
 creat06 creat06
 creat07 creat07
 creat08 creat08
+creat09 creat09
 
 delete_module01 delete_module01
 delete_module02 delete_module02
diff --git a/testcases/kernel/syscalls/creat/.gitignore b/testcases/kernel/syscalls/creat/.gitignore
index a39e63590..caafc02b6 100644
--- a/testcases/kernel/syscalls/creat/.gitignore
+++ b/testcases/kernel/syscalls/creat/.gitignore
@@ -6,3 +6,4 @@
 /creat07
 /creat07_child
 /creat08
+/creat09
diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
new file mode 100644
index 000000000..d678101b7
--- /dev/null
+++ b/testcases/kernel/syscalls/creat/creat09.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 SUSE LLC <mdoucha@suse.cz>
+ *
+ * CVE-2018-13405
+ *
+ * Check for possible privilege escalation through creating files with setgid
+ * bit set inside a setgid directory owned by a group which the user does not
+ * belong to. Fixed in:
+ *
+ *  commit 0fa3ecd87848c9c93c2c828ef4c3a8ca36ce46c7
+ *  Author: Linus Torvalds <torvalds@linux-foundation.org>
+ *  Date:   Tue Jul 3 17:10:19 2018 -0700
+ *
+ *  Fix up non-directory creation in SGID directories
+ */
+
+#include <stdlib.h>
+#include <sys/types.h>
+#include <pwd.h>
+#include "tst_test.h"
+#include "tst_uid.h"
+
+#define MODE_RWX        0777
+#define MODE_SGID       (S_ISGID|0777)
+
+#define WORKDIR		"testdir"
+#define CREAT_FILE	WORKDIR "/creat.tmp"
+#define OPEN_FILE	WORKDIR "/open.tmp"
+
+static gid_t free_gid;
+static int fd = -1;
+
+static void setup(void)
+{
+	struct stat buf;
+	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
+
+	free_gid = tst_get_free_gid(ltpuser->pw_gid);
+
+	/* Create directories and set permissions */
+	SAFE_MKDIR(WORKDIR, MODE_RWX);
+	SAFE_CHOWN(WORKDIR, ltpuser->pw_uid, free_gid);
+	SAFE_CHMOD(WORKDIR, MODE_SGID);
+	SAFE_STAT(WORKDIR, &buf);
+
+	if (!(buf.st_mode & S_ISGID))
+		tst_brk(TBROK, "%s: Setgid bit not set", WORKDIR);
+
+	if (buf.st_gid != free_gid) {
+		tst_brk(TBROK, "%s: Incorrect group, %u != %u", WORKDIR,
+			buf.st_gid, free_gid);
+	}
+
+	/* Switch user */
+	SAFE_SETGID(ltpuser->pw_gid);
+	SAFE_SETREUID(-1, ltpuser->pw_uid);
+}
+
+static void file_test(const char *name)
+{
+	struct stat buf;
+
+	SAFE_STAT(name, &buf);
+
+	if (buf.st_gid != free_gid) {
+		tst_res(TFAIL, "%s: Incorrect group, %u != %u", name,
+			buf.st_gid, free_gid);
+	} else {
+		tst_res(TPASS, "%s: Owned by correct group", name);
+	}
+
+	if (buf.st_mode & S_ISGID)
+		tst_res(TFAIL, "%s: Setgid bit is set", name);
+	else
+		tst_res(TPASS, "%s: Setgid bit not set", name);
+}
+
+static void run(void)
+{
+	fd = SAFE_CREAT(CREAT_FILE, MODE_SGID);
+	SAFE_CLOSE(fd);
+	file_test(CREAT_FILE);
+
+	fd = SAFE_OPEN(OPEN_FILE, O_CREAT | O_EXCL | O_RDWR, MODE_SGID);
+	file_test(OPEN_FILE);
+	SAFE_CLOSE(fd);
+
+	/* Cleanup between loops */
+	tst_purge_dir(WORKDIR);
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "0fa3ecd87848"},
+		{"CVE", "2018-13405"},
+		{}
+	},
+};
-- 
2.32.0

