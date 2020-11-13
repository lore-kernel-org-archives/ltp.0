From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 13 Nov 2020 11:44:27 +0100
Subject: [LTP] [PATCH v2 3/7] Unify error handling in lib/safe_file_ops.c
In-Reply-To: <20201113104431.17808-1-mdoucha@suse.cz>
References: <20201113104431.17808-1-mdoucha@suse.cz>
Message-ID: <20201113104431.17808-3-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Properly format caller file:line location
- Pedantically check invalid syscall return values
- Always return success/failure value so that all SAFE_*() functions can be
  called in test cleanup

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Dropped return type changes in safe_file_scanf() and safe_file_printf()
- Code style fixes

 include/safe_file_ops_fn.h |   4 +-
 lib/safe_file_ops.c        | 187 +++++++++++++++++++++----------------
 2 files changed, 106 insertions(+), 85 deletions(-)

diff --git a/include/safe_file_ops_fn.h b/include/safe_file_ops_fn.h
index 052fb1b9a..ed7d978dd 100644
--- a/include/safe_file_ops_fn.h
+++ b/include/safe_file_ops_fn.h
@@ -55,7 +55,7 @@ void safe_file_printf(const char *file, const int lineno,
 /*
  * Safe function to copy files, no more system("cp ...") please.
  */
-void safe_cp(const char *file, const int lineno,
+int safe_cp(const char *file, const int lineno,
              void (*cleanup_fn)(void),
 	     const char *src, const char *dst);
 
@@ -71,7 +71,7 @@ void safe_cp(const char *file, const int lineno,
  * times is a timespec[2] (as for utimensat(2)). If times is NULL then
  * the access/modification times of the file is set to the current time.
  */
-void safe_touch(const char *file, const int lineno,
+int safe_touch(const char *file, const int lineno,
 		void (*cleanup_fn)(void),
 		const char *pathname,
 		mode_t mode, const struct timespec times[2]);
diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
index e06d399fa..0ec2ff8fe 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -84,9 +84,8 @@ int file_scanf(const char *file, const int lineno,
 	f = fopen(path, "r");
 
 	if (f == NULL) {
-		tst_resm(TWARN,
-			"Failed to open FILE '%s' at %s:%d",
-			 path, file, lineno);
+		tst_resm_(file, lineno, TWARN, "Failed to open FILE '%s'",
+			path);
 		return 1;
 	}
 
@@ -97,23 +96,21 @@ int file_scanf(const char *file, const int lineno,
 	va_end(va);
 
 	if (ret == EOF) {
-		tst_resm(TWARN,
-			 "The FILE '%s' ended prematurely at %s:%d",
-			 path, file, lineno);
+		tst_resm_(file, lineno, TWARN,
+			"The FILE '%s' ended prematurely", path);
 		goto err;
 	}
 
 	if (ret != exp_convs) {
-		tst_resm(TWARN,
-			"Expected %i conversions got %i FILE '%s' at %s:%d",
-			 exp_convs, ret, path, file, lineno);
+		tst_resm_(file, lineno, TWARN,
+			"Expected %i conversions got %i FILE '%s'",
+			exp_convs, ret, path);
 		goto err;
 	}
 
 	if (fclose(f)) {
-		tst_resm(TWARN,
-			 "Failed to close FILE '%s' at %s:%d",
-			 path, file, lineno);
+		tst_resm_(file, lineno, TWARN, "Failed to close FILE '%s'",
+			path);
 		return 1;
 	}
 
@@ -121,10 +118,10 @@ int file_scanf(const char *file, const int lineno,
 
 err:
 	if (fclose(f)) {
-		tst_resm(TWARN,
-			 "Failed to close FILE '%s' at %s:%d",
-			 path, file, lineno);
+		tst_resm_(file, lineno, TWARN, "Failed to close FILE '%s'",
+			path);
 	}
+
 	return 1;
 }
 
@@ -139,9 +136,8 @@ void safe_file_scanf(const char *file, const int lineno,
 	f = fopen(path, "r");
 
 	if (f == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "Failed to open FILE '%s' for reading at %s:%d",
-			 path, file, lineno);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Failed to open FILE '%s' for reading", path);
 		return;
 	}
 
@@ -152,23 +148,21 @@ void safe_file_scanf(const char *file, const int lineno,
 	va_end(va);
 
 	if (ret == EOF) {
-		tst_brkm(TBROK, cleanup_fn,
-			 "The FILE '%s' ended prematurely at %s:%d",
-			 path, file, lineno);
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"The FILE '%s' ended prematurely", path);
 		return;
 	}
 
 	if (ret != exp_convs) {
-		tst_brkm(TBROK, cleanup_fn,
-			 "Expected %i conversions got %i FILE '%s' at %s:%d",
-			 exp_convs, ret, path, file, lineno);
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"Expected %i conversions got %i FILE '%s'",
+			exp_convs, ret, path);
 		return;
 	}
 
 	if (fclose(f)) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "Failed to close FILE '%s' at %s:%d",
-			 path, file, lineno);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Failed to close FILE '%s'", path);
 		return;
 	}
 }
@@ -190,16 +184,14 @@ int file_lines_scanf(const char *file, const int lineno,
 	va_list ap;
 
 	if (!fmt) {
-		tst_brkm(TBROK, cleanup_fn, "pattern is NULL, %s:%d",
-			file, lineno);
+		tst_brkm_(file, lineno, TBROK, cleanup_fn, "pattern is NULL");
 		return 1;
 	}
 
 	fp = fopen(path, "r");
 	if (fp == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			"Failed to open FILE '%s' for reading at %s:%d",
-			path, file, lineno);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Failed to open FILE '%s' for reading", path);
 		return 1;
 	}
 
@@ -216,8 +208,9 @@ int file_lines_scanf(const char *file, const int lineno,
 	fclose(fp);
 
 	if (strict && ret != arg_count) {
-		tst_brkm(TBROK, cleanup_fn, "Expected %i conversions got %i"
-			" FILE '%s' at %s:%d", arg_count, ret, path, file, lineno);
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"Expected %i conversions got %i FILE '%s'",
+			arg_count, ret, path);
 		return 1;
 	}
 
@@ -233,27 +226,24 @@ int file_printf(const char *file, const int lineno,
 	f = fopen(path, "w");
 
 	if (f == NULL) {
-		tst_resm(TWARN,
-			 "Failed to open FILE '%s' at %s:%d",
-			 path, file, lineno);
+		tst_resm_(file, lineno, TWARN, "Failed to open FILE '%s'",
+			path);
 		return 1;
 	}
 
 	va_start(va, fmt);
 
 	if (vfprintf(f, fmt, va) < 0) {
-		tst_resm(TWARN,
-			"Failed to print to FILE '%s' at %s:%d",
-			 path, file, lineno);
+		tst_resm_(file, lineno, TWARN, "Failed to print to FILE '%s'",
+			path);
 		goto err;
 	}
 
 	va_end(va);
 
 	if (fclose(f)) {
-		tst_resm(TWARN,
-			 "Failed to close FILE '%s' at %s:%d",
-			 path, file, lineno);
+		tst_resm_(file, lineno, TWARN, "Failed to close FILE '%s'",
+			path);
 		return 1;
 	}
 
@@ -261,10 +251,10 @@ int file_printf(const char *file, const int lineno,
 
 err:
 	if (fclose(f)) {
-		tst_resm(TWARN,
-			 "Failed to close FILE '%s' at %s:%d",
-			 path, file, lineno);
+		tst_resm_(file, lineno, TWARN, "Failed to close FILE '%s'",
+			path);
 	}
+
 	return 1;
 }
 
@@ -278,33 +268,30 @@ void safe_file_printf(const char *file, const int lineno,
 	f = fopen(path, "w");
 
 	if (f == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "Failed to open FILE '%s' for writing at %s:%d",
-			 path, file, lineno);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Failed to open FILE '%s' for writing", path);
 		return;
 	}
 
 	va_start(va, fmt);
 
 	if (vfprintf(f, fmt, va) < 0) {
-		tst_brkm(TBROK, cleanup_fn,
-			 "Failed to print to FILE '%s' at %s:%d",
-			 path, file, lineno);
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"Failed to print to FILE '%s'", path);
 		return;
 	}
 
 	va_end(va);
 
 	if (fclose(f)) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "Failed to close FILE '%s' at %s:%d",
-			 path, file, lineno);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Failed to close FILE '%s'", path);
 		return;
 	}
 }
 
 //TODO: C implementation? better error condition reporting?
