Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WLpa4-0005qX-DU
	for ltp-list@lists.sourceforge.net; Fri, 07 Mar 2014 07:52:32 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WLpa2-000068-Ez
	for ltp-list@lists.sourceforge.net; Fri, 07 Mar 2014 07:52:32 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s277q1qW013269
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Mar 2014 15:52:10 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Fri, 7 Mar 2014 15:50:32 +0800
Message-Id: <1394178632-14462-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1394178632-14462-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1394178632-14462-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH 2/2] munmap/munmap03.c: make EINVAL error value tests
	sufficient
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

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/munmap/munmap03.c | 45 ++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/munmap/munmap03.c b/testcases/kernel/syscalls/munmap/munmap03.c
index f906e4d..8d3e49a 100644
--- a/testcases/kernel/syscalls/munmap/munmap03.c
+++ b/testcases/kernel/syscalls/munmap/munmap03.c
@@ -23,6 +23,11 @@
  *   1. munmap() fails with -1 return value and sets errno to EINVAL
  *      if addresses in the range [addr,addr+len) are outside the valid
  *	range for the address space of a process.
+ *   2. munmap() fails with -1 return value and sets errno to EINVAL
+ *      if the len argument is 0.
+ *   3. munmap() fails with -1 return value and sets errno to EINVAL
+ *      if the addr argument is not a multiple of the page size as
+ *      returned by sysconf().
  *
  * HISTORY
  *	07/2001 Ported by Wayne Boyer
@@ -42,13 +47,17 @@
 char *TCID = "munmap03";
 
 static size_t page_sz;
+static char *global_addr;
+static size_t global_maplen;
 static int exp_enos[] = { EINVAL, 0 };
 
 static void setup(void);
 static void cleanup(void);
 
 static void test_einval1(void);
-static void (*testfunc[])(void) = { test_einval1 };
+static void test_einval2(void);
+static void test_einval3(void);
+static void (*testfunc[])(void) = { test_einval1, test_einval2, test_einval3 };
 int TST_TOTAL = ARRAY_SIZE(testfunc);
 
 int main(int ac, char **av)
@@ -81,6 +90,11 @@ static void setup(void)
 	TEST_PAUSE;
 
 	page_sz = (size_t)sysconf(_SC_PAGESIZE);
+
+	global_maplen = page_sz * 2;
+	global_addr = SAFE_MMAP(cleanup, NULL, global_maplen, PROT_READ |
+				PROT_WRITE, MAP_PRIVATE_EXCEPT_UCLINUX |
+				MAP_ANONYMOUS, -1, 0);
 }
 
 static void check_and_print(int expected_errno)
@@ -114,8 +128,37 @@ static void test_einval1(void)
 	check_and_print(EINVAL);
 }
 
+static void test_einval2(void)
+{
+	char *addr = global_addr;
+	size_t map_len = 0;
+
+	if (tst_kvercmp(2, 6, 12) < 0) {
+		tst_resm(TCONF,
+			 "EINVAL error value test for this condition needs "
+			 "kernel 2.6.12 or higher");
+		return;
+	}
+
+	TEST(munmap(addr, map_len));
+
+	check_and_print(EINVAL);
+}
+
+static void test_einval3(void)
+{
+	char *addr = (char *)(global_addr + 1);
+	size_t map_len = page_sz;
+
+	TEST(munmap(addr, map_len));
+
+	check_and_print(EINVAL);
+}
+
 static void cleanup(void)
 {
 	TEST_CLEANUP;
 
+	if (munmap(global_addr, global_maplen) == -1)
+		tst_resm(TWARN | TERRNO, "munmap failed");
 }
-- 
1.8.2.1


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
