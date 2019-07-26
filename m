From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 26 Jul 2019 11:21:10 +0200
Subject: [LTP] [PATCH] syscalls/mprotect04: Fix compilation error for ia64
Message-ID: <20190726092110.13116-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes: 94f5be719 ("syscalls/mprotect04: align exec_func to 64 bytes")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

or should we drop ia64 support as the architecture is obsolete?
Since we don't test this arch, there are some other build failures
(at least on old SLES I tested the patch).

Kind regards,
Petr

 testcases/kernel/syscalls/mprotect/mprotect04.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c b/testcases/kernel/syscalls/mprotect/mprotect04.c
index a014ab6b4..d1991a2db 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect04.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
@@ -141,7 +141,7 @@ struct func_desc {
 	uint64_t glob_pointer;
 };
 
-static __attribute__((noinline)) void *get_func(void *mem)
+static __attribute__((noinline)) void *get_func(void *mem, uintptr_t *func_page_offset LTP_ATTRIBUTE_UNUSED)
 {
 	static struct func_desc fdesc;
 
@@ -275,11 +275,13 @@ static void testfunc_protexec(void)
 	if (!func)
 		goto out;
 
+#ifndef __ia64__
 	if (func_page_offset + 64 > page_sz) {
 		SAFE_MUNMAP(cleanup, p, page_sz);
 		tst_brkm(TCONF, cleanup, "func too close to page boundary, "
 			"maybe your compiler ignores -falign-functions?");
 	}
+#endif
 
 	/* Change the protection to PROT_EXEC. */
 	TEST(mprotect(p, page_sz, PROT_EXEC));
-- 
2.22.0

