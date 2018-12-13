From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 13 Dec 2018 16:35:58 +0800
Subject: [LTP] [PATCH v3 1/3] lib: Introduce tst_strttype()
In-Reply-To: <20181211151733.GC1180@rei>
References: <20181211151733.GC1180@rei>
Message-ID: <1544690160-13900-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Rename strttype() to tst_strttype() and introduce the function
for old and new library.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/old/test.h | 2 +-
 include/tst_test.h | 4 ++++
 lib/tst_res.c      | 4 ++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/old/test.h b/include/old/test.h
index 0738237..3dce395 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -113,7 +113,7 @@ void tst_parse_opts(int argc, char *argv[], const option_t *user_optarg,
                     void (*user_help)(void));
 
 /* lib/tst_res.c */
-const char *strttype(int ttype);
+const char *tst_strttype(int ttype);
 
 void tst_resm_(const char *file, const int lineno, int ttype,
 	const char *arg_fmt, ...)
diff --git a/include/tst_test.h b/include/tst_test.h
index 2ebf746..f3d1546 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -222,6 +222,10 @@ extern void *TST_RET_PTR;
  */
 const char *tst_strerrno(int err);
 const char *tst_strsig(int sig);
+
+// Function to convert ttype to its name.
+const char *tst_strttype(int ttype);
+
 /*
  * Returns string describing status as returned by wait().
  *
diff --git a/lib/tst_res.c b/lib/tst_res.c
index c35f41b..8c69b75 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -139,7 +139,7 @@ struct pair {
 	return pair_arr[idx].name;                            \
 } while (0)
 
-const char *strttype(int ttype)
+const char *tst_strttype(int ttype)
 {
 	static const struct pair ttype_pairs[] = {
 		PAIR(TPASS)
@@ -296,7 +296,7 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
 	/*
 	 * Build the result line and print it.
 	 */
-	type = strttype(ttype);
+	type = tst_strttype(ttype);
 
 	if (T_mode == VERBOSE) {
 		size += snprintf(message + size, sizeof(message) - size,
-- 
1.8.3.1



