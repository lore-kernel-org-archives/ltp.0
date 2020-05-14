From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 May 2020 21:30:11 +0200
Subject: [LTP] [PATCH 1/1] rpc-tirpc: Fix deprecated glibc detection
Message-ID: <20200514193011.11386-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It's not enough to check for RPC headers. These can belong to libtirpc 64bit, which
is not enough when compiling 32bit LTP without 32bit libtirpc.

Fixes: 60b20c428 ("rpc: Enable and fix build basic RPC tests with glibc SunRPC")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 m4/ltp-tirpc.m4 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/m4/ltp-tirpc.m4 b/m4/ltp-tirpc.m4
index 639e1e886..4d9701469 100644
--- a/m4/ltp-tirpc.m4
+++ b/m4/ltp-tirpc.m4
@@ -17,9 +17,9 @@ AC_DEFUN([LTP_CHECK_TIRPC], [
 	dnl rpc_broadcast() instead of clnt_broadcast()), but glibc implementation
 	dnl does not have the new ones. We could either provide the deprecated
 	dnl functions (copy from libtirpc src/rpc_soc.c) or drop glibc tests.
-	AC_CHECK_HEADERS([rpc/rpc.h], [have_rpc_headers=yes])
+	AC_CHECK_FUNCS([xdr_char clnttcp_create], [have_rpc_glibc=yes])
 
-	if test "x$have_libtirpc" = "xyes" -o "x$have_rpc_headers" = "xyes"; then
+	if test "x$have_libtirpc" = "xyes" -o "x$have_rpc_glibc" = "xyes"; then
 		AC_SUBST(HAVE_RPC, 1)
 	fi
 
-- 
2.26.2

