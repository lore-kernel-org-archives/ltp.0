From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Fri, 20 Aug 2021 12:00:26 +0200
Subject: [LTP] [PATCH v5 1/3] lib/tst_pid: simplify error handling by
 callers of tst_get_free_pids()
In-Reply-To: <20210820100028.97487-1-krzysztof.kozlowski@canonical.com>
References: <20210820100028.97487-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210820100028.97487-2-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Handle errors of getting free pids directly in the library instead of
tst_get_free_pids() caller.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 lib/tst_pid.c                                         | 9 ++++++---
 testcases/kernel/syscalls/ipc/msgstress/msgstress04.c | 6 ------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/lib/tst_pid.c b/lib/tst_pid.c
index c408172675a7..23753988ca57 100644
--- a/lib/tst_pid.c
+++ b/lib/tst_pid.c
@@ -107,15 +107,14 @@ int tst_get_free_pids_(void (*cleanup_fn) (void))
 
 	f = popen("ps -eT | wc -l", "r");
 	if (!f) {
-		tst_resm(TBROK, "Could not run 'ps' to calculate used " "pids");
+		tst_brkm(TBROK, cleanup_fn, "Could not run 'ps' to calculate used pids");
 		return -1;
 	}
 	rc = fscanf(f, "%i", &used_pids);
 	pclose(f);
 
 	if (rc != 1 || used_pids < 0) {
-		tst_resm(TBROK, "Could not read output of 'ps' to "
-			 "calculate used pids");
+		tst_brkm(TBROK, cleanup_fn, "Could not read output of 'ps' to calculate used pids");
 		return -1;
 	}
 
@@ -128,5 +127,9 @@ int tst_get_free_pids_(void (*cleanup_fn) (void))
 	/* max_pids contains the maximum PID + 1,
 	 * used_pids contains used PIDs + 1,
 	 * so this additional '1' is eliminated by the substraction */
+	if (used_pids >= max_pids) {
+		tst_brkm(TBROK, cleanup_fn, "No free pids");
+		return 0;
+	}
 	return max_pids - used_pids;
 }
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
index f1c124990cb1..b9ebf9035c6d 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
@@ -413,12 +413,6 @@ void setup(void)
 	tst_resm(TINFO, "Found %d available message queues", MSGMNI);
 
 	free_pids = tst_get_free_pids(cleanup);
-	if (free_pids < 0) {
-		tst_brkm(TBROK, cleanup, "Can't obtain free_pid count");
-	} else if (!free_pids) {
-		tst_brkm(TBROK, cleanup, "No free pids");
-	}
-
 	/* We don't use more than a half of available pids.
 	 * For each child we fork up to 2*maxnkids grandchildren. */
 	maxnprocs = (free_pids / 2) / (1 + 2 * maxnkids);
-- 
2.30.2

