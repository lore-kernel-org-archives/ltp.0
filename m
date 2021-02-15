From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 15 Feb 2021 12:04:19 +0100
Subject: [LTP] [PATCH 1/1] configure: Improve error message on missing
 pkg-config
Message-ID: <20210215110419.2964-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

make autotools
configure:7350: error: possibly undefined macro: AC_DEFINE

Fixes: #787

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure.ac b/configure.ac
index d4bef5e45..c1f24891d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -30,6 +30,9 @@ AC_DEFUN([AC_PROG_STRIP], [AC_CHECK_TOOL(STRIP, strip, :)])
 AC_PROG_STRIP
 AC_PROG_YACC
 
+m4_ifndef([PKG_PREREQ],
+	[m4_fatal([must install pkg-config or pkgconfig and pkg.m4 macro (usual dependency)])])
+
 AC_PREFIX_DEFAULT(/opt/ltp)
 
 AC_CHECK_DECLS([IFLA_NET_NS_PID],,,[#include <linux/if_link.h>])
-- 
2.30.0

