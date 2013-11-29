Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VmIyk-0004YA-Tl
	for ltp-list@lists.sourceforge.net; Fri, 29 Nov 2013 07:59:10 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VmIyj-0005KP-Uc
	for ltp-list@lists.sourceforge.net; Fri, 29 Nov 2013 07:59:10 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rAT7x3Lf032289
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 29 Nov 2013 07:59:04 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAT7x3eL006442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 29 Nov 2013 07:59:03 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAT7x276006421
	for <ltp-list@lists.sourceforge.net>; Fri, 29 Nov 2013 07:59:02 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 29 Nov 2013 11:58:54 +0400
Message-Id: <1385711934-8999-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20131128113652.GB19263@rei.Home>
References: <20131128113652.GB19263@rei.Home>
Subject: [LTP] [PATCH V2 3/3] safe_touch: use utimes(2) if utimensat(2) is
	not defined
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

If utimensat(2) is not defined on the platform we switch
to using utimes(2).

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/safe_file_ops.h |    1 +
 lib/safe_file_ops.c     |   53 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/include/safe_file_ops.h b/include/safe_file_ops.h
index 77ad594..1815984 100644
--- a/include/safe_file_ops.h
+++ b/include/safe_file_ops.h
@@ -36,6 +36,7 @@
 
 #include <sys/stat.h>
 
+#include "lapi/utime.h"
 #include "test.h"
 
 /*
diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
index 8cfd264..dee8558 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -21,11 +21,15 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
+#include "config.h"
 #include <stdarg.h>
 #include <stdio.h>
+#include <sys/time.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <unistd.h>
+#include <utime.h>
 
 #include "safe_file_ops.h"
 
@@ -186,10 +190,57 @@ void safe_touch(const char *file, const int lineno,
 				pathname, file, lineno);
 	}
 
+
+#if HAVE_UTIMENSAT
 	ret = utimensat(AT_FDCWD, pathname, times, 0);
+#else
+	if (times == NULL) {
+		ret = utimes(pathname, NULL);
+	} else {
+		int i;
+		struct stat sb;
+		struct timeval cotimes[2];
+
+		ret = stat(pathname, &sb);
+		if (ret == -1)
+			tst_brkm(TBROK | TERRNO, cleanup_fn,
+				"Failed to stat file '%s' at %s:%d",
+				pathname, file, lineno);
+
+		ret = gettimeofday(&(cotimes[0]), NULL);
+		if (ret == -1)
+			tst_brkm(TBROK | TERRNO, cleanup_fn,
+				"Failed to gettimeofday() at %s:%d",
+				file, lineno);
+		cotimes[1] = cotimes[0];
+
+		for (i = 0; i < 2; i++) {
+			if (times[i].tv_nsec == UTIME_NOW) {
+				/* do nothing, because cotimes[i]
+				 * already has the current time
+				 */
+			} else if (times[i].tv_nsec == UTIME_OMIT) {
+				if (i == 0) {
+					cotimes[i].tv_sec = sb.st_atime;
+					cotimes[i].tv_usec = sb.st_atim.tv_nsec;
+					cotimes[i].tv_usec /= 1000;
+				} else {
+					cotimes[i].tv_sec = sb.st_mtime;
+					cotimes[i].tv_usec = sb.st_mtim.tv_nsec;
+					cotimes[i].tv_usec /= 1000;
+				}
+			} else {
+				cotimes[i].tv_sec = times[i].tv_sec;
+				cotimes[i].tv_usec = times[i].tv_nsec / 1000;
+			}
+		}
+
+		ret = utimes(pathname, cotimes);
+	}
+#endif
 	if (ret == -1)
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			"Failed to do utimensat() on file '%s' at %s:%d",
+			"Failed to update the access/modification times on file '%s' at %s:%d",
 			pathname, file, lineno);
 }
 
-- 
1.7.1


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
