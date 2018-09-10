From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 10 Sep 2018 11:36:21 +0200
Subject: [LTP] [PATCH] aiodio: Remove dirty freeblocks
Message-ID: <20180910093621.21622-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

At the beginning of the test it attempts to write some junk data to disk in
order to increase the chance that the blocks allocated are not filled with
zeroes.

It does this by memory mapping a new file and writing 0xaa to the mapped
memory, then syncs and unlinks the file. This uses buffered I/O which should
not be mixed with direct I/O.

Possibly we could use direct I/O to create the dirty blocks or ensure the
buffers have been completely flushed and any writes finalised before
continuing. However it seems unlikely that this is either effective or
necessary. It seems much simpler and thorough to run the test many times,
which we do.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 .../kernel/io/ltp-aiodio/aiodio_sparse.c      |  2 --
 .../kernel/io/ltp-aiodio/common_sparse.h      | 33 -------------------
 testcases/kernel/io/ltp-aiodio/dio_sparse.c   |  2 --
 3 files changed, 37 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
index 4767f49d2..8953586ba 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
@@ -258,8 +258,6 @@ int main(int argc, char **argv)
 	}
 
 	setup();
-	tst_resm(TINFO, "Dirtying free blocks");
-	dirty_freeblocks(filesize);
 
 	fd = SAFE_OPEN(cleanup, filename,
 		O_DIRECT | O_WRONLY | O_CREAT | O_EXCL, 0600);
diff --git a/testcases/kernel/io/ltp-aiodio/common_sparse.h b/testcases/kernel/io/ltp-aiodio/common_sparse.h
index 3819e00a6..6c98f2c7e 100644
--- a/testcases/kernel/io/ltp-aiodio/common_sparse.h
+++ b/testcases/kernel/io/ltp-aiodio/common_sparse.h
@@ -21,39 +21,6 @@
 
 #include "common_checkzero.h"
 
-/*
- * This code tries to create dirty free blocks on
- * the HDD so there is a chance that blocks to be allocated
- * for a file are filled with something else than zeroes.
- *
- * The usefulness of this is IMHO questionable.
- */
-static void dirty_freeblocks(int size)
-{
-	int fd;
-	void *p;
-	int pg;
-	char *filename = "dirty_freeblocks";
-
-	pg = getpagesize();
-	size = ((size + pg - 1) / pg) * pg;
-
-	fd = open(filename, O_CREAT|O_RDWR|O_EXCL, 0600);
-
-	if (fd < 0)
-		tst_brkm(TBROK|TERRNO, cleanup, "failed to open '%s'", filename);
-
-	SAFE_FTRUNCATE(cleanup, fd, size);
-
-	p = SAFE_MMAP(cleanup, NULL, size, PROT_WRITE|PROT_READ, MAP_SHARED|MAP_FILE, fd, 0);
-
-	memset(p, 0xaa, size);
-	msync(p, size, MS_SYNC);
-	munmap(p, size);
-	close(fd);
-	unlink(filename);
-}
-
 /*
  * Scale value by kilo, mega, or giga.
  */
diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 67b338b3f..f52c46734 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -139,8 +139,6 @@ int main(int argc, char **argv)
 	}
 
 	setup();
-	tst_resm(TINFO, "Dirtying free blocks");
-	dirty_freeblocks(filesize);
 
 	fd = SAFE_OPEN(cleanup, filename,
 		O_DIRECT | O_WRONLY | O_CREAT | O_EXCL, 0600);
-- 
2.18.0

