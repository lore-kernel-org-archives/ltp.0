Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1UsDZG-0006Tx-2U
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 14:53:02 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UsDZE-0003BE-AG
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 14:53:02 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r5REqrat005464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Jun 2013 14:52:54 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r5REqquw010678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Jun 2013 14:52:53 GMT
Received: from abhmt110.oracle.com (abhmt110.oracle.com [141.146.116.62])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r5REqqxH022781
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Jun 2013 14:52:52 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 27 Jun 2013 18:52:22 +0400
Message-Id: <1372344742-5138-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v3] lib: tst_run_cmd: add tst_run_cmd() to exec
	specified program
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

vfork() + execvp() specified program.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/test.h    |    9 +++++++++
 lib/tst_run_cmd.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100644 lib/tst_run_cmd.c

diff --git a/include/test.h b/include/test.h
index e68ae60..ee3efc3 100644
--- a/include/test.h
+++ b/include/test.h
@@ -206,6 +206,15 @@ int tst_get_path(const char *prog_name, char *buf, size_t buf_len);
 long tst_ncpus(void);
 long tst_ncpus_max(void);
 
+/* lib/tst_run_cmd.c
+ *
+ * vfork() + execvp() specified program.
+ * @argv: a list of two (at least program name + NULL) or more pointers that
+ * represent the argument list to the new program. The array of pointers
+ * must be terminated by a NULL pointer.
+ */
+void tst_run_cmd(void (cleanup_fn)(void), char *const argv[]);
+
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
 #elif  TST_USE_NEWER64_SYSCALL
diff --git a/lib/tst_run_cmd.c b/lib/tst_run_cmd.c
new file mode 100644
index 0000000..93fe2d6
--- /dev/null
+++ b/lib/tst_run_cmd.c
@@ -0,0 +1,52 @@
+/*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+ *
+ */
+
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "test.h"
+
+void tst_run_cmd(void (cleanup_fn)(void), char *const argv[])
+{
+	if (argv == NULL || argv[0] == NULL) {
+		tst_brkm(TBROK, cleanup_fn,
+			"argument list is empty at %s:%d", __FILE__, __LINE__);
+	}
+
+	pid_t pid = vfork();
+	if (pid == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn, "vfork failed at %s:%d",
+			__FILE__, __LINE__);
+	}
+	if (!pid)
+		_exit(execvp(argv[0], argv));
+
+	int ret = -1;
+	if (waitpid(pid, &ret, 0) != pid) {
+		tst_brkm(TBROK, cleanup_fn, "waitpid failed at %s:%d",
+			__FILE__, __LINE__);
+	}
+
+	if (!WIFEXITED(ret) || WEXITSTATUS(ret) != 0) {
+		tst_brkm(TBROK, cleanup_fn, "failed to exec cmd '%s' at %s:%d",
+			argv[0], __FILE__, __LINE__);
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
