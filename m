Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1PztVd-000206-N5
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 16:23:41 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PztVc-00073t-NC
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 16:23:41 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p2GGNY69004776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 16 Mar 2011 12:23:34 -0400
From: czhang@redhat.com
Date: Thu, 17 Mar 2011 00:23:33 +0800
Message-Id: <1300292613-29189-1-git-send-email-czhang@redhat.com>
Subject: [LTP] [PATCH v5 1/2] fs: fsstress: make test more POSIX compliant
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

in commit bacc849720ec4efda5a0a8a9ea6a0e93a1415541, malloc.h was removed
and stdlib.h got used instead. However, it's not enough. The function
memalign() is also obsolete (via man memalign) and we should use
posix_memalign instead. Also if we keep memalign() function here, the
program would probably hit segfault once it enters dwrite_t and dread_t.

v2: use correct &buf as argument
v3: remove incorrect disabling warning, will try to fix warning and
compiling without -DNO_XFS in another patch
v4: code style
v5: record the retval of posix_memalign and use strerror

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/fs/fsstress/fsstress.c |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
index e3b48ea..d6521f4 100644
--- a/testcases/kernel/fs/fsstress/fsstress.c
+++ b/testcases/kernel/fs/fsstress/fsstress.c
@@ -1746,7 +1746,7 @@ void
 dread_f(int opno, long r)
 {
 	__int64_t	align;
-	char		*buf;
+	char		*buf = NULL;
 	struct dioattr	diob;
 	int		e;
 	pathname_t	f;
@@ -1826,7 +1826,14 @@ dread_f(int opno, long r)
 		len = align;
 	else if (len > diob.d_maxiosz)
 		len = diob.d_maxiosz;
-	buf = memalign(diob.d_mem, len);
+	if ((e = posix_memalign((void **)&buf, diob.d_mem, len)) != 0) {
+		fprintf(stderr, "posix_memalign: %s\n", strerror(e));
+		exit(1);
+	}
+	if (buf == NULL) {
+		fprintf(stderr, "posix_memalign: buf is NULL\n");
+		exit(1);
+	}
 	e = read(fd, buf, len) < 0 ? errno : 0;
 	free(buf);
 	if (v)
@@ -1840,7 +1847,7 @@ void
 dwrite_f(int opno, long r)
 {
 	__int64_t	align;
-	char		*buf;
+	char		*buf = NULL;
 	struct dioattr	diob;
 	int		e;
 	pathname_t	f;
@@ -1909,7 +1916,14 @@ dwrite_f(int opno, long r)
 		len = align;
 	else if (len > diob.d_maxiosz)
 		len = diob.d_maxiosz;
-	buf = memalign(diob.d_mem, len);
+	if ((e = posix_memalign((void **)&buf, diob.d_mem, len)) != 0) {
+		fprintf(stderr, "posix_memalign: %s\n", strerror(e));
+		exit(1);
+	}
+	if (buf == NULL) {
+		fprintf(stderr, "posix_memalign: buf is NULL\n");
+		exit(1);
+	}
 	off %= maxfsize;
 	lseek64(fd, off, SEEK_SET);
 	memset(buf, nameseq & 0xff, len);
@@ -2650,4 +2664,4 @@ write_f(int opno, long r)
 			procid, opno, f.path, (long long)off, (long int)len, e);
 	free_pathname(&f);
 	close(fd);
-}
\ No newline at end of file
+}
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
