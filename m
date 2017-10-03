From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:34 +0200
Subject: [LTP] [COMMITTED] [PATCH 01/40] Make use of SAFE_CHDIR()
Message-ID: <20171003142013.25230-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/self_exec.c                           |  7 ++-----
 testcases/kernel/fs/ftest/ftest01.c       |  4 ++--
 testcases/kernel/fs/ftest/ftest03.c       |  6 ++----
 testcases/kernel/fs/ftest/ftest05.c       |  5 ++---
 testcases/kernel/fs/ftest/ftest07.c       |  6 ++----
 testcases/kernel/syscalls/clone/clone02.c | 11 ++---------
 testcases/kernel/syscalls/mknod/mknod02.c |  6 ++----
 testcases/kernel/syscalls/mknod/mknod03.c |  6 ++----
 testcases/kernel/syscalls/mknod/mknod04.c |  6 ++----
 testcases/kernel/syscalls/mknod/mknod05.c |  6 ++----
 testcases/kernel/syscalls/mknod/mknod08.c |  6 ++----
 11 files changed, 22 insertions(+), 47 deletions(-)

diff --git a/lib/self_exec.c b/lib/self_exec.c
index c287ce913..de7d09517 100644
--- a/lib/self_exec.c
+++ b/lib/self_exec.c
@@ -32,6 +32,7 @@
 #include <string.h>
 #include <stdio.h>
 #include "test.h"
+#include "safe_macros.h"
 
 /* Set from parse_opts.c: */
 char *child_args;		/* Arguments to child when -C is used */
@@ -152,11 +153,7 @@ void maybe_run_child(void (*child) (), const char *fmt, ...)
 
 		va_end(ap);
 		free(args);
-		if (chdir(child_dir) < 0) {
-			tst_brkm(TBROK, NULL,
-				 "Could not change to %s for child", child_dir);
-			return;
-		}
+		SAFE_CHDIR(NULL, child_dir);
 
 		(*child) ();
 		tst_resm(TWARN, "Child function returned unexpectedly");
diff --git a/testcases/kernel/fs/ftest/ftest01.c b/testcases/kernel/fs/ftest/ftest01.c
index 2dfc92a0a..f7e320cd9 100644
--- a/testcases/kernel/fs/ftest/ftest01.c
+++ b/testcases/kernel/fs/ftest/ftest01.c
@@ -59,6 +59,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include "test.h"
+#include "safe_macros.h"
 #include "libftest.h"
 
 char *TCID = "ftest01";
@@ -129,8 +130,7 @@ static void setup(void)
 
 	mkdir(fuss, 0755);
 
-	if (chdir(fuss) < 0)
-		tst_brkm(TBROK | TERRNO, NULL, "chdir failed");
+	SAFE_CHDIR(NULL, fuss);
 
 	/*
 	 * Default values for run conditions.
diff --git a/testcases/kernel/fs/ftest/ftest03.c b/testcases/kernel/fs/ftest/ftest03.c
index 9dc47c942..4d0fc803a 100644
--- a/testcases/kernel/fs/ftest/ftest03.c
+++ b/testcases/kernel/fs/ftest/ftest03.c
@@ -64,6 +64,7 @@
 #include <stdio.h>
 #include <inttypes.h>
 #include "test.h"
+#include "safe_macros.h"
 #include "libftest.h"
 
 char *TCID = "ftest03";
@@ -149,10 +150,7 @@ static void setup(void)
 
 	mkdir(fuss, 0755);
 
-	if (chdir(fuss) < 0) {
-		tst_brkm(TBROK, NULL, "\tCan't chdir(%s), error %d.", fuss,
-			 errno);
-	}
+	SAFE_CHDIR(NULL, fuss);
 
 	/*
 	 * Default values for run conditions.
diff --git a/testcases/kernel/fs/ftest/ftest05.c b/testcases/kernel/fs/ftest/ftest05.c
index da15c971a..b647f8b06 100644
--- a/testcases/kernel/fs/ftest/ftest05.c
+++ b/testcases/kernel/fs/ftest/ftest05.c
@@ -63,6 +63,7 @@
 #include <inttypes.h>
 #include <sys/param.h>
 #include "test.h"
+#include "safe_macros.h"
 #include "libftest.h"
 
 char *TCID = "ftest05";
@@ -137,9 +138,7 @@ static void setup(void)
 
 	mkdir(fuss, 0755);
 
-	if (chdir(fuss) < 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "\tCan't chdir(%s)", fuss);
-	}
+	SAFE_CHDIR(NULL, fuss);
 
 	/*
 	 * Default values for run conditions.
diff --git a/testcases/kernel/fs/ftest/ftest07.c b/testcases/kernel/fs/ftest/ftest07.c
index 915d01540..f80f1922f 100644
--- a/testcases/kernel/fs/ftest/ftest07.c
+++ b/testcases/kernel/fs/ftest/ftest07.c
@@ -70,6 +70,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include "test.h"
+#include "safe_macros.h"
 #include "libftest.h"
 
 char *TCID = "ftest07";
@@ -152,10 +153,7 @@ static void setup(void)
 
 	mkdir(fuss, 0755);
 
-	if (chdir(fuss) < 0) {
-		tst_brkm(TBROK, NULL, "\tCan't chdir(%s), error %d.", fuss,
-			 errno);
-	}
+	SAFE_CHDIR(NULL, fuss);
 
 	/*
 	 * Default values for run conditions.
diff --git a/testcases/kernel/syscalls/clone/clone02.c b/testcases/kernel/syscalls/clone/clone02.c
index 3f61d2297..d864aaea5 100644
--- a/testcases/kernel/syscalls/clone/clone02.c
+++ b/testcases/kernel/syscalls/clone/clone02.c
@@ -63,6 +63,7 @@
 #include <sys/syscall.h>
 #include <sched.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #define FLAG_ALL (CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|SIGCHLD)
 #define FLAG_NONE SIGCHLD
@@ -250,15 +251,7 @@ static void test_cleanup(void)
 {
 
 	/* Restore parent's working directory */
