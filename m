Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WkAwM-0003th-DH
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 11:32:10 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WkAwK-0005Mc-6g
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 11:32:10 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4DB5Hs5003494
	for <ltp-list@lists.sourceforge.net>; Tue, 13 May 2014 19:05:18 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 13 May 2014 19:02:59 +0800
Message-ID: <1399978979-20072-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3] lib/tst_sig.c: output signal name when got
	unexpected signal
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

When testcase is killed by unexpected signal, usually it just prints
signal's value.
	fcntl30     1  TBROK  :  unexpected signal 2 received (pid = 6714).
	fcntl30     2  TBROK  :  Remaining cases broken

Here we also print signal's name to output more informative message.
	fcntl30     1  TBROK  :  unexpected signal SIGINT(2) received (pid = 9872).
	fcntl30     2  TBROK  :  Remaining cases broken

In this patch, we also add two new tst_ functions to convert errno or signal
to its name. The prototype is below:
    const char *tst_strsig(int sig);   returns signal name given signal number
    const char *tst_strerrno(int err); returns errno name given errno number

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 include/test.h |   7 ++++
 lib/errnos.h   |   4 +--
 lib/signame.h  | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/tst_res.c  |  10 ++++--
 lib/tst_sig.c  |   3 +-
 5 files changed, 130 insertions(+), 6 deletions(-)
 create mode 100644 lib/signame.h

diff --git a/include/test.h b/include/test.h
index e32481c..169fdfd 100644
--- a/include/test.h
+++ b/include/test.h
@@ -302,6 +302,13 @@ int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
 unsigned short tst_get_unused_port(void (cleanup_fn)(void),
 	unsigned short family, int type);
 
+/* lib/tst_res.c
+ * tst_strsig converts signal's value to corresponding string.
+ * tst_strerrno converts errno to corresponding string.
+ */
+const char *tst_strsig(int sig);
+const char *tst_strerrno(int err);
+
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
 #elif  TST_USE_NEWER64_SYSCALL
diff --git a/lib/errnos.h b/lib/errnos.h
index 8e80e07..b26a854 100644
--- a/lib/errnos.h
+++ b/lib/errnos.h
@@ -25,9 +25,9 @@
  * Mountain View, CA  94043, or:
  */
 
