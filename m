Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Pzstn-00048l-1O
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 15:44:35 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Pzstl-00089k-Sl
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 15:44:35 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p2GFiS7h009180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 16 Mar 2011 11:44:28 -0400
From: czhang@redhat.com
Date: Wed, 16 Mar 2011 23:44:26 +0800
Message-Id: <1300290266-26725-1-git-send-email-czhang@redhat.com>
In-Reply-To: <[PATCH 1/2]>
References: <[PATCH 1/2]>
Subject: [LTP] [PATCH v4 1/2] fs: fsstress: make test more POSIX compliant
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
+	if (posix_memalign((void **)&buf, diob.d_mem, len) != 0) {
+		perror("posix_memalign");
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
+	if (posix_memalign((void **)&buf, diob.d_mem, len) != 0) {
+		perror("posix_memalign");
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
