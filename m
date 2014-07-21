Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1X99Sn-0004CR-W7
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 09:00:54 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X99Sm-0005N2-2x
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 09:00:53 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s6L90hri020949
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Jul 2014 17:00:43 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 21 Jul 2014 17:00:04 +0800
Message-ID: <1405933204-12601-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1405933204-12601-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1405933204-12601-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 2/2] lib/tst_res.c: make tst_brkm() and tst_resm()
	output more informative message
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

If testcase calls tst_brkm(...) to terminate test, usually we need
to serch the message outputted by tst_brkm() to locate it in test
program, it is inefficient, especially we have multiple same messages,
so here we choose to make tst_brkm output extra information about
source files and line number. Also make similar change to tst_resm().

E.g.:
We execute getxattr01 before this patch:
[root@localhost getxattr]# ./getxattr01
getxattr01    1  TCONF  :  No xattr support in fs or mount without user_xattr option
getxattr01    2  TCONF  :  Remaining cases not appropriate for configuration

After this patch:
[root@localhost getxattr]# ./getxattr01
getxattr01    1  TCONF  :  getxattr01.c:158: No xattr support in fs or mount without user_xattr option
getxattr01    2  TCONF  :  Remaining cases not appropriate for configuration

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 include/test.h | 44 ++++++++++++++++++++------
 lib/tst_res.c  | 99 ++++++++++++++++++++++++----------------------------------
 2 files changed, 75 insertions(+), 68 deletions(-)

diff --git a/include/test.h b/include/test.h
index 011866d..2013a36 100644
--- a/include/test.h
+++ b/include/test.h
@@ -118,16 +118,42 @@ extern int Forker_npids;
 
 /* lib/tst_res.c */
 const char *strttype(int ttype);
