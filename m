From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 11 Feb 2019 16:03:59 +0100
Subject: [LTP] [PATCH] syscalls/mprotect04: align exec_func to 64 bytes
Message-ID: <42aa7fc222cbfbf10136b2a9ae6f74b3b9a2235a.1549897252.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

exec_func() is dummy/empty function. If we make sure it's aligned,
we can be pretty confident that it will located in single page and
can drop code that deals with 2nd page.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/mprotect/Makefile     |  2 ++
 testcases/kernel/syscalls/mprotect/mprotect04.c | 12 ++----------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/mprotect/Makefile b/testcases/kernel/syscalls/mprotect/Makefile
index bd617d806675..bc5c8bc10395 100644
--- a/testcases/kernel/syscalls/mprotect/Makefile
+++ b/testcases/kernel/syscalls/mprotect/Makefile
@@ -20,4 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+mprotect04: CFLAGS += -falign-functions=64
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c b/testcases/kernel/syscalls/mprotect/mprotect04.c
index 60941a4220d5..3125f344795d 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect04.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
@@ -88,7 +88,7 @@ static void setup(void)
 {
 	tst_tmpdir();
 	tst_sig(NOFORK, sighandler, cleanup);
-	copy_sz = getpagesize() * 2;
+	copy_sz = getpagesize();
 
 	TEST_PAUSE;
 }
@@ -133,7 +133,7 @@ static void testfunc_protnone(void)
 
 #ifdef __ia64__
 
-static char exec_func[] = {
+static char exec_func[] __attribute__ ((aligned (64))) = {
 	0x11, 0x00, 0x00, 0x00, 0x01, 0x00, /* nop.m 0x0             */
 	0x00, 0x00, 0x00, 0x02, 0x00, 0x80, /* nop.i 0x0             */
 	0x08, 0x00, 0x84, 0x00,             /* br.ret.sptk.many b0;; */
@@ -237,14 +237,6 @@ static void *get_func(void *mem)
 	}
 	memcpy(mem, page_to_copy, page_sz);
 
-	/* copy 2nd page if possible */
-	mem += page_sz;
-	page_to_copy += page_sz;
-	if (page_present(page_to_copy))
-		memcpy(mem, page_to_copy, page_sz);
-	else
-		memset(mem, 0, page_sz);
-
 	clear_cache(mem_start, copy_sz);
 
 	/* return pointer to area where copy of exec_func resides */
-- 
1.8.3.1

