From: Li Wang <liwang@redhat.com>
Date: Sat, 15 Jun 2019 12:20:46 +0800
Subject: [LTP] [PATCH v2 1/3] lib: adding .arch field in tst_test structure
Message-ID: <20190615042048.29839-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Testcases for specified arch should be limited on that only being supported
platform to run, we now create a function tst_on_arch to achieve this new
feature in LTP library.  All you need to run a test on the expected arch is
to set the '.arch' string in the 'struct tst_test' to choose the required
arch list. e.g. '.arch = "x86_64 i386"'.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 doc/test-writing-guidelines.txt | 26 ++++++++++
 include/tst_arch.h              | 16 ++++++
 include/tst_test.h              |  7 ++-
 lib/tst_arch.c                  | 92 +++++++++++++++++++++++++++++++++
 4 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 include/tst_arch.h
 create mode 100644 lib/tst_arch.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index f1912dc12..b4fba0190 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1668,6 +1668,32 @@ sturct tst_test test = {
 };
 -------------------------------------------------------------------------------
 
+2.2.30 Testing on specified architecture
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Testcases for specified arch should be limited on that only being supported
+platform to run, we now create a function tst_on_arch to achieve this new
+feature in LTP library.  All you need to run a test on the expected arch is
+to set the '.arch' string in the 'struct tst_test' to choose the required
+arch list. e.g. '.arch = "x86_64 i386"'.
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+static void setup(void)
+{
+	...
+}
+
+static struct tst_test test = {
+	...
+	.setup = setup,
+	.arch = "x86_64 i386",
+	...
+}
+-------------------------------------------------------------------------------
+
 
 2.3 Writing a testcase in shell
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/include/tst_arch.h b/include/tst_arch.h
new file mode 100644
index 000000000..7bf0493ce
--- /dev/null
+++ b/include/tst_arch.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) 2019 Li Wang <liwang@redhat.com>
+ */
+
+#ifndef TST_ARCH_H__
+#define TST_ARCH_H__
+
+/*
+ * Check if test platform is in the given arch list. If yes return 1,
+ * otherwise return 0.
+ *
+ * @arch, NULL or vliad arch list
+ */
+int tst_on_arch(const char *arch);
+
+#endif /* TST_ARCH_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 8bdf38482..cafcb1a89 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -28,6 +28,7 @@
 #include "tst_atomic.h"
 #include "tst_kvercmp.h"
 #include "tst_clone.h"
+#include "tst_arch.h"
 #include "tst_kernel.h"
 #include "tst_minmax.h"
 #include "tst_get_bad_addr.h"
@@ -114,6 +115,8 @@ struct tst_test {
 
 	const char *min_kver;
 
+	const char *arch;
+
 	/* If set the test is compiled out */
 	const char *tconf_msg;
 
@@ -253,7 +256,6 @@ const char *tst_strstatus(int status);
 unsigned int tst_timeout_remaining(void);
 void tst_set_timeout(int timeout);
 
-
 /*
  * Returns path to the test temporary directory in a newly allocated buffer.
  */
@@ -265,6 +267,9 @@ static struct tst_test test;
 
 int main(int argc, char *argv[])
 {
+	if (!tst_on_arch(test.arch))
+		tst_brk(TCONF, "Test needs running on %s arch!", test.arch);
+
 	tst_run_tcases(argc, argv, &test);
 }
 
diff --git a/lib/tst_arch.c b/lib/tst_arch.c
new file mode 100644
index 000000000..abc6f0722
--- /dev/null
+++ b/lib/tst_arch.c
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) 2019 Li Wang <liwang@redhat.com>
+ */
+
+#include <string.h>
+#include <stdlib.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_arch.h"
+#include "tst_test.h"
+
+static const char *const arch_type_list[] = {
+	"i386",
+	"x86",
+	"x86_64",
+	"ia64",
+	"ppc",
+	"ppc64",
+	"s390",
+	"s390x",
+	"arm",
+	"aarch64",
+	"sparc",
+	NULL
+};
+
+static int is_matched_arch(const char *arch, const char *tst_arch)
+{
+	char *dup_arch, *p;
+	const char *delim = " ";
+
+	dup_arch = strdup(arch);
+
+	p = strtok(dup_arch, delim);
+	if (strcmp(p, tst_arch) == 0)
+		return 1;
+
+	while ((p = strtok(NULL, delim))) {
+		if (strcmp(p, tst_arch) == 0)
+			return 1;
+	}
+
+	free(dup_arch);
+	return 0;
+}
+
+static int is_valid_arch(const char *arch)
+{
+	unsigned int i;
+
+	for (i = 0; arch_type_list[i]; i++) {
+		if (is_matched_arch(arch, arch_type_list[i]))
+			return 1;
+	}
+
+	return 0;
+}
+
+int tst_on_arch(const char *arch)
+{
+#if defined(__i386__)
+	char *tst_arch = "i386";
+#elif defined(__x86__)
+	char *tst_arch = "x86";
+#elif defined(__x86_64__)
+	char *tst_arch = "x86_64";
+#elif defined(__ia64__)
+	char *tst_arch = "ia64";
+#elif defined(__powerpc__)
+	char *tst_arch = "ppc";
+#elif defined(__powerpc64__)
+	char *tst_arch = "ppc64";
+#elif defined(__s390__)
+	char *tst_arch = "s390";
+#elif defined(__s390x__)
+	char *tst_arch = "s390x";
+#elif defined(__arm__)
+	char *tst_arch = "arm";
+#elif defined(__arch64__)
+	char *tst_arch = "aarch64";
+#elif defined(__sparc__)
+	char *tst_arch = "sparc";
+#endif
+
+	if (arch != NULL && !is_valid_arch(arch))
+		tst_brk(TBROK, "please set valid arches!");
+
+	if (arch == NULL || is_matched_arch(arch, tst_arch))
+		return 1;
+
+	return 0;
+}
-- 
2.20.1

