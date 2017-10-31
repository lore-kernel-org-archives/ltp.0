From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Oct 2017 14:45:37 +0100
Subject: [LTP] [PATCH 1/1] netstress: Add imports for TCP_FASTOPEN definition
Message-ID: <20171031134537.11034-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ add necessary autoconf checks for these headers.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac                            | 2 ++
 testcases/network/netstress/netstress.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/configure.ac b/configure.ac
index 5f1cd3bfb..1f1f53eb0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -39,7 +39,9 @@ AC_CHECK_HEADERS([ \
     linux/mempolicy.h \
     linux/module.h \
     linux/netlink.h \
+    linux/tcp.h \
     mm.h \
+    netinet/tcp.h \
     pthread.h \
     sys/epoll.h \
     sys/fanotify.h \
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 4b211aa75..5e3aca1a1 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -18,6 +18,8 @@
  *
  */
 
+#include "config.h"
+
 #include <pthread.h>
 #include <stdlib.h>
 #include <limits.h>
@@ -32,6 +34,12 @@
 #include <unistd.h>
 #include <errno.h>
 
+#ifdef HAVE_LINUX_TCP_H
+#include <linux/tcp.h>
+#elif defined(HAVE_NETINET_TCP_H)
+#include <netinet/tcp.h>
+#endif
+
 #include "lapi/posix_clocks.h"
 #include "tst_safe_pthread.h"
 #include "tst_test.h"
-- 
2.14.2

