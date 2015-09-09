Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZZdir-0001o5-JS
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2015 11:39:29 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZZdiq-0005rn-0t
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2015 11:39:29 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 39405AB4
	for <ltp-list@lists.sourceforge.net>;
	Wed,  9 Sep 2015 11:39:22 +0000 (UTC)
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id t89BdLAH024491
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2015 07:39:21 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Wed,  9 Sep 2015 13:39:17 +0200
Message-Id: <dde73925917fe3524a598d859fdb66ca95711fc3.1441798744.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] mprotect04: fix powerpc crash when copying exec_func
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

Testcase tried to copy page size area starting at &exec_func.
This results in crash on powerpc, because &exec_func is too close
to end of page and subsequent page is not mapped:

 10000000-10010000 r-xp 00000000 fd:00 402855 mprotect04
 10010000-10020000 rw-p 00000000 fd:00 402855 mprotect04
 806a410000-806a440000 r-xp 00000000 fd:00 2097827 /lib64/ld-2.12.so
where &exec_func == 0x100199c0, and page_size == 65536.

It's also worth noting, that function ptr does not reside in .text,
but in .opd section. That shouldn't matter for this testcase as long
as it doesn't try to copy non-existent pages.

This patch is changing copy function to try copy 2 whole aligned pages.
Both pages are checked to be present in memory before memcpy is
attempted. First is the page which contains &exec_func, and 2nd is the
subsequent page - for the case &exec_func is too close to page boundary.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/mprotect/mprotect04.c | 61 +++++++++++++++++++++----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c b/testcases/kernel/syscalls/mprotect/mprotect04.c
index 8a4a72ad69f2..23aecbd856f4 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect04.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
@@ -54,6 +54,7 @@ int TST_TOTAL = ARRAY_SIZE(testfunc);
 
 static volatile int sig_caught;
 static sigjmp_buf env;
+static int copy_sz;
 
 int main(int ac, char **av)
 {
@@ -83,7 +84,9 @@ static void sighandler(int sig)
 
 static void setup(void)
 {
+	tst_tmpdir();
 	tst_sig(NOFORK, sighandler, cleanup);
+	copy_sz = getpagesize() * 2;
 
 	TEST_PAUSE;
 }
@@ -158,32 +161,71 @@ static void exec_func(void)
 	return;
 }
 
-static void *get_func(void *mem)
+static int page_present(void *p)
 {
-	memcpy(mem, exec_func, getpagesize());
+	int fd;
+
+	fd = SAFE_OPEN(cleanup, "page_present", O_WRONLY|O_CREAT, 0644);
+	TEST(write(fd, p, 1));
+	SAFE_CLOSE(cleanup, fd);
+
+	if (TEST_RETURN >= 0)
+		return 1;
+
+	if (TEST_ERRNO != EFAULT)
+		tst_brkm(TBROK | TTERRNO, cleanup, "page_present write");
 
-	return mem;
+	return 0;
+}
+
+/*
+ * Copy page where &exec_func resides. Also try to copy subsequent page
+ * in case exec_func is close to page boundary.
+ */
+static void *get_func(void *mem)
+{
+	uintptr_t page_sz = getpagesize();
+	uintptr_t page_mask = ~(page_sz - 1);
+	uintptr_t func_page_offset = (uintptr_t)&exec_func & (page_sz - 1);
+	void *func_copy_start = mem + func_page_offset;
+	void *page_to_copy = (void *)((uintptr_t)&exec_func & page_mask);
+
+	/* copy 1st page, if it's not present something is wrong */
+	if (!page_present(page_to_copy)) {
+		tst_resm(TINFO, "exec_func: %p, page_to_copy: %p\n",
+			&exec_func, page_to_copy);
+		tst_brkm(TBROK, cleanup, "page_to_copy not present\n");
+	}
+	memcpy(mem, page_to_copy, page_sz);
+
+	/* copy 2nd page if possible */
+	mem += page_sz;
+	page_to_copy += page_sz;
+	if (page_present(page_to_copy))
+		memcpy(mem, page_to_copy, page_sz);
+	else
+		memset(mem, 0, page_sz);
+
+	/* return pointer to area where copy of exec_func resides */
+	return func_copy_start;
 }
 
 #endif
 
 static void testfunc_protexec(void)
 {
-	int page_sz;
 	void (*func)(void);
 	void *p;
 
 	sig_caught = 0;
 
-	page_sz = getpagesize();
-
-	p = SAFE_MMAP(cleanup, 0, page_sz, PROT_READ | PROT_WRITE,
+	p = SAFE_MMAP(cleanup, 0, copy_sz, PROT_READ | PROT_WRITE,
 		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
 	func = get_func(p);
 
 	/* Change the protection to PROT_EXEC. */
-	TEST(mprotect(p, page_sz, PROT_EXEC));
+	TEST(mprotect(p, copy_sz, PROT_EXEC));
 
 	if (TEST_RETURN == -1) {
 		tst_resm(TFAIL | TTERRNO, "mprotect failed");
@@ -205,9 +247,10 @@ static void testfunc_protexec(void)
 		}
 	}
 
-	SAFE_MUNMAP(cleanup, p, page_sz);
+	SAFE_MUNMAP(cleanup, p, copy_sz);
 }
 
 static void cleanup(void)
 {
+	tst_rmdir();
 }
-- 
1.8.3.1


------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
