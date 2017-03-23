From: Jakub Racek <jracek@redhat.com>
Date: Thu, 23 Mar 2017 19:15:54 +0100
Subject: [LTP] [PATCH v5 3/6] Added fcntl() lapi flags
In-Reply-To: <1490292957-26941-1-git-send-email-jracek@redhat.com>
References: <1490292957-26941-1-git-send-email-jracek@redhat.com>
Message-ID: <1490292957-26941-4-git-send-email-jracek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jakub Racek <jracek@redhat.com>
---
 include/lapi/fcntl.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 38e41ec..849439d 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -50,6 +50,31 @@
 # define F_GETPIPE_SZ 1032
 #endif
 
+/*
+ * Set/Get seals
+ */
+#ifndef F_ADD_SEALS
+# define F_ADD_SEALS     (1033)
+#endif
+
+#ifndef F_GET_SEALS
+# define F_GET_SEALS     (1034)
+#endif
+
+#ifndef F_SEAL_SEAL
+# define F_SEAL_SEAL     0x0001  /* prevent further seals from being set */
+#endif
+
+#ifndef F_SEAL_SHRINK
+# define F_SEAL_SHRINK   0x0002  /* prevent file from shrinking */
+#endif
+#ifndef F_SEAL_GROW
+# define F_SEAL_GROW     0x0004  /* prevent file from growing */
+#endif
+#ifndef F_SEAL_WRITE
+# define F_SEAL_WRITE    0x0008  /* prevent writes */
+#endif
+
 #ifndef F_OWNER_PGRP
 # define F_OWNER_PGRP 2
 #endif
-- 
1.8.3.1

