From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Sep 2020 17:22:27 +0200
Subject: [LTP] [PATCH 1/1] lapi: Add PACKET_VNET_HDR
Message-ID: <20200923152227.6045-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

required for sendto03

Fixme: b59c66210 ("Add test for CVE 2020-14386")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/if_packet.h | 4 ++++
 1 file changed, 4 insertions(+)

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
-- 
2.28.0

