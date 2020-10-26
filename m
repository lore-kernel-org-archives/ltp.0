From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Oct 2020 17:47:46 +0100
Subject: [LTP] [PATCH 09/19] Unify error handling in lib/tst_checkpoint.c
In-Reply-To: <20201026164756.30556-1-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
Message-ID: <20201026164756.30556-10-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Properly format caller file:line location

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 lib/tst_checkpoint.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index 5e5b11496..9e9dcf9e6 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -43,9 +43,8 @@ void tst_checkpoint_init(const char *file, const int lineno,
 	unsigned int page_size;
 
 	if (tst_futexes) {
-		tst_brkm(TBROK, cleanup_fn,
-		         "%s: %d checkpoints already initialized",
-		         file, lineno);
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"checkpoints already initialized");
 		return;
 	}
 
@@ -61,9 +60,9 @@ void tst_checkpoint_init(const char *file, const int lineno,
 	 * the init as a first function with NULL as cleanup function.
 	 */
 	if (cleanup_fn && !tst_tmpdir_created()) {
-		tst_brkm(TBROK, cleanup_fn,
-		         "%s:%d You have to create test temporary directory "
-		         "first (call tst_tmpdir())", file, lineno);
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"You have to create test temporary directory "
+			"first (call tst_tmpdir())");
 		return;
 	}
 
@@ -144,9 +143,9 @@ void tst_safe_checkpoint_wait(const char *file, const int lineno,
 	ret = tst_checkpoint_wait(id, msec_timeout);
 
 	if (ret) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: tst_checkpoint_wait(%u, %i)",
-		         file, lineno, id, msec_timeout);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"tst_checkpoint_wait(%u, %i) failed", id,
+			msec_timeout);
 	}
 }
 
@@ -157,8 +156,8 @@ void tst_safe_checkpoint_wake(const char *file, const int lineno,
 	int ret = tst_checkpoint_wake(id, nr_wake, DEFAULT_MSEC_TIMEOUT);
 
 	if (ret) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: tst_checkpoint_wake(%u, %u, %i)",
-		         file, lineno, id, nr_wake, DEFAULT_MSEC_TIMEOUT);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"tst_checkpoint_wake(%u, %u, %i) failed", id, nr_wake,
+			DEFAULT_MSEC_TIMEOUT);
 	}
 }
-- 
2.28.0

