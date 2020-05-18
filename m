From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 18 May 2020 20:29:52 +0200
Subject: [LTP] [COMMITTED][PATCH 1/1] ebizzy: guard mallocopt() with
 __GLIBC__
Message-ID: <20200518182952.23520-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Khem Raj <raj.khem@gmail.com>

mallocopt is not available on non glibc implementations

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 utils/benchmark/ebizzy-0.3/ebizzy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c b/utils/benchmark/ebizzy-0.3/ebizzy.c
index 5bb8eff56..934d951f3 100644
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
2.26.2