-void safe_cp(const char *file, const int lineno,
+int safe_cp(const char *file, const int lineno,
 	     void (*cleanup_fn) (void), const char *src, const char *dst)
 {
 	size_t len = strlen(src) + strlen(dst) + 16;
@@ -316,10 +303,12 @@ void safe_cp(const char *file, const int lineno,
 	ret = system(buf);
 
 	if (ret) {
-		tst_brkm(TBROK, cleanup_fn,
-			 "Failed to copy '%s' to '%s' at %s:%d",
-			 src, dst, file, lineno);
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"Failed to copy '%s' to '%s'", src, dst);
+		return ret;
 	}
+
+	return 0;
 }
 
 #ifndef HAVE_UTIMENSAT
@@ -342,7 +331,7 @@ static void set_time(struct timeval *res, const struct timespec *src,
 
 #endif
 
-void safe_touch(const char *file, const int lineno,
+int safe_touch(const char *file, const int lineno,
 		void (*cleanup_fn)(void),
 		const char *pathname,
 		mode_t mode, const struct timespec times[2])
@@ -353,28 +342,41 @@ void safe_touch(const char *file, const int lineno,
 	defmode = S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
 
 	ret = open(pathname, O_CREAT | O_WRONLY, defmode);
+
 	if (ret == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			"Failed to open file '%s' at %s:%d",
-			pathname, file, lineno);
-		return;
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Failed to open file '%s'", pathname);
+		return ret;
+	} else if (ret < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid open(%s) return value %d", pathname, ret);
+		return ret;
 	}
 
 	ret = close(ret);
+
 	if (ret == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			"Failed to close file '%s' at %s:%d",
-			pathname, file, lineno);
-		return;
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Failed to close file '%s'", pathname);
+		return ret;
+	} else if (ret) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid close('%s') return value %d", pathname, ret);
+		return ret;
 	}
 
 	if (mode != 0) {
 		ret = chmod(pathname, mode);
+
 		if (ret == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup_fn,
-				"Failed to chmod file '%s' at %s:%d",
-				pathname, file, lineno);
-			return;
+			tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+				"Failed to chmod file '%s'", pathname);
+			return ret;
+		} else if (ret) {
+			tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+				"Invalid chmod('%s') return value %d",
+				pathname, ret);
+			return ret;
 		}
 	}
 
