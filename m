Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanpai.chen@gmail.com>) id 1QcAdK-00065s-Hn
	for ltp-list@lists.sourceforge.net; Thu, 30 Jun 2011 06:21:50 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1QcAdJ-0003gJ-PK
	for ltp-list@lists.sourceforge.net; Thu, 30 Jun 2011 06:21:50 +0000
Received: by mail-gx0-f175.google.com with SMTP id 3so1005483gxk.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Jun 2011 23:21:49 -0700 (PDT)
From: Andrew Chen <yanpai.chen@gmail.com>
Date: Thu, 30 Jun 2011 14:19:47 +0800
Message-Id: <1309414787-2022-7-git-send-email-yanpai.chen@gmail.com>
In-Reply-To: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
References: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
Subject: [LTP] [PATCH 7/7] testcases: syscalls: close file descriptors
	before unlinking
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
Cc: ypchen@faraday-tech.com

From: Andrew Chen <ypchen@faraday-tech.com>

Ensure file descriptors are closed before unlinking them, or we cannot
remove the generated directories after these tests. The leftover
directories may cause tests failed in latter runs once the directory
names are hit.

Signed-off-by: Andrew Chen <ypchen@faraday-tech.com>
---
 .../testcases/kernel/syscalls/fstatat/fstatat01.c  |    4 +++-
 .../kernel/syscalls/futimesat/futimesat01.c        |    4 +++-
 .../testcases/kernel/syscalls/openat/openat01.c    |   11 ++++++++++-
 .../kernel/syscalls/readlinkat/readlinkat01.c      |    4 +++-
 .../kernel/syscalls/renameat/renameat01.c          |    4 +++-
 .../kernel/syscalls/unlinkat/unlinkat01.c          |    5 ++++-
 6 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/ltp-full-20101031/testcases/kernel/syscalls/fstatat/fstatat01.c b/ltp-full-20101031/testcases/kernel/syscalls/fstatat/fstatat01.c
index 5f81dac..f5938eb 100644
--- a/ltp-full-20101031/testcases/kernel/syscalls/fstatat/fstatat01.c
+++ b/ltp-full-20101031/testcases/kernel/syscalls/fstatat/fstatat01.c
@@ -73,6 +73,7 @@ char testfile[256];
 char testfile2[256];
 char testfile3[256];
 int dirfd, fd, ret;
+int innerfd;
 int fds[TEST_CASES];
 char *filenames[TEST_CASES];
 int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, EINVAL, 0 };
@@ -217,7 +218,7 @@ void setup_every_copy()
 		exit(-1);
 	}
 
-	fd = open(testfile2, O_CREAT | O_RDWR, 0600);
+	innerfd = open(testfile2, O_CREAT | O_RDWR, 0600);
 	if (fd < 0) {
 		perror("open: ");
 		exit(-1);
@@ -258,6 +259,7 @@ void setup()
 void cleanup()
 {
 	/* Remove them */
+	close(innerfd);
 	unlink(testfile2);
 	unlink(testfile3);
 	unlink(testfile);
diff --git a/ltp-full-20101031/testcases/kernel/syscalls/futimesat/futimesat01.c b/ltp-full-20101031/testcases/kernel/syscalls/futimesat/futimesat01.c
index d82a2c4..6729941 100644
--- a/ltp-full-20101031/testcases/kernel/syscalls/futimesat/futimesat01.c
+++ b/ltp-full-20101031/testcases/kernel/syscalls/futimesat/futimesat01.c
@@ -73,6 +73,7 @@ char testfile[256];
 char testfile2[256];
 char testfile3[256];
 int dirfd, fd, ret;
+int innerfd;
 int fds[TEST_CASES];
 char *filenames[TEST_CASES];
 int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0 };
@@ -184,7 +185,7 @@ void setup_every_copy()
 		exit(-1);
 	}
 
