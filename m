From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 6 Feb 2018 14:43:28 +0800
Subject: [LTP] [PATCH v2] syscalls/mmap17.c: Add new regression test
In-Reply-To: <940714833.169417.1517830921395.JavaMail.zimbra@redhat.com>
References: <940714833.169417.1517830921395.JavaMail.zimbra@redhat.com>
Message-ID: <1517899408-2710-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We add a regression test to check if mmap() can't map invalid physical
addresses.  If mmap() maps /dev/mem offsets outside of the addressable
limits of a system, setting reserved bits corrupts the page table and
may trigger a kernel crash.

The kernel bug has been fixed by:
'commit ce56a86 ("x86/mm: Limit mmap() of /dev/mem to valid physical addresses")'

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/syscalls                        |   1 +
 testcases/kernel/syscalls/.gitignore    |   1 +
 testcases/kernel/syscalls/mmap/mmap17.c | 115 ++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mmap/mmap17.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2a4fad0..4342f03 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -641,6 +641,7 @@ mmap14 mmap14
 #mmap11 mmap11 -i 30000
 mmap15 mmap15
 mmap16 mmap16
+mmap17 mmap17
 
 modify_ldt01 modify_ldt01
 modify_ldt02 modify_ldt02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 67211ca..6a8560a 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -584,6 +584,7 @@
 /mmap/mmap14
 /mmap/mmap15
 /mmap/mmap16
+/mmap/mmap17
 /modify_ldt/modify_ldt01
 /modify_ldt/modify_ldt02
 /modify_ldt/modify_ldt03
diff --git a/testcases/kernel/syscalls/mmap/mmap17.c b/testcases/kernel/syscalls/mmap/mmap17.c
new file mode 100644
index 0000000..c008460
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap17.c
@@ -0,0 +1,115 @@
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Description:
+ * A regression test to check if mmap() can't map invalid physical addresses.
+ * If mmap() maps /dev/mem offsets outside of the addressable limits of a
+ * system, setting reserved bits corrupts the page table and may trigger a
+ * kernel crash.
+ *
+ * The kernel bug has been fixed by:
+ * 'commit ce56a86 ("x86/mm: Limit mmap() of /dev/mem to valid physical addresses")'
+ */
+
+#include <errno.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mman.h>
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+
+#define MEM_PATH	"/dev/mem"
+#define CPUINFO_PATH	"/proc/cpuinfo"
+
+static int fd;
+static int phys_addr_bits;
+
+/* 1) Before commit c64b04f, we couldn't read phys_addr_bits from
+ *    /proc/cpuinfo in 32-bit kernel on x86.
+ * 2) On non-x86 architectures, we couldn't read phys_addr_bits from
+ *    /proc/cpuinfo as well.
+ * According to above reasons, we add a check for phys_addr_bits in
+ * /proc/cpuinfo.  We can skip this test if phys_addr_bits isn't available.
+ */
+static void check_phys_addr_bits(void)
+{
+	int existed = 0;
+	FILE *fp;
+	char line[BUFSIZ];
+
+	fp = SAFE_FOPEN(CPUINFO_PATH, "r");
+
+	while (fgets(line, BUFSIZ, fp)) {
+		if (strstr(line, "address sizes")) {
+			existed = 1;
+			break;
+		}
+	}
+
+	fclose(fp);
+
+	if (!existed) {
+		tst_brk(TCONF, "Couldn't read x86_phys_bits from %s",
+			CPUINFO_PATH);
+	}
+}
+
+static void verify_mmap(void)
+{
+	char *addr;
+
+	addr = mmap(NULL, 1, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
+		    1ULL<<phys_addr_bits);
+	if (addr == MAP_FAILED) {
+		tst_res(TPASS | TERRNO,
+			"Refused to map invalid physical address");
+		return;
+	}
+
+	addr[0] = 'a';
+	SAFE_MUNMAP(addr, 1);
+	tst_res(TFAIL, "Mapped and set invalid physical address successfully");
+}
+
+static void setup(void)
+{
+	if (access(MEM_PATH, F_OK))
+		tst_brk(TCONF, "%s didn't exist", MEM_PATH);
+
+	fd = SAFE_OPEN(MEM_PATH, O_RDWR | O_SYNC);
+
+	check_phys_addr_bits();
+	SAFE_FILE_LINES_SCANF(CPUINFO_PATH, "address sizes\t: %d",
+			      &phys_addr_bits);
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_mmap,
+};
-- 
1.8.3.1



