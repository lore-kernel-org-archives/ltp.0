Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1Ws7kO-0005Tn-B3
	for ltp-list@lists.sourceforge.net; Wed, 04 Jun 2014 09:44:40 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ws7kM-0000eT-FM
	for ltp-list@lists.sourceforge.net; Wed, 04 Jun 2014 09:44:40 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s549iSfE005196
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Jun 2014 17:44:28 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Wed, 4 Jun 2014 17:43:27 +0800
Message-ID: <1401875007-27025-2-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1401875007-27025-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1401875007-27025-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] truncate/truncate03.c: add EFBIG and ELOOP error
	value tests
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

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/truncate/truncate03.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/truncate/truncate03.c b/testcases/kernel/syscalls/truncate/truncate03.c
index 99f5c1e..59a2a89 100644
--- a/testcases/kernel/syscalls/truncate/truncate03.c
+++ b/testcases/kernel/syscalls/truncate/truncate03.c
@@ -33,8 +33,14 @@
  *        does not exist.
  *     6) truncate(2) returns -1 and sets errno to EISDIR if the named file
  *        is a directory.
+ *     7) truncate(2) returns -1 and sets errno to EFBIG if the argument length
+ *        is larger than the maximum file size.
+ *     8) truncate(2) returns -1 and sets errno to ELOOP if too many symbolic
+ *        links were encountered in translating the pathname.
  */
 
+#define _GNU_SOURCE
+
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -51,6 +57,9 @@
 
 #define TEST_FILE1	"testfile"
 #define TEST_FILE2	"t_file/testfile"
+#define TEST_FILE3	"testfile3"
+#define TEST_SYM1	"testsymlink1"
+#define TEST_SYM2	"testsymlink2"
 #define TEST_DIR1	"testdir"
 #define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
 #define NEW_MODE	S_IRUSR | S_IRGRP | S_IROTH
@@ -73,7 +82,9 @@ static struct test_case_t {
 #endif
 	{ Longpathname, TRUNC_LEN, ENAMETOOLONG },
 	{ "", TRUNC_LEN, ENOENT },
-	{ TEST_DIR1, TRUNC_LEN, EISDIR }
+	{ TEST_DIR1, TRUNC_LEN, EISDIR },
+	{ TEST_FILE3, LLONG_MAX, EFBIG },
+	{ TEST_SYM1, TRUNC_LEN, ELOOP }
 };
 
 static void setup(void);
@@ -83,7 +94,7 @@ static void truncate_verify(struct test_case_t *);
 char *TCID = "truncate03";
 int TST_TOTAL = ARRAY_SIZE(test_cases);
 static int exp_enos[] = { EACCES, ENOTDIR, EFAULT, ENAMETOOLONG,
-							ENOENT, EISDIR, 0 };
+					ENOENT, EISDIR, EFBIG, ELOOP, 0 };
 
 int main(int ac, char **av)
 {
@@ -142,6 +153,11 @@ void setup(void)
 	memset(Longpathname, 'a', PATH_MAX + 1);
 
 	SAFE_MKDIR(cleanup, TEST_DIR1, DIR_MODE);
+
+	SAFE_TOUCH(cleanup, TEST_FILE3, FILE_MODE, NULL);
+
+	SAFE_SYMLINK(cleanup, TEST_SYM1, TEST_SYM2);
+	SAFE_SYMLINK(cleanup, TEST_SYM2, TEST_SYM1);
 }
 
 void truncate_verify(struct test_case_t *tc)
-- 
1.9.0


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
