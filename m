From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Oct 2017 17:33:37 +0200
Subject: [LTP] [RFC] [PATCH 1/2] lib: Add tst_strstatus()
Message-ID: <20171012153338.1233-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This function returns a string describing status as returned by 'wait()'
call. This is expected to be used when we want to TBROK a test if child
haven't terminated in an expected way.

The fucntion is not thread safe, since it uses static buffer, but I
doubt that we actually care in this case and making it thread-safe would
have complicated the nice and simple API.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/test-writing-guidelines.txt    |  9 ++++++
 include/tst_test.h                 |  6 ++++
 lib/newlib_tests/.gitignore        |  1 +
 lib/newlib_tests/test_str_status.c | 49 ++++++++++++++++++++++++++++++
 lib/tst_status.c                   | 62 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 127 insertions(+)
 create mode 100644 lib/newlib_tests/test_str_status.c
 create mode 100644 lib/tst_status.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 15d418954..edc1f602d 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -449,6 +449,15 @@ translate 'errno' values to strings is preferred. You should not use the
 
 [source,c]
 -------------------------------------------------------------------------------
+const char *tst_strstatus(int status);
+-------------------------------------------------------------------------------
+
+Returns string describing the status as returned by 'wait()'.
+
+WARNING: This funciton is not thread safe.
+
+[source,c]
+-------------------------------------------------------------------------------
 void tst_set_timeout(unsigned int timeout);
 -------------------------------------------------------------------------------
 
diff --git a/include/tst_test.h b/include/tst_test.h
index ad468e8cf..f9872d973 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -186,6 +186,12 @@ extern int TEST_ERRNO;
  */
 const char *tst_strerrno(int err);
 const char *tst_strsig(int sig);
+/*
+ * Returns string describing status as returned by wait().
+ *
+ * BEWARE: Not thread safe.
+ */
+const char *tst_strstatus(int status);
 
 void tst_set_timeout(int timeout);
 
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index d47a6ea12..e10cbdb72 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -17,3 +17,4 @@ test16
 tst_device
 tst_safe_fileops
 tst_res_hexd
+test_str_status
diff --git a/lib/newlib_tests/test_str_status.c b/lib/newlib_tests/test_str_status.c
new file mode 100644
index 000000000..706ec1144
--- /dev/null
+++ b/lib/newlib_tests/test_str_status.c
@@ -0,0 +1,49 @@
+/*
+ * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
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
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+/*
+ * The test should abort when oldlib function is called from newlib.
+ */
+
+#include "tst_test.h"
+
+static struct tcase {
+	int status;
+	const char *str;
+} tcases[] = {
+	{0x0100, "exitted with 1"},
+	{0x0001, "killed by SIGHUP"},
+	{0x137f, "is stopped"},
+	{0xffff, "is resumed"},
+	{0xff, "invalid status 0xff"},
+};
+
+static void do_test(unsigned int n)
+{
+	const char *str_status = tst_strstatus(tcases[n].status);
+
+	if (strcmp(str_status, tcases[n].str))
+		tst_res(TFAIL, "%s != %s", str_status, tcases[n].str);
+	else
+		tst_res(TPASS, "%s", str_status);
+}
+
+static struct tst_test test = {
+	.test = do_test,
+	.tcnt = ARRAY_SIZE(tcases),
+};
diff --git a/lib/tst_status.c b/lib/tst_status.c
new file mode 100644
index 000000000..4bd38e547
--- /dev/null
+++ b/lib/tst_status.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
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
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <stdio.h>
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+static char buf[32];
+
+const char *exited(int status)
+{
+	snprintf(buf, sizeof(buf), "exitted with %i", WEXITSTATUS(status));
+
+	return buf;
+}
+
+const char *signaled(int status)
+{
+	snprintf(buf, sizeof(buf), "killed by %s", tst_strsig(status));
+
+	return buf;
+}
+
+const char *invalid(int status)
+{
+	snprintf(buf, sizeof(buf), "invalid status 0x%x", status);
+
+	return buf;
+}
+
+const char *tst_strstatus(int status)
+{
+	if (WIFEXITED(status))
+		return exited(status);
+
+	if (WIFSIGNALED(status))
+		return signaled(status);
+
+	if (WIFSTOPPED(status))
+		return "is stopped";
+
+	if (WIFCONTINUED(status))
+		return "is resumed";
+
+	return invalid(status);
+}
-- 
2.13.5

