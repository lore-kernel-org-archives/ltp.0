From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:20:06 +0200
Subject: [LTP] [COMMITTED] [PATCH 33/40] Make use of SAFE_GETRLIMIT()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-33-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/brk/brk01.c             | 5 ++---
 testcases/kernel/syscalls/mincore/mincore01.c     | 5 +----
 testcases/kernel/syscalls/msync/msync03.c         | 3 +--
 testcases/kernel/syscalls/setrlimit/setrlimit01.c | 3 +--
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/brk/brk01.c b/testcases/kernel/syscalls/brk/brk01.c
index 775bc15fe..9a364318c 100644
--- a/testcases/kernel/syscalls/brk/brk01.c
+++ b/testcases/kernel/syscalls/brk/brk01.c
@@ -43,6 +43,7 @@
 #include <inttypes.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #ifndef BSIZE
 #define BSIZE  BBSIZE
@@ -159,9 +160,7 @@ void setup(void)
 	/*if ((ulim_sz=ulimit(3,0)) == -1)
 	   tst_brkm(TBROK|TERRNO, cleanup, "ulimit(3,0) failed"); */
 
-	if (getrlimit(RLIMIT_DATA, &lim) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "getrlimit(RLIMIT_DATA,%p) failed", &lim);
+	SAFE_GETRLIMIT(cleanup, RLIMIT_DATA, &lim);
 	ulim_sz = lim.rlim_cur;
 
 	/*
diff --git a/testcases/kernel/syscalls/mincore/mincore01.c b/testcases/kernel/syscalls/mincore/mincore01.c
index fa426d163..1632c72ab 100644
--- a/testcases/kernel/syscalls/mincore/mincore01.c
+++ b/testcases/kernel/syscalls/mincore/mincore01.c
@@ -140,10 +140,7 @@ static void setup4(struct test_case_t *tc)
 {
 	struct rlimit as_lim;
 
-	if (getrlimit(RLIMIT_AS, &as_lim) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "getrlimit(RLIMIT_AS) failed");
-	}
+	SAFE_GETRLIMIT(cleanup, RLIMIT_AS, &as_lim);
 
 	tc->addr = global_pointer;
 	tc->len = as_lim.rlim_cur - (rlim_t)global_pointer + pagesize;
diff --git a/testcases/kernel/syscalls/msync/msync03.c b/testcases/kernel/syscalls/msync/msync03.c
index 8bd35be0d..2e072ca92 100644
--- a/testcases/kernel/syscalls/msync/msync03.c
+++ b/testcases/kernel/syscalls/msync/msync03.c
@@ -132,8 +132,7 @@ static void setup(void)
 	addr2 = addr1 + 1;
 
 	/* addr3 is outside the address space of the process */
-	if (getrlimit(RLIMIT_DATA, &rl) < 0)
-		tst_brkm(TBROK | TERRNO, NULL, "getrlimit failed");
+	SAFE_GETRLIMIT(NULL, RLIMIT_DATA, &rl);
 	addr3 = (char *)rl.rlim_max;
 
 #if !defined(UCLINUX)
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
index 05b4cf948..f66f99553 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
@@ -194,8 +194,7 @@ static void test2(void)
  */
 static void test3(void)
 {
-	if (getrlimit(RLIMIT_NPROC, &save_rlim) < 0)
-		tst_brkm(TBROK, cleanup, "getrlimit failed, errno: %d", errno);
+	SAFE_GETRLIMIT(cleanup, RLIMIT_NPROC, &save_rlim);
 
 	rlim.rlim_cur = 10;
 	rlim.rlim_max = 10;
-- 
2.13.5

