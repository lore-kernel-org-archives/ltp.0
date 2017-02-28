From: Jakub Racek <jracek@redhat.com>
Date: Tue, 28 Feb 2017 12:59:55 +0100
Subject: [LTP] [PATCH 2/3] Added fcntl() and fallocate() lapi flags
In-Reply-To: <1488283196-11397-1-git-send-email-jracek@redhat.com>
References: <1488283196-11397-1-git-send-email-jracek@redhat.com>
Message-ID: <1488283196-11397-3-git-send-email-jracek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jakub Racek <jracek@redhat.com>
---
 include/lapi/fcntl.h | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 38e41ec..749343d 100644
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
@@ -116,4 +141,28 @@
 # define SPLICE_F_NONBLOCK 2
 #endif
 
+#ifndef SEEK_HOLE
+#define SEEK_HOLE 4
+#endif
+
+#ifndef FALLOC_FL_KEEP_SIZE
+#define FALLOC_FL_KEEP_SIZE 0x01
+#endif
+
+#ifndef FALLOC_FL_PUNCH_HOLE
+#define FALLOC_FL_PUNCH_HOLE 0x02
+#endif
+
+#ifndef FALLOC_FL_COLLAPSE_RANGE
+#define FALLOC_FL_COLLAPSE_RANGE 0x08
+#endif
+
+#ifndef FALLOC_FL_ZERO_RANGE
+#define FALLOC_FL_ZERO_RANGE 0x10
+#endif
+
+#ifndef FALLOC_FL_INSERT_RANGE
+#define FALLOC_FL_INSERT_RANGE 0x20
+#endif
+
 #endif /* __LAPI_FCNTL_H__ */
-- 
1.8.3.1

