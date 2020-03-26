From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 26 Mar 2020 13:23:29 +0100
Subject: [LTP] [PATCH v2] Fix use after stack unwind in fzsync lib
Message-ID: <20200326122329.24876-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_fzsync_pair_reset() passes a local variable to thread B which may be
already unwinded by the time the thread wrapper function executes. If new
variables get allocated and initialized on stack between pthread_create()
and thread wrapper execution, thread B will segfault.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Use tst_alloc() instead of SAFE_MALLOC() to prevent memory leak even if
  SAFE_PTHREAD_CREATE() fails
- Revert changes in tst_fzsync_thread_wrapper() as they're no longer needed

 include/tst_fuzzy_sync.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index c1d0b00f9..8b38cf37d 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -297,8 +297,12 @@ static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
 	pair->b_cntr = 0;
 	pair->exit = 0;
 	if (run_b) {
-		struct tst_fzsync_run_thread wrap_run_b = {.func = run_b, .arg = NULL};
-		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, tst_fzsync_thread_wrapper, &wrap_run_b);
+		struct tst_fzsync_run_thread *wrap_run_b;
+
+		wrap_run_b = tst_alloc(sizeof(struct tst_fzsync_run_thread));
+		wrap_run_b->func = run_b;
+		wrap_run_b->arg = NULL;
+		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, tst_fzsync_thread_wrapper, wrap_run_b);
 	}
 
 	pair->exec_time_start = (float)tst_timeout_remaining();
-- 
2.25.1

