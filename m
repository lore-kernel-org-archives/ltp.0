From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 26 Mar 2020 16:28:28 +0100
Subject: [LTP] [PATCH v3] Fix use after stack unwind in fzsync lib
Message-ID: <20200326152828.14934-1-mdoucha@suse.cz>
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

Changes since v2:
- Use static local variable instead to prevent memory leaks

 include/tst_fuzzy_sync.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index c1d0b00f9..9ff3a78ae 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -297,7 +297,10 @@ static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
 	pair->b_cntr = 0;
 	pair->exit = 0;
 	if (run_b) {
-		struct tst_fzsync_run_thread wrap_run_b = {.func = run_b, .arg = NULL};
+		static struct tst_fzsync_run_thread wrap_run_b;
+
+		wrap_run_b.func = run_b;
+		wrap_run_b.arg = NULL;
 		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, tst_fzsync_thread_wrapper, &wrap_run_b);
 	}
 
-- 
2.25.1

