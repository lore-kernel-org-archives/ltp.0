From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  6 Oct 2017 03:53:32 +0200
Subject: [LTP] [RFC PATCH 2/6] m4: Fix libacl detection on 32-bit cross build
In-Reply-To: <20171006015336.29972-1-pvorel@suse.cz>
References: <20171006015336.29972-1-pvorel@suse.cz>
Message-ID: <20171006015336.29972-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 m4/ltp-acl.m4 | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/m4/ltp-acl.m4 b/m4/ltp-acl.m4
index 6b739346b..789fabe0b 100644
--- a/m4/ltp-acl.m4
+++ b/m4/ltp-acl.m4
@@ -23,8 +23,7 @@ dnl LTP_CHECK_ACL_SUPPORT
 dnl ----------------------------
 dnl
 AC_DEFUN([LTP_CHECK_ACL_SUPPORT],[
-AH_TEMPLATE(HAVE_LIBACL,
-[Define to 1 if you have libacl installed.])
-AC_CHECK_HEADERS([sys/acl.h], [acl_libs="-lacl"])
-AC_SUBST([ACL_LIBS], [$acl_libs])
+	AH_TEMPLATE(HAVE_LIBACL, [Define to 1 if you have libacl installed.])
+	AC_CHECK_LIB([acl], [acl_init], [acl_libs="-lacl"])
+	AC_SUBST([ACL_LIBS], [$acl_libs])
 ])
-- 
2.14.2

