From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Jan 2018 14:11:34 +0100
Subject: [LTP] [RFC PATCH 2/2] cve/cve-2018-1000001: Add Realpath Buffer
	Underflow test
In-Reply-To: <20180118131134.11945-1-pvorel@suse.cz>
References: <20180118131134.11945-1-pvorel@suse.cz>
Message-ID: <20180118131134.11945-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Idea based on test from glibc , contributed by Dmitry V. Levin:
52a713fdd0 ("linux: make getcwd(3) fail if it cannot obtain an absolute
path [BZ #22679]")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: I didn't use TEST() macro due warning assignment makes integer
from pointer without a cast. Am I blind not to see how to use it?
---
 testcases/cve/cve-2018-1000001.c | 66 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 testcases/cve/cve-2018-1000001.c

diff --git a/testcases/cve/cve-2018-1000001.c b/testcases/cve/cve-2018-1000001.c
new file mode 100644
index 000000000..ae41c786f
--- /dev/null
+++ b/testcases/cve/cve-2018-1000001.c
@@ -0,0 +1,66 @@
+/*
+ * Copyright (C) 2018 Petr Vorel <pvorel@suse.cz>
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
+#include "tst_test.h"
+
+#include <errno.h>
+#include <stdlib.h>
+
+#define CHROOT_DIR "cve-2018-1000001"
+
+static void setup(void)
+{
+	SAFE_MKDIR(CHROOT_DIR, 0755);
+	SAFE_CHROOT(CHROOT_DIR);
+}
+
+static void run(unsigned int i)
+{
+	char *cwd;
+
+	int fail = 0;
+
+	errno = 0;
+	if (!i) {
+		tst_res(TINFO, "testing getcwd()");
+		cwd = getcwd(NULL, 0);
+	} else {
+		tst_res(TINFO, "testing realpath()");
+		cwd = realpath(".", NULL);
+	}
+
+	if (errno != ENOENT) {
+		tst_res(TFAIL | TERRNO, "returned unexpected errno");
+		fail = 1;
+	}
+
+	if (cwd != NULL) {
+		tst_res(TFAIL, "getcwd() not returned NULL path: '%s'", cwd);
+		fail = 1;
+	}
+
+	if (!fail)
+		tst_res(TPASS, "bug not reproduced");
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = 2,
+	.setup = setup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
-- 
2.15.1

