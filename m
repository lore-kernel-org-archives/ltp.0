From: Sandeep Patil <sspatil@android.com>
Date: Mon, 25 Mar 2019 16:20:09 -0700
Subject: [LTP] [RFC PATCH 1/4] syscalls/abort01: convert to new library
In-Reply-To: <20190325232012.67123-1-sspatil@android.com>
References: <20190325232012.67123-1-sspatil@android.com>
Message-ID: <20190325232012.67123-2-sspatil@android.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Sandeep Patil <sspatil@google.com>

In the process, drop checks for UCLINUX and WCOREDUMP.
Make the test simple and remove all the logic to detect if a
system is "in stress".

Signed-off-by: Sandeep Patil <sspatil@android.com>
---
 testcases/kernel/syscalls/abort/abort01.c | 171 ++++++----------------
 1 file changed, 48 insertions(+), 123 deletions(-)

diff --git a/testcases/kernel/syscalls/abort/abort01.c b/testcases/kernel/syscalls/abort/abort01.c
index 3a5dff585..ac5ddb140 100644
--- a/testcases/kernel/syscalls/abort/abort01.c
+++ b/testcases/kernel/syscalls/abort/abort01.c
@@ -1,25 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
 /*
  *   Copyright (c) International Business Machines  Corp., 2002
  *   01/02/2003	Port to LTP	avenkat@us.ibm.com
  *   11/11/2002: Ported to LTP Suite by Ananda
  *   06/30/2001	Port to Linux	nsharoff@us.ibm.com
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
- /* ALGORITHM
+ * ALGORITHM
  *	Fork child.  Have child abort, check return status.
  *
  * RESTRICTIONS
@@ -35,132 +22,70 @@
 #include <unistd.h>
 #include <sys/resource.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
-#define NUM 3
-
-char *TCID = "abort01";
-int TST_TOTAL = 1;
-
-static void setup(void);
-static void cleanup(void);
-static void do_child();
-static int instress();
+static void do_child(void)
+{
+	abort();
+	fprintf(stderr, "\tchild - abort failed.\n");
+	exit(1);
+}
 
-int main(int argc, char *argv[])
+void verify_abort(unsigned int nr)
 {
-	register int i;
-	int status, count, child, kidpid;
+	int i;
+	int status, child, kidpid;
 	int sig, ex;
-
-#ifdef WCOREDUMP
 	int core;
-	core = 0;
-#endif
-	ex = sig = 0;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "");
-#endif
-
-	setup();
-
-	for (i = 0; i < NUM; i++) {
-		kidpid = FORK_OR_VFORK();
-		if (kidpid == 0) {
-#ifdef UCLINUX
-			if (self_exec(argv[0], "")) {
-				if (!instress()) {
-					perror("fork failed");
-					exit(1);
-				}
-			}
-#else
-			do_child();
-#endif
-		}
-		if (kidpid < 0)
-			if (!instress())
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "fork failed");
-		count = 0;
-		while ((child = wait(&status)) > 0)
-			count++;
-		if (count != 1) {
-			tst_brkm(TBROK, cleanup,
-				 "wrong # children waited on; got %d, expected 1",
-				 count);
-		}
-		if (WIFSIGNALED(status)) {
+	core = ex = sig = 0;
 
-#ifdef WCOREDUMP
-			core = WCOREDUMP(status);
-#endif
-			sig = WTERMSIG(status);
+	kidpid = SAFE_FORK();
+	if (kidpid == 0)
+		do_child();
 
-		}
-		if (WIFEXITED(status))
-			ex = WEXITSTATUS(status);
+	child = SAFE_WAIT(&status);
 
-#ifdef WCOREDUMP
-		if (core == 0) {
-			tst_brkm(TFAIL, cleanup,
-				 "Child did not dump core; exit code = %d, "
-				 "signal = %d", ex, sig);
-		} else if (core != -1) {
-			tst_resm(TPASS, "abort dumped core");
-		}
-#endif
-		if (sig == SIGIOT) {
-			tst_resm(TPASS, "abort raised SIGIOT");
-		} else {
-			tst_brkm(TFAIL, cleanup,
-				 "Child did not raise SIGIOT (%d); exit code = %d, "
-				 "signal = %d", SIGIOT, ex, sig);
-		}
+	if (WIFSIGNALED(status)) {
+		core = WCOREDUMP(status);
+		sig = WTERMSIG(status);
 
 	}
 
-	cleanup();
-	tst_exit();
+	if (WIFEXITED(status))
+		ex = WEXITSTATUS(status);
+
+	if (core == 0)
+		tst_brk(TFAIL,
+			"Missing core dump; exit(%d), signal(%d)",
+			ex, sig);
+	else if (core != -1)
+		tst_res(TPASS, "abort() dumped core");
+
+	if (sig == SIGIOT)
+		tst_res(TPASS, "abort() raised SIGIOT");
+	else
+		tst_brk(TFAIL,
+			"Unexpected signal(%d), expected SIGIOT(%d)",
+			sig, SIGIOT);
 }
 
-/* 1024 GNU blocks */
-#define MIN_RLIMIT_CORE (1024 * 1024)
-
 static void setup(void)
 {
+#define MIN_RLIMIT_CORE (1024 * 1024)
 	struct rlimit rlim;
 
-	SAFE_GETRLIMIT(NULL, RLIMIT_CORE, &rlim);
-
+	/* make sure we get core dumps */
+	SAFE_GETRLIMIT(RLIMIT_CORE, &rlim);
 	if (rlim.rlim_cur < MIN_RLIMIT_CORE) {
-		tst_resm(TINFO, "Adjusting RLIMIT_CORE to %i", MIN_RLIMIT_CORE);
 		rlim.rlim_cur = MIN_RLIMIT_CORE;
-		SAFE_SETRLIMIT(NULL, RLIMIT_CORE, &rlim);
+		SAFE_SETRLIMIT(RLIMIT_CORE, &rlim);
 	}
-
-	tst_tmpdir();
 }
 
-static void cleanup(void)
-{
-	unlink("core");
-	tst_rmdir();
-}
-
-static void do_child(void)
-{
-	abort();
-	fprintf(stderr, "\tchild - abort failed.\n");
-	exit(1);
-}
-
-static int instress(void)
-{
-	tst_resm(TINFO,
-		 "System resources may be too low; fork(), select() etc are likely to fail.");
-	return 1;
-}
+static struct tst_test test = {
+	.tcnt = 3,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.test = verify_abort,
+};
-- 
2.21.0.392.gf8f6787159e-goog

