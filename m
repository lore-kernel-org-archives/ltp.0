From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Nov 2020 13:09:23 +0100
Subject: [LTP] [PATCH 1/1] m4: Remove workaround for old pkg-config
Message-ID: <20201110120923.21759-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

fix was for 0.24 which is probably old enough (released in 2010;
problematic 0.23 was released 2008).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Travis CI:
https://travis-ci.org/github/pevik/ltp/builds/742685737

 m4/ltp-tirpc.m4 | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/m4/ltp-tirpc.m4 b/m4/ltp-tirpc.m4
index 4d9701469..f06fed3d9 100644
--- a/m4/ltp-tirpc.m4
+++ b/m4/ltp-tirpc.m4
@@ -22,9 +22,4 @@ AC_DEFUN([LTP_CHECK_TIRPC], [
 	if test "x$have_libtirpc" = "xyes" -o "x$have_rpc_glibc" = "xyes"; then
 		AC_SUBST(HAVE_RPC, 1)
 	fi
-
-	dnl fix for old pkg-config (< 0.24)
-	dnl https://autotools.io/pkgconfig/pkg_check_modules.html
-	AC_SUBST(TIRPC_CFLAGS)
-	AC_SUBST(TIRPC_LIBS)
 ])
-- 
2.29.2

