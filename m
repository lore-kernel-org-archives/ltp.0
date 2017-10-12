From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Oct 2017 20:33:25 +0200
Subject: [LTP] [PATCH v3 08/18] m4: Fix libacl detection on 32-bit cross
	build
In-Reply-To: <20171012183335.24568-1-pvorel@suse.cz>
References: <20171012183335.24568-1-pvorel@suse.cz>
Message-ID: <20171012183335.24568-9-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 m4/ltp-acl.m4                      | 12 +++++++-----
 testcases/network/nfsv4/acl/acl1.c |  5 ++---
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/m4/ltp-acl.m4 b/m4/ltp-acl.m4
index 6b739346b..603837d9e 100644
--- a/m4/ltp-acl.m4
+++ b/m4/ltp-acl.m4
@@ -22,9 +22,11 @@ dnl
 dnl LTP_CHECK_ACL_SUPPORT
 dnl ----------------------------
 dnl
-AC_DEFUN([LTP_CHECK_ACL_SUPPORT],[
-AH_TEMPLATE(HAVE_LIBACL,
-[Define to 1 if you have libacl installed.])
-AC_CHECK_HEADERS([sys/acl.h], [acl_libs="-lacl"])
-AC_SUBST([ACL_LIBS], [$acl_libs])
+AC_DEFUN([LTP_CHECK_ACL_SUPPORT], [
+	AC_CHECK_LIB([acl], [acl_init], [have_libacl=yes], [AC_MSG_WARN(missing libacl)])
+	AC_CHECK_HEADERS([sys/acl.h], [have_acl=yes], [AC_MSG_WARN(missing libacl headers)])
+	if test "x$have_libacl" = "xyes" -a "x$have_acl" = "xyes"; then
+		AC_DEFINE(HAVE_LIBACL, 1, [Define to 1 if you have libacl and it's headers installed])
+	    AC_SUBST(ACL_LIBS, "-lacl")
+	fi
 ])
diff --git a/testcases/network/nfsv4/acl/acl1.c b/testcases/network/nfsv4/acl/acl1.c
index 1693d4347..bdf0180da 100644
--- a/testcases/network/nfsv4/acl/acl1.c
+++ b/testcases/network/nfsv4/acl/acl1.c
@@ -19,7 +19,7 @@
 #include "config.h"
 #include "tst_res_flags.h"
 
-#ifdef HAVE_SYS_ACL_H
+#ifdef HAVE_LIBACL
 
 #include <sys/acl.h>
 
@@ -365,11 +365,10 @@ int main(int argc, char *argv[])
 	showstats();
 	return 1;
 }
-
 #else
 int main(void)
 {
 	printf("The acl library was missing upon compilation.\n");
 	return TCONF;
 }
-#endif /* HAVE_SYS_ACL_H */
+#endif /* HAVE_LIBACL */
-- 
2.14.2

