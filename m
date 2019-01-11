From: Matthias Maennich <maennich@google.com>
Date: Fri, 11 Jan 2019 08:53:26 +0000
Subject: [LTP] [PATCH v2 2/2] aio_tio: determine alignment based on target
	filesystem
In-Reply-To: <20190111085326.171826-1-maennich@google.com>
References: <20190111085326.171826-1-maennich@google.com>
Message-ID: <20190111085326.171826-2-maennich@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The alignment for O_DIRECT operations has to match the blocksize of the
underlying filesystem. Determine the alignment from the target file's
file system.

aio_tio test cases 1 and 2 failed (nondeterministic) on aarch64 when run
on a 4096 byte blocksize filesystem and with an alignment of 512 bytes.

Determining the blocksize from the file system and using it for the
alignment resolves the test issue.

Signed-off-by: Matthias Maennich <maennich@google.com>
Reviewed-by: Alessio Balsini <balsini@google.com>
---
 testcases/kernel/io/aio/aio02/aio_tio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/io/aio/aio02/aio_tio.c b/testcases/kernel/io/aio/aio02/aio_tio.c
index 623c81a5e..db6fa2688 100644
--- a/testcases/kernel/io/aio/aio02/aio_tio.c
+++ b/testcases/kernel/io/aio/aio02/aio_tio.c
@@ -34,6 +34,7 @@
 #include "config.h"
 #include "common.h"
 #include "test.h"
+#include "safe_macros.h"
 #include <string.h>
 #include <errno.h>
 
@@ -42,7 +43,6 @@
 #define AIO_MAXIO 32
 #define AIO_BLKSIZE (64*1024)
 
-static int alignment = 512;
 static int wait_count = 0;
 
 /*
@@ -94,6 +94,8 @@ int io_tio(char *pathname, int flag, int n, int operation)
 	void *bufptr = NULL;
 	off_t offset = 0;
 	struct timespec timeout;
+	struct stat fi_stat;
+	size_t alignment;
 
 	io_context_t myctx;
 	struct iocb iocb_array[AIO_MAXIO];
@@ -105,6 +107,10 @@ int io_tio(char *pathname, int flag, int n, int operation)
 		return -1;
 	}
 
+	/* determine the alignment from the blksize of the underlying fs */
+	SAFE_FSTAT(NULL, fd, &fi_stat);
+	alignment = fi_stat.st_blksize;
+
 	res = io_queue_init(n, &myctx);
 	//printf (" res = %d \n", res);
 
-- 
2.20.1.97.g81188d93c3-goog

