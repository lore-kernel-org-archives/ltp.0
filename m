From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 May 2021 10:56:33 +0200
Subject: [LTP] [PATCH v3 1/1] lapi: Add missing IFA_FLAGS
Message-ID: <20210514085633.1319-1-pvorel@suse.cz>
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
Changes v2->v3:
* drop autotools check (Cyril)

Kind regards,
Petr

 include/lapi/rtnetlink.h | 13 +++++++++++++
 lib/tst_netdevice.c      |  3 ++-
 2 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 include/lapi/rtnetlink.h

diff --git a/include/lapi/rtnetlink.h b/include/lapi/rtnetlink.h
new file mode 100644
index 000000000..8a1b5385b
--- /dev/null
+++ b/include/lapi/rtnetlink.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2021 Petr Vorel <petr.vorel@gmail.com> */
+
+#ifndef LAPI_IF_ADDR_H__
+# define LAPI_IF_ADDR_H__
+
+#include <linux/rtnetlink.h>
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