-	fd = open(testfile2, O_CREAT | O_RDWR, 0600);
+	innerfd = open(testfile2, O_CREAT | O_RDWR, 0600);
 	if (fd < 0) {
 		perror("open: ");
 		exit(-1);
@@ -224,6 +225,7 @@ void setup()
 void cleanup()
 {
 	/* Remove them */
+	close(innerfd);
 	unlink(testfile2);
 	unlink(testfile3);
 	unlink(testfile);
diff --git a/ltp-full-20101031/testcases/kernel/syscalls/openat/openat01.c b/ltp-full-20101031/testcases/kernel/syscalls/openat/openat01.c
index be40c63..38f2014 100644
--- a/ltp-full-20101031/testcases/kernel/syscalls/openat/openat01.c
+++ b/ltp-full-20101031/testcases/kernel/syscalls/openat/openat01.c
@@ -72,6 +72,7 @@ char testfile[256];
 char testfile2[256];
 char testfile3[256];
 int dirfd, fd, ret;
+int innerfds[2];
 int fds[TEST_CASES];
 char *filenames[TEST_CASES];
 int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0 };
@@ -118,9 +119,12 @@ int main(int ac, char **av)
 		 * Call openat
 		 */
 		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(myopenat
+			TEST(fd = myopenat
 			     (fds[i], filenames[i], O_CREAT | O_WRONLY, 0600));
 
+			if (i < 2)
+				innerfds[i] = fd;
+
 			/* check return code */
 			if (TEST_ERRNO == expected_errno[i]) {
 
@@ -206,7 +210,12 @@ void setup()
 void cleanup()
 {
 	/* Remove them */
+	int i;
 	char tmppathname[256];
+
+	for (i = 0; i < 2; ++i)
+		close(innerfds[i]);
+
 	strcpy(tmppathname, pathname);
 	unlink(strcat(strcat(tmppathname, "/"), testfile));
 	unlink(testfile);
diff --git a/ltp-full-20101031/testcases/kernel/syscalls/readlinkat/readlinkat01.c b/ltp-full-20101031/testcases/kernel/syscalls/readlinkat/readlinkat01.c
index a6963f1..78768fb 100644
--- a/ltp-full-20101031/testcases/kernel/syscalls/readlinkat/readlinkat01.c
+++ b/ltp-full-20101031/testcases/kernel/syscalls/readlinkat/readlinkat01.c
@@ -83,6 +83,7 @@ char dtestfile2[256];
 char testfile3[256];
 char dtestfile3[256];
 int dirfd, fd, ret;
+int innerfd;
 int fds[TEST_CASES];
 char *filenames[TEST_CASES];
 int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0 };
@@ -222,7 +223,7 @@ void setup_every_copy()
 		exit(-1);
 	}
 
-	fd = open(testfile2, O_CREAT | O_RDWR, 0600);
+	innerfd = open(testfile2, O_CREAT | O_RDWR, 0600);
 	if (fd < 0) {
 		perror("open: ");
 		exit(-1);
@@ -285,6 +286,7 @@ void setup()
 void cleanup()
 {
 	/* Remove them */
+	close(innerfd);
 	unlink(testfile2);
 	unlink(dtestfile2);
 	unlink(testfile3);
diff --git a/ltp-full-20101031/testcases/kernel/syscalls/renameat/renameat01.c b/ltp-full-20101031/testcases/kernel/syscalls/renameat/renameat01.c
index 3f27c95..5eff504 100644
--- a/ltp-full-20101031/testcases/kernel/syscalls/renameat/renameat01.c
+++ b/ltp-full-20101031/testcases/kernel/syscalls/renameat/renameat01.c
@@ -81,6 +81,7 @@ char dtestfile2[256];
 char testfile3[256];
 char dtestfile3[256];
 int olddirfd, newdirfd, fd, ret;
+int innerfd;
 int oldfds[TEST_CASES], newfds[TEST_CASES];
 char *oldfilenames[TEST_CASES], *newfilenames[TEST_CASES];
 int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0 };
@@ -208,7 +209,7 @@ void setup_every_copy()
 		exit(-1);
 	}
 
-	fd = open(testfile2, O_CREAT | O_RDWR, 0600);
+	innerfd = open(testfile2, O_CREAT | O_RDWR, 0600);
 	if (fd < 0) {
 		perror("open: ");
 		exit(-1);
@@ -258,6 +259,7 @@ void setup()
 void cleanup()
 {
 	/* Remove them */
+	close(innerfd);
 	unlink(testfile2);
 	unlink(dtestfile2);
 	unlink(testfile3);
diff --git a/ltp-full-20101031/testcases/kernel/syscalls/unlinkat/unlinkat01.c b/ltp-full-20101031/testcases/kernel/syscalls/unlinkat/unlinkat01.c
index f8977f5..a20c085 100644
--- a/ltp-full-20101031/testcases/kernel/syscalls/unlinkat/unlinkat01.c
+++ b/ltp-full-20101031/testcases/kernel/syscalls/unlinkat/unlinkat01.c
@@ -78,6 +78,7 @@ char testfile[256];
 char testfile2[256];
 char testfile3[256];
 int dirfd, fd, ret;
+int innerfd;
 int fds[TEST_CASES];
 char *filenames[TEST_CASES];
 int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, EINVAL, 0, 0 };
@@ -196,7 +197,7 @@ void setup_every_copy()
 		exit(-1);
 	}
 
-	fd = open(testfile2, O_CREAT | O_RDWR, 0600);
+	innerfd = open(testfile2, O_CREAT | O_RDWR, 0600);
 	if (fd < 0) {
 		perror("open: ");
 		exit(-1);
@@ -239,6 +240,8 @@ void cleanup()
 {
 	/* Remove them */
 	char tmppathname[256] = "";
+
+	close(innerfd);
 	strcat(strcat(strcat(tmppathname, pathname), "/"), subpathname);
 	rmdir(tmppathname);
 	unlink(testfile2);
-- 
1.6.5


------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
