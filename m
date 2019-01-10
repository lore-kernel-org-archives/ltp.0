From: Matthias Maennich <maennich@google.com>
Date: Thu, 10 Jan 2019 13:28:10 +0000
Subject: [LTP] [PATCH 1/2] aio_tio: fix error diagnosis for byte transfers
Message-ID: <20190110132811.175790-1-maennich@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In case the expected bytes written during an async io operation did not
match the actually written ones, the wrong error code (res2) had been
reported. Correct that to reflect the error condition (res!=bytes).

Signed-off-by: Matthias Maennich <maennich@google.com>
---
 testcases/kernel/io/aio/aio02/aio_tio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/io/aio/aio02/aio_tio.c b/testcases/kernel/io/aio/aio02/aio_tio.c
index 08fb04162..623c81a5e 100644
--- a/testcases/kernel/io/aio/aio02/aio_tio.c
+++ b/testcases/kernel/io/aio/aio02/aio_tio.c
@@ -57,7 +57,7 @@ static void work_done(io_context_t ctx, struct iocb *iocb, long res, long res2)
 
 	if (res != iocb->u.c.nbytes) {
 		fprintf(stderr, "write missed bytes expect %lu got %ld\n",
-			iocb->u.c.nbytes, res2);
+			iocb->u.c.nbytes, res);
 		exit(1);
 	}
 	wait_count--;
-- 
2.20.1.97.g81188d93c3-goog

