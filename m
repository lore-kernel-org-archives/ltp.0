From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Oct 2020 17:47:44 +0100
Subject: [LTP] [PATCH 07/19] Unify error handling in lib/safe_stdio.c
In-Reply-To: <20201026164756.30556-1-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
Message-ID: <20201026164756.30556-8-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Properly format caller file:line location
- Pedantically check invalid function return values

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 lib/safe_stdio.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/lib/safe_stdio.c b/lib/safe_stdio.c
index 966a039a5..ab23e43bb 100644
--- a/lib/safe_stdio.c
+++ b/lib/safe_stdio.c
@@ -29,9 +29,8 @@ FILE *safe_fopen(const char *file, const int lineno, void (cleanup_fn)(void),
 	FILE *f = fopen(path, mode);
 
 	if (f == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: fopen(%s,%s) failed",
-			 file, lineno, path, mode);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"fopen(%s,%s) failed", path, mode);
 	}
 
 	return f;
@@ -44,9 +43,12 @@ int safe_fclose(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	ret = fclose(f);
 
-	if (ret) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: fclose(%p) failed", file, lineno, f);
+	if (ret == EOF) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"fclose(%p) failed", f);
+	} else if (ret) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid fclose(%p) return value %d", f, ret);
 	}
 
 	return ret;
@@ -62,9 +64,12 @@ int safe_asprintf(const char *file, const int lineno, void (cleanup_fn)(void),
 	ret = vasprintf(strp, fmt, va);
 	va_end(va);
 
-	if (ret < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: asprintf(%s,...) failed", file, lineno, fmt);
+	if (ret == -1) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"asprintf(%s,...) failed", fmt);
+	} else if (ret < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid asprintf(%s,...) return value %d", fmt, ret);
 	}
 
 	return ret;
@@ -81,13 +86,12 @@ FILE *safe_popen(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	if (stream == NULL) {
 		if (errno != 0) {
-			tst_brkm(TBROK | TERRNO, cleanup_fn,
-				 "%s:%d: popen(%s,%s) failed",
-				 file, lineno, command, type);
+			tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+				"popen(%s,%s) failed", command, type);
 		} else {
-			tst_brkm(TBROK, cleanup_fn,
-				 "%s:%d: popen(%s,%s) failed: Out of memory",
-				 file, lineno, command, type);
+			tst_brkm_(file, lineno, TBROK, cleanup_fn,
+				"popen(%s,%s) failed: Out of memory",
+				command, type);
 		}
 	}
 
-- 
2.28.0

