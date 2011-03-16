Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1PzrML-0006Dr-Ba
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 14:05:57 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PzrMK-0007od-Bq
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 14:05:57 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p2GE5oPa013196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 16 Mar 2011 10:05:50 -0400
From: czhang@redhat.com
Date: Wed, 16 Mar 2011 22:05:45 +0800
Message-Id: <1300284345-23533-1-git-send-email-czhang@redhat.com>
Subject: [LTP] [PATCH 2/2] fs: fsstress: fix compile when -DNO_XFS disabled
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
Cc: Caspar Zhang <czhang@redhat.com>

From: Caspar Zhang <czhang@redhat.com>

When -DNO_XFS disabled in Makefile, the compilation couldn't pass and
many errors and warnings outputed. This patch fixes this issue.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/fs/fsstress/Makefile   |    3 +++
 testcases/kernel/fs/fsstress/fsstress.c |   16 ++++++++--------
 testcases/kernel/fs/fsstress/global.h   |    4 ++--
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/fs/fsstress/Makefile b/testcases/kernel/fs/fsstress/Makefile
index 0a53891..f6527ed 100644
--- a/testcases/kernel/fs/fsstress/Makefile
+++ b/testcases/kernel/fs/fsstress/Makefile
@@ -27,6 +27,9 @@ include $(top_srcdir)/include/mk/env_pre.mk
 CPPFLAGS			+= -DNO_XFS -I$(abs_srcdir) \
 				   -D_LARGEFILE64_SOURCE -D_GNU_SOURCE
 
+# if removed -DNO_XFS, you should unmask the following line
+#CPPFLAGS			+= -lattr
+
 # XXX (garrcoop): not -Wuninitialized clean.
 CPPFLAGS			+= -Wno-error
 
diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
index 37956f3..e774d22 100644
--- a/testcases/kernel/fs/fsstress/fsstress.c
+++ b/testcases/kernel/fs/fsstress/fsstress.c
@@ -1436,7 +1436,7 @@ allocsp_f(int opno, long r)
 	e = ioctl(fd, XFS_IOC_ALLOCSP64, &fl) < 0 ? errno : 0;
 	if (v)
 		printf("%d/%d: ioctl(XFS_IOC_ALLOCSP64) %s %lld 0 %d\n",
-			procid, opno, f.path, off, e);
+			procid, opno, f.path, (long long)off, e);
 	free_pathname(&f);
 	close(fd);
 }
@@ -1571,7 +1571,7 @@ bulkstat_f(int opno, long r)
 	free(t);
 	if (verbose)
 		printf("%d/%d: bulkstat nent %d total %lld\n",
-			procid, opno, nent, total);
+			procid, opno, nent, (long long)total);
 	close(fd);
 }
 
@@ -1704,7 +1704,7 @@ creat_f(int opno, long r)
 				geom.rtextsize * geom.blocksize * extsize;
 			if (ioctl(fd, XFS_IOC_FSSETXATTR, &a) < 0)
 				e1 = errno;
-			esz = a.fsx_estsize;
+			esz = a.fsx_extsize;
 
 		}
 #endif
@@ -2014,7 +2014,7 @@ freesp_f(int opno, long r)
 	e = ioctl(fd, XFS_IOC_FREESP64, &fl) < 0 ? errno : 0;
 	if (v)
 		printf("%d/%d: ioctl(XFS_IOC_FREESP64) %s %lld 0 %d\n",
-			procid, opno, f.path, off, e);
+			procid, opno, f.path, (long long)off, e);
 	free_pathname(&f);
 	close(fd);
 }
@@ -2386,8 +2386,8 @@ resvsp_f(int opno, long r)
 	fl.l_len = (off64_t)(random() % (1024 * 1024));
 	e = ioctl(fd, XFS_IOC_RESVSP64, &fl) < 0 ? errno : 0;
 	if (v)
-		printf("%d/%d: ioctl(XFS_IOC_RESVSP64) %s %lld %lld %d\n",
-			procid, opno, f.path, off, fl.l_len, e);
+		printf("%d/%d: ioctl(XFS_IOC_RESVSP64) %s %lld %ld %d\n",
+			procid, opno, f.path, (long long)off, fl.l_len, e);
 	free_pathname(&f);
 	close(fd);
 }
@@ -2603,8 +2603,8 @@ unresvsp_f(int opno, long r)
 	fl.l_len = (off64_t)(random() % (1 << 20));
 	e = ioctl(fd, XFS_IOC_UNRESVSP64, &fl) < 0 ? errno : 0;
 	if (v)
-		printf("%d/%d: ioctl(XFS_IOC_UNRESVSP64) %s %lld %lld %d\n",
-			procid, opno, f.path, off, fl.l_len, e);
+		printf("%d/%d: ioctl(XFS_IOC_UNRESVSP64) %s %lld %ld %d\n",
+			procid, opno, f.path, (long long)off, fl.l_len, e);
 	free_pathname(&f);
 	close(fd);
 }
diff --git a/testcases/kernel/fs/fsstress/global.h b/testcases/kernel/fs/fsstress/global.h
index f788395..9644666 100644
--- a/testcases/kernel/fs/fsstress/global.h
+++ b/testcases/kernel/fs/fsstress/global.h
@@ -38,8 +38,8 @@
 #if defined(NO_XFS)
 # include "xfscompat.h"
 #else
-# include <libxfs.h>
-# include <attributes.h>
+# include <xfs/libxfs.h>
+# include <attr/attributes.h>
 #endif
 
 /* libc includes */
-- 
1.7.4.1


------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
