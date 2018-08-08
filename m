From: Li Wang <liwang@redhat.com>
Date: Wed,  8 Aug 2018 13:54:29 +0800
Subject: [LTP] [PATCH 1/6] execl: rewrite to newlib
In-Reply-To: <20180808055434.26293-1-liwang@redhat.com>
References: <20180808055434.26293-1-liwang@redhat.com>
Message-ID: <20180808055434.26293-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/execl/Makefile        | 14 ++--
 testcases/kernel/syscalls/execl/execl01.c       | 89 ++++++++-----------------
 testcases/kernel/syscalls/execl/execl01_child.c | 47 ++++++-------
 3 files changed, 57 insertions(+), 93 deletions(-)

diff --git a/testcases/kernel/syscalls/execl/Makefile b/testcases/kernel/syscalls/execl/Makefile
index bd617d8..a0e5f0f 100644
--- a/testcases/kernel/syscalls/execl/Makefile
+++ b/testcases/kernel/syscalls/execl/Makefile
@@ -1,19 +1,19 @@
 #
+#  Copyright (c) Linux Test Project, 2018
 #  Copyright (c) International Business Machines  Corp., 2001
 #
-#  This program is free software;  you can redistribute it and/or modify
+#  This program is free software: you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
+#  the Free Software Foundation, either version 2 of the License, or
 #  (at your option) any later version.
 #
 #  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
 #
 #  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#  along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
 
 top_srcdir		?= ../../../..
diff --git a/testcases/kernel/syscalls/execl/execl01.c b/testcases/kernel/syscalls/execl/execl01.c
index 1a4710d..421cfe2 100644
--- a/testcases/kernel/syscalls/execl/execl01.c
+++ b/testcases/kernel/syscalls/execl/execl01.c
@@ -1,85 +1,54 @@
 /*
+ * Copyright (c) 2018 Linux Test Project
+ * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *    AUTHOR		: William Roske
  *    CO-PILOT		: Dave Fenner
  *    DATE STARTED	: 06/01/02
- * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
+
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <errno.h>
 #include <string.h>
-#include <signal.h>
 #include <stdlib.h>
 
-#include "test.h"
+#include "tst_test.h"
 
-static void setup(void);
-
-char *TCID = "execl01";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void verify_execl(void)
 {
-	int lc;
 	pid_t pid;
-	char path[2048];
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	char path[512];
 
 	if (tst_get_path("execl01_child", path, sizeof(path)))
-		tst_brkm(TCONF, NULL, "Couldn't find execl01_child in $PATH");
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		switch (pid = FORK_OR_VFORK()) {
-		case 0:
-			execl(path, "execl01_child", "canary", NULL);
-			tst_brkm(TFAIL | TERRNO, NULL,
-			         "Failed to execute execl01_child");
-		case -1:
-			tst_brkm(TBROK | TERRNO, NULL, "fork failed");
-		default:
-			tst_record_childstatus(NULL, pid);
-		}
+		tst_brk(TCONF, "Couldn't find execl01_child in $PATH");
 
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		TEST(execl(path, "execl01_child", "canary", NULL));
+		tst_brk(TFAIL | TERRNO,
+			"Failed to execute execl01_child");
 	}
 
-	tst_exit();
+	SAFE_WAITPID(pid, NULL, 0);
 }
 
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, NULL);
-
-	TEST_PAUSE;
-}
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
+	.child_needs_reinit = 1,
+	.test_all = verify_execl,
+};
diff --git a/testcases/kernel/syscalls/execl/execl01_child.c b/testcases/kernel/syscalls/execl/execl01_child.c
index a339e53..8a6e512 100644
--- a/testcases/kernel/syscalls/execl/execl01_child.c
+++ b/testcases/kernel/syscalls/execl/execl01_child.c
@@ -1,40 +1,35 @@
 /*
+ * Copyright (c) 2018 Linux Test Project
  * Copyright (C) 2015 Cyril Hrubis chrubis@suse.cz
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
  *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "test.h"
-
-char *TCID = "execl01_child";
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
 
 int main(int argc, char *argv[])
 {
+	tst_reinit();
+
 	if (argc != 2)
-		tst_brkm(TFAIL, NULL, "argc is %d, expected 2", argc);
+		tst_brk(TFAIL, "argc is %d, expected 2", argc);
+
+	if (strcmp(argv[1], "canary"))
+		tst_brk(TFAIL, "argv[1] is %s, expected 'canary'", argv[1]);
 
-	if (strcmp(argv[1], "canary")) {
-		tst_brkm(TFAIL, NULL, "argv[1] is %s, expected 'canary'",
-		         argv[1]);
-	}
+	tst_res(TPASS, "%s executed", argv[0]);
 
-	tst_resm(TPASS, "%s executed", argv[0]);
-	tst_exit();
+	return 0;
 }
-- 
2.9.5

