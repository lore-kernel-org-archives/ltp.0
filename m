From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 21 Mar 2018 15:39:27 +0100
Subject: [LTP] [PATCH v2 3/3] Add pcrypt_aead01 CVE-2017-18075
In-Reply-To: <20180321143927.12156-1-rpalethorpe@suse.com>
References: <20180321143927.12156-1-rpalethorpe@suse.com>
Message-ID: <20180321143927.12156-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/crypto                          |  1 +
 runtest/cve                             |  1 +
 testcases/kernel/crypto/.gitignore      |  1 +
 testcases/kernel/crypto/Makefile        | 22 +++++++++
 testcases/kernel/crypto/pcrypt_aead01.c | 85 +++++++++++++++++++++++++++++++++
 5 files changed, 110 insertions(+)
 create mode 100644 runtest/crypto
 create mode 100644 testcases/kernel/crypto/.gitignore
 create mode 100644 testcases/kernel/crypto/Makefile
 create mode 100644 testcases/kernel/crypto/pcrypt_aead01.c

diff --git a/runtest/crypto b/runtest/crypto
new file mode 100644
index 000000000..e5ba61e5e
--- /dev/null
+++ b/runtest/crypto
@@ -0,0 +1 @@
+pcrypt_aead01 pcrypt_aead01
diff --git a/runtest/cve b/runtest/cve
index 8b7cbe539..15fa02bc8 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -32,3 +32,4 @@ cve-2017-5754 meltdown
 cve-2017-17052 cve-2017-17052
 cve-2017-16939 cve-2017-16939
 cve-2017-17053 cve-2017-17053
+cve-2017-18075 pcrypt_aead01
diff --git a/testcases/kernel/crypto/.gitignore b/testcases/kernel/crypto/.gitignore
new file mode 100644
index 000000000..fafe5c972
--- /dev/null
+++ b/testcases/kernel/crypto/.gitignore
@@ -0,0 +1 @@
+pcrypt_aead01
diff --git a/testcases/kernel/crypto/Makefile b/testcases/kernel/crypto/Makefile
new file mode 100644
index 000000000..76f9308c2
--- /dev/null
+++ b/testcases/kernel/crypto/Makefile
@@ -0,0 +1,22 @@
+# Copyright (c) 2017 Linux Test Project
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+CFLAGS			+= -D_GNU_SOURCE
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/crypto/pcrypt_aead01.c b/testcases/kernel/crypto/pcrypt_aead01.c
new file mode 100644
index 000000000..8053b33e4
--- /dev/null
+++ b/testcases/kernel/crypto/pcrypt_aead01.c
@@ -0,0 +1,85 @@
+/*
+ * Copyright (c) 2018 SUSE
+ * Author: Nicolai Stange <nstange@suse.de>
+ * LTP conversion: Richard Palethorpe <rpalethorpe@suse.com>
+ *
+ * Originally found by syzkaller:
+ * https://groups.google.com/forum/#!topic/syzkaller-bugs/NKn_ivoPOpk
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Test for CVE-2017-5754 - pcrypt mishandles freeing instances.
+ *
+ * The test works by adding and then removing pcrypt-AEAD instances.
+ * See commit d76c68109f37 crypto: pcrypt - fix freeing pcrypt instances.
+ *
+ * If the bug is present then this will probably crash the kernel, but also
+ * sometimes the test simply times out.
+ */
+
+#include <errno.h>
+#include <time.h>
+
+#include "tst_test.h"
+#include "tst_safe_net.h"
+#include "tst_taint.h"
+#include "tst_crypto.h"
+
+#define ATTEMPTS 10000
+#define DEL_RETRY_COUNT 1000
+
+static struct tst_crypto_session ses;
+
+void setup(void)
+{
+	tst_crypto_open(&ses);
+}
+
+void run(void)
+{
+	int i;
+	struct crypto_user_alg a = {
+		.cru_driver_name = "pcrypt(authenc(hmac(sha256-generic),cbc(aes-generic)))",
+		.cru_type = CRYPTO_ALG_TYPE_AEAD,
+		.cru_mask = CRYPTO_ALG_TYPE_MASK,
+	};
+
+	for (i = 0; i < ATTEMPTS; ++i) {
+		TEST(tst_crypto_add_alg(&ses, &a));
+		if (TEST_RETURN && TEST_RETURN == -ENOENT) {
+			tst_brk(TCONF | TRERRNO,
+				"pcrypt, hmac, sha256, cbc or aes not supported");
+		}
+		if (TEST_RETURN && TEST_RETURN != -EEXIST)
+			tst_brk(TBROK | TRERRNO, "add_alg");
+
+		TEST(tst_crypto_del_alg(&ses, &a, DEL_RETRY_COUNT));
+		if (TEST_RETURN)
+			tst_brk(TBROK | TRERRNO, "del_alg");
+	}
+
+	tst_res(TPASS, "Nothing bad appears to have happened");
+}
+
+void cleanup(void)
+{
+	tst_crypto_close(&ses);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.cleanup = cleanup,
+	.needs_root = 1,
+};
-- 
2.16.2

