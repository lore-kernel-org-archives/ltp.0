Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1V9U9k-0004TH-QL
	for ltp-list@lists.sourceforge.net; Wed, 14 Aug 2013 06:02:04 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V9U9j-0005fG-39
	for ltp-list@lists.sourceforge.net; Wed, 14 Aug 2013 06:02:04 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r7E61u63027966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Aug 2013 06:01:57 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7E61tA8016779
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Aug 2013 06:01:56 GMT
Received: from abhmt115.oracle.com (abhmt115.oracle.com [141.146.116.67])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7E61tv2015197
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Aug 2013 06:01:55 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 14 Aug 2013 10:01:46 +0400
Message-Id: <1376460107-3578-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20130717130502.GD25145@rei>
References: <20130717130502.GD25145@rei>
Subject: [LTP] [PATCH V5 1/2] Implemented tst_fill_file function
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

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/test.h      |   10 +++++++
 lib/tst_fill_file.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 0 deletions(-)
 create mode 100644 lib/tst_fill_file.c

diff --git a/include/test.h b/include/test.h
index 991269e..d9eba31 100644
--- a/include/test.h
+++ b/include/test.h
@@ -249,6 +249,16 @@ void tst_run_cmd(void (cleanup_fn)(void),
 void tst_mkfs(void (cleanup_fn)(void), const char *dev,
               const char *fs_type, const char *fs_opts);
 
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
index 0000000..1827322
--- /dev/null
+++ b/lib/tst_fill_file.c
@@ -0,0 +1,71 @@
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
+	for (counter = 0; counter < bcount; counter++) {
+		if (write(fd, buf, bs) != bs) {
+			free(buf);
+			close(fd);
+			unlink(path);
+
+			return -1;
+		}
+	}
+
+	free(buf);
+
+	if (close(fd) < 0) {
+		unlink(path);
+
+		return -1;
+	}
+
+	return 0;
+}
-- 
1.7.1


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
