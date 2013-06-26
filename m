Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1UrpIe-000525-EQ
	for ltp-list@lists.sourceforge.net; Wed, 26 Jun 2013 12:58:16 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UrpIc-0006Ql-KK
	for ltp-list@lists.sourceforge.net; Wed, 26 Jun 2013 12:58:16 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r5QCpnZb015414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Jun 2013 12:51:49 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r5QCw75j006071
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Jun 2013 12:58:07 GMT
Received: from abhmt105.oracle.com (abhmt105.oracle.com [141.146.116.57])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r5QCw7us026783
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Jun 2013 12:58:07 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 26 Jun 2013 16:57:37 +0400
Message-Id: <1372251457-25602-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] lib: safe_macros: add SAFE_EXECVP()
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
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/safe_macros.h |    5 +++++
 lib/safe_macros.c     |   26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/include/safe_macros.h b/include/safe_macros.h
index 3a26df6..8ef5113 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -184,5 +184,10 @@ int safe_fclose(const char *file, const int lineno, void (cleanup_fn)(void),
 #define SAFE_FCLOSE(cleanup_fn, f) \
 	safe_fclose(__FILE__, __LINE__, cleanup_fn, f)
 
+void safe_execvp(const char *file, const int lineno, void (cleanup_fn)(void),
+                 char *const argv[]);
+#define SAFE_EXECVP(cleanup_fn, argv) \
+	safe_execvp(__FILE__, __LINE__, cleanup_fn, argv)
+
 #endif /* __SAFE_MACROS_H__ */
 #endif /* __TEST_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index fb02796..58e6f6a 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -2,6 +2,7 @@
 #include <sys/mman.h>
 #include <sys/resource.h>
 #include <sys/stat.h>
+#include <sys/wait.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <libgen.h>
@@ -467,3 +468,28 @@ int safe_fclose(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	return ret;
 }
+
+void safe_execvp(const char *file, const int lineno, void (cleanup_fn)(void),
+                 char *const argv[])
+{
+	if (argv == NULL || ARRAY_SIZE(argv) == 0) {
+		tst_brkm(TBROK, cleanup_fn,
+			"argument list is empty at %s:%d", file, lineno);
+	}
+
+	pid_t pid = vfork();
+	if (pid == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn, "fork failed at %s:%d",
+			file, lineno);
+	}
+	if (!pid)
+		_exit(execvp(argv[0], argv));
+
+	int ret = -1;
+	waitpid(pid, &ret, 0);
+
+	if (ret != 0) {
+		tst_brkm(TBROK, cleanup_fn, "failed to exec cmd '%s' at %s:%d",
+			argv[0], file, lineno);
+	}
+}
-- 
1.7.1


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
