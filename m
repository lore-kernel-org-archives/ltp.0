Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VdyOY-0002FF-PL
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 08:23:22 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VdyOX-0007V3-Uw
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 08:23:22 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA68NFuj000414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 08:23:16 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA68NERc004133
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 08:23:15 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA68NEPh019155
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 08:23:14 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed,  6 Nov 2013 12:23:06 +0400
Message-Id: <1383726187-25943-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20131105164645.GB21812@rei.suse.cz>
References: <20131105164645.GB21812@rei.suse.cz>
Subject: [LTP] [PATCH V2 1/2] Implemented SAFE_TOUCH macro
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
 include/safe_file_ops.h |   21 +++++++++++++++++++++
 lib/safe_file_ops.c     |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/include/safe_file_ops.h b/include/safe_file_ops.h
index 7ff5baa..77ad594 100644
--- a/include/safe_file_ops.h
+++ b/include/safe_file_ops.h
@@ -72,4 +72,25 @@ void safe_cp(const char *file, const int lineno,
 #define SAFE_CP(cleanup_fn, src, dst) \
 	safe_cp(__FILE__, __LINE__, (cleanup_fn), (src), (dst))
 
+/*
+ * Safe function to touch a file.
+ *
+ * If the file (pathname) does not exist It will be created with
+ * the specified permission (mode) and the access/modification times (times).
+ *
+ * If mode is 0 then the file is created with (0666 & ~umask)
+ * permission or (if the file exists) the permission is not changed.
+ *
+ * times is a timespec[2] (as for utimensat(2)). If times is NULL then
+ * the access/modification times of the file is set to the current time.
+ */
+void safe_touch(const char *file, const int lineno,
+		void (*cleanup_fn)(void),
+		const char *pathname,
+		mode_t mode, const struct timespec times[2]);
+
+#define SAFE_TOUCH(cleanup_fn, pathname, mode, times) \
+	safe_touch(__FILE__, __LINE__, (cleanup_fn), \
+			(pathname), (mode), (times))
+
 #endif /* SAFE_FILE_OPS */
diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
index b602345..8cfd264 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -23,6 +23,9 @@
 
 #include <stdarg.h>
 #include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 
 #include "safe_file_ops.h"
 
@@ -152,3 +155,41 @@ void safe_cp(const char *file, const int lineno,
 			 src, dst, file, lineno);
 	}
 }
+
+void safe_touch(const char *file, const int lineno,
+		void (*cleanup_fn)(void),
+		const char *pathname,
+		mode_t mode, const struct timespec times[2])
+{
+	int ret;
+	mode_t defmode;
+
+	defmode = S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
+
+	ret = open(pathname, O_CREAT | O_WRONLY, defmode);
+	if (ret == -1)
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			"Failed to open file '%s' at %s:%d",
+			pathname, file, lineno);
+
+	ret = close(ret);
+	if (ret == -1)
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			"Failed to close file '%s' at %s:%d",
+			pathname, file, lineno);
+
+	if (mode != 0) {
+		ret = chmod(pathname, mode);
+		if (ret == -1)
+			tst_brkm(TBROK | TERRNO, cleanup_fn,
+				"Failed to chmod file '%s' at %s:%d",
+				pathname, file, lineno);
+	}
+
+	ret = utimensat(AT_FDCWD, pathname, times, 0);
+	if (ret == -1)
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			"Failed to do utimensat() on file '%s' at %s:%d",
+			pathname, file, lineno);
+}
+
-- 
1.7.1


------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
