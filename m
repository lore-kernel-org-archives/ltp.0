From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  9 Oct 2017 13:00:56 +0200
Subject: [LTP] [RFC PATCH v2 2/7] m4: Fix libacl detection on 32-bit cross
	build
In-Reply-To: <20171009110101.3329-1-pvorel@suse.cz>
References: <20171009110101.3329-1-pvorel@suse.cz>
Message-ID: <20171009110101.3329-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac  | 1 +
 m4/ltp-acl.m4 | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0bae6ce3f..e9c61ef78 100644
--- a/configure.ac
+++ b/configure.ac
@@ -41,6 +41,7 @@ AC_CHECK_HEADERS([ \
     linux/mempolicy.h \
     linux/module.h \
     linux/netlink.h \
+    sys/acl.h \
     sys/epoll.h \
     sys/inotify.h \
     sys/fanotify.h \
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

