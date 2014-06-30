Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1X1YMC-0006l5-FE
	for ltp-list@lists.sourceforge.net; Mon, 30 Jun 2014 09:58:40 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X1YMB-0000YD-9L
	for ltp-list@lists.sourceforge.net; Mon, 30 Jun 2014 09:58:40 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5U9wSgA009861
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Jun 2014 17:58:28 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 30 Jun 2014 17:55:35 +0800
Message-ID: <1404122135-8089-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [[RFC PATCH]] lib/tst_res.c: make tst_brkm() output more
	informative message
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
program, it is inefficient, especially we have same messages, so here
we choose to make tst_brkm more informative.

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
 include/test.h            | 9 +++++++--
 lib/tst_res.c             | 9 ++++++---
 tools/apicmds/ltpapicmd.c | 2 +-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/test.h b/include/test.h
index a4a23e3..9024493 100644
--- a/include/test.h
+++ b/include/test.h
@@ -126,8 +126,13 @@ void tst_resm_hexd(int ttype, const void *buf, size_t size, const char *arg_fmt,
 	__attribute__ ((format (printf, 4, 5)));
 void tst_brk(int ttype, const char *fname, void (*func)(void), const char *arg_fmt, ...)
 	__attribute__ ((format (printf, 4, 5)));
-void tst_brkm(int ttype, void (*func)(void), const char *arg_fmt, ...)
-	__attribute__ ((format (printf, 3, 4))) LTP_ATTRIBUTE_NORETURN;
+void tst_brkm_d(const char *file, const int lineno, int ttype,
+		void (*func)(void), const char *arg_fmt, ...)
+	__attribute__ ((format (printf, 5, 6))) LTP_ATTRIBUTE_NORETURN;
+#define tst_brkm(ttype, func, arg_fmt, ...) \
+	tst_brkm_d(__FILE__, __LINE__, (ttype), (func),\
+		   (arg_fmt), ##__VA_ARGS__)
+
 void tst_require_root(void (*func)(void));
 int  tst_environ(void);
 void tst_exit(void) LTP_ATTRIBUTE_NORETURN;
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 31186e0..015ca52 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -721,10 +721,12 @@ void tst_resm_hexd(int ttype, const void *buf, size_t size, const char *arg_fmt,
 }
 
 /*
- * tst_brkm() - Interface to tst_brk(), with no filename.
+ * tst_brkm_d() - Interface to tst_brk(), with no filename.
  */
-void tst_brkm(int ttype, void (*func) (void), const char *arg_fmt, ...)
+void tst_brkm_d(const char *file, const int lineno, int ttype,
+	void (*func)(void), const char *arg_fmt, ...)
 {
+	int len;
 	char tmesg[USERMESG];
 
 #if DEBUG
@@ -733,7 +735,8 @@ void tst_brkm(int ttype, void (*func) (void), const char *arg_fmt, ...)
 	fflush(stdout);
 #endif
 
-	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
+	len = sprintf(tmesg, "%s:%d: ", file, lineno);
+	EXPAND_VAR_ARGS(tmesg + len, arg_fmt, USERMESG);
 
 	tst_brk(ttype, NULL, func, "%s", tmesg);
 	/* Shouldn't be reach, but fixes build time warnings about noreturn. */
diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index 220edae..ae25244 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -173,7 +173,7 @@ void apicmd_brkm(int argc, char *argv[])
 	}
 	trestype = ident_ttype((argv++)[0]);
 	argv++;
-	tst_brkm(trestype, NULL, "%s", *argv);
+	tst_brk(trestype, NULL, NULL, "%s", *argv);
 }
 
 void apicmd_resm(int argc, char *argv[])
-- 
1.8.2.1


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
