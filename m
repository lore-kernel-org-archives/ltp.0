From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 18 Mar 2016 09:36:30 +0100
Subject: [LTP] [PATCH] mprotect04: invalidate icache on powerpc
Message-ID: <2ee2ff0eb9e3c133005f9e938a2c7d4c5bde26d0.1458290113.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Kshitij Malik reported that this testcase is crashing on his
PowerPc based board MPC8360 with SIGILL on PROT_EXEC test
when it tried to execute copy of exec_func.

Coherency and Synchronization Requirements for PowerQUICC III, 2.2 says:
"Instruction cache coherency must be handled separately from data cache
coherency. Whereas there is hardware support for data cache coherency,
instruction cache coherency must be maintained in software. Even if
stores are performed to pages marked as coherence required, icbi
instructions are required to ensure the instruction cache is coherent."

And indeed, we were able to confirm, that invalidating icache resolved
the problem. Without patch, it was highly reproducible, with patch it
ran fine for minutes in a loop. Presumably mmap() mapped an area that
was previously a code, that was still in icache.

The patch is a powerpc assembly, but it should be safe, because we
already do this in different testcase since:
commit 038e4bc450d1 ("POWER5 has coherent icache, but POWER4,
PPC970 and some other processors lack it.")

This patch has some extra syncs, I updated it according to current
kernel version from:
  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/lib/code-patching.c#n19

Reported-and-tested-by: Kshitij.Malik@mitel.com
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/mprotect/mprotect04.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c b/testcases/kernel/syscalls/mprotect/mprotect04.c
index 23aecbd856f4..c94e25c59e06 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect04.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
@@ -54,7 +54,7 @@ int TST_TOTAL = ARRAY_SIZE(testfunc);
 
 static volatile int sig_caught;
 static sigjmp_buf env;
-static int copy_sz;
+static unsigned int copy_sz;
 
 int main(int ac, char **av)
 {
@@ -189,6 +189,10 @@ static void *get_func(void *mem)
 	uintptr_t func_page_offset = (uintptr_t)&exec_func & (page_sz - 1);
 	void *func_copy_start = mem + func_page_offset;
 	void *page_to_copy = (void *)((uintptr_t)&exec_func & page_mask);
+#ifdef __powerpc__
+	void *mem_start = mem;
+	uintptr_t i;
+#endif
 
 	/* copy 1st page, if it's not present something is wrong */
 	if (!page_present(page_to_copy)) {
@@ -206,6 +210,12 @@ static void *get_func(void *mem)
 	else
 		memset(mem, 0, page_sz);
 
+#ifdef __powerpc__
+	for (i = 0; i < copy_sz; i += 4)
+		__asm__ __volatile__("dcbst 0,%0; sync; icbi 0,%0; sync; isync"
+			:: "r"(mem_start + i));
+#endif
+
 	/* return pointer to area where copy of exec_func resides */
 	return func_copy_start;
 }
-- 
1.8.3.1

