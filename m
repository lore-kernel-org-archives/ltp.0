From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Oct 2017 20:33:18 +0200
Subject: [LTP] [PATCH v3 01/18] configure.ac: Sort headers alphabetically
In-Reply-To: <20171012183335.24568-1-pvorel@suse.cz>
References: <20171012183335.24568-1-pvorel@suse.cz>
Message-ID: <20171012183335.24568-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 82ebfc8da..fa66db6fc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -33,18 +33,18 @@ AC_PREFIX_DEFAULT(/opt/ltp)
 AC_CHECK_HEADERS([ \
     ifaddrs.h \
     libaio.h \
-    mm.h \
-    pthread.h \
-    sys/xattr.h \
     linux/genetlink.h \
     linux/mempolicy.h \
     linux/module.h \
     linux/netlink.h \
+    mm.h \
+    pthread.h \
     sys/epoll.h \
-    sys/inotify.h \
     sys/fanotify.h \
+    sys/inotify.h \
     sys/prctl.h \
     sys/ustat.h \
+    sys/xattr.h \
 ])
 
 AC_CHECK_FUNCS([ \
-- 
2.14.2

