Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1W2dvm-0000Da-Gc
	for ltp-list@lists.sourceforge.net; Mon, 13 Jan 2014 09:35:38 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1W2dvl-0003G9-LK
	for ltp-list@lists.sourceforge.net; Mon, 13 Jan 2014 09:35:38 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s0D9ZUNj027122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Jan 2014 09:35:31 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s0D9ZTvu021381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Jan 2014 09:35:30 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s0D9ZT7M009292
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Jan 2014 09:35:29 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 13 Jan 2014 13:35:22 +0400
Message-Id: <1389605723-17937-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <52CFC6D1.4060006@oracle.com>
References: <52CFC6D1.4060006@oracle.com>
Subject: [LTP] [PATCH 1/2] lib: tst_get_unused_uid, tst_get_unused_gid
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

Implemented functions which return the first unused
uid and gid.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/test.h    |    7 ++++
 lib/tst_uid_gid.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+), 0 deletions(-)
 create mode 100644 lib/tst_uid_gid.c

diff --git a/include/test.h b/include/test.h
index ffc1c8c..9f4cfd7 100644
--- a/include/test.h
+++ b/include/test.h
@@ -264,6 +264,13 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
  */
 int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
 
+/* lib/tst_uid_gid.c
+ *
+ * Return the first unused uid and gid
+ */
+uid_t tst_get_unused_uid(void);
+gid_t tst_get_unused_gid(void);
+
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
 #elif  TST_USE_NEWER64_SYSCALL
diff --git a/lib/tst_uid_gid.c b/lib/tst_uid_gid.c
new file mode 100644
index 0000000..e462d45
--- /dev/null
+++ b/lib/tst_uid_gid.c
@@ -0,0 +1,86 @@
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
+ */
+
+#include <grp.h>
+#include <limits.h>
+#include <pwd.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+uid_t tst_get_unused_uid(void)
+{
+	struct passwd pwd;
+	struct passwd *result;
+	char *buf;
+	size_t bufsize;
+	int s;
+	uid_t uid;
+
+	bufsize = sysconf(_SC_GETPW_R_SIZE_MAX);
+	if (bufsize == -1)
+		bufsize = 16384;
+
+	buf = malloc(bufsize);
+	if (buf == NULL)
+		return -1;
+
+	for (uid = 0; uid <= UINT_MAX - 1; uid++) {
+		s = getpwuid_r(uid, &pwd, buf, bufsize, &result);
+		if (result == NULL) {
+			if (s == 0)
+				return uid;
+			else
+				return -1;
+		}
+	}
+
+	free(buf);
+	return -1;
+}
+
+gid_t tst_get_unused_gid(void)
+{
+	struct group grp;
+	struct group *result;
+	char *buf;
+	size_t bufsize;
+	int s;
+	gid_t gid;
+
+	bufsize = sysconf(_SC_GETGR_R_SIZE_MAX);
+	if (bufsize == -1)
+		bufsize = 16384;
+
+	buf = malloc(bufsize);
+	if (buf == NULL)
+		return -1;
+
+	for (gid = 0; gid <= UINT_MAX - 1; gid++) {
+		s = getgrgid_r(gid, &grp, buf, bufsize, &result);
+		if (result == NULL) {
+			if (s == 0)
+				return gid;
+			else
+				return -1;
+		}
+	}
+
+	free(buf);
+	return -1;
+}
-- 
1.7.1


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
