From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jul 2016 17:31:05 +0100
Subject: [LTP] [PATCH] syscalls/mprotect04: Use __builtin___clear_cache() to
	sync caches
Message-ID: <1469550665-12918-1-git-send-email-peter.maydell@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In commit cf9a0800cd0 code was added to mprotect04 to synchronize
the instruction and data caches on PowerPC before executing
the copied code. This is also necessary on other architectures
which have split instruction and data caches and need explicit
cache maintenance operations, like ARM.

The GCC builtin __builtin___clear_cache() will correctly handle
this for all architectures, so switch to using it. The builtin
was only implemented at around GCC 4.1, so use a configure
check so that we will skip the test with TCONF if the compiler
doesn't support the builtin.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Disclaimer: untested on PPC.

 configure.ac                                    |  1 +
 m4/ltp-builtin_clear_cache.m4                   | 30 +++++++++++++++++++++++++
 testcases/kernel/syscalls/mprotect/mprotect04.c | 20 ++++++++++-------
 3 files changed, 43 insertions(+), 8 deletions(-)
 create mode 100644 m4/ltp-builtin_clear_cache.m4

diff --git a/configure.ac b/configure.ac
index e0e9c1b..9901612 100644
--- a/configure.ac
+++ b/configure.ac
@@ -188,5 +188,6 @@ LTP_CHECK_PWRITEV
 LTP_CHECK_EPOLL_PWAIT
 LTP_CHECK_KEYUTILS_SUPPORT
 LTP_CHECK_SYNC_ADD_AND_FETCH
+LTP_CHECK_BUILTIN_CLEAR_CACHE
 
 AC_OUTPUT
diff --git a/m4/ltp-builtin_clear_cache.m4 b/m4/ltp-builtin_clear_cache.m4
new file mode 100644
index 0000000..74e4ccd
--- /dev/null
+++ b/m4/ltp-builtin_clear_cache.m4
@@ -0,0 +1,30 @@
+dnl
+dnl Copyright (c) Linux Test Project, 2016
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+
+AC_DEFUN([LTP_CHECK_BUILTIN_CLEAR_CACHE],[dnl
+	AC_MSG_CHECKING([for __builtin___clear_cache])
+	AC_LINK_IFELSE([AC_LANG_SOURCE([[
+int main(void) {
+	char arr[16];
+	__builtin___clear_cache(arr, arr + sizeof(arr));
+        return 0;
+}]])],[has_bcc="yes"])
+
+if test "x$has_bcc" = xyes; then
+	AC_DEFINE(HAVE_BUILTIN_CLEAR_CACHE,1,[Define to 1 if you have __builtin___clear_cache])
+	AC_MSG_RESULT(yes)
+else
+	AC_MSG_RESULT(no)
+fi
+])
diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c b/testcases/kernel/syscalls/mprotect/mprotect04.c
index c94e25c..1173afd 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect04.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
@@ -24,6 +24,7 @@
  *      'prot' is set to PROT_EXEC.
  */
 
+#include "config.h"
 #include <signal.h>
 #include <setjmp.h>
 #include <sys/types.h>
@@ -178,6 +179,16 @@ static int page_present(void *p)
 	return 0;
 }
 
+static void clear_cache(void *start, int len)
+{
+#if HAVE_BUILTIN_CLEAR_CACHE == 1
+	__builtin___clear_cache(start, start + len);
+#else
+	tst_brkm(TCONF, cleanup,
+		"compiler doesn't have __builtin___clear_cache()");
+#endif
+}
+
 /*
  * Copy page where &exec_func resides. Also try to copy subsequent page
  * in case exec_func is close to page boundary.
@@ -189,10 +200,7 @@ static void *get_func(void *mem)
 	uintptr_t func_page_offset = (uintptr_t)&exec_func & (page_sz - 1);
 	void *func_copy_start = mem + func_page_offset;
 	void *page_to_copy = (void *)((uintptr_t)&exec_func & page_mask);
-#ifdef __powerpc__
 	void *mem_start = mem;
-	uintptr_t i;
-#endif
 
 	/* copy 1st page, if it's not present something is wrong */
 	if (!page_present(page_to_copy)) {
@@ -210,11 +218,7 @@ static void *get_func(void *mem)
 	else
 		memset(mem, 0, page_sz);
 
-#ifdef __powerpc__
-	for (i = 0; i < copy_sz; i += 4)
-		__asm__ __volatile__("dcbst 0,%0; sync; icbi 0,%0; sync; isync"
-			:: "r"(mem_start + i));
-#endif
+	clear_cache(mem_start, copy_sz);
 
 	/* return pointer to area where copy of exec_func resides */
 	return func_copy_start;
-- 
1.9.1

