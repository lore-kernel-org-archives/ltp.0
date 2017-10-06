From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  6 Oct 2017 03:53:31 +0200
Subject: [LTP] [RFC PATCH 1/6] m4: Fix libkeyutils detection on 32-bit cross
	build
In-Reply-To: <20171006015336.29972-1-pvorel@suse.cz>
References: <20171006015336.29972-1-pvorel@suse.cz>
Message-ID: <20171006015336.29972-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 m4/ltp-keyutils.m4 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/m4/ltp-keyutils.m4 b/m4/ltp-keyutils.m4
index 74b7d3249..1434ca823 100644
--- a/m4/ltp-keyutils.m4
+++ b/m4/ltp-keyutils.m4
@@ -18,7 +18,7 @@ dnl
 dnl LTP_CHECK_KEYUTILS_SUPPORT
 dnl ----------------------------
 dnl
-AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT],[
-AC_CHECK_HEADERS([keyutils.h], [keyutils_libs="-lkeyutils"])
-AC_SUBST([KEYUTILS_LIBS], [$keyutils_libs])
+AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT], [
+	AC_CHECK_LIB([keyutils], [add_key], [keyutils_libs="-lkeyutils"])
+	AC_SUBST([KEYUTILS_LIBS], [$keyutils_libs])
 ])
-- 
2.14.2

