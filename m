From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:38 -0700
Subject: [LTP] [PATCH V3 05/23] guard mallocopt() with __GLIBC__
In-Reply-To: <20160722042656.22346-1-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
Message-ID: <20160722042656.22346-5-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

mallocopt is not available on non glibc implementations

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 utils/benchmark/ebizzy-0.3/ebizzy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c b/utils/benchmark/ebizzy-0.3/ebizzy.c
index 5bb8eff..f9ccc8b 100644
--- a/utils/benchmark/ebizzy-0.3/ebizzy.c
+++ b/utils/benchmark/ebizzy-0.3/ebizzy.c
@@ -215,10 +215,12 @@ static void read_options(int argc, char *argv[])
 			"\"never mmap\" option specified\n");
 		usage();
 	}
-
+#ifdef __GLIBC__
 	if (never_mmap)
 		mallopt(M_MMAP_MAX, 0);
-
+#else
+	fprintf(stderr, "Platform does not support mallopt() API\n");
+#endif
 	if (chunk_size < record_size) {
 		fprintf(stderr, "Chunk size %u smaller than record size %u\n",
 			chunk_size, record_size);
-- 
2.9.0

