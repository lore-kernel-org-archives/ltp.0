From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 18 Oct 2018 14:46:22 +0200
Subject: [LTP] [PATCH RFC] lib: add helper funcs to save and restore
	/proc|sys content
Message-ID: <bc3a3f3599064b34d60a2f2f21c5cac578582a50.1539866505.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To avoid adding specially crafted functions for every feature
where we need to save/restore some proc/sys config, this patch
introduces a struct (linked list) where user pushes files names
whose values should be saved. These can be later restored in
cleanup or during the test.

Example:
  TST_SYS_CONF_INIT(saved_conf);
  tst_sys_conf_save(&saved_conf, "/proc/sys/kernel/core_pattern");
  tst_sys_conf_save(&saved_conf, "/proc/sys/kernel/numa_balancing");

  SAFE_FILE_PRINTF("/proc/sys/kernel/core_pattern", "changed");
  SAFE_FILE_PRINTF("/proc/sys/kernel/numa_balancing", "0");

  tst_sys_conf_restore(&saved_conf, 1);

At the moment this saves/restores one line of a specified file.
Saving is non-strict, it only prints info message if file can't be found.
Restoring is strict and will TBROK.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_sys_conf.h      | 28 ++++++++++++++
 lib/newlib_tests/.gitignore |  1 +
 lib/newlib_tests/test19.c   | 60 +++++++++++++++++++++++++++++
 lib/tst_sys_conf.c          | 92 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 181 insertions(+)
 create mode 100644 include/tst_sys_conf.h
 create mode 100644 lib/newlib_tests/test19.c
 create mode 100644 lib/tst_sys_conf.c

diff --git a/include/tst_sys_conf.h b/include/tst_sys_conf.h
new file mode 100644
index 000000000000..6c4545822a3e
--- /dev/null
+++ b/include/tst_sys_conf.h
@@ -0,0 +1,28 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2018 Jan Stancek <jstancek@redhat.com>
+ */
+
+#ifndef TST_SYS_CONF_H__
+#define TST_SYS_CONF_H__
+
+struct tst_sys_conf {
+	char path[PATH_MAX];
+	char value[PATH_MAX];
+	struct tst_sys_conf *prev;
+	struct tst_sys_conf *next;
+};
+
+#define HEAD_INIT(name) { .prev = &(name), .next = &(name) }
+
+#define TST_SYS_CONF_INIT(name) \
+        struct tst_sys_conf name = HEAD_INIT(name)
+
+int tst_sys_conf_save_str(struct tst_sys_conf *c, const char *path, const char *value);
+int tst_sys_conf_save(struct tst_sys_conf *c, const char *path);
+void tst_sys_conf_restore(struct tst_sys_conf *c, int verbose);
+
+void tst_sys_conf_dump(struct tst_sys_conf *c);
+
+#endif
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 76e89e438f55..c702644f0d1c 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -20,6 +20,7 @@ tst_res_hexd
 tst_strstatus
 test17
 test18
+test19
 tst_expiration_timer
 test_exec
 test_exec_child
diff --git a/lib/newlib_tests/test19.c b/lib/newlib_tests/test19.c
new file mode 100644
index 000000000000..97a0798b2dd7
--- /dev/null
+++ b/lib/newlib_tests/test19.c
@@ -0,0 +1,60 @@
+/*
+ * Copyright (c) 2018, Linux Test Project
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
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <stdlib.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_sys_conf.h"
+
+TST_SYS_CONF_INIT(saved_conf);
+static char orig[1024];
+
+static void setup(void)
+{
+	tst_sys_conf_save(&saved_conf, "/proc/sys/kernel/core_pattern");
+	tst_sys_conf_save(&saved_conf, "/proc/sys/kernel/numa_balancing");
+	tst_sys_conf_save(&saved_conf, "/proc/sys/vm/panic_on_oom");
+	tst_sys_conf_save(&saved_conf, "/proc/nonexistent");
+
+	SAFE_FILE_SCANF("/proc/sys/kernel/core_pattern", "%s", orig);
+	SAFE_FILE_PRINTF("/proc/sys/kernel/core_pattern", "changed");
+}
+
+static void cleanup(void)
+{
+	char cur[1024];
+
+	tst_sys_conf_restore(&saved_conf, 1);
+
+	SAFE_FILE_SCANF("/proc/sys/kernel/core_pattern", "%s", cur);
+	if (strcmp(cur, orig) == 0)
+		tst_res(TPASS, "value looks good after restore");
+	else
+		tst_res(TFAIL, "value is %s after restore", cur);
+}
+
+static void run(void)
+{
+	tst_res(TPASS, "OK");
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};
diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c
new file mode 100644
index 000000000000..69a841a6a8e2
--- /dev/null
+++ b/lib/tst_sys_conf.c
@@ -0,0 +1,92 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2018 Jan Stancek <jstancek@redhat.com>
+ */
+
+#include <limits.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_sys_conf.h"
+
+struct tst_sys_conf *tst_sys_conf_new(void)
+{
+	struct tst_sys_conf *p = SAFE_MALLOC(sizeof(*p));
+
+	p->prev = p;
+	p->next = p;
+
+	return p;
+}
+
+void tst_sys_conf_dump(struct tst_sys_conf *c)
+{
+	struct tst_sys_conf *i = c->next;
+
+	while (i != c) {
+		printf("%s -> %s\n", i->path, i->value);
+		i = i->next;
+	}
+}
+
+int tst_sys_conf_save_str(struct tst_sys_conf *c, const char *path, const char *value)
+{
+	struct tst_sys_conf *n = SAFE_MALLOC(sizeof(*n));
+
+	strncpy(n->path, path, sizeof(n->path));
+	strncpy(n->value, value, sizeof(n->value));
+
+	/* add new entry at the beginning, right after 'c' */
+	n->next = c->next;
+	c->next->prev = n;
+
+	c->next = n;
+	n->prev = c;
+
+	return 0;
+}
+
+int tst_sys_conf_save(struct tst_sys_conf *c, const char *path)
+{
+	char line[PATH_MAX];
+	FILE *fp;
+	void *ret;
+
+	if (access(path, F_OK) != 0) {
+		tst_res(TINFO, "Path not found, skipping saving of: '%s'\n", path);
+		return 1;
+	}
+
+	fp = fopen(path, "r");
+	if (fp == NULL) {
+		tst_brk(TBROK | TERRNO, "Failed to open FILE '%s' for reading",
+			path);
+		return 1;
+	}
+
+	ret = fgets(line, sizeof(line), fp);
+	fclose(fp);
+
+	if (ret == NULL) {
+		tst_brk(TBROK | TERRNO, "Failed to read anything from '%s'",
+			path);
+	}
+
+	return tst_sys_conf_save_str(c, path, line);
+}
+
+void tst_sys_conf_restore(struct tst_sys_conf *c, int verbose)
+{
+	struct tst_sys_conf *i = c->next;
+
+	while (i != c) {
+		if (verbose)
+			tst_res(TINFO, "Restoring conf.: %s -> %s\n", i->path, i->value);
+		SAFE_FILE_PRINTF(i->path, "%s", i->value);
+		i = i->next;
+	}
+}
+
-- 
1.8.3.1

