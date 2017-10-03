From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:20:02 +0200
Subject: [LTP] [COMMITTED] [PATCH 29/40] Make use of SAFE_FTRUNCATE()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-29-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fsync/fsync02.c | 4 ++--
 testcases/kernel/syscalls/mlock/mlock04.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fsync/fsync02.c b/testcases/kernel/syscalls/fsync/fsync02.c
index 2673edc9e..1e5f9ee00 100644
--- a/testcases/kernel/syscalls/fsync/fsync02.c
+++ b/testcases/kernel/syscalls/fsync/fsync02.c
@@ -53,6 +53,7 @@
 #include <errno.h>
 #include <sys/resource.h>
 #include "test.h"
+#include "safe_macros.h"
 #include <time.h>
 
 #define BLOCKSIZE 8192
@@ -138,8 +139,7 @@ int main(int ac, char **av)
 			tst_resm(TPASS, "fsync succeeded in an "
 				 "acceptable amount of time");
 
-		if (ftruncate(fd, 0) == -1)
-			tst_brkm(TBROK, cleanup, "ftruncate failed");
+		SAFE_FTRUNCATE(cleanup, fd, 0);
 	}
 
 	sync();
diff --git a/testcases/kernel/syscalls/mlock/mlock04.c b/testcases/kernel/syscalls/mlock/mlock04.c
index d1f3c9d0d..fb541ec08 100644
--- a/testcases/kernel/syscalls/mlock/mlock04.c
+++ b/testcases/kernel/syscalls/mlock/mlock04.c
@@ -91,8 +91,7 @@ static void setup(void)
 	if (fd == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "open");
 
-	if (ftruncate(fd, file_len) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "ftruncate");
+	SAFE_FTRUNCATE(cleanup, fd, file_len);
 
 	TEST_PAUSE;
 }
-- 
2.13.5

