Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <root@localhost.localdomain>) id 1WLVRW-0004zE-Iy
	for ltp-list@lists.sourceforge.net; Thu, 06 Mar 2014 10:22:22 +0000
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WLVRU-0005go-Qe
	for ltp-list@lists.sourceforge.net; Thu, 06 Mar 2014 10:22:22 +0000
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by fgwmail7.fujitsu.co.jp (Postfix) with ESMTP id 9C8BD1793018
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Mar 2014 19:04:07 +0900 (JST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 94F2D3EE12D
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Mar 2014 19:04:00 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 86DCB45DD77
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Mar 2014 19:04:00 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.nic.fujitsu.com [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 709F045DD76
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Mar 2014 19:04:00 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 63C36E08004
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Mar 2014 19:04:00 +0900 (JST)
Received: from s01.gw.fujitsu.co.jp (s01.gw.nic.fujitsu.com [133.161.11.16])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 13EF91DB8038
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Mar 2014 19:04:00 +0900 (JST)
Received: from s01.gw.fujitsu.co.jp (yt-mxio2.gw.nic.fujitsu.com
	[10.134.25.142])
	by s01.gw.fujitsu.co.jp (Postfix) with ESMTP id DA7A63F0001
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Mar 2014 19:03:59 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.127])
	by s01.gw.fujitsu.co.jp (Postfix) with ESMTP id 818A9AC3C1
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Mar 2014 19:03:59 +0900 (JST)
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Thu,  6 Mar 2014 18:04:20 +0800
Message-Id: <1394100261-12596-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH v2 1/2] madvise/madvise02.c: cleanup
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

Move the test body from main() to (*testfunc[])().
Use some SAFE_* macros.
Some cleanup.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/madvise/madvise02.c | 288 ++++++++++++++------------
 1 file changed, 156 insertions(+), 132 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index e7f4656..f6d47f6 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -13,8 +13,8 @@
  *  GNU Library General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *  along with this program; if not, write to the Free Software Foundation,
