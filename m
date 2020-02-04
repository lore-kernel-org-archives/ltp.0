From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 4 Feb 2020 15:29:18 +0100
Subject: [LTP] [RFC PATCH 1/1] autotools: Move simple definitions out of
 m4/* to configure.ac
In-Reply-To: <20200204132152.GC16090@rei>
References: <20200130110753.20459-1-pvorel@suse.cz>
 <20200204132152.GC16090@rei>
Message-ID: <20200204142918.GB18759@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > +AC_CHECK_HEADERS(fts.h, [have_fts=1])
> > +AC_SUBST(HAVE_FTS_H, $have_fts)

> How is that different from simple AC_CHECK_HEADERS() ?

> Can't we just put the hader into the call above?

Maybe we could use ac_cv_header_sys_xattr_h=yes to set HAVE_FTS_H for Makefile.

So it works with following diff applied work as well.
I have no strong opinion which one is better.

Kind regards,
Petr

diff --git configure.ac configure.ac
index 1c9ef38eb..74648556e 100644
--- configure.ac
+++ configure.ac
@@ -38,6 +38,7 @@ AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ],,,[#include <sys/prctl.h>])
 
 AC_CHECK_HEADERS([ \
     asm/ldt.h \
+    fts.h \
     ifaddrs.h \
     keyutils.h \
     linux/can.h \
@@ -71,8 +72,10 @@ AC_CHECK_HEADERS([ \
     sys/xattr.h \
     xfs/xqm.h \
 ])
-AC_CHECK_HEADERS(fts.h, [have_fts=1])
-AC_SUBST(HAVE_FTS_H, $have_fts)
+
+if test "x$ac_cv_header_sys_xattr_h" = "xyes"; then
+AC_SUBST(HAVE_FTS_H, 1)
+fi
 
 AC_CHECK_FUNCS([ \
     copy_file_range \
