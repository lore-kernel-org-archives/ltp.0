Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q8IOE-0006zd-MO
	for ltp-list@lists.sourceforge.net; Fri, 08 Apr 2011 20:34:46 +0000
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q8IOD-0002t7-Rg
	for ltp-list@lists.sourceforge.net; Fri, 08 Apr 2011 20:34:46 +0000
From: Alex Elder <aelder@sgi.com>
Date: Fri,  8 Apr 2011 15:34:35 -0500
Message-Id: <de84600847aa9a4caaed369f0771bf4a2e18536c.1302294850.git.aelder@sgi.com>
In-Reply-To: <1302294875-6898-1-git-send-email-aelder@sgi.com>
References: <1302294875-6898-1-git-send-email-aelder@sgi.com>
In-Reply-To: <2fb6f8d9dc82ef63e3c7cd80151cb6ea7972aae9.1302294850.git.aelder@sgi.com>
References: <2fb6f8d9dc82ef63e3c7cd80151cb6ea7972aae9.1302294850.git.aelder@sgi.com>
Subject: [LTP] [PATCH 4/4] ltp: kill off warnings in "fsstress.c"
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

Fix remaining warnings in "testcases/kernel/fs/fsstress/fsstress.c".
Three of them are due to mismatches between fprintf() conversion
specifications and the variables being formatted.  Fix these by
casting the variables to the right type.

Two others are due to the use of a __uint64_t local variable to
represent a value of type __u64 (which evidently can be defined
differently in some environments).  Fix these by using the exact
matching type in the cases that produce the warning messages.

Signed-off-by: Alex Elder <aelder@sgi.com>
---
 testcases/kernel/fs/fsstress/fsstress.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
index 9b93bca..4a81d99 100644
--- a/testcases/kernel/fs/fsstress/fsstress.c
+++ b/testcases/kernel/fs/fsstress/fsstress.c
@@ -1549,7 +1549,7 @@ bulkstat_f(int opno, long r)
 {
 	int		count;
 	int		fd;
-	__uint64_t	last;
+	__u64		last;
 	int		nent;
 	xfs_bstat_t	*t;
 	__int64_t	total;
@@ -1582,7 +1582,7 @@ bulkstat1_f(int opno, long r)
 	pathname_t	f;
 	int		fd;
 	int		good;
-	__uint64_t	ino;
+	__u64		ino;
 	struct stat64	s;
 	xfs_bstat_t	t;
 	int		v;
@@ -1625,7 +1625,7 @@ bulkstat1_f(int opno, long r)
 	e = ioctl(fd, XFS_IOC_FSBULKSTAT_SINGLE, &bsr) < 0 ? errno : 0;
 	if (v)
 		printf("%d/%d: bulkstat1 %s ino %lld %d\n",
-			procid, opno, good?"real":"random", (int64_t)ino, e);
+			procid, opno, good?"real":"random", (long long)ino, e);
 	close(fd);
 }
 
@@ -2388,8 +2388,9 @@ resvsp_f(int opno, long r)
 	fl.l_len = (off64_t)(random() % (1024 * 1024));
 	e = ioctl(fd, XFS_IOC_RESVSP64, &fl) < 0 ? errno : 0;
 	if (v)
-		printf("%d/%d: ioctl(XFS_IOC_RESVSP64) %s %lld %ld %d\n",
-			procid, opno, f.path, (long long)off, fl.l_len, e);
+		printf("%d/%d: ioctl(XFS_IOC_RESVSP64) %s %lld %lld %d\n",
+			procid, opno, f.path, (long long) off,
+			(long long) fl.l_len, e);
 	free_pathname(&f);
 	close(fd);
 }
@@ -2605,8 +2606,9 @@ unresvsp_f(int opno, long r)
 	fl.l_len = (off64_t)(random() % (1 << 20));
 	e = ioctl(fd, XFS_IOC_UNRESVSP64, &fl) < 0 ? errno : 0;
 	if (v)
-		printf("%d/%d: ioctl(XFS_IOC_UNRESVSP64) %s %lld %ld %d\n",
-			procid, opno, f.path, (long long)off, fl.l_len, e);
+		printf("%d/%d: ioctl(XFS_IOC_UNRESVSP64) %s %lld %lld %d\n",
+			procid, opno, f.path, (long long) off,
+			(long long) fl.l_len, e);
 	free_pathname(&f);
 	close(fd);
 }
-- 
1.7.4


------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