+ *  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
 /*
@@ -50,176 +50,95 @@
 #include <unistd.h>
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
-#define MM_RLIMIT_RSS 5
-
-char *TCID = "madvise02";
-int TST_TOTAL = 7;
+#define TEST_FILE "testfile"
+#define STR "abcdefghijklmnopqrstuvwxyz12345\n"
 
 static void setup(void);
 static void cleanup(void);
 static void check_and_print(int expected_errno);
 
+static void test_addr_einval(void);
+static void test_advice_einval(void);
+#if !defined(UCLINUX)
+static void test_lock_einval(void);
+#endif /* if !defined(UCLINUX) */
+static void test_enomem(void);
+static void test_ebadf(void);
+
+static void (*test_func[])(void) = {
+	test_addr_einval,
+	test_advice_einval,
+#if !defined(UCLINUX)
+	test_lock_einval,
+#endif /* if !defined(UCLINUX) */
+	test_enomem,
+	test_ebadf,
+};
+
+char *TCID = "madvise02";
+int TST_TOTAL = ARRAY_SIZE(test_func);
+static int exp_enos[] = { EINVAL, ENOMEM, EBADF, 0 };
+
+static int fd;
+static struct stat st;
+static int pagesize;
+
 int main(int argc, char *argv[])
 {
-	int lc, fd, pagesize;
+	int lc;
 	int i;
-	unsigned long len;
-	char *file, *low, *high;
-	struct stat stat;
-	char *ptr_memory_allocated = NULL;
-	char *tmp_memory_allocated = NULL;
-
 	char *msg = NULL;
-	char filename[64];
-	char *progname = NULL;
-	char *str_for_file = "abcdefghijklmnopqrstuvwxyz12345\n";
 
 	msg = parse_opts(argc, argv, NULL, NULL);
-	if (msg)
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
 	setup();
 
-	progname = *argv;
-	sprintf(filename, "%s-out.%d", progname, getpid());
+	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		fd = open(filename, O_RDWR | O_CREAT, 0664);
-		if (fd < 0)
-			tst_brkm(TBROK, cleanup, "open failed");
-#ifdef DEBUG
-		tst_resm(TINFO, "filename = %s opened successfully", filename);
-#endif
-
-		pagesize = getpagesize();
-
-		/* Writing 16 pages of random data into this file */
-		for (i = 0; i < (pagesize / 2); i++)
-			if (write(fd, str_for_file, strlen(str_for_file)) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "write failed");
-
-		if (fstat(fd, &stat) == -1)
-			tst_brkm(TBROK, cleanup, "fstat failed");
-
-		file = mmap(NULL, stat.st_size, PROT_READ, MAP_SHARED, fd, 0);
-		if (file == MAP_FAILED)
-			tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
-#ifdef DEBUG
-		tst_resm(TINFO, "The Page size is %d", pagesize);
-#endif
-
-		/* Test Case 1 */
-		TEST(madvise(file + 100, stat.st_size, MADV_NORMAL));
-		check_and_print(EINVAL);
-
-		/* Test Case 2 */
-		TEST(madvise(file, stat.st_size, 1212));
-		check_and_print(EINVAL);
-
-#if !defined(UCLINUX)
-		/* Test Case 3 */
-		if (mlock((void *)file, stat.st_size) < 0)
-			tst_brkm(TBROK, cleanup, "mlock failed");
-
-		TEST(madvise(file, stat.st_size, MADV_DONTNEED));
-		check_and_print(EINVAL);
-
-		if (munmap(file, stat.st_size) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "munmap failed");
-#endif /* if !defined(UCLINUX) */
-
-		/* Test Case 4 */
-
-		/* We cannot be sure, which region is mapped, which is
-		 * not, at runtime.
-		 * So, we will create two maps(of the same file),
-		 * unmap the map at higher address.
-		 * Now issue an madvise() on a region covering the
-		 * region which we unmapped.
-		 */
-
-		low = mmap(NULL, stat.st_size / 2, PROT_READ, MAP_SHARED,
-			   fd, 0);
-		if (low == MAP_FAILED)
-			tst_brkm(TBROK, cleanup, "mmap [low] failed");
-
-		high = mmap(NULL, stat.st_size / 2, PROT_READ, MAP_SHARED,
-			    fd, stat.st_size / 2);
-		if (high == MAP_FAILED)
-			tst_brkm(TBROK, cleanup, "mmap [high] failed");
-
-		/* Swap if necessary to make low < high */
-		if (low > high) {
-			char *tmp;
-			tmp = high;
-			high = low;
-			low = tmp;
-		}
-
-		len = (high - low) + pagesize;
-
-		if (munmap(high, stat.st_size / 2) < 0)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "munmap [high] failed");
-
-		TEST(madvise(low, len, MADV_NORMAL));
-		check_and_print(ENOMEM);
-
-		/* Test Case 5 */
-		/* Unmap the file map from low */
-		if (munmap(low, stat.st_size / 2) < 0)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "munmap [low] failed");
-		/* Create one memory segment using malloc */
-		ptr_memory_allocated = (char *)malloc(5 * pagesize);
-		/*
-		 * Take temporary pointer for later use, freeing up the
-		 * original one.
-		 */
-		tmp_memory_allocated = ptr_memory_allocated;
-		tmp_memory_allocated =
-		    (char *)(((unsigned long)tmp_memory_allocated +
-			      pagesize - 1) & ~(pagesize - 1));
-
-		TEST(madvise
-		     (tmp_memory_allocated, 5 * pagesize, MADV_WILLNEED));
-		if (tst_kvercmp(3, 9, 0) < 0)
-			check_and_print(EBADF);
-		/* in kernel commit 1998cc0, madvise(MADV_WILLNEED) to anon
-		 * mem doesn't return -EBADF now, as now we support swap
-		 * prefretch.
-		 */
-		else
-			tst_resm(TPASS, "madvise succeeded as expected, see "
-					"kernel commit 1998cc0 for details.");
-		free((void *)ptr_memory_allocated);
-
-		close(fd);
+		for (i = 0; i < TST_TOTAL; i++)
+			(*test_func[i])();
 	}