-static const char *strerrnodef(int err)
+const char *tst_strerrno(int err)
 {
-	struct pair errno_pairs[] = {
+	static const struct pair errno_pairs[] = {
 		{.name = "SUCCESS", .val = 0},
 		/* asm-generic/errno-base.h */
 		PAIR(EPERM)
diff --git a/lib/signame.h b/lib/signame.h
new file mode 100644
index 0000000..19d38d9
--- /dev/null
+++ b/lib/signame.h
@@ -0,0 +1,112 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+const char *tst_strsig(int sig)
+{
+	static const struct pair signal_pairs[] = {
+		PAIR(SIGHUP)
+		PAIR(SIGINT)
+		PAIR(SIGQUIT)
+		PAIR(SIGILL)
+	#ifdef SIGTRAP
+		PAIR(SIGTRAP)
+	#endif
+
+	#ifdef SIGIOT
+		/* SIGIOT same as SIGABRT */
+		STRPAIR(SIGABRT, "SIGIOT/SIGABRT")
+	#else
+		PAIR(SIGABRT)
+	#endif
+
+	#ifdef SIGEMT
+		PAIR(SIGEMT)
+	#endif
+	#ifdef SIGBUS
+		PAIR(SIGBUS)
+	#endif
+		PAIR(SIGFPE)
+		PAIR(SIGKILL)
+		PAIR(SIGUSR1)
+		PAIR(SIGSEGV)
+		PAIR(SIGUSR2)
+		PAIR(SIGPIPE)
+		PAIR(SIGALRM)
+		PAIR(SIGTERM)
+	#ifdef SIGSTKFLT
+		PAIR(SIGSTKFLT)
+	#endif
+
+	#ifdef SIGCLD
+		/* SIGCLD same as SIGCHLD */
+		STRPAIR(SIGCHLD, "SIGCHLD/SIGCLD")
+	#else
+		PAIR(SIGCHLD)
+	#endif
+		PAIR(SIGCONT)
+		PAIR(SIGSTOP)
+		PAIR(SIGTSTP)
+		PAIR(SIGTTIN)
+		PAIR(SIGTTOU)
+	#ifdef SIGURG
+		PAIR(SIGURG)
+	#endif
+	#ifdef SIGXCPU
+		PAIR(SIGXCPU)
+	#endif
+	#ifdef SIGXFSZ
+		PAIR(SIGXFSZ)
+	#endif
+	#ifdef SIGVTALRM
+		PAIR(SIGVTALRM)
+	#endif
+	#ifdef SIGPROF
+		PAIR(SIGPROF)
+	#endif
+	#ifdef SIGWINCH
+		PAIR(SIGWINCH)
+	#endif
+
+	#if defined(SIGIO) && defined(SIGPOLL)
+		/* SIGPOLL same as SIGIO */
+		STRPAIR(SIGIO, "SIGIO/SIGPOLL")
+	#elif defined(SIGIO)
+		PAIR(SIGIO)
+	#elif defined(SIGPOLL)
+		PAIR(SIGPOLL)
+	#endif
+
+	#ifdef SIGINFO
+		PAIR(SIGINFO)
+	#endif
+	#ifdef SIGLOST
+		PAIR(SIGLOST)
+	#endif
+	#ifdef SIGPWR
+		PAIR(SIGPWR)
+	#endif
+	#if defined(SIGSYS)
+		/*
+		 * According to signal(7)'s manpage, SIGUNUSED is synonymous
+		 * with SIGSYS on most architectures.
+		 */
+		STRPAIR(SIGSYS, "SIGSYS/SIGUNUSED")
+	#endif
+	};
+
+	PAIR_LOOKUP(signal_pairs, sig);
+};
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 8faa5a9..c179e31 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -189,6 +189,7 @@ struct pair {
 };
 
 #define PAIR(def) [def] = {.name = #def, .val = def},
+#define STRPAIR(key, value) [key] = {.name = value, .val = key},
 
 #define PAIR_LOOKUP(pair_arr, idx) do {                       \
 	if (idx < 0 || (size_t)idx >= ARRAY_SIZE(pair_arr) || \
@@ -216,10 +217,13 @@ const char *strttype(int ttype)
 }
 
 /*
- * Include table of errnos and strerrnodef() function.
+ * Include table of errnos and tst_strerrno() function.
  */
 #include "errnos.h"
 
+/* Include table of signals and tst_strsig() function*/
+#include "signame.h"
+
 /*
  * tst_res() - Main result reporting function.  Handle test information
  *             appropriately depending on output display mode.  Call
@@ -459,7 +463,7 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
 
 	if (ttype & TERRNO) {
 		size += snprintf(message + size, sizeof(message) - size,
-				 ": errno=%s(%i): %s", strerrnodef(err),
+				 ": errno=%s(%i): %s", tst_strerrno(err),
 				 err, strerror(err));
 	}
 
@@ -471,7 +475,7 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
 	if (ttype & TTERRNO) {
 		size += snprintf(message + size, sizeof(message) - size,
 				 ": TEST_ERRNO=%s(%i): %s",
-				 strerrnodef(TEST_ERRNO), (int)TEST_ERRNO,
+				 tst_strerrno(TEST_ERRNO), (int)TEST_ERRNO,
 				 strerror(TEST_ERRNO));
 	}
 
diff --git a/lib/tst_sig.c b/lib/tst_sig.c
index 2ffe610..95310f0 100644
--- a/lib/tst_sig.c
+++ b/lib/tst_sig.c
@@ -246,7 +246,8 @@ static void def_handler(int sig)
 	 * Break remaining test cases, do any cleanup, then exit
 	 */
 	tst_brkm(TBROK, T_cleanup,
-		 "unexpected signal %d received (pid = %d).", sig, getpid());
+		 "unexpected signal %s(%d) received (pid = %d).",
+		 tst_strsig(sig), sig, getpid());
 }
 
 /*
-- 
1.8.2.1


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
