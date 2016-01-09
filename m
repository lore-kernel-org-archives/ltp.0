From: Khem Raj <raj.khem@gmail.com>
Date: Sat,  9 Jan 2016 01:14:06 +0000
Subject: [LTP] [PATCH V2 18/32] guard mallocopt() with __GLIBC__
In-Reply-To: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452302060-103643-18-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

mallocopt is not available on non glibc implementations

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 utils/benchmark/ebizzy-0.3/ebizzy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c b/utils/benchmark/ebizzy-0.3/ebizzy.c
index 5bb8eff..934d951 100644
--- a/utils/benchmark/ebizzy-0.3/ebizzy.c
+++ b/utils/benchmark/ebizzy-0.3/ebizzy.c
@@ -215,10 +215,10 @@ static void read_options(int argc, char *argv[])
 			"\"never mmap\" option specified\n");
 		usage();
 	}
-
+#ifdef __GLIBC__
 	if (never_mmap)
 		mallopt(M_MMAP_MAX, 0);
-
+#endif
 	if (chunk_size < record_size) {
 		fprintf(stderr, "Chunk size %u smaller than record size %u\n",
 			chunk_size, record_size);
-- 
2.7.0

