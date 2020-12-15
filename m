From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 15 Dec 2020 07:07:02 +0100
Subject: [LTP] [RFC] openposix: Use TMPDIR instead of hardcoded /tmp
Message-ID: <20201215060702.507970-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Hi everyone,

There are lots of code snippets like

snprintf(fname, sizeof(fname), "/tmp/<some_name>_%d", getpid());
unlink(fname);
open(fname, ...);

throughout the open posix tests.
I'd like to get rid of the hardcoded /tmp paths and replace them
with TMPDIR, if it is set. Because the pattern is mostly the same,
I'd like to generalize the implementation. Currently there is no library
linked to the open_posix tests, that's why I choose a static inline
function implemented in posixtests.h.
This could also be enhanced to use mkstemp and return the filehandle
directly, because most of the time the file is opend anyway.

What is your opionion? Does a change like this make sense or would
you do it differently?

Thanks,
J?rg


---
 .../conformance/interfaces/mmap/5-1.c               |  3 ++-
 testcases/open_posix_testsuite/include/posixtest.h  | 13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/5-1.c
index d9d476bd5..fb98cb877 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/5-1.c
@@ -93,7 +93,8 @@ int main(void)
 	int fd, fail = 0;
 	unsigned int i;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_5_1_%d", getpid());
+	GET_TMP_FILENAME(tmpfname, "pts_mmap_5_1");
+
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/include/posixtest.h b/testcases/open_posix_testsuite/include/posixtest.h
index cf0952cbf..e0f1f0214 100644
--- a/testcases/open_posix_testsuite/include/posixtest.h
+++ b/testcases/open_posix_testsuite/include/posixtest.h
@@ -9,6 +9,9 @@
 /*
  * return codes
  */
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
 
 #define PTS_PASS        0
 #define PTS_FAIL        1
@@ -23,3 +26,13 @@
 #define LTP_ATTRIBUTE_NORETURN		__attribute__((noreturn))
 #define LTP_ATTRIBUTE_UNUSED		__attribute__((unused))
 #define LTP_ATTRIBUTE_UNUSED_RESULT	__attribute__((warn_unused_result))
+
+#define GET_TMP_FILENAME(target, prefix) \
+    snprintf(target, sizeof(target), "%s/" prefix "%d",  tmpdir(), getpid());
+
+static inline const char *tmpdir(void)
+{
+    const char *tmpdir_env;
+    tmpdir_env = getenv("TMPDIR");
+    return tmpdir_env ? tmpdir_env : "/tmp";
+}
-- 
2.25.1

