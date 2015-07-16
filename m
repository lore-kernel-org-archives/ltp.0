Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1ZFge8-0004zq-BK
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 10:44:08 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZFge5-0007VL-VG
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 10:44:08 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t6GAg9wt027803
	for <ltp-list@lists.sourceforge.net>; Thu, 16 Jul 2015 18:42:09 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Thu, 16 Jul 2015 18:43:22 +0800
Message-ID: <1437043403-11184-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] mmap: allocate buffer on stack avoid memory leak
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

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/open_posix_testsuite/conformance/interfaces/mmap/1-1.c  | 6 ++----
 testcases/open_posix_testsuite/conformance/interfaces/mmap/13-1.c | 7 ++-----
 testcases/open_posix_testsuite/conformance/interfaces/mmap/14-1.c | 7 ++-----
 testcases/open_posix_testsuite/conformance/interfaces/mmap/6-2.c  | 6 ++----
 testcases/open_posix_testsuite/conformance/interfaces/mmap/7-1.c  | 6 ++----
 testcases/open_posix_testsuite/conformance/interfaces/mmap/7-2.c  | 6 ++----
 6 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/1-1.c
index a9f5596..21b3b11 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/1-1.c
@@ -30,9 +30,9 @@
 int main(void)
 {
 	char tmpfname[256];
-	char *data;
-	void *pa;
 	ssize_t len = 1024;
+	char data[len];
+	void *pa;
 	int fd;
 
 	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_1_1_%d", getpid());
@@ -45,13 +45,11 @@ int main(void)
 
 	unlink(tmpfname);
 
-	data = malloc(len);
 	memset(data, 'a', len);
 	if (write(fd, data, len) != len) {
 		printf("Error at write(): %s\n", strerror(errno));
 		return PTS_UNRESOLVED;
 	}
-	free(data);
 
 	pa = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 	if (pa == MAP_FAILED) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/13-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/13-1.c
index 5976bdb..035f1e5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/13-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/13-1.c
@@ -37,10 +37,9 @@
 int main(void)
 {
 	char tmpfname[256];
-	char *data;
-
-	void *pa;
 	ssize_t size = 1024;
+	char data[size];
+	void *pa;
 	int fd;
 
 	struct stat stat_buff, stat_buff2;
@@ -61,7 +60,6 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	data = malloc(size);
 	memset(data, 'a', size);
 	printf("Time before write(): %ld\n", time(NULL));
 	if (write(fd, data, size) != size) {
@@ -69,7 +67,6 @@ int main(void)
 		unlink(tmpfname);
 		return PTS_UNRESOLVED;
 	}
-	free(data);
 
 	if (stat(tmpfname, &stat_buff) == -1) {
 		printf("Error at 1st stat(): %s\n", strerror(errno));
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/14-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/14-1.c
index 9431b97..b5e7da3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/14-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/14-1.c
@@ -35,10 +35,9 @@
 int main(void)
 {
 	char tmpfname[256];
-	char *data;
-
-	void *pa;
 	ssize_t size = 1024;
+	char data[size];
+	void *pa;
 	int fd;
 	struct stat stat_buff;
 
@@ -54,7 +53,6 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	data = malloc(size);
 	memset(data, 'a', size);
 	printf("Time before write(): %ld\n", time(NULL));
 	if (write(fd, data, size) != size) {
@@ -62,7 +60,6 @@ int main(void)
 		unlink(tmpfname);
 		return PTS_UNRESOLVED;
 	}
-	free(data);
 	sleep(1);
 	printf("Time before mmap(): %ld\n", time(NULL));
 	pa = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-2.c
index c9237d7..eb43327 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-2.c
@@ -44,9 +44,9 @@ int main(void)
 {
 #ifdef _POSIX_MEMORY_PROTECTION
 	char tmpfname[256];
-	char *data;
-	void *pa;
 	ssize_t size = 1024;
+	char data[size];
+	void *pa;
 	int fd;
 
 	pid_t child;
@@ -65,13 +65,11 @@ int main(void)
 	child = fork();
 	switch (child) {
 	case 0:
-		data = malloc(size);
 		memset(data, 'a', size);
 		if (write(fd, data, size) != size) {
 			printf("Error at write(): %s\n", strerror(errno));
 			return PTS_UNRESOLVED;
 		}
-		free(data);
 
 		pa = mmap(NULL, size, PROT_NONE, MAP_SHARED, fd, 0);
 		if (pa == MAP_FAILED) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-1.c
index e501e24..79ed4ae 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-1.c
@@ -41,9 +41,9 @@
 int main(void)
 {
 	char tmpfname[256];
-	char *data;
-	void *pa;
 	ssize_t size = 1024;
+	char data[size];
+	void *pa;
 	int fd;
 
 	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_7_1_%d", getpid());
@@ -55,13 +55,11 @@ int main(void)
 	}
 	unlink(tmpfname);
 
-	data = malloc(size);
 	memset(data, 'a', size);
 	if (write(fd, data, size) != size) {
 		printf("Error at write(): %s\n", strerror(errno));
 		return PTS_UNRESOLVED;
 	}
-	free(data);
 
 	pa = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 	if (pa == MAP_FAILED) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-2.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-2.c
index b52e383..a8e142d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-2.c
@@ -41,9 +41,9 @@
 int main(void)
 {
 	char tmpfname[256];
-	char *data;
-	void *pa;
 	ssize_t size = 1024;
+	char data[size];
+	void *pa;
 	int fd;
 
 	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_7_2_%d", getpid());
@@ -55,13 +55,11 @@ int main(void)
 	}
 	unlink(tmpfname);
 
-	data = malloc(size);
 	memset(data, 'a', size);
 	if (write(fd, data, size) != size) {
 		printf("Error at write(): %s\n", strerror(errno));
 		return PTS_UNRESOLVED;
 	}
-	free(data);
 
 	pa = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if (pa == MAP_FAILED) {
-- 
1.9.3


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