-	if (chdir(cwd_parent) == -1) {
-		/*
-		 * we have to exit here
-		 *
-		 * XXX (garrcoop): why???
-		 */
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "chdir() failed in test_cleanup()");
-	}
+	SAFE_CHDIR(cleanup, cwd_parent);
 
 }
 
diff --git a/testcases/kernel/syscalls/mknod/mknod02.c b/testcases/kernel/syscalls/mknod/mknod02.c
index 07c204841..85ae1409b 100644
--- a/testcases/kernel/syscalls/mknod/mknod02.c
+++ b/testcases/kernel/syscalls/mknod/mknod02.c
@@ -80,6 +80,7 @@
 #include <sys/stat.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define LTPUSER		"nobody"
 #define MODE_RWX	S_IFIFO | S_IRWXU | S_IRWXG | S_IRWXO
@@ -279,10 +280,7 @@ void setup(void)
 	mygid = getgid();
 
 	/* Change directory to DIR_TEMP */
-	if (chdir(DIR_TEMP) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "Unable to change to %s directory", DIR_TEMP);
-	}
+	SAFE_CHDIR(cleanup, DIR_TEMP);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/mknod/mknod03.c b/testcases/kernel/syscalls/mknod/mknod03.c
index 4318bb9b6..3d4e3c37f 100644
--- a/testcases/kernel/syscalls/mknod/mknod03.c
+++ b/testcases/kernel/syscalls/mknod/mknod03.c
@@ -80,6 +80,7 @@
 #include <sys/stat.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define LTPUSER		"nobody"
 #define MODE_RWX	S_IFIFO | S_IRWXU | S_IRWXG | S_IRWXO
@@ -279,10 +280,7 @@ void setup(void)
 	mygid = getgid();
 
 	/* Change directory to DIR_TEMP */
-	if (chdir(DIR_TEMP) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "Unable to change to %s directory", DIR_TEMP);
-	}
+	SAFE_CHDIR(cleanup, DIR_TEMP);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/mknod/mknod04.c b/testcases/kernel/syscalls/mknod/mknod04.c
index 4b7f42f51..67c31fe58 100644
--- a/testcases/kernel/syscalls/mknod/mknod04.c
+++ b/testcases/kernel/syscalls/mknod/mknod04.c
@@ -80,6 +80,7 @@
 #include <sys/stat.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define LTPUSER		"nobody"
 #define MODE_RWX	S_IFIFO | S_IRWXU | S_IRWXG | S_IRWXO
@@ -281,10 +282,7 @@ void setup(void)
 	mygid = getgid();
 
 	/* Change directory to DIR_TEMP */
-	if (chdir(DIR_TEMP) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "Unable to change to %s directory", DIR_TEMP);
-	}
+	SAFE_CHDIR(cleanup, DIR_TEMP);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/mknod/mknod05.c b/testcases/kernel/syscalls/mknod/mknod05.c
index a9b395fe1..0808971ed 100644
--- a/testcases/kernel/syscalls/mknod/mknod05.c
+++ b/testcases/kernel/syscalls/mknod/mknod05.c
@@ -80,6 +80,7 @@
 #include <sys/stat.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define LTPUSER		"nobody"
 #define MODE_RWX	S_IFIFO | S_IRWXU | S_IRWXG | S_IRWXO
@@ -256,10 +257,7 @@ void setup(void)
 	}
 
 	/* Change directory to DIR_TEMP */
-	if (chdir(DIR_TEMP) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "Unable to change to %s directory", DIR_TEMP);
-	}
+	SAFE_CHDIR(cleanup, DIR_TEMP);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/mknod/mknod08.c b/testcases/kernel/syscalls/mknod/mknod08.c
index 5d3f6872a..6937da532 100644
--- a/testcases/kernel/syscalls/mknod/mknod08.c
+++ b/testcases/kernel/syscalls/mknod/mknod08.c
@@ -80,6 +80,7 @@
 #include <sys/stat.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define LTPUSER		"nobody"
 #define MODE_RWX	S_IFIFO | S_IRWXU | S_IRWXG | S_IRWXO
@@ -274,10 +275,7 @@ void setup(void)
 	mygid = getgid();
 
 	/* Change directory to DIR_TEMP */
-	if (chdir(DIR_TEMP) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "Unable to change to %s directory", DIR_TEMP);
-	}
+	SAFE_CHDIR(cleanup, DIR_TEMP);
 }
 
 /*
-- 
2.13.5

