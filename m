Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1M9gNm-000319-Oj
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2009 14:14:58 +0000
Received: from relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id B7DF66CB00
	for <ltp-list@lists.sourceforge.net>;
	Thu, 28 May 2009 16:14:54 +0200 (CEST)
Date: Thu, 28 May 2009 16:14:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090528141453.GA23822@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
Subject: [LTP] [PATCH] postponing close() after aio_write() has finished
	II	and cleanups
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


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
I've fixed all the sources in the aio_return directory (from the same errors as
previous one) and cleaned the coding style a little.

-- 
Cyril Hrubis
chrubis@suse.cz

--gBBFr7Ir9EOA20Yy
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="aio_return_cleanup.patch"

Index: ltp-full-20090430/testcases/open_posix_testsuite/conformance/interfaces/aio_return/1-1.c
===================================================================
--- ltp-full-20090430.orig/testcases/open_posix_testsuite/conformance/interfaces/aio_return/1-1.c
+++ ltp-full-20090430/testcases/open_posix_testsuite/conformance/interfaces/aio_return/1-1.c
@@ -34,15 +34,14 @@
 #include "posixtest.h"
 
 #define TNAME "aio_return/1-1.c"
+#define BUF_SIZE 111
 
-int main()
+int main(void)
 {
 	char tmpfname[256];
-#define BUF_SIZE 111
 	char buf[BUF_SIZE];
-	int fd;
 	struct aiocb aiocb;
-	int retval;
+	int fd, retval;
 
 #if _POSIX_ASYNCHRONOUS_IO != 200112L
 	exit(PTS_UNSUPPORTED);
@@ -53,8 +52,8 @@ int main()
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
@@ -65,20 +64,19 @@ int main()
 	memset(buf, 0xaa, BUF_SIZE);
 	memset(&aiocb, 0, sizeof(struct aiocb));
 	aiocb.aio_fildes = fd;
-	aiocb.aio_buf = buf;
+	aiocb.aio_buf    = buf;
 	aiocb.aio_nbytes = BUF_SIZE;
 
-	if (aio_write(&aiocb) == -1)
-	{
+	if (aio_write(&aiocb) == -1) {
+		close(fd);
 		printf(TNAME " Error at aio_write(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
 	}
 
 	do {
-		retval = aio_error( &aiocb);
-		if (retval == -1)
-		{
+		retval = aio_error(&aiocb);
+		if (retval == -1) {
 			close(fd);
 			printf(TNAME " Error at aio_error(): %s\n",
 				strerror(errno));
@@ -87,8 +85,8 @@ int main()
 	} while (retval == EINPROGRESS);
 
 	retval = aio_return(&aiocb);
-	if (retval != BUF_SIZE)
-	{
+
+	if (retval != BUF_SIZE) {
 		close(fd);
 		printf(TNAME " Error at aio_return(): %s\n",
 		       strerror(errno));
@@ -96,6 +94,6 @@ int main()
 	}
 	
 	close(fd);
-	printf ("Test PASSED\n");
-	return PTS_PASS;
+	printf("Test PASSED\n");
+	exit(PTS_PASS);
 }
Index: ltp-full-20090430/testcases/open_posix_testsuite/conformance/interfaces/aio_return/2-1.c
===================================================================
--- ltp-full-20090430.orig/testcases/open_posix_testsuite/conformance/interfaces/aio_return/2-1.c
+++ ltp-full-20090430/testcases/open_posix_testsuite/conformance/interfaces/aio_return/2-1.c
@@ -31,15 +31,14 @@
 #include "posixtest.h"
 
 #define TNAME "aio_return/2-1.c"
+#define BUF_SIZE 111
 
-int main()
+int main(void)
 {
 	char tmpfname[256];
-#define BUF_SIZE 111
 	char buf[BUF_SIZE];
-	int fd;
 	struct aiocb aiocb;
-	int retval;
+	int fd, retval;
 
 #if _POSIX_ASYNCHRONOUS_IO != 200112L
 	exit(PTS_UNSUPPORTED);
@@ -50,8 +49,8 @@ int main()
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
@@ -62,22 +61,20 @@ int main()
 	memset(buf, 0xaa, BUF_SIZE);
 	memset(&aiocb, 0, sizeof(struct aiocb));
 	aiocb.aio_fildes = fd;
-	aiocb.aio_buf = buf;
+	aiocb.aio_buf    = buf;
 	aiocb.aio_nbytes = BUF_SIZE;
 
-	if (aio_write(&aiocb) == -1)
-	{
+	if (aio_write(&aiocb) == -1) {
+		close(fd);
 		printf(TNAME " Error at aio_write(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
 	}
 
-	close(fd);
-
 	do {
-		retval = aio_error( &aiocb);
-		if (retval == -1)
-		{
+		retval = aio_error(&aiocb);
+		if (retval == -1) {
+			close(fd);
 			printf(TNAME " Error at aio_error(): %s\n",
 				strerror(errno));
 			exit(PTS_FAIL);
@@ -85,8 +82,9 @@ int main()
 	} while (retval == EINPROGRESS);
 
 	retval = aio_return(&aiocb);
-	if (retval != BUF_SIZE)
-	{
+
+	if (retval != BUF_SIZE) {
+		close(fd);
 		printf(TNAME " Error at aio_return(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
@@ -94,13 +92,14 @@ int main()
 
 	retval = aio_return(&aiocb);
 
-	if (retval != -1)
-	{
+	if (retval != -1) {
+		close(fd);
 		printf(TNAME " Second call to aio_return() should return -1 : %d\n",
 		       retval);
 		exit(PTS_FAIL);
 	}
 
-	printf ("Test PASSED\n");
-	return PTS_PASS;
+	close(fd);
+	printf("Test PASSED\n");
+	exit(PTS_PASS);
 }
Index: ltp-full-20090430/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-1.c
===================================================================
--- ltp-full-20090430.orig/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-1.c
+++ ltp-full-20090430/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-1.c
@@ -37,15 +37,14 @@
 #include "posixtest.h"
 
 #define TNAME "aio_return/3-1.c"
+#define BUF_SIZE 4096
 
-int main()
+int main(void)
 {
 	char tmpfname[256];
-#define BUF_SIZE 4096
 	char buf[BUF_SIZE];
-	int fd;
 	struct aiocb aiocb;
-	int retval;
+	int fd, retval;
 
 #if _POSIX_ASYNCHRONOUS_IO != 200112L
 	exit(PTS_UNSUPPORTED);
@@ -56,8 +55,8 @@ int main()
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
@@ -68,19 +67,20 @@ int main()
 	memset(buf, 0xaa, BUF_SIZE);
 	memset(&aiocb, 0, sizeof(struct aiocb));
 	aiocb.aio_fildes = fd;
-	aiocb.aio_buf = buf;
+	aiocb.aio_buf    = buf;
 	aiocb.aio_nbytes = BUF_SIZE;
-	if (aio_write(&aiocb) == -1)
-	{
+	
+	if (aio_write(&aiocb) == -1) {
+		close(fd);
 		printf(TNAME " Error at aio_write(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
 	}
 
 	do {
-		retval = aio_error( &aiocb);
-		if (retval == -1)
-		{
+		retval = aio_error(&aiocb);
+		if (retval == -1) {
+			close(fd);
 			printf(TNAME " Error at aio_error(): %s\n",
 				strerror(errno));
 			exit(PTS_FAIL);
@@ -88,8 +88,9 @@ int main()
 	} while (retval == EINPROGRESS);
 
 	retval = aio_return(&aiocb);
-	if (retval != BUF_SIZE)
-	{
+
+	if (retval != BUF_SIZE) {
+		close(fd);
 		printf(TNAME " Error at aio_return(): %d, %s\n", retval,
 		       strerror(errno));
 		exit(PTS_FAIL);
@@ -97,34 +98,36 @@ int main()
 
 	memset(&aiocb, 0, sizeof(struct aiocb));
 	aiocb.aio_fildes = fd;
-	aiocb.aio_buf = buf;
-	aiocb.aio_nbytes = BUF_SIZE/2;
-	if (aio_write(&aiocb) == -1)
-	{
+	aiocb.aio_buf    = buf;
+	aiocb.aio_nbytes = BUF_SIZE / 2;
+	
+	if (aio_write(&aiocb) == -1) {
+		close(fd);
 		printf(TNAME " Error at aio_write(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
 	}
 
 	do {
-		retval = aio_error( &aiocb);
-		if (retval == -1)
-		{
+		retval = aio_error(&aiocb);
+		if (retval == -1) {
+			close(fd);
 			printf(TNAME " Error at aio_error(): %s\n",
 				strerror(errno));
 			exit(PTS_FAIL);
 		}
 	} while (retval == EINPROGRESS);
 
-	close(fd);
 	retval = aio_return(&aiocb);
-	if (retval != BUF_SIZE / 2)
-	{
+
+	if (retval != BUF_SIZE / 2) {
+		close(fd);
 		printf(TNAME " Error at aio_return(): %d, %s\n", retval,
 		       strerror(errno));
 		exit(PTS_FAIL);
 	}
 	
-	printf ("Test PASSED\n");
-	return PTS_PASS;
+	close(fd);
+	printf("Test PASSED\n");
+	exit(PTS_PASS);
 }
Index: ltp-full-20090430/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-2.c
===================================================================
--- ltp-full-20090430.orig/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-2.c
+++ ltp-full-20090430/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-2.c
@@ -35,15 +35,14 @@
 #include "posixtest.h"
 
 #define TNAME "aio_return/3-2.c"
+#define BUF_SIZE 4096
 
-int main()
+int main(void)
 {
 	char tmpfname[256];
-#define BUF_SIZE 4096
 	char buf[BUF_SIZE];
-	int fd;
 	struct aiocb aiocb;
-	int retval;
+	int fd, retval;
 
 #if _POSIX_ASYNCHRONOUS_IO != 200112L
 	exit(PTS_UNSUPPORTED);
@@ -54,8 +53,8 @@ int main()
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
@@ -66,19 +65,20 @@ int main()
 	memset(buf, 0xaa, BUF_SIZE);
 	memset(&aiocb, 0, sizeof(struct aiocb));
 	aiocb.aio_fildes = fd;
-	aiocb.aio_buf = buf;
+	aiocb.aio_buf    = buf;
 	aiocb.aio_nbytes = BUF_SIZE;
-	if (aio_write(&aiocb) == -1)
-	{
+	
+	if (aio_write(&aiocb) == -1) {
+		close(fd);
 		printf(TNAME " Error at aio_write(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
 	}
 
 	do {
-		retval = aio_error( &aiocb);
-		if (retval == -1)
-		{
+		retval = aio_error(&aiocb);
+		if (retval == -1) {
+			close(fd);
 			printf(TNAME " Error at aio_error(): %s\n",
 				strerror(errno));
 			exit(PTS_FAIL);
@@ -86,21 +86,23 @@ int main()
 	} while (retval == EINPROGRESS);
 
 	retval = aio_return(&aiocb);
-	if (retval != BUF_SIZE)
-	{
+
+	if (retval != BUF_SIZE) {
+		close(fd);
 		printf(TNAME " Error at aio_return(): %d, %s\n", retval,
 		       strerror(errno));
 		exit(PTS_FAIL);
 	}
 
 	retval = aio_return(&aiocb);
-	if ( (retval != -1) && (errno != EINVAL) )
-	{
+
+	if ((retval != -1) && (errno != EINVAL)) {
+		close(fd);
 		printf(TNAME " aio_return() should fail\n");
 		exit(PTS_FAIL);
 	}
-	close(fd);
 	
-	printf ("Test PASSED\n");
-	return PTS_PASS;
+	close(fd);
+	printf("Test PASSED\n");
+	exit(PTS_PASS);
 }
Index: ltp-full-20090430/testcases/open_posix_testsuite/conformance/interfaces/aio_return/4-1.c
===================================================================
--- ltp-full-20090430.orig/testcases/open_posix_testsuite/conformance/interfaces/aio_return/4-1.c
+++ ltp-full-20090430/testcases/open_posix_testsuite/conformance/interfaces/aio_return/4-1.c
@@ -33,16 +33,15 @@
 #include "posixtest.h"
 
 #define TNAME "aio_return/4-1.c"
+#define BUF_SIZE 111
 
-int main()
+int main(void)
 {
 	char tmpfname[256];
-#define BUF_SIZE 111
 	char buf[BUF_SIZE];
-	int fd;
 	struct aiocb aiocb;
 	struct aiocb aiocb2;
-	int retval;
+	int fd, retval;
 
 #if _POSIX_ASYNCHRONOUS_IO != 200112L
 	exit(PTS_UNSUPPORTED);
@@ -53,8 +52,8 @@ int main()
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
@@ -65,50 +64,49 @@ int main()
 	memset(buf, 0xaa, BUF_SIZE);
 	memset(&aiocb, 0, sizeof(struct aiocb));
 	aiocb.aio_fildes = fd;
-	aiocb.aio_buf = buf;
+	aiocb.aio_buf    = buf;
 	aiocb.aio_nbytes = BUF_SIZE;
 
-	if (aio_write(&aiocb) == -1)
-	{
+	if (aio_write(&aiocb) == -1) {
+		close(fd);
 		printf(TNAME " Error at aio_write(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
 	}
 
-	close(fd);
-
 	do {
 		retval = aio_error( &aiocb);
-		if (retval == -1)
-		{
+		if (retval == -1) {
+			close(fd);
 			printf(TNAME " Error at aio_error(): %s\n",
 				strerror(errno));
 			exit(PTS_FAIL);
 		}
 	} while (retval == EINPROGRESS);
 
+	memset(&aiocb2, 0, sizeof(struct aiocb));
 	aiocb2.aio_fildes = fd;
-	aiocb2.aio_buf = buf;
+	aiocb2.aio_buf    = buf;
 	aiocb2.aio_nbytes = BUF_SIZE;
 
 	retval = aio_return(&aiocb2);
-	if (retval != -1)
-	{
+
+	if (retval != -1) {
+		close(fd);
 		printf(TNAME " aio_return() should fail\n");
 		exit(PTS_FAIL);
 	}
 
 	retval = aio_return(&aiocb);
-	if (retval != BUF_SIZE)
-	{
+	
+	if (retval != BUF_SIZE) {
+		close(fd);
 		printf(TNAME " Error at aio_return(): %d, %s\n", retval,
 		       strerror(errno));
 		exit(PTS_FAIL);
 	}
 
-
 	close(fd);
-
-	printf ("Test PASSED\n");
-	return PTS_PASS;
+	printf("Test PASSED\n");
+	exit(PTS_PASS);
 }

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--gBBFr7Ir9EOA20Yy--

