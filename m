From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 25 Aug 2020 18:07:33 +0200
Subject: [LTP] [PATCH v2 2/4] Add tst_pollute_memory() helper function
In-Reply-To: <20200825160735.24602-1-mdoucha@suse.cz>
References: <20200825160735.24602-1-mdoucha@suse.cz>
Message-ID: <20200825160735.24602-3-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_pollute_memory() fills available RAM up to specified limit with given fill
byte. Useful for testing data disclosure vulnerablities.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: New patch

 include/tst_memutils.h | 22 +++++++++++++++
 lib/tst_memutils.c     | 62 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 include/tst_memutils.h
 create mode 100644 lib/tst_memutils.c

diff --git a/include/tst_memutils.h b/include/tst_memutils.h
new file mode 100644
index 000000000..91dad07cd
--- /dev/null
+++ b/include/tst_memutils.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2020 SUSE LLC <mdoucha@suse.cz>
+ */
+
+#ifndef TST_MEMUTILS_H__
+#define TST_MEMUTILS_H__
+
+/*
+ * Fill up to maxsize physical memory with fillchar, then free it for reuse.
+ * If maxsize is zero, fill as much memory as possible. This function is
+ * intended for data disclosure vulnerability tests to reduce the probability
+ * that a vulnerable kernel will leak a block of memory that was full of
+ * zeroes by chance.
+ *
+ * The function keeps a safety margin to avoid invoking OOM killer and
+ * respects the limitations of available address space. (Less than 3GB can be
+ * polluted on a 32bit system regardless of available physical RAM.)
+ */
+void tst_pollute_memory(size_t maxsize, int fillchar);
+
+#endif /* TST_MEMUTILS_H__ */
diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
new file mode 100644
index 000000000..f134d90c9
--- /dev/null
+++ b/lib/tst_memutils.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 SUSE LLC <mdoucha@suse.cz>
+ */
+
+#include <unistd.h>
+#include <limits.h>
+#include <sys/sysinfo.h>
+#include <stdlib.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+#define BLOCKSIZE (16 * 1024 * 1024)
+
+void tst_pollute_memory(size_t maxsize, int fillchar)
+{
+	size_t i, map_count = 0, safety = 0, blocksize = BLOCKSIZE;
+	void **map_blocks;
+	struct sysinfo info;
+
+	SAFE_SYSINFO(&info);
+	safety = 4096 * SAFE_SYSCONF(_SC_PAGESIZE) / info.mem_unit;
+
+	if (info.freeswap > safety)
+		safety = 0;
+
+	/* Not enough free memory to avoid invoking OOM killer */
+	if (info.freeram <= safety)
+		return;
+
+	if (!maxsize)
+		maxsize = SIZE_MAX;
+
+	if (info.freeram - safety < maxsize / info.mem_unit)
+		maxsize = (info.freeram - safety) * info.mem_unit;
+
+	blocksize = MIN(maxsize, blocksize);
+	map_count = maxsize / blocksize;
+	map_blocks = SAFE_MALLOC(map_count * sizeof(void *));
+
+	/*
+	 * Keep allocating until the first failure. The address space may be
+	 * too fragmented or just smaller than maxsize.
+	 */
+	for (i = 0; i < map_count; i++) {
+		map_blocks[i] = mmap(NULL, blocksize, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+		if (map_blocks[i] == MAP_FAILED) {
+			map_count = i;
+			break;
+		}
+
+		memset(map_blocks[i], fillchar, blocksize);
+	}
+
+	for (i = 0; i < map_count; i++)
+		SAFE_MUNMAP(map_blocks[i], blocksize);
+
+	free(map_blocks);
+}
-- 
2.28.0