+
 	cleanup();
 	tst_exit();
 }
 
 static void setup(void)
 {
+	int i;
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
 	tst_tmpdir();
+
+	fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0664);
+
+	pagesize = getpagesize();
+
+	/* Writing 16 pages of random data into this file */
+	for (i = 0; i < (pagesize / 2); i++)
+		SAFE_WRITE(cleanup, 1, fd, STR, sizeof(STR) - 1);
+
+	SAFE_FSTAT(cleanup, fd, &st);
 }
 
 static void cleanup(void)
 {
 	TEST_CLEANUP;
 
-	tst_rmdir();
+	if (fd && close(fd) < 0)
+		tst_resm(TWARN | TERRNO, "close failed");
 
+	tst_rmdir();
 }
 
 static void check_and_print(int expected_errno)
@@ -235,3 +154,108 @@ static void check_and_print(int expected_errno)
 		tst_resm(TFAIL, "madvise succeeded unexpectedly");
 	}
 }
+
+static void test_addr_einval(void)
+{
+	char *file;
+
+	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
+					 MAP_SHARED, fd, 0);
+
+	TEST(madvise(file + 100, st.st_size, MADV_NORMAL));
+	check_and_print(EINVAL);
+
+	SAFE_MUNMAP(cleanup, file, st.st_size);
+}
+
+static void test_advice_einval(void)
+{
+	char *file;
+
+	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
+					 MAP_SHARED, fd, 0);
+
+	TEST(madvise(file, st.st_size, 1212));
+	check_and_print(EINVAL);
+
+	SAFE_MUNMAP(cleanup, file, st.st_size);
+}
+
+#if !defined(UCLINUX)
+static void test_lock_einval(void)
+{
+	char *file;
+
+	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
+					 MAP_SHARED, fd, 0);
+
+	if (mlock((void *)file, st.st_size) < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "mlock failed");
+
+	TEST(madvise(file, st.st_size, MADV_DONTNEED));
+	check_and_print(EINVAL);
+
+	SAFE_MUNMAP(cleanup, file, st.st_size);
+}
+#endif /* if !defined(UCLINUX) */
+
+static void test_enomem(void)
+{
+	char *low;
+	char *high;
+	unsigned long len;
+
+	low = SAFE_MMAP(cleanup, 0, st.st_size / 2, PROT_READ,
+					MAP_SHARED, fd, 0);
+
+	high = SAFE_MMAP(cleanup, 0, st.st_size / 2, PROT_READ,
+					 MAP_SHARED, fd, st.st_size / 2);
+
+	/* Swap if necessary to make low < high */
+	if (low > high) {
+		char *tmp;
+		tmp = high;
+		high = low;
+		low = tmp;
+	}
+
+	len = (high - low) + pagesize;
+
+	SAFE_MUNMAP(cleanup, high, st.st_size / 2);
+
+	TEST(madvise(low, len, MADV_NORMAL));
+	check_and_print(ENOMEM);
+
+	SAFE_MUNMAP(cleanup, low, st.st_size / 2);
+}
+
+static void test_ebadf(void)
+{
+	char *ptr_memory_allocated = NULL;
+	char *tmp_memory_allocated = NULL;
+
+	/* Create one memory segment using malloc */
+	ptr_memory_allocated = (char *)malloc(5 * pagesize);
+	/*
+	 * Take temporary pointer for later use, freeing up the
+	 * original one.
+	 */
+	tmp_memory_allocated = ptr_memory_allocated;
+	tmp_memory_allocated =
+		(char *)(((unsigned long)tmp_memory_allocated +
+			pagesize - 1) & ~(pagesize - 1));
+
+	TEST(madvise(tmp_memory_allocated, 5 * pagesize, MADV_WILLNEED));
+	if (tst_kvercmp(3, 9, 0) < 0) {
+		check_and_print(EBADF);
+	/* in kernel commit 1998cc0, madvise(MADV_WILLNEED) to anon
+	 * mem doesn't return -EBADF now, as now we support swap
+	 * prefretch.
+	 */
+	} else {
+		tst_resm(TPASS, "madvise succeeded as expected, see "
+				"kernel commit 1998cc0 for details.");
+	}
+
+	free((void *)ptr_memory_allocated);
+}
-- 
1.8.3.1


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
