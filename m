From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  7 Mar 2017 11:47:44 +0100
Subject: [LTP] [COMMITTED] [PATCH] syscalls/getcwd02: Fix failures on
	symlinked /tmp
Message-ID: <20170307104744.4067-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This test had the same problem as getcwd01.

In order not to fail the test on symlinked /tmp we call realpath() on
/tmp in the test setup to initialize the expected test output and also
adjust the sizes of the buffers.

Fixes #133.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/getcwd/getcwd02.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/getcwd/getcwd02.c b/testcases/kernel/syscalls/getcwd/getcwd02.c
index bf02140..09fa190 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd02.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd02.c
@@ -29,8 +29,10 @@
 #include <string.h>
 #include "tst_test.h"
 
-static const char *exp_buf = "/tmp";
-static char buffer[5];
+#define TMPDIR "/tmp"
+
+static char exp_buf[PATH_MAX];
+static char buffer[PATH_MAX];
 
 static struct t_case {
 	char *buf;
@@ -38,7 +40,7 @@ static struct t_case {
 } tcases[] = {
 	{buffer, sizeof(buffer)},
 	{NULL, 0},
-	{NULL, 5}
+	{NULL, PATH_MAX}
 };
 
 static void verify_getcwd(unsigned int n)
@@ -69,7 +71,12 @@ end:
 
 static void setup(void)
 {
-	SAFE_CHDIR("/tmp");
+	SAFE_CHDIR(TMPDIR);
+
+	if (!realpath(TMPDIR, exp_buf))
+		tst_brk(TBROK | TERRNO, "realpath() failed");
+
+	tst_res(TINFO, "Expected path '%s'", exp_buf);
 }
 
 static struct tst_test test = {
-- 
2.10.2

