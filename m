Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PYL2u-0000WS-Gy
	for ltp-list@lists.sourceforge.net; Thu, 30 Dec 2010 16:08:08 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 8A6A990847
	for <ltp-list@lists.sourceforge.net>;
	Thu, 30 Dec 2010 17:07:59 +0100 (CET)
Date: Thu, 30 Dec 2010 17:23:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101230162331.GA25928@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
Subject: [LTP] [PATCH] first part of the sysconf(_SC_ASYNCHRONOUS_IO) !=
 200112L cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
I've started to fix testcases disabled by value from
sysconf(_SC_ASYNCHRONOUS_IO) as POSIX from 2008 allows value 200XXXL to be
returned. Attached patch fixes all tests in conformance/aio_fsync directory.
Each test gets reviewed and issues are fixed.  See detailed log below (trivial
coding style fixes are not mentoined).

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>


conformance/interfaces/aio_fsync/

1-1.c  -- trivial change (test unimplemented)

2-1.c  -- looks like test is not finished
          (does some work and then return UNTESTED)

3-1.c  -- looks like test is not finished
          (does some work and then return UNTESTED)

4-1.c  -- works

4-2.c  -- was broken (testing errno value instead of
                      value from aio_return())
          works now

5-1.c  -- works

6-1.c  -- trivial change (test unimplemented)

7-1.c  -- trivial change (test unimplemented)

8-1.c  -- works

8-2.c  -- works

8-3.c  -- works

8-4.c  -- works

9-1.c  -- works

10-1.c -- trivial change (test unimplemented)

11-1.c -- trivial change (test unimplemented)

12-1.c -- works

13-1.c -- works

14-1.c -- works

-- 
Cyril Hrubis
chrubis@suse.cz

--u3/rZRmxL6MmkK24
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="SC_ASYNCHRONOUS_IO_1.patch"

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/1-1.c
index a7aa26a..bbafb41 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/1-1.c
@@ -6,14 +6,13 @@
  * source tree.
  */
 
-#define _XOPEN_SOURCE 600
 #include <stdlib.h>
 #include <unistd.h>
 #include "posixtest.h"
 
-int main()
+int main(void)
 {
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) <= 0)
 		exit(PTS_UNSUPPORTED);
 	exit(PTS_UNTESTED);
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/10-1.c
index e2f9a21..9596ca1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/10-1.c
@@ -20,14 +20,13 @@
  *
  */
 
-#define _XOPEN_SOURCE 600
 #include <stdlib.h>
 #include <unistd.h>
 #include "posixtest.h"
 
-int main()
+int main(void)
 {
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) <= 0)
 		exit(PTS_UNSUPPORTED);
 	exit(PTS_UNTESTED);
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/11-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/11-1.c
index a7aa26a..bbafb41 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/11-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/11-1.c
@@ -6,14 +6,13 @@
  * source tree.
  */
 
-#define _XOPEN_SOURCE 600
 #include <stdlib.h>
 #include <unistd.h>
 #include "posixtest.h"
 
-int main()
+int main(void)
 {
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) <= 0)
 		exit(PTS_UNSUPPORTED);
 	exit(PTS_UNTESTED);
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/12-1.c
index cc9b6e1..1423db4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/12-1.c
@@ -6,7 +6,6 @@
  * source tree.
  */
 
-#define _XOPEN_SOURCE 600
 #include <stdio.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -21,28 +20,27 @@
 
 #define TNAME "aio_fsync/12-1.c"
 
-int main()
+int main(void)
 {
 	struct aiocb aiocb;
 
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) <= 0)
 		return PTS_UNSUPPORTED;
 
 	memset(&aiocb, 0, sizeof(struct aiocb));
 	aiocb.aio_fildes = -1;
 
