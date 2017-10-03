From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:55 +0200
Subject: [LTP] [COMMITTED] [PATCH 22/40] Make use of SAFE_MKFIFO()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-22-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/ipc/pipeio/pipeio.c        | 5 +----
 testcases/kernel/syscalls/dup/dup05.c       | 3 +--
 testcases/kernel/syscalls/select/select03.c | 6 ++----
 testcases/kernel/syscalls/unlink/unlink06.c | 7 ++-----
 4 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/ipc/pipeio/pipeio.c b/testcases/kernel/ipc/pipeio/pipeio.c
index 5aa082fd5..b9421cbea 100644
--- a/testcases/kernel/ipc/pipeio/pipeio.c
+++ b/testcases/kernel/ipc/pipeio/pipeio.c
@@ -478,10 +478,7 @@ static void setup(int argc, char *argv[])
 		pipe_type = PIPE_UNNAMED;
 		blk_type = UNNAMED_IO;
 	} else {
-		if (mkfifo(pname, 0777) == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				"mkfifo(%s, 0777) failed", pname);
-		}
+		SAFE_MKFIFO(cleanup, pname, 0777);
 		pipe_type = PIPE_NAMED;
 	}
 }
diff --git a/testcases/kernel/syscalls/dup/dup05.c b/testcases/kernel/syscalls/dup/dup05.c
index 3ef61cfa0..fc0e1f1d4 100644
--- a/testcases/kernel/syscalls/dup/dup05.c
+++ b/testcases/kernel/syscalls/dup/dup05.c
@@ -167,8 +167,7 @@ void setup(void)
 	tst_tmpdir();
 
 	sprintf(Fname, "dupfile");
-	if (mkfifo(Fname, 0777) == -1)
-		tst_brkm(TBROK, cleanup, "mkfifo failed");
+	SAFE_MKFIFO(cleanup, Fname, 0777);
 	if ((fd = open(Fname, O_RDWR, 0700)) == -1)
 		tst_brkm(TBROK, cleanup, "open failed");
 }
diff --git a/testcases/kernel/syscalls/select/select03.c b/testcases/kernel/syscalls/select/select03.c
index a9a81d0f9..da7fdb094 100644
--- a/testcases/kernel/syscalls/select/select03.c
+++ b/testcases/kernel/syscalls/select/select03.c
@@ -48,6 +48,7 @@
 #include <sys/stat.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define FILENAME	"select03"
 
@@ -113,10 +114,7 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	if (mkfifo(FILENAME, 0777) == -1) {
-		tst_brkm(TBROK, cleanup, "mkfifo(%s, 0777) failed, errno=%d",
-			 FILENAME, errno);
-	}
+	SAFE_MKFIFO(cleanup, FILENAME, 0777);
 
 	if ((Fd = open(FILENAME, O_RDWR)) == -1) {
 		tst_brkm(TBROK, cleanup, "open(%s, O_RDWR) failed, errno=%d",
diff --git a/testcases/kernel/syscalls/unlink/unlink06.c b/testcases/kernel/syscalls/unlink/unlink06.c
index 2f9601214..0e384804d 100644
--- a/testcases/kernel/syscalls/unlink/unlink06.c
+++ b/testcases/kernel/syscalls/unlink/unlink06.c
@@ -117,6 +117,7 @@
 #include <signal.h>
 #include <unistd.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void create_file();
@@ -210,9 +211,5 @@ void cleanup(void)
  ******************************************************************/
 void create_file(void)
 {
-	if (mkfifo(Fname, 0777) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "mkfifo(%s, 0777) failed errno:%d %s\n", Fname,
-			 errno, strerror(errno));
-	}
+	SAFE_MKFIFO(cleanup, Fname, 0777);
 }
-- 
2.13.5

