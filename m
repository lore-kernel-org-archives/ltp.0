Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1V2Jxs-0006tf-UX
	for ltp-list@lists.sourceforge.net; Thu, 25 Jul 2013 11:44:12 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V2Jxr-00079t-3v
	for ltp-list@lists.sourceforge.net; Thu, 25 Jul 2013 11:44:12 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r6PBi4AX018240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jul 2013 11:44:05 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r6PBi4Mp008525
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jul 2013 11:44:04 GMT
Received: from abhmt106.oracle.com (abhmt106.oracle.com [141.146.116.58])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r6PBi3Jq019708
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jul 2013 11:44:04 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 25 Jul 2013 15:43:34 +0400
Message-Id: <1374752615-9112-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20130717130502.GD25145@rei>
References: <20130717130502.GD25145@rei>
Subject: [LTP] [PATCH V3 1/2] lib/tst_fill_file.c: added tst_fill_file
	function
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
Cc: vasily.isaenko@oracle.com

From: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>

Signed-off-by: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/test.h      |   10 +++++++
 lib/tst_fill_file.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 0 deletions(-)
 create mode 100644 lib/tst_fill_file.c

diff --git a/include/test.h b/include/test.h
index f294b16..d9975a1 100644
--- a/include/test.h
+++ b/include/test.h
@@ -229,6 +229,16 @@ void tst_run_cmd(void (cleanup_fn)(void),
 		const char *stdout_path,
 		const char *stderr_path);
 
+/* lib/tst_fill_file.c
+ *
+ * Creates/ovewrites a file with specified pattern
+ * @path: path to file
+ * @pattern: pattern
+ * @bs: block size
+ * @bcount: blocks amount
+ */
+int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
+
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
 #elif  TST_USE_NEWER64_SYSCALL
diff --git a/lib/tst_fill_file.c b/lib/tst_fill_file.c
new file mode 100644
index 0000000..6613330
--- /dev/null
+++ b/lib/tst_fill_file.c
@@ -0,0 +1,67 @@
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
+ * Author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "test.h"
+
+int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount)
+{
+	int fd, counter;
+	char *buf;
+
+	fd = open(path, O_CREAT|O_WRONLY|O_TRUNC, S_IRUSR|S_IWUSR);
+	if (fd < 0)
+		return -1;
+
+	/* Filling a memory buffer with provided pattern */
+	buf = malloc(bs);
+	if (buf == NULL) {
+		close(fd);
+
+		return -1;
+	}
+
+	for (counter = 0; counter < bs; counter++)
+		buf[counter] = pattern;
+
+	/* Filling the file */
+	for (counter = 0; counter < bcount; counter++)
+		if (write(fd, buf, bs) != bs) {
+			free(buf);
+			close(fd);
+			unlink(path);
+
+			return -1;
+		}
+
+
+	free(buf);
+	if (close(fd) < 0)
+		return -1;
+
+	return 0;
+}
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
