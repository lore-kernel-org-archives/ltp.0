From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Jan 2018 11:09:28 +0100
Subject: [LTP] [COMMITTED 1/1] numa: Fix numa v2 detection for cross
	compilation
Message-ID: <20180129100928.12980-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Changed to AC_COMPILE_IFELSE as AC_RUN_IFELSE cannot be run while
cross compiling.

AC_RUN_IFELSE was run only if numa headers are installed, that's why our
travis build tests didn't find that.

Bug found by Buildroot project:
http://autobuild.buildroot.net/results/21a/21a6eeddbf5ccffc34c38527d0807305a5eb3917/

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Reported-by: Baruch Siach <baruch@tkos.co.il>
---
I'll also detect this in travis.
Petr
---
 m4/ltp-numa.m4 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/m4/ltp-numa.m4 b/m4/ltp-numa.m4
index fc3383e97..633f54c18 100644
--- a/m4/ltp-numa.m4
+++ b/m4/ltp-numa.m4
@@ -28,11 +28,11 @@ AC_DEFUN([LTP_CHECK_SYSCALL_NUMA], [
 	AC_CHECK_HEADERS([numa.h numaif.h], [], [have_numa_headers=no])
 
 	if test "x$have_numa_headers" != "xno"; then
-		AC_RUN_IFELSE([AC_LANG_PROGRAM([
+		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([
 #include <numa.h>
 		], [
 #if LIBNUMA_API_VERSION < 2
-exit(1);
+# error Required numa headers >= 2
 #endif
 		])], [have_numa_headers_v2=yes])
 	fi
-- 
2.16.0

