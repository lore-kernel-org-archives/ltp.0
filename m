Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VoBNl-0002Xx-Cp
	for ltp-list@lists.sourceforge.net; Wed, 04 Dec 2013 12:16:45 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VoBNk-0000kG-HZ
	for ltp-list@lists.sourceforge.net; Wed, 04 Dec 2013 12:16:45 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rB4CGcFj016906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Dec 2013 12:16:38 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rB4CGbEM012068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Dec 2013 12:16:37 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rB4CGb8h012051
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Dec 2013 12:16:37 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed,  4 Dec 2013 16:16:28 +0400
Message-Id: <1386159388-23713-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <529D7CFE.9090104@oracle.com>
References: <529D7CFE.9090104@oracle.com>
Subject: [LTP] [PATCH V3 3/3] safe_touch: use utimes(2) if utimensat(2) is
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
 lib/safe_file_ops.c     |   53 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 2 deletions(-)

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
index 8cfd264..f9c316d 100644
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
 
@@ -69,6 +73,22 @@ static int count_scanf_conversions(const char *fmt)
 	return cnt;
 }
 
+static void set_time(struct timeval *res, struct timespec *src,
+			long cur_tv_sec, long cur_tv_usec)
+{
+	switch (src->tv_nsec) {
+	case UTIME_NOW:
+	break;
+	case UTIME_OMIT:
+		res->tv_sec = cur_tv_sec;
+		res->tv_usec = cur_tv_usec;
+	break;
+	default:
+		res->tv_sec = src->tv_sec;
+		res->tv_usec = src->tv_nsec / 1000;
+	}
+}
+
 void safe_file_scanf(const char *file, const int lineno,
 		     void (*cleanup_fn) (void),
 		     const char *path, const char *fmt, ...)
@@ -186,10 +206,39 @@ void safe_touch(const char *file, const int lineno,
 				pathname, file, lineno);
 	}
 
+
+#if HAVE_UTIMENSAT
 	ret = utimensat(AT_FDCWD, pathname, times, 0);
+#else
+	if (times == NULL) {
+		ret = utimes(pathname, NULL);
+	} else {
+		struct stat sb;
+		struct timeval cotimes[2];
+
+		ret = stat(pathname, &sb);
+		if (ret == -1)
+			tst_brkm(TBROK | TERRNO, cleanup_fn,
+				"Failed to stat file '%s' at %s:%d",
+				pathname, file, lineno);
+
+		ret = gettimeofday(cotimes, NULL);
+		if (ret == -1)
+			tst_brkm(TBROK | TERRNO, cleanup_fn,
+				"Failed to gettimeofday() at %s:%d",
+				file, lineno);
+		cotimes[1] = cotimes[0];
+
+		set_time(cotimes, times,
+			sb.st_atime, sb.st_atim.tv_nsec / 1000);
+		set_time(cotimes + 1, times + 1,
+			sb.st_mtime, sb.st_mtim.tv_nsec / 1000);
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
-
-- 
1.7.1


------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