-	if (aio_fsync(O_SYNC, &aiocb) != -1)
-	{
+	if (aio_fsync(O_SYNC, &aiocb) != -1) {
 		printf(TNAME " aio_fsync() accepts bad filedes\n");
 		exit(PTS_FAIL);
 	}
 
-	if (errno != EBADF)
-	{
+	if (errno != EBADF) {
 		printf(TNAME " errno is not EBADF (%d)\n", errno);
 		exit(PTS_FAIL);
 	}
 	
-	printf ("Test PASSED\n");
+	printf("Test PASSED\n");
+
 	return PTS_PASS;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/13-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/13-1.c
index a7aa26a..bbafb41 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/13-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/13-1.c
@@ -6,14 +6,13 @@
  * source tree.
  */
 
-#define _XOPEN_SOURCE 600
 #include <stdlib.h>
 #include <unistd.h>
 #include "posixtest.h"
 
-int main()
+int main(void)
 {
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) <= 0)
 		exit(PTS_UNSUPPORTED);
 	exit(PTS_UNTESTED);
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c
index bc1d384..d60636a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c
@@ -6,7 +6,6 @@
  * source tree.
  */
 
-#define _XOPEN_SOURCE 600
 #include <stdio.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -21,16 +20,17 @@
 
 #define TNAME "aio_fsync/14-1.c"
 
-int main()
+#define BUF_SIZE 111
+
+int main(void)
 {
 	char tmpfname[256];
-#define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
 	struct aiocb aiocb_write;
 	struct aiocb aiocb_fsync;
 
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) <= 0)
 		return PTS_UNSUPPORTED;
 
 	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_14_1_%d", 
@@ -38,8 +38,8 @@ int main()
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
 		  S_IRUSR | S_IWUSR);
