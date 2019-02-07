From: Daniel Mentz <danielmentz@google.com>
Date: Wed,  6 Feb 2019 17:40:55 -0800
Subject: [LTP] [PATCH] mprotect04: Support execute-only page access
	permissions
Message-ID: <20190207014055.166152-1-danielmentz@google.com>
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
 .../kernel/syscalls/mprotect/mprotect04.c     | 31 ++++++++++++++++---
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c b/testcases/kernel/syscalls/mprotect/mprotect04.c
index 60941a422..811449f6a 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect04.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
@@ -217,6 +217,7 @@ static void *get_func(void *mem)
 	uintptr_t func_page_offset;
 	void *func_copy_start, *page_to_copy;
 	void *mem_start = mem;
+	int exec_only_platform = 0;
 
 #ifdef USE_FUNCTION_DESCRIPTORS
 	func_descr_t *opd =  (func_descr_t *)&exec_func;
@@ -229,17 +230,35 @@ static void *get_func(void *mem)
 	page_to_copy = (void *)((uintptr_t)&exec_func & page_mask);
 #endif
 
-	/* copy 1st page, if it's not present something is wrong */
+	/* Copy 1st page. If it's not accessible, we might be running on a
+	 * platform that supports execute-only page access permissions, in which
+	 * case we have to explicitly change access protections to allow the
+	 * memory to be read. */
 	if (!page_present(page_to_copy)) {
-		tst_resm(TINFO, "exec_func: %p, page_to_copy: %p\n",
-			&exec_func, page_to_copy);
-		tst_brkm(TBROK, cleanup, "page_to_copy not present\n");
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
+		exec_only_platform = 1;
 	}
 	memcpy(mem, page_to_copy, page_sz);
 
 	/* copy 2nd page if possible */
 	mem += page_sz;
 	page_to_copy += page_sz;
+	/* Mark page readable on platforms that support execute-only page access
+	 * permissions. */
+	if (exec_only_platform)
+		mprotect(page_to_copy, page_sz, PROT_READ | PROT_EXEC);
 	if (page_present(page_to_copy))
 		memcpy(mem, page_to_copy, page_sz);
 	else
@@ -271,6 +290,9 @@ static void testfunc_protexec(void)
 	func = get_func(p);
 #endif
 
+	if (!func)
+		goto out;
+
 	/* Change the protection to PROT_EXEC. */
 	TEST(mprotect(p, copy_sz, PROT_EXEC));
 
@@ -294,6 +316,7 @@ static void testfunc_protexec(void)
 		}
 	}
 
+out:
 	SAFE_MUNMAP(cleanup, p, copy_sz);
 }
 
-- 
2.20.1.611.gfbb209baf1-goog

