From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Jun 2019 16:14:27 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/futex: Get rid of futex_common.h
Message-ID: <20190620141427.26338-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There is no point in passing fd to anynomous mapping, the fd was ignored
to begin with.

This commit just moves the mmap() to particular tests as there is no
point in having helper just for one mmap() call and removes the
futex_common.h completely.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/futex/futex_common.h      | 46 -------------------
 .../kernel/syscalls/futex/futex_wait02.c      | 11 ++++-
 .../kernel/syscalls/futex/futex_wake03.c      | 11 ++++-
 3 files changed, 20 insertions(+), 48 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/futex/futex_common.h

diff --git a/testcases/kernel/syscalls/futex/futex_common.h b/testcases/kernel/syscalls/futex/futex_common.h
deleted file mode 100644
index 231fdc67e..000000000
--- a/testcases/kernel/syscalls/futex/futex_common.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
- *
- * Licensed under the GNU GPLv2 or later.
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
- /*
-  * Setups futex in shared memory needed for synchronization between multiple
-  * processes.
-  */
-
-static futex_t *futex;
-
-static void setup(void)
-{
-	int fd;
-
-	fd = shm_open("/LTP_futex_wait", O_RDWR | O_CREAT | O_EXCL, 0);
-
-	if (fd < 0) {
-		tst_brkm(TBROK | TERRNO, NULL,
-		         "shm_open(/LTP_futex_wait,O_RDWR|O_CREAT|O_EXCL,775)");
-	}
-	if (shm_unlink("/LTP_futex_wait"))
-		tst_brkm(TBROK | TERRNO, NULL, "shm_unlink(/LTP_futex_wait)");
-
-	futex = SAFE_MMAP(NULL, NULL, sizeof(*futex), PROT_READ | PROT_WRITE,
-			  MAP_ANONYMOUS | MAP_SHARED, fd, 0);
-
-	SAFE_CLOSE(NULL, fd);
-
-	*futex = FUTEX_INITIALIZER;
-}
diff --git a/testcases/kernel/syscalls/futex/futex_wait02.c b/testcases/kernel/syscalls/futex/futex_wait02.c
index 2b863fe7c..1ca1df457 100644
--- a/testcases/kernel/syscalls/futex/futex_wait02.c
+++ b/testcases/kernel/syscalls/futex/futex_wait02.c
@@ -29,11 +29,12 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "futextest.h"
-#include "futex_common.h"
 
 const char *TCID="futex_wait02";
 const int TST_TOTAL=1;
 
+static futex_t *futex;
+
 static void do_child(void)
 {
 	int ret;
@@ -81,6 +82,14 @@ static void verify_futex_wait(void)
 		tst_resm(TFAIL, "child failed");
 }
 
+static void setup(void)
+{
+	futex = SAFE_MMAP(NULL, NULL, sizeof(*futex), PROT_READ | PROT_WRITE,
+			  MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+
+	*futex = FUTEX_INITIALIZER;
+}
+
 int main(int argc, char *argv[])
 {
 	int lc;
diff --git a/testcases/kernel/syscalls/futex/futex_wake03.c b/testcases/kernel/syscalls/futex/futex_wake03.c
index 523f32851..d6e5e5422 100644
--- a/testcases/kernel/syscalls/futex/futex_wake03.c
+++ b/testcases/kernel/syscalls/futex/futex_wake03.c
@@ -27,11 +27,12 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "futextest.h"
-#include "futex_common.h"
 
 const char *TCID="futex_wake03";
 const int TST_TOTAL=11;
 
+static futex_t *futex;
+
 static void do_child(void)
 {
 	futex_wait(futex, *futex, NULL, 0);
@@ -103,6 +104,14 @@ static void verify_futex_wake(void)
 	}
 }
 
+static void setup(void)
+{
+	futex = SAFE_MMAP(NULL, NULL, sizeof(*futex), PROT_READ | PROT_WRITE,
+			  MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+
+	*futex = FUTEX_INITIALIZER;
+}
+
 int main(int argc, char *argv[])
 {
 	int lc;
-- 
2.19.2

