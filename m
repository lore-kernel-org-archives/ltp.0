From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Sep 2020 17:29:02 +0200
Subject: [LTP] [PATCH v2 1/1] sendto: Add PACKET_VNET_HDR to lapi and use it
Message-ID: <20200923152902.8738-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to fix build on CentOS 6

Fixme: b59c66210 ("Add test for CVE 2020-14386")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v1->v2:
* actually add lapi header

 include/lapi/if_packet.h                    | 4 ++++
 testcases/kernel/syscalls/sendto/sendto03.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/lapi/if_packet.h b/include/lapi/if_packet.h
index 81110217d..902489b57 100644
--- a/include/lapi/if_packet.h
+++ b/include/lapi/if_packet.h
@@ -25,6 +25,10 @@
 # define PACKET_RESERVE 12
 #endif
 
+#ifndef PACKET_VNET_HDR
+#define PACKET_VNET_HDR	15
+#endif
+
 #ifndef PACKET_FANOUT
 #define PACKET_FANOUT	18
 #endif
diff --git a/testcases/kernel/syscalls/sendto/sendto03.c b/testcases/kernel/syscalls/sendto/sendto03.c
index a6332ec52..3ecb574a1 100644
--- a/testcases/kernel/syscalls/sendto/sendto03.c
+++ b/testcases/kernel/syscalls/sendto/sendto03.c
@@ -23,13 +23,13 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
-#include <linux/if_packet.h>
 #include <net/if.h>
 #include <net/ethernet.h>
 #include <sched.h>
 
 #include "tst_test.h"
 #include "tst_net.h"
+#include "lapi/if_packet.h"
 
 #define BUFSIZE 1024
 
-- 
2.28.0

