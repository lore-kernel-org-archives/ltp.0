From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:20:04 +0200
Subject: [LTP] [COMMITTED] [PATCH 31/40] Make use of SAFE_FSTAT()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-31-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/dup2/dup202.c | 9 +++------
 testcases/kernel/syscalls/dup2/dup204.c | 8 ++------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup202.c b/testcases/kernel/syscalls/dup2/dup202.c
index daff81fc4..15443ef3d 100644
--- a/testcases/kernel/syscalls/dup2/dup202.c
+++ b/testcases/kernel/syscalls/dup2/dup202.c
@@ -53,6 +53,7 @@
 #include <fcntl.h>
 #include <stdio.h>
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "dup202";
 int TST_TOTAL = 3;
@@ -113,14 +114,10 @@ int main(int ac, char **av)
 			}
 
 			/* stat the original file */
-			if (fstat(ofd, &oldbuf) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "fstat #1 failed");
+			SAFE_FSTAT(cleanup, ofd, &oldbuf);
 
 			/* stat the duped file */
-			if (fstat(*TC[i].nfd, &newbuf) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "fstat #2 failed");
+			SAFE_FSTAT(cleanup, *TC[i].nfd, &newbuf);
 
 			if (oldbuf.st_mode != newbuf.st_mode)
 				tst_resm(TFAIL, "original and dup "
diff --git a/testcases/kernel/syscalls/dup2/dup204.c b/testcases/kernel/syscalls/dup2/dup204.c
index 634bde8f2..c864f9866 100644
--- a/testcases/kernel/syscalls/dup2/dup204.c
+++ b/testcases/kernel/syscalls/dup2/dup204.c
@@ -84,12 +84,8 @@ int main(int ac, char **av)
 				continue;
 			}
 
-			if (fstat(fd[i], &oldbuf) == -1)
-				tst_brkm(TBROK, cleanup, "fstat() #1 "
-					 "failed");
-			if (fstat(nfd[i], &newbuf) == -1)
-				tst_brkm(TBROK, cleanup, "fstat() #2 "
-					 "failed");
+			SAFE_FSTAT(cleanup, fd[i], &oldbuf);
+			SAFE_FSTAT(cleanup, nfd[i], &newbuf);
 
 			if (oldbuf.st_ino != newbuf.st_ino)
 				tst_resm(TFAIL, "original and duped "
-- 
2.13.5

