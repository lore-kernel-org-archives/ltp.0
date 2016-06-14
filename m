From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 14 Jun 2016 13:27:58 +0200
Subject: [LTP] [PATCH] lib: add tst_read_meminfo / tst_get_avail_mem
Message-ID: <cad01181438a055f45b32fc28b33a8b8da74b768.1465903335.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch adds 2 new functions that both parse data
from /proc/meminfo.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_mem.h | 36 ++++++++++++++++++++++++++++++++
 lib/tst_mem.c     | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 include/tst_mem.h
 create mode 100644 lib/tst_mem.c

Julio Cruz reported couple issues when running LTP on systems with
limited RAM. To avoid duplicating get_avail_mem() in all of them,
I propose we add such function to lib.

diff --git a/include/tst_mem.h b/include/tst_mem.h
new file mode 100644
index 000000000000..a37aaa088103
--- /dev/null
+++ b/include/tst_mem.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright (c) 2016 Linux Test Project
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
+#ifndef TST_MEM_H__
+#define TST_MEM_H__
+
+/*
+ * Returns number of kB for /proc/meminfo "item" or -1
+ * if "item" can not be found.
+ *
+ * @item: name of /proc/meminfo item, e.g. MemFree
+ * @strict: if true and "item" can not be found,
+ *          function calls tst_brk(TBROK,..)
+ */
+long tst_read_meminfo(const char *item, int strict);
+
+/*
+ * Returns number of kB of available memory.
+ */
+long tst_get_avail_mem(void);
+
+#endif /* TST_MEM_H__ */
diff --git a/lib/tst_mem.c b/lib/tst_mem.c
new file mode 100644
index 000000000000..d1a08f78b026
--- /dev/null
+++ b/lib/tst_mem.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright (c) 2016 Linux Test Project
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
+#include <stdio.h>
+#include "tst_test.h"
+#include "tst_mem.h"
+
+static const char *path_meminfo = "/proc/meminfo";
+
+long tst_read_meminfo(const char *item, int strict)
+{
+	FILE *fp;
+	char line[BUFSIZ], buf[BUFSIZ];
+	long val;
+
+	fp = fopen(path_meminfo, "r");
+	if (fp == NULL)
+		tst_brk(TBROK | TERRNO, "fopen %s", path_meminfo);
+
+	while (fgets(line, BUFSIZ, fp) != NULL) {
+		if (sscanf(line, "%64s %ld", buf, &val) == 2)
+			if (strcmp(buf, item) == 0) {
+				fclose(fp);
+				return val;
+			}
+		continue;
+	}
+	fclose(fp);
+
+	if (strict)
+		tst_brk(TBROK, "cannot find \"%s\" in %s",
+			item, path_meminfo);
+
+	return -1;
+}
+
+long tst_get_avail_mem(void)
+{
+	long mem_available;
+
+	mem_available = tst_read_meminfo("MemAvailable:", 0);
+	if (mem_available == -1) {
+		mem_available = tst_read_meminfo("MemFree:", 1);
+		mem_available += tst_read_meminfo("Cached:", 1);
+	}
+
+	return mem_available;
+}
-- 
1.8.3.1