@@ -389,19 +391,28 @@ void safe_touch(const char *file, const int lineno,
 		struct timeval cotimes[2];
 
 		ret = stat(pathname, &sb);
+
 		if (ret == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup_fn,
-				"Failed to stat file '%s' at %s:%d",
-				pathname, file, lineno);
-			return;
+			tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+				"Failed to stat file '%s'", pathname);
+			return ret;
+		} else if (ret) {
+			tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+				"Invalid stat('%s') return value %d",
+				pathname, ret);
+			return ret;
 		}
 
 		ret = gettimeofday(cotimes, NULL);
+
 		if (ret == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup_fn,
-				"Failed to gettimeofday() at %s:%d",
-				file, lineno);
-			return;
+			tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+				"Failed to gettimeofday()");
+			return ret;
+		} else if (ret) {
+			tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+				"Invalid gettimeofday() return value %d", ret);
+			return ret;
 		}
 
 		cotimes[1] = cotimes[0];
@@ -415,8 +426,18 @@ void safe_touch(const char *file, const int lineno,
 	}
 #endif
 	if (ret == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			"Failed to update the access/modification time on file"
-			" '%s'@%s:%d", pathname, file, lineno);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Failed to update the access/modification time on file '%s'",
+			pathname);
+	} else if (ret) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+#ifdef HAVE_UTIMENSAT
+			"Invalid utimensat('%s') return value %d",
+#else
+			"Invalid utimes('%s') return value %d",
+#endif
+			pathname, ret);
 	}
+
+	return ret;
 }
-- 
2.28.0

