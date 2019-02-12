From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 11 Feb 2019 16:00:08 -0800
Subject: [LTP] [PATCH v2] mprotect04: Support execute-only page access
	permissions
Message-ID: <20190212000008.57085-1-danielmentz@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Linux version 4.9 introduced support for execute-only page access permissions on
arm64. As a result, user space processes, by default, cannot read from
their own .text sections. This change adds an extra call to mprotect()
to explicitly change access protections to allow relevant parts of the
.text section to be read.

Without this change, mprotect04 generates false TBROK results. We
previously saw this test output:

mprotect04    1  TPASS  :  test PROT_NONE for mprotect success
mprotect04    0  TINFO  :  exec_func: 0x5ac82d3588, page_to_copy: 0x5ac82d3000
mprotect04    2  TBROK  :  ltp/testcases/kernel/syscalls/mprotect/mprotect04.c:236: page_to_copy not present
mprotect04    3  TBROK  :  ltp/testcases/kernel/syscalls/mprotect/mprotect04.c:236: Remaining cases broken

Signed-off-by: Daniel Mentz <danielmentz@google.com>
---

v2: Re-based on Jan's commit ("syscalls/mprotect: align exec_func to 64
bytes")

 .../kernel/syscalls/mprotect/mprotect04.c     | 27 ++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c b/testcases/kernel/syscalls/mprotect/mprotect04.c
index 0f7890dca..192a0184d 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect04.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
@@ -227,10 +227,25 @@ static void *get_func(void *mem, uintptr_t *func_page_offset)
 	tst_resm(TINFO, "exec_func: %p, page_to_copy: %p",
 		&exec_func, page_to_copy);
 
-	/* copy 1st page, if it's not present something is wrong */
-	if (!page_present(page_to_copy))
-		tst_brkm(TBROK, cleanup, "page_to_copy not present\n");
-
+	/* Copy 1st page. If it's not accessible, we might be running on a
+	 * platform that supports execute-only page access permissions, in which
+	 * case we have to explicitly change access protections to allow the
+	 * memory to be read. */
+	if (!page_present(page_to_copy)) {
+		TEST(mprotect(page_to_copy, page_sz, PROT_READ | PROT_EXEC));
+		if (TEST_RETURN == -1) {
+			tst_resm(TFAIL | TTERRNO,
+				 "mprotect(PROT_READ|PROT_EXEC) failed");
+			return NULL;
+		}
+		/* If the memory is still not accessible, then something must be
+		 * wrong. */
+		if (!page_present(page_to_copy)) {
+			tst_resm(TINFO, "exec_func: %p, page_to_copy: %p\n",
+				&exec_func, page_to_copy);
+			tst_brkm(TBROK, cleanup, "page_to_copy not present\n");
+		}
+	}
 	memcpy(mem, page_to_copy, page_sz);
 
 	clear_cache(mem_start, page_sz);
@@ -260,6 +275,9 @@ static void testfunc_protexec(void)
 	func = get_func(p, &func_page_offset);
 #endif
 
+	if (!func)
+		goto out;
+
 	if (func_page_offset + 64 >= page_sz) {
 		SAFE_MUNMAP(cleanup, p, page_sz);
 		tst_brkm(TCONF, cleanup, "func too close to page boundary, "
@@ -289,6 +307,7 @@ static void testfunc_protexec(void)
 		}
 	}
 
+out:
 	SAFE_MUNMAP(cleanup, p, page_sz);
 }
 
-- 
2.20.1.791.gb4d0f1c61a-goog

