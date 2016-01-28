From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 28 Jan 2016 15:28:47 +0300
Subject: [LTP] [PATCH v2 1/6] lib/tst_dir_is_empty: add a library function
In-Reply-To: <1453984132-6240-1-git-send-email-alexey.kodanev@oracle.com>
References: <1453984132-6240-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1453984132-6240-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Checks if a given directory is empty.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/test.h         |    8 +++++++
 lib/tst_dir_is_empty.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100644 lib/tst_dir_is_empty.c

diff --git a/include/test.h b/include/test.h
index fc07dae..c364b75 100644
--- a/include/test.h
+++ b/include/test.h
@@ -441,6 +441,14 @@ int tst_fs_fill_hardlinks(void (*cleanup) (void), const char *dir);
 int tst_fs_fill_subdirs(void (*cleanup) (void), const char *dir);
 
 /*
+ * lib/tst_dir_is_empty.c
+ *
+ * Checks if a given directory contains any entities,
+ * returns 1 if directory is empty, 0 otherwise
+ */
+int tst_dir_is_empty(void (*cleanup) (void), const char *name, int verbose);
+
+/*
  * lib/tst_pid.c
  *
  * Get a pid value not used by the OS
diff --git a/lib/tst_dir_is_empty.c b/lib/tst_dir_is_empty.c
new file mode 100644
index 0000000..75df50d
--- /dev/null
+++ b/lib/tst_dir_is_empty.c
@@ -0,0 +1,49 @@
+/*
+ * Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+ *
+ */
+
+#include <string.h>
+#include <sys/types.h>
+#include <dirent.h>
+
+#include "test.h"
+#include "safe_macros.h"
+
+int tst_dir_is_empty(void (cleanup_fn)(void), const char *name, int verbose)
+{
+	struct dirent *entry;
+	DIR *dir = SAFE_OPENDIR(cleanup_fn, name);
+	int ret = 1;
+
+	while ((entry = SAFE_READDIR(cleanup_fn, dir)) != NULL) {
+		const char *file = entry->d_name;
+
+		if (!strcmp(file, "..") || !strcmp(file, "."))
+			continue;
+
+		if (verbose)
+			tst_resm(TINFO, "found a file: %s", file);
+		ret = 0;
+		break;
+	}
+
+	SAFE_CLOSEDIR(cleanup_fn, dir);
+
+	return ret;
+}
-- 
1.7.1

