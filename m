From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  8 Jan 2020 11:34:11 +0100
Subject: [LTP] [PATCH 2/4] rpc-tirpc: Add libntirpc support
In-Reply-To: <20200108103413.29096-1-pvorel@suse.cz>
References: <20200108103413.29096-1-pvorel@suse.cz>
Message-ID: <20200108103413.29096-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 m4/ltp-tirpc.m4 | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/m4/ltp-tirpc.m4 b/m4/ltp-tirpc.m4
index 3f23b1a17..dd563e650 100644
--- a/m4/ltp-tirpc.m4
+++ b/m4/ltp-tirpc.m4
@@ -6,10 +6,13 @@ AC_DEFUN([LTP_CHECK_TIRPC], [
 	dnl libtirpc library and headers
 	PKG_CHECK_MODULES([LIBTIRPC], [libtirpc], [have_libtirpc=yes], [have_libtirpc=no])
 
+	dnl libntirpc library and headers
+	PKG_CHECK_MODULES([LIBNTIRPC], [libntirpc], [have_libntirpc=yes], [have_libntirpc=no])
+
 	dnl TI-RPC headers (in glibc, since 2.26 installed only when configured with --enable-obsolete-rpc)
 	AC_CHECK_HEADERS([rpc/rpc.h], [have_rpc_headers=yes])
 
-	if test "x$have_libtirpc" = "xyes" -o "x$have_rpc_headers" = "xyes"; then
-		AC_DEFINE([HAVE_TIRPC], [1], [Define to 1 if you have libtirpc library and headers or glibc with TI-RPC support])
+	if test "x$have_libtirpc" = "xyes" -o "x$have_libntirpc" = "xyes" -o "x$have_rpc_headers" = "xyes"; then
+		AC_DEFINE([HAVE_TIRPC], [1], [Define to 1 if you have libtirpc or libntirpc library and headers or glibc with TI-RPC support])
 	fi
 ])
-- 
2.24.1

