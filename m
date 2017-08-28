From: Sandeep Patil <sspatil@google.com>
Date: Mon, 28 Aug 2017 09:40:43 -0700
Subject: [LTP] [PATCH v2 2/2] android: getcwd02: use temp dir from $TMPDIR
	if present
In-Reply-To: <20170828164043.93407-1-sspatil@google.com>
References: <20170828164043.93407-1-sspatil@google.com>
Message-ID: <20170828164043.93407-3-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

getcwd02 test are broken on an Android system as the device doesn't have
"/tmp", so make sure the test checks if a directory exists before using
it as a temporary directory. Look for an altternative path in 'TMPDIR'
environment variable and fallback to using that as the temporary
directory for the test if /tmp is not found.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 testcases/kernel/syscalls/getcwd/getcwd02.c | 43 +++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/getcwd/getcwd02.c b/testcases/kernel/syscalls/getcwd/getcwd02.c
index 384157d42..cff2124b7 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd02.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd02.c
@@ -27,9 +27,12 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
 #include "tst_test.h"
 
-#define TMPDIR "/tmp"
+#define GETCWD_TMPDIR_PATH	"/tmp"
 
 static char exp_buf[PATH_MAX];
 static char buffer[PATH_MAX];
@@ -43,6 +46,38 @@ static struct t_case {
 	{NULL, PATH_MAX}
 };
 
+static int dir_exists(const char *dirpath)
+{
+	struct stat sb;
+
+	if (!stat(dirpath, &sb) && S_ISDIR(sb.st_mode))
+		return 1;
+
+	return 0;
+}
+
+static const char *get_tmpdir_path(void)
+{
+	char *tmpdir = GETCWD_TMPDIR_PATH;
+
+	if (dir_exists(tmpdir))
+		goto done;
+
+	/* fallback to $TMPDIR */
+	tmpdir = getenv("TMPDIR");
+	if (!tmpdir)
+		tst_brk(TBROK | TERRNO, "Failed to get $TMPDIR");
+
+	if (tmpdir[0] != '/')
+		tst_brk(TBROK, "$TMPDIR must be an absolute path");
+
+	if (!dir_exists(tmpdir))
+		tst_brk(TBROK | TERRNO, "TMPDIR '%s' doesn't exist", tmpdir);
+
+done:
+	return tmpdir;
+}
+
 static void verify_getcwd(unsigned int n)
 {
 	struct t_case *tc = &tcases[n];
@@ -71,9 +106,11 @@ end:
 
 static void setup(void)
 {
-	SAFE_CHDIR(TMPDIR);
+	const char *tmpdir = get_tmpdir_path();
+
+	SAFE_CHDIR(tmpdir);
 
-	if (!realpath(TMPDIR, exp_buf))
+	if (!realpath(tmpdir, exp_buf))
 		tst_brk(TBROK | TERRNO, "realpath() failed");
 
 	tst_res(TINFO, "Expected path '%s'", exp_buf);
-- 
2.14.1.342.g6490525c54-goog

