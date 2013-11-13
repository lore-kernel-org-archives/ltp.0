Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VgbSt-0000MI-3G
	for ltp-list@lists.sourceforge.net; Wed, 13 Nov 2013 14:30:43 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VgbSo-0002tm-A7
	for ltp-list@lists.sourceforge.net; Wed, 13 Nov 2013 14:30:43 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rADEUWA0012453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Nov 2013 14:30:32 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rADEUVi5016770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Nov 2013 14:30:32 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rADEUVIg010671
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Nov 2013 14:30:31 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 13 Nov 2013 18:30:22 +0400
Message-Id: <1384353022-9088-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1384353022-9088-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1384353022-9088-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [RFC PATCH 2/2] safe_touch: use utimes(2) if utimensat(2) is
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
 lib/safe_file_ops.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
index 8cfd264..3876c27 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -21,10 +21,12 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
+#include "config.h"
 #include <stdarg.h>
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/syscall.h>
 #include <fcntl.h>
 
 #include "safe_file_ops.h"
@@ -186,10 +188,20 @@ void safe_touch(const char *file, const int lineno,
 				pathname, file, lineno);
 	}
 
+
+#if HAVE_UTIMENSAT
 	ret = utimensat(AT_FDCWD, pathname, times, 0);
+#else
+	/* we can't reliably check if times[i].tv_nsec is
+	 * either UTIME_NOW or UTIME_OMIT (because they
+	 * are not defined if utimensat() is not defined),
+	 * therefore update the access/modification times
+	 * to the current time */
+	ret = utimes(pathname, NULL);
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
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
