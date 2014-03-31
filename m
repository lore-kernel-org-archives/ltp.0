Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <root@localhost.localdomain>) id 1WUZQD-0008SP-S5
	for ltp-list@lists.sourceforge.net; Mon, 31 Mar 2014 10:26:29 +0000
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WUZQC-0003Im-Cu
	for ltp-list@lists.sourceforge.net; Mon, 31 Mar 2014 10:26:29 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id B59203EE0D4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 31 Mar 2014 19:26:21 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id A58E145DEB7
	for <ltp-list@lists.sourceforge.net>;
	Mon, 31 Mar 2014 19:26:21 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.nic.fujitsu.com [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 84CE745DEB5
	for <ltp-list@lists.sourceforge.net>;
	Mon, 31 Mar 2014 19:26:21 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 785AE1DB803B
	for <ltp-list@lists.sourceforge.net>;
	Mon, 31 Mar 2014 19:26:21 +0900 (JST)
Received: from s00.gw.fujitsu.co.jp (s00.gw.nic.fujitsu.com [133.161.11.15])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 212A71DB8038
	for <ltp-list@lists.sourceforge.net>;
	Mon, 31 Mar 2014 19:26:21 +0900 (JST)
Received: from s00.gw.fujitsu.co.jp (kw-mxio2.gw.nic.fujitsu.com
	[10.0.237.142])
	by s00.gw.fujitsu.co.jp (Postfix) with ESMTP id 037344E264
	for <ltp-list@lists.sourceforge.net>;
	Mon, 31 Mar 2014 19:26:21 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.127])
	by s00.gw.fujitsu.co.jp (Postfix) with ESMTP id B6C988A004
	for <ltp-list@lists.sourceforge.net>;
	Mon, 31 Mar 2014 19:26:20 +0900 (JST)
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Mon, 31 Mar 2014 18:26:25 +0800
Message-Id: <1396261585-3628-2-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1396261585-3628-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1396261585-3628-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH 2/2] readlink/readlink03.c: add ENOTDIR and ELOOP
	error value tests
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

add ENOTDIR and ELOOP error value tests for readlink(2)

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/readlink/readlink03.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/readlink/readlink03.c b/testcases/kernel/syscalls/readlink/readlink03.c
index d713810..ef50652 100644
--- a/testcases/kernel/syscalls/readlink/readlink03.c
+++ b/testcases/kernel/syscalls/readlink/readlink03.c
@@ -31,6 +31,10 @@
  *	pathname component of symbolic link is too long (ie, > PATH_MAX).
  *   5) readlink(2) returns -1 and sets errno to ENOENT if the component of
  *	symbolic link points to an empty string.
+ *   6) readlink(2) returns -1 and sets errno to ENOTDIR if a component of
+ *	the path prefix is not a directory.
+ *   7) readlink(2) returns -1 and sets errno to ELOOP if too many symbolic
+ *	links were encountered in translating the pathname.
  */
 
 #include <stdio.h>
@@ -53,9 +57,13 @@
 #define SYM_FILE1	"testdir_1/sfile_1"
 #define TEST_FILE2	"tfile_2"
 #define SYM_FILE2	"sfile_2"
+#define TEST_FILE3	"tfile_3"
+#define SYM_FILE3	"tfile_3/sfile_3"
+#define ELOOPFILE	"/test_eloop"
 #define MAX_SIZE	256
 
 static char longpathname[PATH_MAX + 2];
+static char elooppathname[sizeof(ELOOPFILE) * 43] = ".";
 
 static struct test_case_t {
 	char *link;
@@ -76,6 +84,8 @@ static struct test_case_t {
 	{TEST_FILE2, 1, EINVAL, NULL},
 	{longpathname, 1, ENAMETOOLONG, NULL},
 	{"", 1, ENOENT, NULL},
+	{SYM_FILE3, 1, ENOTDIR, NULL},
+	{elooppathname, 1, ELOOP, NULL},
 };
 
 static void setup(void);
@@ -84,7 +94,8 @@ static void cleanup(void);
 
 char *TCID = "readlink03";
 int TST_TOTAL = ARRAY_SIZE(test_cases);
-static int exp_enos[] = { EACCES, EINVAL, ENAMETOOLONG, ENOENT, 0 };
+static int exp_enos[] = { EACCES, EINVAL, ENAMETOOLONG, ENOENT,
+							ENOTDIR, ELOOP, 0 };
 
 int main(int ac, char **av)
 {
@@ -113,6 +124,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 	struct passwd *ltpuser;
+	int i;
 
 	tst_require_root(NULL);
 
@@ -134,6 +146,17 @@ void setup(void)
 	SAFE_SYMLINK(cleanup, TEST_FILE2, SYM_FILE2);
 
 	memset(longpathname, 'a', PATH_MAX + 2);
+
+	SAFE_TOUCH(cleanup, TEST_FILE3, 0666, NULL);
+
+	/*
+	 * NOTE: the ELOOP test is written based on that the consecutive
+	 * symlinks limit in kernel is hardwired to 40.
+	 */
+	SAFE_MKDIR(cleanup, "test_eloop", MODE_RWX);
+	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
+	for (i = 0; i < 43; i++)
+		strcat(elooppathname, ELOOPFILE);
 }
 
 void readlink_verify(struct test_case_t *tc)
-- 
1.8.3.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
