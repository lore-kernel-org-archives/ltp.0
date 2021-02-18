From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Feb 2021 16:07:38 +0100
Subject: [LTP] [PATCH 1/1] configure: Fix pkg.m4 detection
Message-ID: <20210218150738.26253-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

6e17e2ba1 attempt to detect missing pkg.m4, which usually gets installed
with pkg-config/pkgconfig. Unfortunately this macro is since 0.29, which
is too new for CentOS 7. Let's use PKG_CHECK_EXISTS, which is since 0.16
(old enough, we expect 0.24).

Fixes: 6e17e2ba1 ("configure: Improve error message on missing pkg-config")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index beeb9e669..d41688f04 100644
--- a/configure.ac
+++ b/configure.ac
@@ -30,7 +30,7 @@ AC_DEFUN([AC_PROG_STRIP], [AC_CHECK_TOOL(STRIP, strip, :)])
 AC_PROG_STRIP
 AC_PROG_YACC
 
-m4_ifndef([PKG_PREREQ],
+m4_ifndef([PKG_CHECK_EXISTS],
 	[m4_fatal([must install pkg-config or pkgconfig and pkg.m4 macro (usual dependency), see INSTALL])])
 
 AC_PREFIX_DEFAULT(/opt/ltp)
-- 
2.30.0

