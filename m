From: Li Wang <liwang@redhat.com>
Date: Mon, 23 May 2016 12:58:55 +0800
Subject: [LTP] [PATCH v2 1/3] ltp/lapi: add some madvices definition
Message-ID: <1463979535-21327-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/lapi/mmap.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
index e8e5917..b121e43 100644
--- a/include/lapi/mmap.h
+++ b/include/lapi/mmap.h
@@ -23,4 +23,36 @@
 #define MAP_HUGETLB 0x40000
 #endif
 
+#ifndef MADV_REMOVE
+#define MADV_REMOVE 9
+#endif
+
+#ifndef MADV_DONTFORK
+#define MADV_DONTFORK 10
+#define MADV_DOFORK   11
+#endif
+
+#ifndef MADV_HWPOISON
+#define MADV_HWPOISON 100
+#endif
+
+#ifndef MADV_SOFT_OFFLINE
+#define MADV_SOFT_OFFLINE 101
+#endif
+
+#ifndef MADV_MERGEABLE
+#define MADV_MERGEABLE   12
+#define MADV_UNMERGEABLE 13
+#endif
+
+#ifndef MADV_HUGEPAGE
+#define MADV_HUGEPAGE   14
+#define MADV_NOHUGEPAGE 15
+#endif
+
+#ifndef MADV_DONTDUMP
+#define MADV_DONTDUMP 16
+#define MADV_DODUMP   17
+#endif
+
 #endif /* __LAPI_MMAP_H__ */
-- 
1.8.3.1

