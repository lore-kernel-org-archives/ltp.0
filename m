From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 Mar 2019 23:03:28 +0100
Subject: [LTP] [PATCH COMMITTED] lapi/socket.h: provide SO_REUSEPORT
	definition for older distros
Message-ID: <0619b30959aa7b1d0e3154f939d4cb6e2964fcf3.1552687391.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/lapi/socket.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/lapi/socket.h b/include/lapi/socket.h
index d58c460f141b..4e856dfb3183 100644
--- a/include/lapi/socket.h
+++ b/include/lapi/socket.h
@@ -29,6 +29,10 @@
 # define MSG_FASTOPEN	0x20000000 /* Send data in TCP SYN */
 #endif
 
+#ifndef SO_REUSEPORT
+# define SO_REUSEPORT	15
+#endif
+
 #ifndef SO_BUSY_POLL
 # define SO_BUSY_POLL	46
 #endif
-- 
1.8.3.1

