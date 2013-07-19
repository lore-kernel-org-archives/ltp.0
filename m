Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1V06nP-0000N2-W3
	for ltp-list@lists.sourceforge.net; Fri, 19 Jul 2013 09:16:16 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V06nO-00057I-1b
	for ltp-list@lists.sourceforge.net; Fri, 19 Jul 2013 09:16:15 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r6J9G6Eu021234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Jul 2013 09:16:07 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r6J9G5Ld019402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Jul 2013 09:16:06 GMT
Received: from abhmt112.oracle.com (abhmt112.oracle.com [141.146.116.64])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r6J9G5Hw029686
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Jul 2013 09:16:05 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 19 Jul 2013 13:15:52 +0400
Message-Id: <1374225352-16396-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 1/2] tst_run_cmd: added support for stdout and stderr
	redirection
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, alexey.kodanev@oracle.com

From: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>

Signed-off-by: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/test.h    |    9 ++++++++-
 lib/tst_run_cmd.c |   20 ++++++++++++++++++--
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/test.h b/include/test.h
index a76fafc..f294b16 100644
--- a/include/test.h
+++ b/include/test.h
@@ -219,8 +219,15 @@ long tst_ncpus_max(void);
  * @argv: a list of two (at least program name + NULL) or more pointers that
  * represent the argument list to the new program. The array of pointers
  * must be terminated by a NULL pointer.
+ * @stdout_path: path where to redirect stdout. Set NULL if redirection is
+ * not needed.
+ * @stderr_path: path where to redirect stderr. Set NULL if redirection is
+ * not needed.
  */
-void tst_run_cmd(void (cleanup_fn)(void), char *const argv[]);
+void tst_run_cmd(void (cleanup_fn)(void),
+		char *const argv[],
+		const char *stdout_path,
+		const char *stderr_path);
 
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
diff --git a/lib/tst_run_cmd.c b/lib/tst_run_cmd.c
index 93fe2d6..c54c650 100644
--- a/lib/tst_run_cmd.c
+++ b/lib/tst_run_cmd.c
@@ -19,12 +19,16 @@
  *
  */
 
+#include <stdio.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
 #include "test.h"
 
-void tst_run_cmd(void (cleanup_fn)(void), char *const argv[])
+void tst_run_cmd(void (cleanup_fn)(void),
+		char *const argv[],
+		const char *stdout_path,
+		const char *stderr_path)
 {
 	if (argv == NULL || argv[0] == NULL) {
 		tst_brkm(TBROK, cleanup_fn,
@@ -36,8 +40,20 @@ void tst_run_cmd(void (cleanup_fn)(void), char *const argv[])
 		tst_brkm(TBROK | TERRNO, cleanup_fn, "vfork failed at %s:%d",
 			__FILE__, __LINE__);
 	}
-	if (!pid)
+	if (!pid) {
+		/* redirecting stdout and stderr if needed */
+		if ((stdout_path != NULL) &&
+				(freopen(stdout_path, "a", stdout) == NULL))
+			tst_resm(TWARN | TERRNO, "freopen failed at %s:%d",
+					__FILE__, __LINE__);
+
+		if ((stderr_path != NULL) &&
+				(freopen(stderr_path, "a", stderr) == NULL))
+			tst_resm(TWARN | TERRNO, "freopen failed at %s:%d",
+					__FILE__, __LINE__);
+
 		_exit(execvp(argv[0], argv));
+	}
 
 	int ret = -1;
 	if (waitpid(pid, &ret, 0) != pid) {
-- 
1.7.1


From 5cc0b5ffd90736a780bd487947f804ed2ab4d03d Mon Sep 17 00:00:00 2001
From: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 19 Jul 2013 13:02:55 +0400
Subject: [PATCH 2/2] lib/tst_module.c: modification for updated tst_run_cmd specification

Modified lib/tst_module.c:
* for updated tst_run_cmd specification
* to hide gcc warning "initialization discards qualifiers from pointer target type"

Signed-off-by: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 lib/tst_module.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/tst_module.c b/lib/tst_module.c
index 832da27..4871005 100644
--- a/lib/tst_module.c
+++ b/lib/tst_module.c
@@ -94,12 +94,12 @@ void tst_module_load(void (cleanup_fn)(void),
 	for (i = offset; i < size; ++i)
 		mod_argv[i] = argv[i - offset];
 
-	tst_run_cmd(cleanup_fn, mod_argv);
+	tst_run_cmd(cleanup_fn, mod_argv, NULL, NULL);
 	free(mod_path);
 }
 
 void tst_module_unload(void (cleanup_fn)(void), const char *mod_name)
 {
-	char *const argv[] = { "rmmod", mod_name, NULL };
-	tst_run_cmd(cleanup_fn, argv);
+	char *const argv[] = { "rmmod", (char *) mod_name, NULL };
+	tst_run_cmd(cleanup_fn, argv, NULL, NULL);
 }
-- 
1.7.1


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
