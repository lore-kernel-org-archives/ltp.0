From: Michael Moese <mmoese@suse.de>
Date: Thu,  4 Jan 2018 11:38:16 +0100
Subject: [LTP] [PATCH] Add regression test for CVE-2017-17052
Message-ID: <20180104103816.7373-1-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
 testcases/cve/Makefile         |  2 ++
 testcases/cve/cve-2017-17052.c | 68 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 testcases/cve/cve-2017-17052.c

diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 0905fd95c..22dca3b3f 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -30,4 +30,6 @@ cve-2014-0196:  LDLIBS += -lrt -lutil
 cve-2017-2671:	CFLAGS += -pthread
 cve-2017-2671:	LDLIBS += -lrt
 
+cve-2017-17052:	CFLAGS += -pthread
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/cve/cve-2017-17052.c b/testcases/cve/cve-2017-17052.c
new file mode 100644
index 000000000..7103685f2
--- /dev/null
+++ b/testcases/cve/cve-2017-17052.c
@@ -0,0 +1,68 @@
+/*
+ * Copyright (c) 2018 Michael Moese <mmoese@suse.com>
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
+/*
+ * Test for CVE-2017-17052, original reproducer can be found here:
+ * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2b7e8665b4ff51c034c55df3cff76518d1a9ee3a
+ */
+
+#include <unistd.h>
+#include <pthread.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <sys/syscall.h>
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+static void *mmap_thread(void *_arg)
+{
+	for (;;) {
+		mmap(NULL, 0x1000000, PROT_READ,
+			MAP_POPULATE|MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	}
+}
+
+static void *fork_thread(void *_arg)
+{
+	usleep(rand() % 10000);
+	fork();
+}
+
+static void run(void)
+{
+	fork();
+	fork();
+	fork();
+	for(;;) {
+		if (fork() == 0) {
+			pthread_t t;
+
+			pthread_create(&t, NULL, mmap_thread, NULL);
+			pthread_create(&t, NULL, fork_thread, NULL);
+			usleep(rand() % 10000);
+			syscall(__NR_exit_group, 0);
+		}
+		wait(NULL);
+	}
+}
+
+
+
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.13.6

