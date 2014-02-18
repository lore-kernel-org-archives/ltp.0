Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WFfuD-0004Dk-44
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 08:19:53 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WFfuB-00051M-7g
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 08:19:53 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1I8Jgiq022242
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Feb 2014 16:19:42 +0800
Message-ID: <1392711579.2036.18.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 18 Feb 2014 16:19:39 +0800
In-Reply-To: <1392710999.2036.16.camel@G08JYZSD130126>
References: <1389853977.2282.9.camel@G08JYZSD130126>
	<1389854521.2282.10.camel@G08JYZSD130126>
	<1392710999.2036.16.camel@G08JYZSD130126>
Mime-Version: 1.0
Subject: [LTP] [PATCH v2 2/2] lstat/lstat02.c: add ELOOP errno test
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Add ELOOP errno test for lstat(2)

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/lstat/lstat02.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/lstat/lstat02.c b/testcases/kernel/syscalls/lstat/lstat02.c
index d108c12..b9494e2 100644
--- a/testcases/kernel/syscalls/lstat/lstat02.c
+++ b/testcases/kernel/syscalls/lstat/lstat02.c
@@ -29,6 +29,8 @@
  *	component is too long.
  *   5) lstat(2) returns -1 and sets errno to ENOTDIR if the directory
  *	component in pathname is not a directory.
+ *   6) lstat(2) returns -1 and sets errno to ELOOP if the pathname has too
+ *	many symbolic links encountered while traversing.
  */
 
 #include <stdio.h>
@@ -55,6 +57,7 @@
 #define TEST_ENOTDIR	"test_file/test_enotdir"
 
 static char longpathname[PATH_MAX + 2];
+static char elooppathname[PATH_MAX] = ".";
 
 #if !defined(UCLINUX)
 static void bad_addr_setup(int);
@@ -74,11 +77,13 @@ static struct test_case_t {
 #endif
 	{longpathname, ENAMETOOLONG, NULL},
 	{TEST_ENOTDIR, ENOTDIR, NULL},
+	{elooppathname, ELOOP, NULL},
 };
 
 char *TCID = "lstat02";
 int TST_TOTAL = ARRAY_SIZE(test_cases);
-static int exp_enos[] = { EACCES, EFAULT, ENAMETOOLONG, ENOENT, ENOTDIR, 0 };
+static int exp_enos[] = { EACCES, EFAULT, ENAMETOOLONG, ENOENT,
+			  ENOTDIR, ELOOP, 0 };
 
 static void setup(void);
 static void lstat_verify(int);
@@ -110,6 +115,7 @@ int main(int ac, char **av)
 
 static void setup(void)
 {
+	int i;
 	struct passwd *ltpuser;
 
 	tst_require_root(NULL);
@@ -131,6 +137,11 @@ static void setup(void)
 	SAFE_TOUCH(cleanup, "test_file", MODE_RWX, NULL);
 
 	memset(longpathname, 'a', PATH_MAX+1);
+
+	SAFE_MKDIR(cleanup, "test_eloop", MODE_RWX);
+	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
+	for (i = 0; i < 43; i++)
+		strcat(elooppathname, "/test_eloop");
 }
 
 #if !defined(UCLINUX)
-- 
1.8.4.2




------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
