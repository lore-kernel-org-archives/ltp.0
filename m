From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 May 2021 10:06:30 +0200
Subject: [LTP] [PATCH v2 1/1] lapi: Add missing IFA_FLAGS
Message-ID: <20210514080630.11273-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <petr.vorel@gmail.com>

and use them in tst_netdevice.c. This fixes on older toolchains
(e.g. sourcery-arm from Buildroot):

tst_netdevice.c: In function 'modify_address':
tst_netdevice.c:218:44: error: 'IFA_FLAGS' undeclared (first use in this function)
  if (!tst_rtnl_add_attr(file, lineno, ctx, IFA_FLAGS, &addr_flags,

Fixes: bc2151a65 ("lib: Add helper functions for managing network interfaces")

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Changes v1->v2:

* add missing #include "config.h"
* rename: lapi/if_addr.h => lapi/rtnetlink.h (Cyril)
* include <linux/rtnetlink.h> instead of <linux/if_addr.h> (Cyril)

 configure.ac             |  1 +
 include/lapi/rtnetlink.h | 17 +++++++++++++++++
 lib/tst_netdevice.c      |  3 ++-
 3 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 include/lapi/rtnetlink.h

diff --git a/configure.ac b/configure.ac
index 136d82d09..95c6d2e72 100644
--- a/configure.ac
+++ b/configure.ac
@@ -59,6 +59,7 @@ AC_CHECK_HEADERS_ONCE([ \
     linux/mempolicy.h \
     linux/module.h \
     linux/netlink.h \
+    linux/rtnetlink.h \
     linux/seccomp.h \
     linux/securebits.h \
     linux/tty.h \
diff --git a/include/lapi/rtnetlink.h b/include/lapi/rtnetlink.h
new file mode 100644
index 000000000..d1dc53df8
--- /dev/null
+++ b/include/lapi/rtnetlink.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2021 Petr Vorel <petr.vorel@gmail.com> */
+
+#ifndef LAPI_IF_ADDR_H__
+# define LAPI_IF_ADDR_H__
+
+#include "config.h"
+
+#ifdef HAVE_LINUX_RTNETLINK_H
+# include <linux/rtnetlink.h>
+#endif
+
+#ifndef IFA_FLAGS
+# define IFA_FLAGS 8
+#endif
+
+#endif	/* LAPI_IF_ADDR_H__ */
diff --git a/lib/tst_netdevice.c b/lib/tst_netdevice.c
index 5ca523759..d098173d5 100644
--- a/lib/tst_netdevice.c
+++ b/lib/tst_netdevice.c
@@ -5,10 +5,11 @@
 
 #include <asm/types.h>
 #include <linux/netlink.h>
-#include <linux/rtnetlink.h>
 #include <linux/veth.h>
 #include <sys/socket.h>
 #include <net/if.h>
+#include "lapi/rtnetlink.h"
+
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_rtnetlink.h"
-- 
2.31.1