-	if (fd == -1)
-	{
+
+	if (fd == -1) {
 		printf(TNAME " Error at open(): %s\n",
 		       strerror(errno));
 		exit(PTS_UNRESOLVED);
@@ -52,8 +52,7 @@ int main()
 	aiocb_write.aio_buf = buf;
 	aiocb_write.aio_nbytes = BUF_SIZE;
 
-	if (aio_write(&aiocb_write) == -1)
-	{
+	if (aio_write(&aiocb_write) == -1) {
 		printf(TNAME " Error at aio_write(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
@@ -62,19 +61,17 @@ int main()
 	memset(&aiocb_fsync, 0, sizeof(aiocb_fsync));
 	aiocb_fsync.aio_fildes = fd;
 
-	if (aio_fsync(-1, &aiocb_fsync) != -1)
-	{
+	if (aio_fsync(-1, &aiocb_fsync) != -1) {
 		printf(TNAME " aio_fsync() accepts bad op\n");
 		exit(PTS_FAIL);
 	}
 
-	if (errno != EINVAL)
-	{
+	if (errno != EINVAL) {
 		printf(TNAME " errno is not EINVAL (%d)\n", errno);
 		exit(PTS_FAIL);
 	}
 	
 	close(fd);
-	printf ("Test PASSED\n");
+	printf("Test PASSED\n");
 	return PTS_PASS;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c
index 52d0dad..a2be2c1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c
@@ -6,7 +6,6 @@
  * source tree.
  */
 
-#define _XOPEN_SOURCE 600
 #include <stdio.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -23,8 +22,7 @@
 
 #define BUF_SIZE 1024
 
-int
-main (void)
+int main(void)
 {
 	char tmpfname[256];
 	char buf[BUF_SIZE];
@@ -32,7 +30,7 @@ main (void)
 	struct aiocb aiocb_write;
 	struct aiocb aiocb_fsync;
 
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) <= 0)
 		return PTS_UNSUPPORTED;
 
 	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_2_1_%d", 
@@ -40,8 +38,8 @@ main (void)
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
 		  S_IRUSR | S_IWUSR);
-	if (fd == -1)
-	{
+
+	if (fd == -1) {
 		printf(TNAME " Error at open(): %s\n",
 		       strerror(errno));
 		exit(PTS_UNRESOLVED);
@@ -54,8 +52,7 @@ main (void)
 	aiocb_write.aio_buf = buf;
 	aiocb_write.aio_nbytes = BUF_SIZE;
 
-	if (aio_write(&aiocb_write) == -1)
-	{
+	if (aio_write(&aiocb_write) == -1) {
 		printf(TNAME " Error at aio_write(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
@@ -64,8 +61,7 @@ main (void)
 	memset(&aiocb_fsync, 0, sizeof(aiocb_fsync));
 	aiocb_fsync.aio_fildes = fd;
 
-	if (aio_fsync(O_DSYNC, &aiocb_fsync) != 0)
-	{
+	if (aio_fsync(O_DSYNC, &aiocb_fsync) != 0) {
 		printf(TNAME " Error at aio_fsync(): %s\n", strerror(errno));
 		exit(PTS_FAIL);
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/3-1.c
index dd80669..e016fb1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/3-1.c
@@ -6,7 +6,6 @@
  * source tree.
  */
 
-#define _XOPEN_SOURCE 600
 #include <stdio.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -23,7 +22,7 @@
 
 #define BUF_SIZE 1024
 
-int main()
+int main(void)
 {
 	char tmpfname[256];
 	char buf[BUF_SIZE];
@@ -31,7 +30,7 @@ int main()
 	struct aiocb aiocb_write;
 	struct aiocb aiocb_fsync;
 
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) <= 0)
 		return PTS_UNSUPPORTED;
 
 	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_3_1_%d", 
@@ -39,8 +38,8 @@ int main()
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
 		  S_IRUSR | S_IWUSR);
-	if (fd == -1)
-	{
+
+	if (fd == -1) {
 		printf(TNAME " Error at open(): %s\n",
 		       strerror(errno));
 		exit(PTS_UNRESOLVED);
@@ -53,8 +52,7 @@ int main()
 	aiocb_write.aio_buf = buf;
 	aiocb_write.aio_nbytes = BUF_SIZE;
 
-	if (aio_write(&aiocb_write) == -1)
-	{
+	if (aio_write(&aiocb_write) == -1) {
 		printf(TNAME " Error at aio_write(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
@@ -63,8 +61,7 @@ int main()
 	memset(&aiocb_fsync, 0, sizeof(aiocb_fsync));
 	aiocb_fsync.aio_fildes = fd;
 
-	if (aio_fsync(O_SYNC, &aiocb_fsync) != 0)
-	{
+	if (aio_fsync(O_SYNC, &aiocb_fsync) != 0) {
 		printf(TNAME " Error at aio_fsync(): %s\n", strerror(errno));
 		exit(PTS_FAIL);
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-1.c
index 41adb25..1767889 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-1.c
@@ -6,7 +6,6 @@
  * source tree.
  */
 
-#define _XOPEN_SOURCE 600
 #include <stdio.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -21,16 +20,17 @@
 
 #define TNAME "aio_fsync/4-1.c"
 
-int main()
+#define BUF_SIZE 111
+
+int main(void)
 {
 	char tmpfname[256];
-#define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
 	struct aiocb aiocb_write;
 	struct aiocb aiocb_fsync;
 
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) <= 0)
 		return PTS_UNSUPPORTED;
 
 	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_4_1_%d", 
@@ -38,8 +38,8 @@ int main()
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
 		  S_IRUSR | S_IWUSR);
-	if (fd == -1)
-	{
+
+	if (fd == -1) {
 		printf(TNAME " Error at open(): %s\n",
 		       strerror(errno));
 		exit(PTS_UNRESOLVED);
@@ -52,8 +52,7 @@ int main()
 	aiocb_write.aio_buf = buf;
 	aiocb_write.aio_nbytes = BUF_SIZE;
 
-	if (aio_write(&aiocb_write) == -1)
-	{
+	if (aio_write(&aiocb_write) == -1) {
 		printf(TNAME " Error at aio_write(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
@@ -62,19 +61,17 @@ int main()
 	memset(&aiocb_fsync, 0, sizeof(aiocb_fsync));
 	aiocb_fsync.aio_fildes = fd;
 
-	if (aio_fsync(O_SYNC, &aiocb_fsync) != 0)
-	{
+	if (aio_fsync(O_SYNC, &aiocb_fsync) != 0) {
 		printf(TNAME " Error at aio_fsync()\n");
 		exit(PTS_FAIL);
 	}
 
-	if (aio_error(&aiocb_fsync) < 0)
-	{
+	if (aio_error(&aiocb_fsync) < 0) {
 		printf(TNAME " Error at aio_error() : %s\n", strerror(errno));
 		exit(PTS_FAIL);
 	}
 
 	close(fd);
-	printf ("Test PASSED\n");
+	printf("Test PASSED\n");
 	return PTS_PASS;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-2.c
index 9bc63ea..1e77103 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-2.c
@@ -6,7 +6,6 @@
  * source tree.
  */
 
-#define _XOPEN_SOURCE 600
 #include <stdio.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -21,16 +20,17 @@
 
 #define TNAME "aio_fsync/4-2.c"
 
-int main()
+#define BUF_SIZE 111
+
+int main(void)
 {
 	char tmpfname[256];
-#define BUF_SIZE 111
 	char buf[BUF_SIZE];
-	int fd;
+	int fd, ret;
 	struct aiocb aiocb_write;
 	struct aiocb aiocb_fsync;
 
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) <= 0)
 		return PTS_UNSUPPORTED;
 
 	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_4_2_%d", 
@@ -38,8 +38,8 @@ int main()
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
 		  S_IRUSR | S_IWUSR);
-	if (fd == -1)
-	{
+
+	if (fd == -1) {
 		printf(TNAME " Error at open(): %s\n",
 		       strerror(errno));
 		exit(PTS_UNRESOLVED);
@@ -52,8 +52,7 @@ int main()
 	aiocb_write.aio_buf = buf;
 	aiocb_write.aio_nbytes = BUF_SIZE;
 
-	if (aio_write(&aiocb_write) == -1)
-	{
+	if (aio_write(&aiocb_write) == -1) {
 		printf(TNAME " Error at aio_write(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
@@ -62,20 +61,17 @@ int main()
 	memset(&aiocb_fsync, 0, sizeof(aiocb_fsync));
 	aiocb_fsync.aio_fildes = fd;
 
-	if (aio_fsync(O_SYNC, &aiocb_fsync) != 0)
-	{
+	if (aio_fsync(O_SYNC, &aiocb_fsync) != 0) {
 		printf(TNAME " Error at aio_fsync()\n");
 		exit(PTS_FAIL);
 	}
 
-	errno = 0;
-	aio_return(&aiocb_fsync);
-	if (errno != 0)
-	{
-		printf(TNAME " Error at aio_return() : %s\n", strerror(errno));
+	if ((ret = aio_return(&aiocb_fsync) != 0)) {
+		printf(TNAME " Error at aio_return() : %s\n", strerror(ret));
 		exit(PTS_FAIL);
 	}
+
 	close(fd);
-	printf ("Test PASSED\n");
+	printf("Test PASSED\n");
 	return PTS_PASS;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/5-1.c
index 6524cf8..b641232 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/5-1.c
@@ -6,7 +6,6 @@
  * source tree.
  */
 
-#define _XOPEN_SOURCE 600
 #include <stdio.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -23,7 +22,7 @@
 
 #define BUF_SIZE 1024
 
-int main()
+int main(void)
 {
 	char tmpfname[256];
 	char buf[BUF_SIZE];
@@ -32,7 +31,7 @@ int main()
 	struct aiocb aiocb_fsync;
 	int ret;
 
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) <= 0)
 		return PTS_UNSUPPORTED;
 
 	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_5_1_%d", 
@@ -40,8 +39,8 @@ int main()
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
 		  S_IRUSR | S_IWUSR);
-	if (fd == -1)
-	{
+	
+	if (fd == -1) {
 		printf(TNAME " Error at open(): %s\n",
 		       strerror(errno));
 		exit(PTS_UNRESOLVED);
@@ -54,8 +53,7 @@ int main()
 	aiocb_write.aio_buf = buf;
 	aiocb_write.aio_nbytes = BUF_SIZE;
 
-	if (aio_write(&aiocb_write) == -1)
-	{
+	if (aio_write(&aiocb_write) == -1) {
 		printf(TNAME " Error at aio_write(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
@@ -64,8 +62,7 @@ int main()
 	memset(&aiocb_fsync, 0, sizeof(aiocb_fsync));
 	aiocb_fsync.aio_fildes = fd;
 
-	if (aio_fsync(O_SYNC, &aiocb_fsync) != 0)
-	{
+	if (aio_fsync(O_SYNC, &aiocb_fsync) != 0) {
 		printf(TNAME " Error at aio_fsync(): %s\n", strerror(errno));
 		exit(PTS_FAIL);
 	}
@@ -78,12 +75,13 @@ int main()
 	 * something else
 	 * otherwise test hangs
 	 */
-
 	while (aio_error(&aiocb_fsync) == EINPROGRESS);
 
 	close(fd);
 
 	/* we didn't check if the operation is really performed */
+	if (ret == PTS_PASS)
+		printf("Test PASSED\n");
 
 	return ret;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/6-1.c
index a7aa26a..bbafb41 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/6-1.c
@@ -6,14 +6,13 @@
  * source tree.
  */
 
-#define _XOPEN_SOURCE 600
 #include <stdlib.h>
 #include <unistd.h>
 #include "posixtest.h"
 
-int main()
+int main(void)
 {
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) <= 0)
 		exit(PTS_UNSUPPORTED);
 	exit(PTS_UNTESTED);
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/7-1.c
index a7aa26a..bbafb41 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/7-1.c
@@ -6,14 +6,13 @@
  * source tree.
  */
 
-#define _XOPEN_SOURCE 600
 #include <stdlib.h>
 #include <unistd.h>
 #include "posixtest.h"
 
-int main()
+int main(void)
 {
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) <= 0)
 		exit(PTS_UNSUPPORTED);
 	exit(PTS_UNTESTED);
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-1.c
index 8a54098..1ea09c5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-1.c
@@ -6,7 +6,6 @@
  * source tree.
  */
 
-#define _XOPEN_SOURCE 600
 #include <stdio.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -21,16 +20,17 @@
 
 #define TNAME "aio_fsync/8-1.c"
 
-int main()
+#define BUF_SIZE 111
+
+int main(void)
 {
 	char tmpfname[256];
-#define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
 	struct aiocb aiocb_write;
 	struct aiocb aiocb_fsync;
 
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) <= 0)
 		return PTS_UNSUPPORTED;
 
 	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_8_1_%d", 
@@ -38,8 +38,8 @@ int main()
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
 		  S_IRUSR | S_IWUSR);
-	if (fd == -1)
-	{
+
+	if (fd == -1) {
 		printf(TNAME " Error at open(): %s\n",
 		       strerror(errno));
 		exit(PTS_UNRESOLVED);
@@ -52,8 +52,7 @@ int main()
 	aiocb_write.aio_buf = buf;
 	aiocb_write.aio_nbytes = BUF_SIZE;
 
-	if (aio_write(&aiocb_write) == -1)
-	{
+	if (aio_write(&aiocb_write) == -1) {
 		printf(TNAME " Error at aio_write(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
@@ -63,13 +62,12 @@ int main()
 	aiocb_fsync.aio_fildes = fd;
 	aiocb_fsync.aio_nbytes = -1;
 
-	if (aio_fsync(O_SYNC, &aiocb_fsync) != 0)
-	{
+	if (aio_fsync(O_SYNC, &aiocb_fsync) != 0) {
 		printf(TNAME " Error at aio_fsync(): %s\n", strerror(errno));
 		exit(PTS_FAIL);
 	}
 
 	close(fd);
-	printf ("Test PASSED\n");
+	printf("Test PASSED\n");
 	return PTS_PASS;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-2.c
index 798339e..1a7d5e6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-2.c
@@ -6,7 +6,6 @@
  * source tree.
  */
 
-#define _XOPEN_SOURCE 600
 #include <stdio.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -21,16 +20,17 @@
 
 #define TNAME "aio_fsync/8-2.c"
 
-int main()
+#define BUF_SIZE 111
+
+int main(void)
 {
 	char tmpfname[256];
-#define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
 	struct aiocb aiocb_write;
 	struct aiocb aiocb_fsync;
 
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) <= 0)
 		return PTS_UNSUPPORTED;
 
 	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_8_2_%d", 
@@ -38,8 +38,8 @@ int main()
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
 		  S_IRUSR | S_IWUSR);
-	if (fd == -1)
-	{
+
+	if (fd == -1) {
 		printf(TNAME " Error at open(): %s\n",
 		       strerror(errno));
 		exit(PTS_UNRESOLVED);
@@ -52,8 +52,7 @@ int main()
 	aiocb_write.aio_buf = buf;
 	aiocb_write.aio_nbytes = BUF_SIZE;
 
-	if (aio_write(&aiocb_write) == -1)
-	{
+	if (aio_write(&aiocb_write) == -1) {
 		printf(TNAME " Error at aio_write(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
@@ -63,13 +62,12 @@ int main()
 	aiocb_fsync.aio_fildes = fd;
 	aiocb_fsync.aio_buf = NULL;
 
-	if (aio_fsync(O_SYNC, &aiocb_fsync) != 0)
-	{
+	if (aio_fsync(O_SYNC, &aiocb_fsync) != 0) {
 		printf(TNAME " Error at aio_fsync(): %s\n", strerror(errno));
 		exit(PTS_FAIL);
 	}
 
 	close(fd);
-	printf ("Test PASSED\n");
+	printf("Test PASSED\n");
 	return PTS_PASS;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-3.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-3.c
index c7ad2f4..7745e58 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-3.c
@@ -6,7 +6,6 @@
  * source tree.
  */
 
-#define _XOPEN_SOURCE 600
 #include <stdio.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -21,16 +20,17 @@
 
 #define TNAME "aio_fsync/8-3.c"
 
-int main()
+#define BUF_SIZE 111
+
+int main(void)
 {
 	char tmpfname[256];
-#define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
 	struct aiocb aiocb_write;
 	struct aiocb aiocb_fsync;
 
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) <= 0)
 		return PTS_UNSUPPORTED;
 
 	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_8_3_%d", 
@@ -38,8 +38,8 @@ int main()
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
 		  S_IRUSR | S_IWUSR);
-	if (fd == -1)
-	{
+
+	if (fd == -1) {
 		printf(TNAME " Error at open(): %s\n",
 		       strerror(errno));
 		exit(PTS_UNRESOLVED);
@@ -52,8 +52,7 @@ int main()
 	aiocb_write.aio_buf = buf;
 	aiocb_write.aio_nbytes = BUF_SIZE;
 
-	if (aio_write(&aiocb_write) == -1)
-	{
+	if (aio_write(&aiocb_write) == -1) {
 		printf(TNAME " Error at aio_write(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
@@ -63,13 +62,12 @@ int main()
 	aiocb_fsync.aio_fildes = fd;
 	aiocb_fsync.aio_reqprio = -1;
 
-	if (aio_fsync(O_SYNC, &aiocb_fsync) != 0)
-	{
+	if (aio_fsync(O_SYNC, &aiocb_fsync) != 0) {
 		printf(TNAME " Error at aio_fsync(): %s\n", strerror(errno));
 		exit(PTS_FAIL);
 	}
 
 	close(fd);
-	printf ("Test PASSED\n");
+	printf("Test PASSED\n");
 	return PTS_PASS;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-4.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-4.c
index bce6714..167566e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-4.c
@@ -6,7 +6,6 @@
  * source tree.
  */
 
-#define _XOPEN_SOURCE 600
 #include <stdio.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -21,16 +20,17 @@
 
 #define TNAME "aio_fsync/8-4.c"
 
-int main()
+#define BUF_SIZE 111
+
+int main(void)
 {
 	char tmpfname[256];
-#define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
 	struct aiocb aiocb_write;
 	struct aiocb aiocb_fsync;
 
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) == -1)
 		return PTS_UNSUPPORTED;
 
 	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_8_4_%d", 
@@ -38,8 +38,8 @@ int main()
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
 		  S_IRUSR | S_IWUSR);
-	if (fd == -1)
-	{
+
+	if (fd == -1) {
 		printf(TNAME " Error at open(): %s\n",
 		       strerror(errno));
 		exit(PTS_UNRESOLVED);
@@ -52,8 +52,7 @@ int main()
 	aiocb_write.aio_buf = buf;
 	aiocb_write.aio_nbytes = BUF_SIZE;
 
-	if (aio_write(&aiocb_write) == -1)
-	{
+	if (aio_write(&aiocb_write) == -1) {
 		printf(TNAME " Error at aio_write(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
@@ -63,13 +62,12 @@ int main()
 	aiocb_fsync.aio_fildes = fd;
 	aiocb_fsync.aio_offset = -1;
 
-	if (aio_fsync(O_SYNC, &aiocb_fsync) != 0)
-	{
+	if (aio_fsync(O_SYNC, &aiocb_fsync) != 0) {
 		printf(TNAME " Error at aio_fsync(): %s\n", strerror(errno));
 		exit(PTS_FAIL);
 	}
 
 	close(fd);
-	printf ("Test PASSED\n");
+	printf("Test PASSED\n");
 	return PTS_PASS;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/9-1.c
index 6ff435f..3cd4c74 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/9-1.c
@@ -6,7 +6,6 @@
  * source tree.
  */
 
-#define _XOPEN_SOURCE 600
 #include <stdio.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -21,16 +20,17 @@
 
 #define TNAME "aio_fsync/9-1.c"
 
-int main()
+#define BUF_SIZE 111
+
+int main(void)
 {
 	char tmpfname[256];
-#define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
 	struct aiocb aiocb_write;
 	struct aiocb aiocb_fsync;
 
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) <= 0)
 		return PTS_UNSUPPORTED;
 
 	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_9_1_%d", 
@@ -38,8 +38,8 @@ int main()
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
 		  S_IRUSR | S_IWUSR);
-	if (fd == -1)
-	{
+	
+	if (fd == -1) {
 		printf(TNAME " Error at open(): %s\n",
 		       strerror(errno));
 		exit(PTS_UNRESOLVED);
@@ -52,8 +52,7 @@ int main()
 	aiocb_write.aio_buf = buf;
 	aiocb_write.aio_nbytes = BUF_SIZE;
 
-	if (aio_write(&aiocb_write) == -1)
-	{
+	if (aio_write(&aiocb_write) == -1) {
 		printf(TNAME " Error at aio_write(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
@@ -69,6 +68,6 @@ int main()
 	}
 
 	close(fd);
-	printf ("Test PASSED\n");
+	printf("Test PASSED\n");
 	return PTS_PASS;
 }

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--u3/rZRmxL6MmkK24--

