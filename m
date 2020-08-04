From: Martin Doucha <mdoucha@suse.cz>
Date: Tue,  4 Aug 2020 15:18:10 +0200
Subject: [LTP] [PATCH v2 1/2] Add N_HDLC constant to lapi/tty.h
Message-ID: <20200804131811.26515-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- patch split off from the CVE test

 include/lapi/tty.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/lapi/tty.h b/include/lapi/tty.h
index 353a103f1..6122145f3 100644
--- a/include/lapi/tty.h
+++ b/include/lapi/tty.h
@@ -10,6 +10,10 @@
 # include <linux/tty.h>
 #endif
 
+#ifndef N_HDLC
+# define N_HDLC 13
+#endif
+
 #ifndef N_SLCAN
 # define N_SLCAN		17	/* Serial / USB serial CAN Adaptors */
 #endif
-- 
2.27.0

