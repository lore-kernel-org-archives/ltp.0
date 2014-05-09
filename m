Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WijTf-0001GM-UA
	for ltp-list@lists.sourceforge.net; Fri, 09 May 2014 12:00:35 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WijTe-000610-35
	for ltp-list@lists.sourceforge.net; Fri, 09 May 2014 12:00:35 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s49Bf7Hp026516
	for <ltp-list@lists.sourceforge.net>; Fri, 9 May 2014 19:41:27 +0800
Message-ID: <1399635588.2217.0.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 9 May 2014 19:39:48 +0800
In-Reply-To: <1399634696.3515.0.camel@G08JYZSD130126>
References: <1399634696.3515.0.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] statfs/statfs02.c: Add ELOOP errno test
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

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/statfs/statfs02.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/statfs/statfs02.c b/testcases/kernel/syscalls/statfs/statfs02.c
index 98d9111..6208ec7 100644
--- a/testcases/kernel/syscalls/statfs/statfs02.c
+++ b/testcases/kernel/syscalls/statfs/statfs02.c
@@ -28,6 +28,8 @@
  *		the process, and expect EFAULT.
  *	5.	Pass a pointer to the buf paramter outside the address space
  *		of the process, and expect EFAULT.
+ *	6.	Pass a filename which has too many symbolic links, and expect
+ *		ELOOP.
  */
 
 #include <sys/types.h>
@@ -48,6 +50,7 @@ static int exp_enos[] = {
 #if !defined(UCLINUX)
 	EFAULT,
 #endif
+	ELOOP,
 	0
 };
 
@@ -56,6 +59,7 @@ static int fd;
 #define TEST_FILE		"statfs_file"
 #define TEST_FILE1		TEST_FILE"/statfs_file1"
 #define TEST_NOEXIST		"statfs_noexist"
+#define TEST_SYMLINK		"statfs_symlink"
 
 static char test_toolong[PATH_MAX+2];
 static struct statfs buf;
@@ -72,6 +76,7 @@ static struct test_case_t {
 	{(char *)-1, &buf, EFAULT},
 	{TEST_FILE, (struct statfs *)-1, EFAULT},
 #endif
+	{TEST_SYMLINK, &buf, ELOOP},
 };
 
 int TST_TOTAL = ARRAY_SIZE(TC);
@@ -119,6 +124,9 @@ static void setup(void)
 	TC[3].path = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
 			       MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 #endif
+
+	SAFE_SYMLINK(cleanup, TEST_SYMLINK, "statfs_symlink_2");
+	SAFE_SYMLINK(cleanup, "statfs_symlink_2", TEST_SYMLINK);
 }
 
 static void statfs_verify(const struct test_case_t *test)
-- 
1.8.4.2




------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
