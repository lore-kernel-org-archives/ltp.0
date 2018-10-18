From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Oct 2018 11:14:39 +0200
Subject: [LTP] [COMMITTED][PATCH 1/1] m4: Remove include from AC_CHECK_FUNCS
Message-ID: <20181018091439.20354-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

As AC_CHECK_FUNCS doesn't use it (unlike AC_CHECK_TYPES). The purpose
of AC_CHECK_FUNCS is to check whether the linker can find a function
by that name, independently of system headers, so there is no reason
to include any system headers.

Fixes: 0d28feaac ("syscalls: Prepare for testing statx syscall")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 m4/ltp-statx.m4 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/m4/ltp-statx.m4 b/m4/ltp-statx.m4
index 5f79a94cd..7629f51c2 100644
--- a/m4/ltp-statx.m4
+++ b/m4/ltp-statx.m4
@@ -21,7 +21,7 @@ dnl LTP_CHECK_STATX
 dnl ----------------------------
 dnl
 AC_DEFUN([LTP_CHECK_STATX],[
-AC_CHECK_FUNCS(statx,,,[[#include <sys/stat.h>]])
+AC_CHECK_FUNCS(statx,,)
 AC_CHECK_HEADER(linux/fs.h,,,)
 AC_CHECK_TYPES([struct statx],,,[[
 	#define _GNU_SOURCE
-- 
2.19.0

