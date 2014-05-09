Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WieFY-0000Im-30
	for ltp-list@lists.sourceforge.net; Fri, 09 May 2014 06:25:40 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WieFS-0004ZR-8w
	for ltp-list@lists.sourceforge.net; Fri, 09 May 2014 06:25:40 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s496PQ3Y005556
	for <ltp-list@lists.sourceforge.net>; Fri, 9 May 2014 14:25:26 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Fri, 9 May 2014 14:23:11 +0800
Message-ID: <1399616591-32662-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] lib/tst_sig.c: output signal name when got
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

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 include/test.h |   7 ++++
 lib/errnos.h   |   4 +--
 lib/signame.h  | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/tst_res.c  |  20 +++++++++--
 lib/tst_sig.c  |   3 +-
 5 files changed, 139 insertions(+), 6 deletions(-)
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
index 8e80e07..c1ea17e 100644
--- a/lib/errnos.h
+++ b/lib/errnos.h
@@ -25,9 +25,9 @@
  * Mountain View, CA  94043, or:
  */
 
-static const char *strerrnodef(int err)
+const char *tst_strerrno(int err)
 {
-	struct pair errno_pairs[] = {
+	static struct pair errno_pairs[] = {
 		{.name = "SUCCESS", .val = 0},
 		/* asm-generic/errno-base.h */
 		PAIR(EPERM)
diff --git a/lib/signame.h b/lib/signame.h
new file mode 100644
index 0000000..99250bf
--- /dev/null
+++ b/lib/signame.h
@@ -0,0 +1,111 @@
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
+		STRPAIR(SIGHUP, "SIGHUP")
+		STRPAIR(SIGINT, "SIGINT")
+		STRPAIR(SIGQUIT, "SIGQUIT")
+		STRPAIR(SIGILL, "SIGILL")
+	#ifdef SIGTRAP
+		STRPAIR(SIGTRAP, "SIGTRAP")
+	#endif
+
+	#ifdef SIGIOT
+		/* SIGIOT same as SIGABRT */
+		STRPAIR(SIGABRT, "SIGIOT/SIGABRT")
+	#else
+		STRPAIR(SIGABRT, "SIGABRT")
+	#endif
+
+	#ifdef SIGEMT
+		STRPAIR(SIGEMT, "SIGEMT")
+	#endif
+	#ifdef SIGBUS
+		STRPAIR(SIGBUS, "SIGBUS")
+	#endif
+		STRPAIR(SIGFPE, "SIGFPE")
+		STRPAIR(SIGKILL, "SIGKILL")
+		STRPAIR(SIGUSR1, "SIGUSR1")
+		STRPAIR(SIGSEGV, "SIGSEGV")
+		STRPAIR(SIGUSR2, "SIGUSR2")
+		STRPAIR(SIGPIPE, "SIGPIPE")
+		STRPAIR(SIGALRM, "SIGALRM")
+		STRPAIR(SIGTERM, "SIGTERM")
+	#ifdef SIGSTKFLT
+		STRPAIR(SIGSTKFLT, "SIGSTKFLT")
+	#endif
+
+	#ifdef SIGCLD
+		/* SIGCLD same as SIGCHLD */
+		STRPAIR(SIGCHLD, "SIGCHLD/SIGCLD")
+	#else
+		STRPAIR(SIGCHLD, "SIGCHLD")
+	#endif
+		STRPAIR(SIGCONT, "SIGCONT")
+		STRPAIR(SIGSTOP, "SIGSTOP")
+		STRPAIR(SIGTSTP, "SIGTSTP")
+		STRPAIR(SIGTTIN, "SIGTTIN")
+		STRPAIR(SIGTTOU, "SIGTTOU")
+	#ifdef SIGURG
+		STRPAIR(SIGURG, "SIGURG")
+	#endif
+	#ifdef SIGXCPU
+		STRPAIR(SIGXCPU, "SIGXCPU")
+	#endif
+	#ifdef SIGXFSZ
+		STRPAIR(SIGXFSZ, "SIGXFSZ")
+	#endif
+	#ifdef SIGVTALRM
+		STRPAIR(SIGVTALRM, "SIGVTALRM")
+	#endif
+	#ifdef SIGPROF
+		STRPAIR(SIGPROF, "SIGPROF")
+	#endif
+	#ifdef SIGWINCH
+		STRPAIR(SIGWINCH, "SIGWINCH")
+	#endif
+
+	#if defined(SIGIO) && defined(SIGPOLL)
+		/* SIGPOLL same as SIGIO */
+		STRPAIR(SIGIO, "SIGIO/SIGPOLL")
+	#elif defined(SIGIO)
+		STRPAIR(SIGIO, "SIGIO")
+	#elif defined(SIGPOLL)
+		STRPAIR(SIGPOLL, "SIGPOLL")
+	#endif
+
+	#ifdef SIGINFO
+		STRPAIR(SIGINFO, "SIGINFO")
+	#endif
+	#ifdef SIGLOST
+		STRPAIR(SIGLOST, "SIGLOST")
+	#endif
+	#ifdef SIGPWR
+		STRPAIR(SIGPWR, "SIGPWR")
+	#endif
+	#if defined(SIGSYS)
+		STRPAIR(SIGSYS, "SIGSYS")
+	#endif
+	#if defined(SIGUNUSED)
+		STRPAIR(SIGUNUSED, "SIGUNUSED")
+	#endif
+	};
+
+	STRPAIR_LOOKUP(signal_pairs, sig);
+};
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 8faa5a9..7fc7ad8 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -197,6 +197,17 @@ struct pair {
 	return pair_arr[idx].name;                            \
 } while (0)
 
+#define STRPAIR(key, value)  {.val = (key), .name = (value)},
+#define STRPAIR_LOOKUP(strpair_arr, key) do {                     \
+	int i;                                                    \
+	for (i = 0; (size_t) i < ARRAY_SIZE(strpair_arr); i++) {  \
+		if (key == strpair_arr[i].val)                    \
+			return strpair_arr[i].name;               \
+	}                                                         \
+	return "???";                                             \
+} while (0)
+
+
 /*
  * strttype() - convert a type result to the human readable string
  */
@@ -216,10 +227,13 @@ const char *strttype(int ttype)
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
@@ -459,7 +473,7 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
 
 	if (ttype & TERRNO) {
 		size += snprintf(message + size, sizeof(message) - size,
-				 ": errno=%s(%i): %s", strerrnodef(err),
+				 ": errno=%s(%i): %s", tst_strerrno(err),
 				 err, strerror(err));
 	}
 
@@ -471,7 +485,7 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
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
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
