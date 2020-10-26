From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Oct 2020 17:47:55 +0100
Subject: [LTP] [PATCH 18/19] Unify error handling in lib/tst_resource.c
In-Reply-To: <20201026164756.30556-1-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
Message-ID: <20201026164756.30556-19-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Properly format caller file:line location

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 lib/tst_resource.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/tst_resource.c b/lib/tst_resource.c
index 0b9b381f1..c35d05a25 100644
--- a/lib/tst_resource.c
+++ b/lib/tst_resource.c
@@ -102,9 +102,8 @@ void tst_resource_copy(const char *file, const int lineno,
 		       const char *filename, const char *dest)
 {
 	if (!tst_tmpdir_created()) {
-		tst_brkm(TBROK, cleanup_fn,
-		         "Temporary directory doesn't exist at %s:%d",
-		         file, lineno);
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"Temporary directory doesn't exist");
 		return;
 	}
 
@@ -133,6 +132,6 @@ void tst_resource_copy(const char *file, const int lineno,
 	if (file_copy(file, lineno, cleanup_fn, startwd, filename, dest))
 		return;
 
-	tst_brkm(TBROK, cleanup_fn, "Failed to copy resource '%s' at %s:%d",
-	         filename, file, lineno);
+	tst_brkm_(file, lineno, TBROK, cleanup_fn,
+		"Failed to copy resource '%s'", filename);
 }
-- 
2.28.0

