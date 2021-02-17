From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 17 Feb 2021 13:04:58 +0100
Subject: [LTP] [PATCH 1/2] lapi/io_uring.h: Define constants that may be
 missing
Message-ID: <20210217120459.17500-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Early liburing headers did not include IOSQE_ASYNC and IOSQE_IO_HARDLINK.
Check for their presence separately even if the system header file is present
and define them if needed.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/lapi/io_uring.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
index 9d280f155..897ed7c64 100644
--- a/include/lapi/io_uring.h
+++ b/include/lapi/io_uring.h
@@ -71,8 +71,6 @@ enum {
 	IOSQE_FIXED_FILE_BIT,
 	IOSQE_IO_DRAIN_BIT,
 	IOSQE_IO_LINK_BIT,
-	IOSQE_IO_HARDLINK_BIT,
-	IOSQE_ASYNC_BIT,
 };
 
 /*
@@ -84,10 +82,6 @@ enum {
 #define IOSQE_IO_DRAIN		(1U << IOSQE_IO_DRAIN_BIT)
 /* links next sqe */
 #define IOSQE_IO_LINK		(1U << IOSQE_IO_LINK_BIT)
-/* like LINK, but stronger */
-#define IOSQE_IO_HARDLINK	(1U << IOSQE_IO_HARDLINK_BIT)
-/* always go async */
-#define IOSQE_ASYNC		(1U << IOSQE_ASYNC_BIT)
 
 /*
  * io_uring_setup() flags
@@ -262,6 +256,17 @@ struct io_uring_probe {
 
 #endif /* IOSQE_FIXED_FILE */
 
+#ifndef IOSQE_IO_HADRLINK
+/* like LINK, but stronger */
+#define IOSQE_IO_HARDLINK_BIT	3
+#define IOSQE_IO_HARDLINK	(1U << IOSQE_IO_HARDLINK_BIT)
+#endif /* IOSQE_IO_HADRLINK */
+
+#ifndef IOSQE_ASYNC
+/* always go async */
+#define IOSQE_ASYNC_BIT		4
+#define IOSQE_ASYNC		(1U << IOSQE_ASYNC_BIT)
+#endif /* IOSQE_ASYNC */
 
 #ifndef HAVE_IO_URING_REGISTER
 static inline int io_uring_register(int fd, unsigned int opcode, void *arg,
-- 
2.30.0