-void tst_res(int ttype, const char *fname, const char *arg_fmt, ...)
-	__attribute__ ((format (printf, 3, 4)));
-void tst_resm(int ttype, const char *arg_fmt, ...)
-	__attribute__ ((format (printf, 2, 3)));
-void tst_resm_hexd(int ttype, const void *buf, size_t size, const char *arg_fmt, ...)
-	__attribute__ ((format (printf, 4, 5)));
-void tst_brk(int ttype, const char *fname, void (*func)(void), const char *arg_fmt, ...)
+void tst_res_(const char *file, const int lineno, int ttype,
+	const char *fname, const char *arg_fmt, ...)
+	__attribute__ ((format (printf, 5, 6)));
+
+#define tst_res(ttype, fname, arg_fmt, ...) \
+	tst_res_(__FILE__, __LINE__, (ttype), (fname), \
+		 (arg_fmt), ##__VA_ARGS__)
+
+void tst_resm_(const char *file, const int lineno, int ttype,
+	const char *arg_fmt, ...)
 	__attribute__ ((format (printf, 4, 5)));
-void tst_brkm(int ttype, void (*func)(void), const char *arg_fmt, ...)
-	__attribute__ ((format (printf, 3, 4))) LTP_ATTRIBUTE_NORETURN;
+#define tst_resm(ttype, arg_fmt, ...) \
+	tst_resm_(__FILE__, __LINE__, (ttype), \
+		  (arg_fmt), ##__VA_ARGS__)
+
+void tst_resm_hexd_(const char *file, const int lineno, int ttype,
+	const void *buf, size_t size, const char *arg_fmt, ...)
+	__attribute__ ((format (printf, 6, 7)));
+#define tst_resm_hexd(ttype, buf, size, arg_fmt, ...) \
+	tst_resm_hexd_(__FILE__, __LINE__, (ttype), (buf), (size), \
+		       (arg_fmt), ##__VA_ARGS__)
+
+void tst_brk_(const char *file, const int lineno, int ttype,
+	const char *fname, void (*func)(void), const char *arg_fmt, ...)
+	__attribute__ ((format (printf, 6, 7)));
+#define tst_brk(ttype, fname, func, arg_fmt, ...) \
+	tst_brk_(__FILE__, __LINE__, (ttype), (fname), (func), \
+		 (arg_fmt), ##__VA_ARGS__)
+
+void tst_brkm_(const char *file, const int lineno, int ttype,
+	void (*func)(void), const char *arg_fmt, ...)
+	__attribute__ ((format (printf, 5, 6))) LTP_ATTRIBUTE_NORETURN;
+#define tst_brkm(ttype, func, arg_fmt, ...) \
+	tst_brkm_(__FILE__, __LINE__, (ttype), (func), \
+		  (arg_fmt), ##__VA_ARGS__)
+
 void tst_require_root(void (*func)(void));
 int  tst_environ(void);
 void tst_exit(void) LTP_ATTRIBUTE_NORETURN;
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 0383c98..c584265 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -36,12 +36,12 @@
  *    OS Testing - Silicon Graphics, Inc.
  *
  *    FUNCTION NAME     :
- *      tst_res() -       Print result message (include file contents)
- *      tst_resm() -      Print result message
- *      tst_resm_hexd() - Print result message (add buffer contents in hex)
- *      tst_brk() -       Print result message (include file contents)
+ *      tst_res_() -       Print result message (include file contents)
+ *      tst_resm_() -      Print result message
+ *      tst_resm_hexd_() - Print result message (add buffer contents in hex)
+ *      tst_brk_() -       Print result message (include file contents)
  *                        and break remaining test cases
- *      tst_brkm() -      Print result message and break remaining test
+ *      tst_brkm_() -      Print result message and break remaining test
  *                        cases
  *      tst_flush() -     Print any messages pending in the output stream
  *      tst_exit() -      Exit test with a meaningful exit value.
@@ -49,35 +49,6 @@
  *
  *    FUNCTION TITLE    : Standard automated test result reporting mechanism
  *
- *    SYNOPSIS:
- *      #include "test.h"
- *
- *      void tst_res(ttype, fname, tmesg [,arg]...)
- *      int  ttype;
- *      char *fname;
- *      char *tmesg;
- *
- *      void tst_resm(ttype, tmesg [,arg]...)
- *      int  ttype;
- *      char *tmesg;
- *
- *      void tst_brk(ttype, fname, cleanup, tmesg, [,argv]...)
- *      int  ttype;
- *      char *fname;
- *      void (*cleanup)();
- *      char *tmesg;
- *
- *      void tst_brkm(ttype, cleanup, tmesg [,arg]...)
- *      int  ttype;
- *      void (*cleanup)();
- *      char *tmesg;
- *
- *      void tst_flush()
- *
- *      void tst_exit()
- *
- *      int  tst_environ()
- *
  *    AUTHOR            : Kent Rogers (from Dave Fenner's original)
  *
  *    CO-PILOT          : Rich Logan
@@ -224,25 +195,29 @@ const char *strttype(int ttype)
 #include "signame.h"
 
 /*
- * tst_res() - Main result reporting function.  Handle test information
+ * tst_res_() - Main result reporting function.  Handle test information
  *             appropriately depending on output display mode.  Call
  *             tst_condense() or tst_print() to actually print results.
- *             All result functions (tst_resm(), tst_brk(), etc.)
+ *             All result functions (tst_resm_(), tst_brk_(), etc.)
  *             eventually get here to print the results.
  */
-void tst_res(int ttype, const char *fname, const char *arg_fmt, ...)
+void tst_res_(const char *file, const int lineno, int ttype,
+	const char *fname, const char *arg_fmt, ...)
 {
 	pthread_mutex_lock(&tmutex);
 
 	char tmesg[USERMESG];
+	int len = 0;
 	int ttype_result = TTYPE_RESULT(ttype);
 
 #if DEBUG
-	printf("IN tst_res; tst_count = %d\n", tst_count);
+	printf("IN tst_res_; tst_count = %d\n", tst_count);
 	fflush(stdout);
 #endif
 
-	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
+	if (file && (ttype_result != TPASS && ttype_result != TINFO))
+		len = sprintf(tmesg, "%s:%d: ", file, lineno);
+	EXPAND_VAR_ARGS(tmesg + len, arg_fmt, USERMESG - len);
 
 	/*
 	 * Save the test result type by ORing ttype into the current exit
@@ -599,10 +574,11 @@ int tst_environ(void)
 static int tst_brk_entered = 0;
 
 /*
- * tst_brk() - Fail or break current test case, and break the remaining
+ * tst_brk_() - Fail or break current test case, and break the remaining
  *             tests cases.
  */
-void tst_brk(int ttype, const char *fname, void (*func) (void), const char *arg_fmt, ...)
+void tst_brk_(const char *file, const int lineno, int ttype, const char *fname,
+	void (*func)(void), const char *arg_fmt, ...)
 {
 	pthread_mutex_lock(&tmutex);
 
@@ -610,7 +586,7 @@ void tst_brk(int ttype, const char *fname, void (*func) (void), const char *arg_
 	int ttype_result = TTYPE_RESULT(ttype);
 
 #if DEBUG
-	printf("IN tst_brk\n");
+	printf("IN tst_brk_\n");
 	fflush(stdout);
 	fflush(stdout);
 #endif
@@ -629,14 +605,16 @@ void tst_brk(int ttype, const char *fname, void (*func) (void), const char *arg_
 		ttype = (ttype & ~ttype_result) | TBROK;
 	}
 
-	tst_res(ttype, fname, "%s", tmesg);
+	tst_res_(file, lineno, ttype, fname, "%s", tmesg);
 	if (tst_brk_entered == 0) {
-		if (ttype_result == TCONF)
-			tst_res(ttype, NULL,
+		if (ttype_result == TCONF) {
+			tst_res_(file, lineno, ttype, NULL,
 				"Remaining cases not appropriate for "
 				"configuration");
-		else if (ttype_result == TBROK)
-			tst_res(TBROK, NULL, "Remaining cases broken");
+		} else if (ttype_result == TBROK) {
+			tst_res_(file, lineno, TBROK, NULL,
+				 "Remaining cases broken");
+		}
 	}
 
 	/*
@@ -655,9 +633,10 @@ void tst_brk(int ttype, const char *fname, void (*func) (void), const char *arg_
 }
 
 /*
- * tst_resm() - Interface to tst_res(), with no filename.
+ * tst_resm_() - Interface to tst_res(), with no filename.
  */
-void tst_resm(int ttype, const char *arg_fmt, ...)
+void tst_resm_(const char *file, const int lineno, int ttype,
+	const char *arg_fmt, ...)
 {
 	char tmesg[USERMESG];
 
@@ -669,21 +648,22 @@ void tst_resm(int ttype, const char *arg_fmt, ...)
 
 	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
 
-	tst_res(ttype, NULL, "%s", tmesg);
+	tst_res_(file, lineno, ttype, NULL, "%s", tmesg);
 }
 
 /*
- * tst_resm_hexd() - Interface to tst_res(), with no filename.
+ * tst_resm_hexd_() - Interface to tst_res(), with no filename.
  * Also, dump specified buffer in hex.
  */
-void tst_resm_hexd(int ttype, const void *buf, size_t size, const char *arg_fmt, ...)
+void tst_resm_hexd_(const char *file, const int lineno, int ttype,
+	const void *buf, size_t size, const char *arg_fmt, ...)
 {
 	pthread_mutex_lock(&tmutex);
 
 	char tmesg[USERMESG];
 
 #if DEBUG
-	printf("IN tst_resm_hexd\n");
+	printf("IN tst_resm_hexd_\n");
 	fflush(stdout);
 #endif
 
@@ -696,7 +676,7 @@ void tst_resm_hexd(int ttype, const void *buf, size_t size, const char *arg_fmt,
 
 	if (size > size_max || size == 0 ||
 		(offset + size * (symb_num + 1)) >= USERMESG)
-		tst_res(ttype, NULL, "%s", tmesg);
+		tst_res_(file, lineno, ttype, NULL, "%s", tmesg);
 	else
 		pmesg += offset;
 
@@ -709,7 +689,7 @@ void tst_resm_hexd(int ttype, const void *buf, size_t size, const char *arg_fmt,
 		sprintf(pmesg, "%02x", ((unsigned char *)buf)[i]);
 		pmesg += symb_num;
 		if ((i + 1) % size_max == 0 || i + 1 == size) {
-			tst_res(ttype, NULL, "%s", tmesg);
+			tst_res_(file, lineno, ttype, NULL, "%s", tmesg);
 			pmesg = tmesg;
 		}
 	}
@@ -718,21 +698,22 @@ void tst_resm_hexd(int ttype, const void *buf, size_t size, const char *arg_fmt,
 }
 
 /*
- * tst_brkm() - Interface to tst_brk(), with no filename.
+ * tst_brkm_() - Interface to tst_brk(), with no filename.
  */
-void tst_brkm(int ttype, void (*func) (void), const char *arg_fmt, ...)
+void tst_brkm_(const char *file, const int lineno, int ttype,
+	void (*func)(void), const char *arg_fmt, ...)
 {
 	char tmesg[USERMESG];
 
 #if DEBUG
-	printf("IN tst_brkm\n");
+	printf("IN tst_brkm_\n");
 	fflush(stdout);
 	fflush(stdout);
 #endif
 
 	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
 
-	tst_brk(ttype, NULL, func, "%s", tmesg);
+	tst_brk_(file, lineno, ttype, NULL, func, "%s", tmesg);
 	/* Shouldn't be reach, but fixes build time warnings about noreturn. */
 	abort();
 }
-- 
1.8.2.1


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
