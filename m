Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1Z2zuo-00025G-GR
	for ltp-list@lists.sourceforge.net; Thu, 11 Jun 2015 10:40:54 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z2zun-0005Lf-15
	for ltp-list@lists.sourceforge.net; Thu, 11 Jun 2015 10:40:54 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t5BAd9P5017948
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Jun 2015 18:39:09 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Thu, 11 Jun 2015 18:40:09 +0800
Message-ID: <1434019209-21232-1-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <20150610141614.GE31980@rei.suse.de>
References: <20150610141614.GE31980@rei.suse.de>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] syscalls/chroot&creat: fix undefined behavior
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
 testcases/kernel/syscalls/chroot/chroot03.c | 14 ++++++--------
 testcases/kernel/syscalls/creat/creat04.c   | 13 +++++--------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/chroot/chroot03.c b/testcases/kernel/syscalls/chroot/chroot03.c
index 9376892..3d51056 100644
--- a/testcases/kernel/syscalls/chroot/chroot03.c
+++ b/testcases/kernel/syscalls/chroot/chroot03.c
@@ -53,7 +53,11 @@ char *TCID = "chroot03";
 
 static int fd;
 static char fname[255];
-static char good_dir[100] = "/tmp/testdir";
+/*
+ *  set up nonexistent_dir to test whether chroot() is setting ENOENT
+ *  if the directory does not exist.
+ */
+static char nonexistent_dir[100] = "testdir";
 static char bad_dir[] = "abcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
 static char symbolic_dir[] = "sym_dir1";
 
@@ -78,7 +82,7 @@ struct test_case_t {
 	     * does not exist.
 	     */
 	{
-	good_dir, ENOENT},
+	nonexistent_dir, ENOENT},
 #if !defined(UCLINUX)
 	    /*
 	     * attempt to chroot to a path pointing to an invalid address
@@ -147,12 +151,6 @@ static void setup(void)
 	if (fd == -1)
 		tst_brkm(TBROK, cleanup, "Failed to creat a temp file");
 
-	/*
-	 * set up good_dir to test whether chroot() is setting ENOENT if the
-	 * directory does not exist.
-	 */
-	(void)sprintf(good_dir, "%s.%d", good_dir, getpid());
-
 #if !defined(UCLINUX)
 	bad_addr = mmap(0, 1, PROT_NONE,
 			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
diff --git a/testcases/kernel/syscalls/creat/creat04.c b/testcases/kernel/syscalls/creat/creat04.c
index 0268e77..aa4498a 100644
--- a/testcases/kernel/syscalls/creat/creat04.c
+++ b/testcases/kernel/syscalls/creat/creat04.c
@@ -68,8 +68,9 @@ void cleanup(void);
 #define FMODE	0444
 #define DMODE	00700
 
-char good_dir[40] = "testdir";
-char fname[40], fname1[40];
+static char fname_dir[] = "testdir";
+static char fname[] = "testdir/file";
+static char fname1[] = "testdir/file1";
 
 static uid_t nobody_uid;
 
@@ -103,7 +104,7 @@ int main(int ac, char **av)
 		}
 
 		if (pid == 0) {	/* first child */
-			if (mkdir(good_dir, DMODE) != 0) {
+			if (mkdir(fname_dir, DMODE) != 0) {
 				perror("mkdir() failed");
 				exit(1);
 			}
@@ -157,7 +158,7 @@ int main(int ac, char **av)
 			/* clean up things in case we are looping */
 			unlink(fname);
 			unlink(fname1);
-			rmdir(good_dir);
+			rmdir(fname_dir);
 			exit(retval);
 
 		} else {	/* parent */
@@ -192,10 +193,6 @@ void setup(void)
 
 	/* make a temporary directory and cd to it */
 	tst_tmpdir();
-
-	sprintf(good_dir, "%s.%d", good_dir, getpid());
-	sprintf(fname1, "%s/file1.%d", good_dir, getpid());
-	sprintf(fname, "%s/file.%d", good_dir, getpid());
 }
 
 /*
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
