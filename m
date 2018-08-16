From: Li Wang <liwang@redhat.com>
Date: Thu, 16 Aug 2018 16:07:24 +0800
Subject: [LTP] [PATCH] pty: fix some issues in pty02
Message-ID: <20180816080724.25143-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Add EXTPROC into lapi

2. Exit the test with TCONF if we get EINVAL from tcsetattr()

3. Giving newline('\n') to ptmx to avoid reading pts block on rhel6

4. Using tcgetattr() to get attributes before re-setting it
Fix this error:
   tst_test.c:1015: INFO: Timeout per run is 0h 50m 00s
   pty02.c:42: BROK: tcsetattr() failed: EINVAL

POSIX.1 General description:
  Changes the attributes associated with a terminal. New attributes are
  specified with a termios control structure. Programs should always
  issue a tcgetattr() first, modify the desired fields, and then issue
  a tcsetattr(). tcsetattr() should never be issued using a termios
  structure that was not obtained using tcgetattr(). tcsetattr() should
  use only a termios structure that was obtained by tcgetattr().

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 include/lapi/termbits.h      | 25 +++++++++++++++++++++++++
 testcases/kernel/pty/pty02.c | 21 ++++++++++++++++++---
 2 files changed, 43 insertions(+), 3 deletions(-)
 create mode 100644 include/lapi/termbits.h

diff --git a/include/lapi/termbits.h b/include/lapi/termbits.h
new file mode 100644
index 0000000..23ad5a7
--- /dev/null
+++ b/include/lapi/termbits.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2018 Linux Test Project
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
+ * along with this program; if not, write the Free Software Foundation
+ */
+
+#ifndef LAPI_TERMBITS_H__
+#define LAPI_TERMBITS_H__
+
+#ifndef EXTPROC
+# define EXTPROC     0200000
+#endif
+
+#endif
diff --git a/testcases/kernel/pty/pty02.c b/testcases/kernel/pty/pty02.c
index fd3d26b..8720407 100644
--- a/testcases/kernel/pty/pty02.c
+++ b/testcases/kernel/pty/pty02.c
@@ -25,27 +25,42 @@
  */
 
 #include <stdlib.h>
+#include <errno.h>
 #include <termio.h>
 
 #include "tst_test.h"
+#include "lapi/termbits.h"
 
 static void do_test(void)
 {
-	struct termios io = { .c_lflag = EXTPROC | ICANON };
+	struct termios io;
 	int ptmx, pts;
 	char c = 'A';
+	char n = '\n';
 	int nbytes;
 
 	ptmx = SAFE_OPEN("/dev/ptmx", O_WRONLY);
 
-	if (tcsetattr(ptmx, TCSANOW, &io) != 0)
-		tst_brk(TBROK | TERRNO, "tcsetattr() failed");
+	if (tcgetattr(ptmx, &io) != 0)
+		tst_brk(TBROK | TERRNO, "tcgetattr() failed");
+
+	io.c_lflag = EXTPROC | ICANON;
+
+	TEST(tcsetattr(ptmx, TCSANOW, &io));
+	if (TEST_RETURN == -1) {
+		if (TEST_ERRNO == EINVAL)
+			tst_res(TCONF, "tcsetattr(, , EXTPROC | ICANON) is not supported");
+		else
+			tst_brk(TBROK | TERRNO, "tcsetattr() failed");
+	}
 
 	if (unlockpt(ptmx) != 0)
 		tst_brk(TBROK | TERRNO, "unlockpt() failed");
 
 	pts = SAFE_OPEN(ptsname(ptmx), O_RDONLY);
 	SAFE_WRITE(1, ptmx, &c, 1);
+	/* giving newline('\n') to ptmx to avoid reading pts block */
+	SAFE_WRITE(1, ptmx, &n, 1);
 	SAFE_READ(1, pts, &c, 1);
 
 	tst_res(TINFO, "Calling FIONREAD, this will hang in n_tty_ioctl() if the bug is present...");
-- 
2.9.5

