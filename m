Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1Z2ZvS-00086B-P0
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 06:55:50 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z2ZvO-0005ND-Ik
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 06:55:50 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t5A6s7K0004873
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Jun 2015 14:54:08 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 10 Jun 2015 14:54:58 +0800
Message-ID: <1433919301-24797-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/4] syscalls/chroot&creat: fix undefined behavior
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

The results are undefined if source and destination
buffers overlap when calling s[n]printf().
Such as,
    sprintf(buf, "%s some further text", buf);
The above will not produce the expected results.

This patch enssures that produce output as expected.

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/chroot/chroot03.c | 4 +++-
 testcases/kernel/syscalls/creat/creat04.c   | 9 +++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/chroot/chroot03.c b/testcases/kernel/syscalls/chroot/chroot03.c
index 9376892..69fead4 100644
--- a/testcases/kernel/syscalls/chroot/chroot03.c
+++ b/testcases/kernel/syscalls/chroot/chroot03.c
@@ -151,7 +151,9 @@ static void setup(void)
 	 * set up good_dir to test whether chroot() is setting ENOENT if the
 	 * directory does not exist.
 	 */
-	(void)sprintf(good_dir, "%s.%d", good_dir, getpid());
+	good_dir_dup = strdup(good_dir);
+	(void)sprintf(good_dir, "%s.%d", good_dir_dup, getpid());
+	free(good_dir_dup);
 
 #if !defined(UCLINUX)
 	bad_addr = mmap(0, 1, PROT_NONE,
diff --git a/testcases/kernel/syscalls/creat/creat04.c b/testcases/kernel/syscalls/creat/creat04.c
index 0268e77..44c249f 100644
--- a/testcases/kernel/syscalls/creat/creat04.c
+++ b/testcases/kernel/syscalls/creat/creat04.c
@@ -192,10 +192,11 @@ void setup(void)
 
 	/* make a temporary directory and cd to it */
 	tst_tmpdir();
-
-	sprintf(good_dir, "%s.%d", good_dir, getpid());
-	sprintf(fname1, "%s/file1.%d", good_dir, getpid());
-	sprintf(fname, "%s/file.%d", good_dir, getpid());
+	good_dir_dup = strdup(good_dir);
+	sprintf(good_dir, "%s.%d", good_dir_dup, getpid());
+	sprintf(fname1, "%s/file1.%d", good_dir_dup, getpid());
+	sprintf(fname, "%s/file.%d", good_dir_dup, getpid());
+	free(good_dir_dup);
 }
 
 /*
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
